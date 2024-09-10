local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
	s("clg", {
		t({ "console.log(" }),
		i(1), -- First jump point (inside the parentheses)
		t({ ");" }),
		i(2), -- Second jump point (after the semicolon)
	}),

	s("tryc", {
		t({ "try {", "\t" }),
		i(1), -- This is where $0 (your first placeholder) goes
		t({ "", "} catch (error) {", "\tconsole.log(error);", "}" }),
	}),
})
