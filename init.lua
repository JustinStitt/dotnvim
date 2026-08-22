-- Point sudo/ssh/git at the askpass helper regardless of how nvim was launched
-- (a GUI launcher never sources .zshrc, and /etc/sudo.conf still defaults to
-- ssh-askpass, which can't open a display under niri). See ~/.local/bin/askpass.
local askpass = vim.fn.expand("~/.local/bin/askpass")
if vim.fn.executable(askpass) == 1 then
  vim.env.SUDO_ASKPASS = askpass
  vim.env.SSH_ASKPASS = askpass
  vim.env.GIT_ASKPASS = askpass
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
