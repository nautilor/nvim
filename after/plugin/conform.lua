local conform = require("conform")

conform.setup({
      formatters_by_ft = {
        typescript = { { 'prettierd', "prettier" } },
        typescriptreact = { { 'prettierd', "prettier" } },
        javascript = { { 'prettierd', "prettier" } },
        javascriptreact = { { 'prettierd', "prettier" } },
        json = { { 'prettierd', "prettier" } },
        html = { { 'prettierd', "prettier" } },
        css = { { 'prettierd', "prettier" } },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500
      },
    })


vim.keymap.set({ "n", "v" }, "<leader>fc", function()
	conform.format({
		lsp_fallback = true,
		timeout_ms = 500
	})
end)

vim.lsp.buf.format({
    filter = function(client)
        return client.name ~= "tsserver"
    end
})
