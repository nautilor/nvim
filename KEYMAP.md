| Mode | Keybind | Command | Extra |
|------|---------|----------|--------|
  "n"  |   "<tab>"  |   ":bnext<Return>"  |   opts  
  "n"  |   "<S-tab>"  |   ":bprev<Return>"  |   opts  
  "n"  |   "<leader>bd"  |   ":bd!<Return>"  |   opts  
  "t"  |   "<Esc>"  |   [[<C-\><C-n>]]  |    
  "n"  |   "<leader>q"  |   ":q<Return>"  |   opts  
  "n"  |   "<leader>!"  |   ":q!<Return>"  |   opts  
  "n"  |   "<C-s>"  |   ":w<Return>"  |    
  { "n" ,  "v" }  |   "<C-y>"  |   "\"+y"  |    
  { "n" ,  "v" }  |   "<C-p>"  |   "\"+p"  |    
  "n"  |   "q"  |   ""  |    
  { "n" ,  "i" }  |   "<F1>"  |   ""  |    
  "n"  |   "<leader>/"  |   ":nohlsearch<Return>"  |   opts  
  "v"  |   "<C-Down>"  |   ":m '>+1<CR>gv=gv"  |   opts  
  "v"  |   "<C-Up>"  |   ":m '<-2<CR>gv=gv"  |   opts  
  "v"  |   "<C-Left>"  |   "<gv"  |   opts  
  "v"  |   "<C-Right>"  |   ">gv"  |   opts  
  "n"  |   "<C-a>"  |   "gg<S-v>G"  |    
  "n"  |   "ss"  |   ":split<Return>"  |   opts  
  "n"  |   "sv"  |   ":svplit<Return>"  |   opts  
  "n"  |   "wd"  |   "<C-w><C-w>"  |   opts  
  "n"  |   "sd"  |   "<C-w>q"  |   opts  
  "n"  |   "<C-j>"  |   vim.diagnostic.goto_next  |   opts  
  "n"  |   "<C-l>"  |   ":LazyGit<Return>"  |   opts  
  "n"  |   "<leader><tab>"  |   ":Telescope find_files<Return>"  |   opts  
  "n"  |   "<leader>fg"  |   ":Telescope live_grep<Return>"  |   opts  
  "n"  |   "<leader>bb"  |   ":Telescope buffers<Return>"  |   opts  
  "n"  |   "<leader>gd"  |   ":Telescope lsp_definitions<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-tab>"  |   ":Telescope buffers<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-o>"  |   ":Telescope find_files<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-f>"  |   ":Telescope live_grep<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-tab>"  |   ":Telescope buffers<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-g>"  |   ":Telescope lsp_definitions<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-f>"  |   ":Telescope live_grep<Return>"  |   opts  
  "n"  |   "<leader>e"  |   ":NvimTreeToggle<Return>"  |   opts  
  { "i" ,  "n" }  |   "<C-b>"  |   ":NvimTreeToggle<Return>"  |   opts  
  "n"  |   "<leader>r"  |   vim.lsp.buf.rename  |    
  { "n" ,  "i" }  |   "<F2>"  |   vim.lsp.buf.rename  |    
  { "i" ,  "n" ,  "t" }  |   "<C-t>"  |   ":ToggleTerm direction=float<Return>"  |   opts  
  "n"  |   "<leader>gp"  |   ":Gitsign preview_hunk<Return>"  |   opts  
  "n"  |   "<C-n>"  |   toggleDired  |   opts  
  "n"  |   "<leader>lc"  |   toggle_latex_compiler  |   opts  
