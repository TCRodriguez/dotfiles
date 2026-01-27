--[[ return {
	-- DAP (Debug Adapter Protocol) for debugging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			-- UI for nvim-dap
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			-- Virtual text support (shows variable values inline)
			"theHamsta/nvim-dap-virtual-text",
			-- Mason integration for automatic adapter installation
			"jay-babu/mason-nvim-dap.nvim",
			-- Language specific debug adapters
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
			-- JavaScript/TypeScript debugger
			{
				"mxsdev/nvim-dap-vscode-js",
				dependencies = {
					{
						"microsoft/vscode-js-debug",
						version = "1.74.1",
						build = "npm install && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
					},
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup DAP UI
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "□",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})

			-- Setup virtual text
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				filter_references_pattern = "<module",
				virt_text_pos = "eol",
				all_frames = false,
				virt_lines = false,
				virt_text_win_col = nil,
			})

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Setup language-specific adapters
			-- Python
			require("dap-python").setup("python3")

			-- Go
			require("dap-go").setup()

			-- Setup Mason DAP for automatic adapter installation
			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "delve" },
				automatic_installation = true,
				handlers = {
					function(config)
						-- Default handler - applies to all adapters without custom handler
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- Setup vscode-js-debug for JavaScript/TypeScript
			-- Manual adapter configuration (more reliable than nvim-dap-vscode-js auto-setup)
			local js_debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path .. "/out/src/vsDebugServer.js", "${port}" },
				},
			}

			-- JavaScript/TypeScript debug configurations
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			-- Keybindings
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug: Toggle [B]reakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "[D]ebug: Set conditional [B]reakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug: [C]ontinue" })
			vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "[D]ebug: Run to [C]ursor" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug: Step [I]nto" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebug: Step [O]ver" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "[D]ebug: Step [O]ut" })
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "[D]ebug: Toggle [R]EPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[D]ebug: Run [L]ast" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ebug: [T]erminate" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]ebug: Toggle [U]I" })
			vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "[D]ebug: [E]val" })

			-- Sign icons for breakpoints
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "", numhl = "" })
		end,
	},
} ]]

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Mason integration to ensure adapters are installed
			{ "jay-babu/mason-nvim-dap.nvim", opts = { ensure_installed = { "python", "delve" } } },
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
		},
		keys = {
			-- We define your specific keybindings here to ensure they override LazyVim defaults
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Conditional Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Debug: Run to Cursor",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Debug: Toggle REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Debug: Run Last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Debug: Terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "Debug: Eval",
			},
		},
		config = function()
			-- Setup Python
			require("dap-python").setup("python3")
			-- Setup Go
			require("dap-go").setup()

			-- Note: JS/TS debugging is automatically configured by the
			-- 'lang.typescript' extra.
		end,
	},
}
