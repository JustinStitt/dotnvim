-- View the git gutter for a past commit instead of the working tree.
--
-- gitsigns normally diffs the buffer against the index. change_base points it
-- at an arbitrary rev, so setting the base to <commit>^ makes the signs show
-- exactly what <commit> touched. State is tracked here so <leader>se can list
-- the same set of files.
local M = {}

--- @type string|nil the rev we are diffing against, nil when following the index
M.base = nil
--- @type string|nil the commit whose changes we are inspecting (base is its parent)
M.commit = nil

local function git(args, env)
  local out = vim.system({ "git", unpack(args) }, { text = true, env = env }):wait()
  -- Extra parens: gsub also returns a count, which would leak into the caller's
  -- error slot and read as a failure.
  if out.code ~= 0 then
    return nil, ((out.stderr or ""):gsub("%s+$", ""))
  end
  return ((out.stdout or ""):gsub("%s+$", ""))
end

local function root()
  return git({ "rev-parse", "--show-toplevel" }) or assert(vim.uv.cwd())
end

local function apply(base, commit)
  M.base = base
  M.commit = commit
  require("gitsigns").change_base(base, true)
end

--- Diff against the parent of `rev` so the gutter shows that commit's own diff.
--- @param rev string|nil commit-ish, defaults to HEAD
function M.set(rev)
  rev = (rev and rev ~= "") and rev or "HEAD"

  local commit, err = git({ "rev-parse", "--verify", rev .. "^{commit}" })
  if not commit then
    vim.notify("gitbase: " .. (err ~= "" and err or "bad rev: " .. rev), vim.log.levels.ERROR)
    return
  end

  -- Root commits have no parent; diff against the empty tree instead.
  local base = git({ "rev-parse", "--verify", commit .. "^" })
  if not base then
    base = git({ "hash-object", "-t", "tree", "/dev/null" })
  end

  apply(base, commit)
  local subject = git({ "log", "-1", "--format=%h %s", commit }) or commit:sub(1, 7)
  vim.notify("gitbase: showing " .. subject, vim.log.levels.INFO)
end

--- Go back to diffing against the index.
function M.reset()
  apply(nil, nil)
  vim.notify("gitbase: back to working tree", vim.log.levels.INFO)
end

--- @return boolean
function M.active()
  return M.base ~= nil
end

--- <leader>gc: HEAD's changes on, or off if already on.
function M.toggle()
  if M.active() then
    M.reset()
  else
    M.set("HEAD")
  end
end

--- <leader>gC: pick the commit to inspect.
function M.prompt()
  vim.ui.input({ prompt = "Show gutter for commit: ", default = "HEAD" }, function(rev)
    if rev then
      M.set(rev)
    end
  end)
end

--- Rewrite `commit`'s message to the contents of `msgfile`.
---
--- Everything goes through `rebase -i`, HEAD included, so one code path covers
--- both cases. The sequence editor rewords the first (= target) line and
--- GIT_EDITOR is a `cp` that drops the prepared message in place, so neither
--- editor ever blocks on input.
--- @param commit string
--- @param msgfile string
--- @return boolean ok
local function reword(commit, msgfile)
  local has_parent = git({ "rev-parse", "--verify", commit .. "^" }) ~= nil
  local args = { "rebase", "-i", "--autostash" }
  if has_parent then
    table.insert(args, commit .. "^")
  else
    table.insert(args, "--root")
  end

  local out, err = git(args, {
    GIT_SEQUENCE_EDITOR = "sed -i -e '1s/^pick/reword/'",
    GIT_EDITOR = "cp " .. vim.fn.shellescape(msgfile),
  })

  -- Key off the result, not the error slot: only a nil result means failure.
  if not out then
    git({ "rebase", "--abort" })
    vim.notify("gitbase: reword failed: " .. (err or "?"), vim.log.levels.ERROR)
    return false
  end
  return true
end

