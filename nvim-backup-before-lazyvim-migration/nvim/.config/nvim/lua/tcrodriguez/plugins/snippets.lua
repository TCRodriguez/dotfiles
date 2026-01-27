return {
	{
		"L3MON4D3/LuaSnip",
		opts = function(_, opts)
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			-- your custom snippets
			ls.add_snippets("all", {
				s("clg", {
					t("console.log("),
					i(1),
					t(");"),
					i(2),
				}),

				s("tryc", {
					t({ "try {", "\t" }),
					i(1),
					t({ "", "} catch (error) {", "\tconsole.log(error);", "}" }),
				}),
			})

			return opts
		end,
	},
}
