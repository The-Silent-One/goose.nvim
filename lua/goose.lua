local M = {}
M.geese = {}
local conf = { character = "🪿", speed = 10, width = 2, height = 1, color = "none", blend = 100 }

local handle
local on_exit = function(code, signal)
	if handle then
		handle:close()
	end
end

local honk_audio = vim.api.nvim_get_runtime_file("./honk-sound.mp3", false)[1]
local waddle = function(goose, speed)
	local timer = vim.loop.new_timer()
	local new_goose = { name = goose, timer = timer, honk = false }
	table.insert(M.geese, new_goose)

	local waddle_period = 1000 / (speed or conf.speed)
	vim.loop.timer_start(
		timer,
		1000,
		waddle_period,
		vim.schedule_wrap(function()
			if vim.api.nvim_win_is_valid(goose) then
				local config = vim.api.nvim_win_get_config(goose)
				local col, row = 0, 0
				local g = M.geese[#M.geese]
				col, row = config["col"], config["row"]

				math.randomseed(os.time() * goose)
				local p = math.random()
				if not g.honk and p > 0.95 then
					g.honk = true
					vim.loop.spawn(
						"ffplay",
						{ args = { "-v", "0", "-nodisp", "-autoexit", honk_audio } },
						function(code, signal)
							on_exit(code, signal)
							g.honk = false
						end
					)
				end
				local angle = 2 * math.pi * math.random()
				local s = math.sin(angle)
				local c = math.cos(angle)

				if row < 0 and s < 0 then
					row = vim.o.lines
				end

				if row > vim.o.lines and s > 0 then
					row = 0
				end

				if col < 0 and c < 0 then
					col = vim.o.columns
				end

				if col > vim.o.columns and c > 0 then
					col = 0
				end

				config["row"] = row + 0.5 * s
				config["col"] = col + 1 * c

				vim.api.nvim_win_set_config(goose, config)
			end
		end)
	)
end

M.hatch = function(character, speed)
	if #M.geese >= 1 then
		print("why more?")
		return
	end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, 1, true, { character or conf.character })

	local goose = vim.api.nvim_open_win(buf, false, {
		relative = "cursor",
		style = "minimal",
		row = 1,
		col = 1,
		width = conf.width,
		height = conf.height,
	})
	waddle(goose, speed)
end

M.cook = function()
	if #M.geese <= 0 then
		vim.notify("You're safe, for now.")
		return
	end

	local goose = M.geese[#M.geese]["name"]
	local timer = M.geese[#M.geese]["timer"]
	local config = vim.api.nvim_win_get_config(goose)
	local row = config["row"]
	local col = config["col"]
	table.remove(M.geese, #M.geese)
	timer:stop()

	vim.api.nvim_win_close(goose, true)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, 1, true, { "🍗" })
	local dead = vim.api.nvim_open_win(buf, false, {
		relative = "cursor",
		style = "minimal",
		row = row,
		col = col,
		width = conf.width,
		height = conf.height,
	})
	vim.defer_fn(function()
		vim.api.nvim_win_close(dead, true)
	end, 2000)
end

M.setup = function(opts)
	conf = vim.tbl_deep_extend("force", conf, opts or {})
end
vim.keymap.set("n", "<leader>GG", function()
	require("goose").hatch()
end, {})
vim.keymap.set("n", "<leader>GK", function()
	require("goose").cook()
end, {})

return M