--- <C-o> in the commit picker: edit a commit's message in a scratch buffer.
--- Writing the buffer runs the reword; the rebase rewrites every SHA from this
--- commit onwards, so an active base is dropped afterwards.
--- @param commit string
function M.edit_message(commit)
  local subject = git({ "log", "-1", "--format=%h %s", commit })
  local msg = git({ "log", "-1", "--format=%B", commit })
  if not msg or not subject then
    vim.notify("gitbase: cannot read message for " .. commit, vim.log.levels.ERROR)
    return
  end

  local bufnr = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(bufnr, "gitbase://reword/" .. subject)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(msg, "\n"))
  vim.bo[bufnr].filetype = "gitcommit"
  vim.bo[bufnr].buftype = "acwrite"
  vim.bo[bufnr].modified = false

  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = bufnr,
    callback = function()
      local choice =
        vim.fn.confirm("Rewrite history from " .. subject .. " onwards?", "&Yes\n&No", 2)
      if choice ~= 1 then
        return
      end

      local msgfile = vim.fn.tempname()
      vim.fn.writefile(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), msgfile)
      if not reword(commit, msgfile) then
        return
      end

      vim.bo[bufnr].modified = false
      vim.notify("gitbase: reworded " .. subject, vim.log.levels.INFO)
      if M.active() then
        M.reset()
      end
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end,
  })

  vim.cmd.split()
  vim.api.nvim_win_set_buf(0, bufnr)
end

--- <leader>gf: browse the log and set the gutter to whichever commit is picked.
--- <C-o> on a commit edits its message instead.
function M.pick_commit()
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  local toplevel = root()

  require("telescope.builtin").git_commits({
    -- git log is newest-first; ascending draws entry 1 at the top, where the
    -- cursor starts, so the newest commit is selected by default.
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    -- Default previewer is the bare diff; `show` leads with the full commit
    -- message. termopen so git does its own colouring.
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return {
          "git",
          "-C",
          toplevel,
          "-c",
          "color.ui=always",
          "--no-pager",
          "show",
          "--stat",
          "--patch",
          entry.value,
        }
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          M.set(entry.value)
        end
      end)
      map({ "i", "n" }, "<C-o>", function()
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          M.edit_message(entry.value)
        end
      end)
      return true
    end,
  })
end

--- Files the inspected commit itself touched (base..commit, not base..worktree).
--- @return string[]
function M.changed_files()
  local out = git({ "diff", "--name-only", "--diff-filter=ACMR", M.base, M.commit })
  if not out or out == "" then
    return {}
  end
  return vim.split(out, "\n", { trimempty = true })
end

