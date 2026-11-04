-- Java support lives in its own plugin (shadow-java.nvim).

return {
	{
		"nautilor/shadow-java.nvim",
		ft = "java",
		cmd = { "JavaRun", "JavaRunSpring", "JavaRunQuarkus", "JavaRunTests" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-java/nvim-java",
			"MunifTanjim/nui.nvim",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			{
				"JavaHello/spring-boot.nvim",
				commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
			},
		},
		opts = {
			runtimes = {
				{ name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk", default = true },
			},
		},
	},
}
