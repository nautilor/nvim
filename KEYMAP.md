| Mode | Keybind | Command | Extra |
|------|---------|----------|--------|
  { "n" ,  "v" }  |   "\<S-Down>"  |   "3j"  |   opts  
  { "n" ,  "v" }  |   "\<S-Up>"  |   "3k"  |   opts  
  "n"  |   "\<C-/>"  |   "gcc"  |   opts  
  "v"  |   "\<C-/>"  |   'gc'  |   opts  
  { "n" ,  "v" }  |   "x"  |   '"_x'  |   nopts  
  "v"  |   "p"  |   ':call setreg("", @", "V") \| put<Return>' | nopts
  "n"  |   "\<tab>"  |   ":bnext\<Return>"  |   nopts  
  "n"  |   "\<S-tab>"  |   ":bprev\<Return>"  |   nopts  
  "n"  |   "\<leader>bd"  |   ":bd!\<Return>"  |   nopts  
  "t"  |   "\<Esc>"  |   \[\[\<C-\>\<C-n>]]  |    
  "n"  |   "\<leader>q"  |   ":q\<Return>"  |   nopts  
  "n"  |   "\<leader>!"  |   ":q!\<Return>"  |   nopts  
  "n"  |   "\<C-s>"  |   ":w\<Return>"  |    
  { "n" ,  "v" }  |   "\<C-y>"  |   "\"+y"  |    
  { "n" ,  "v" }  |   "\<C-p>"  |   "\"+p"  |    
  "n"  |   "q"  |   ""  |    
  { "n" ,  "i" }  |   "\<F1>"  |   ""  |    
  "n"  |   "\<leader>/"  |   ":nohlsearch\<Return>"  |   nopts  
  "v"  |   "\<C-Down>"  |   ":m '>+1\<CR>gv=gv"  |   nopts  
  "v"  |   "\<C-Up>"  |   ":m '\<-2\<CR>gv=gv"  |   nopts  
  "v"  |   "\<C-Left>"  |   "\<gv"  |   nopts  
  "v"  |   "\<C-Right>"  |   ">gv"  |   nopts  
  "n"  |   "\<C-a>"  |   "gg\<S-v>G"  |    
  "n"  |   "ss"  |   ":split\<Return>"  |   nopts  
  "n"  |   "sv"  |   ":vsplit\<Return>"  |   nopts  
  "n"  |   "wd"  |   "\<C-w>\<C-w>"  |   nopts  
  "n"  |   "sd"  |   "\<C-w>q"  |   nopts  
  "n"  |   "sk"  |   ":bp \| bd #\<Return>"  |   nopts  
  "n"  |   "\<C-w>d"  |   ":bp \| bd #\<Return>"  |   nopts  
  "n"  |   "\<C-j>"  |   vim.diagnostic.goto_next  |   nopts  
  "n"  |   "\<C-l>"  |   ":LazyGit\<Return>"  |   nopts  
  "n"  |   "\<C-w>b"  |   "\<C-o>"  |   nopts  
  "n"  |   "\<C-w>f"  |   "\<C-i>"  |   nopts  
  { "i" ,  "n" }  |   "\<C-o>"  |   function( require("snacks".picker.files() end  |   nopts  
  { "i" ,  "n" }  |   "\<C-f>"  |   function( require("snacks".picker.grep() end  |   nopts  
  "n"  |   "\<leader>bb"  |   function( require("snacks".picker.buffers() end  |   nopts  
  "n"  |   "\<leader>gd"  |   function( require("snacks".picker.lsp_definitions() end  |   nopts  
  "n"  |   "\<leader>gf"  |   function( require("snacks".picker.lsp_references() end  |   nopts  
  "n"  |   "\<leader>fm"  |   function( require("snacks".zen() end  |   nopts  
  { "n" ,  "v",  "t",   "i" }  |   "\<C-t>" | :ToggleTerm direction=float<Return> | nopts 
  "n"  |   "\<leader>e"  |   ":NvimTreeToggle\<Return>"  |   nopts  
  { "i" ,  "n" }  |   "\<C-b>"  |   ":NvimTreeToggle\<Return>"  |   nopts  
  "n"  |   "\<leader>r"  |   vim.lsp.buf.rename  |    
  { "n" ,  "i" }  |   "\<F2>"  |   vim.lsp.buf.rename  |    
  "n"  |   "\<leader>gp"  |   ":Gitsign preview_hunk\<Return>"  |   nopts  
  "n"  |   "\<leader>os"  |   ":Obsidian quick_switch\<CR>"  |    
  "n"  |   "\<leader>on"  |   ":Obsidian new\<CR>"  |    
  "n"  |   "\<leader>oo"  |   ":cd ~/.obsidian/Notes/\<CR>"  |    
  "n"  |   "\<leader>lc"  |   toggle_latex_compiler  |   opts  