--- Replay history with `commit` amended to hold `lines` for `relpath`.
---
--- `rebase -i` stops at the commit with the file exactly as the buffer found
--- it, so the edit needs no patching -- the buffer content is written straight
--- over the file and amended in. Later commits are then replayed, which is
--- where conflicts can surface; the rebase is left in progress if they do.
--- @param commit string
--- @param relpath string
--- @param lines string[]
--- @return string? new_sha nil on failure
local function amend_file_at(commit, relpath, lines)
  local has_parent = git({ "rev-parse", "--verify", commit .. "^" }) ~= nil
  local base = has_parent and git({ "rev-parse", commit .. "^" }) or nil

  local args = { "rebase", "-i", "--autostash" }
  table.insert(args, has_parent and (commit .. "^") or "--root")

  local started, err = git(args, {
    GIT_SEQUENCE_EDITOR = "sed -i -e '1s/^pick/edit/'",
    GIT_EDITOR = "true",
  })
  if not started then
    git({ "rebase", "--abort" })
    vim.notify("gitbase: rebase failed: " .. (err or "?"), vim.log.levels.ERROR)
    return nil
  end

  local wrote = pcall(vim.fn.writefile, lines, root() .. "/" .. relpath)
  local amend_ok, aerr ---@type string?, string?
  if wrote then
    amend_ok, aerr = git({ "add", "--", relpath })
    if amend_ok then
      amend_ok, aerr = git({ "commit", "--amend", "--no-edit" }, { GIT_EDITOR = "true" })
    end
  end
  if not amend_ok then
    git({ "rebase", "--abort" })
    vim.notify(
      "gitbase: amend failed: " .. (aerr or "cannot write " .. relpath),
      vim.log.levels.ERROR
    )
    return nil
  end

  local amended = git({ "rev-parse", "HEAD" })

  local done, cerr = git({ "rebase", "--continue" }, { GIT_EDITOR = "true" })
  if not done then
    vim.notify(
      "gitbase: edit applied, but replaying later commits stopped:\n"
        .. (cerr or "?")
        .. "\nResolve and `git rebase --continue`.",
      vim.log.levels.WARN
    )
    return nil
  end

  -- Every SHA from here on moved; find what the amended commit became.
  if not base then
    return git({ "rev-list", "--max-parents=0", "HEAD" })
  end
  local descendants = git({ "rev-list", "--ancestry-path", base .. "..HEAD" })
  if not descendants or descendants == "" then
    return amended
  end
  local list = vim.split(descendants, "\n", { trimempty = true })
  return list[#list]
end

--- BufWriteCmd for a revision buffer: fold its contents into the commit.
--- @param bufnr integer
--- @param relpath string
function M.fixup(bufnr, relpath)
  if not M.active() then
    vim.notify("gitbase: no commit selected", vim.log.levels.ERROR)
    return
  end

  local commit = M.commit
  local subject = git({ "log", "-1", "--format=%h %s", commit }) or commit
  local choice = vim.fn.confirm(
    ("Fold changes to %s into %s? Rewrites history from there."):format(relpath, subject),
    "&Yes\n&No",
    2
  )
  if choice ~= 1 then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local new_sha = amend_file_at(commit, relpath, lines)
  if not new_sha then
    return
  end

  vim.bo[bufnr].modified = false
  vim.notify("gitbase: folded into " .. subject, vim.log.levels.INFO)

  -- The buffer's name is keyed on the old base, and its content is now stale;
  -- drop it and reopen against the rewritten commit.
  vim.api.nvim_buf_delete(bufnr, { force = true })
  M.set(new_sha)
  M.open_at_commit(relpath)
end

--- Open a file as it looked at the inspected commit.
---
--- The buffer holds the commit's content but is named after the *base* the way
--- gitsigns names its own revision buffers. gitsigns then attaches on its own
--- and diffs the content against the base, so the gutter shows that commit's
--- hunks alone -- not everything that landed on the file afterwards.
--- @param relpath string repo-relative path
function M.open_at_commit(relpath)
  if not M.active() then
    vim.cmd.edit(vim.fn.fnameescape(root() .. "/" .. relpath))
    return
  end

  local gitdir = git({ "rev-parse", "--absolute-git-dir" })
  local content, err = git({ "show", M.commit .. ":" .. relpath })
  if not gitdir or not content then
    vim.notify("gitbase: " .. (err or "cannot read " .. relpath), vim.log.levels.ERROR)
    return
  end

  local bufname = ("gitsigns://%s//%s:%s"):format(gitdir, M.base, relpath)
  local bufnr = vim.fn.bufnr(bufname)
  if bufnr == -1 then
    bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(bufnr, bufname)
    vim.bo[bufnr].buftype = "acwrite"
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(content, "\n"))
    vim.bo[bufnr].modified = false
    vim.bo[bufnr].filetype = vim.filetype.match({ filename = relpath, buf = bufnr }) or ""

    -- Writing the buffer folds the edit into the commit it came from.
    vim.api.nvim_create_autocmd("BufWriteCmd", {
      buffer = bufnr,
      callback = function()
        M.fixup(bufnr, relpath)
      end,
    })
  end

  vim.api.nvim_win_set_buf(0, bufnr)
end

--- Telescope picker over `changed_files()`, previewing each file's diff vs the base.
function M.pick_changed_files()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local previewers = require("telescope.previewers")

  local files = M.changed_files()
  if #files == 0 then
    vim.notify("gitbase: no files changed in " .. (M.commit or "?"), vim.log.levels.WARN)
    return
  end

  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")

  local toplevel = root()
  local subject = git({ "log", "-1", "--format=%h %s", M.commit }) or M.commit

  pickers
    .new({}, {
      prompt_title = "Changed in " .. subject,
      finder = finders.new_table({
        results = files,
        entry_maker = function(file)
          return {
            value = file,
            display = file,
            ordinal = file,
            path = toplevel .. "/" .. file,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.new_termopen_previewer({
        get_command = function(entry)
          return { "git", "-C", toplevel, "diff", M.base, M.commit, "--", entry.value }
        end,
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local entry = state.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry then
            M.open_at_commit(entry.value)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
