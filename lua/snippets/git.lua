local luasnip = require("luasnip")

local git_snippets = {
  luasnip.snippet("abj", {
    luasnip.text_node("Acknowledged-by: Justin Stitt <justinstitt@google.com>"),
  }),
  luasnip.snippet("rbj", {
    luasnip.text_node("Reviewed-by: Justin Stitt <justinstitt@google.com>"),
  }),
  luasnip.snippet("sob", {
    luasnip.text_node("Signed-off-by: Justin Stitt <justinstitt@google.com>"),
  }),
}

return git_snippets

