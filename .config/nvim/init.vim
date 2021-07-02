"=================================================================
"         _        _                        _                    
"  _   __(_)____  (_)___ __  __      _   __(_)___ ___  __________
" | | / / / ___/ / / __ `/ |/_/_____| | / / / __ `__ \/ ___/ ___/
" | |/ / / /__  / / /_/ />  </_____/| |/ / / / / / / / /  / /__  
" |___/_/\___/_/ /\__,_/_/|_|     (_)___/_/_/ /_/ /_/_/   \___/  
"           /___/                                                
"=================================================================

"==============================================
"=              >>> 基本设置 <<<              =
"==============================================

"-->关闭vi的兼容模式 使用vim的新特性
set nocompatible
"-->设置中文不乱码
"-->windows下激活python模块(可以忽略此项)
"if(has("win32")||has("win64")||has("win16"))
"    let g:python3_host_prog='the\path\to\python3.exe'
"    let g:python_host_prog='the\path\to\python.exe'
"endif
"-->linux下激活python模块 安装pynvim支持后可以不用指定
"let g:python3_host_prog='/usr/bin/python3'
"let g:python_host_prog='/usr/bin/python'
set fileencodings=utf-8,usc-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"-->启用鼠标
set mouse=a
"-->启用全局剪贴板
set clipboard+=unnamedplus
set selection=exclusive
"set selectmode=mouse.key
"-->启用粘贴 避免插入模式下粘贴内容时出现缩进变形问题
set paste
"-->配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"-->显示命令
set showcmd
"-->命令智能补全
set wildmenu
"
"
"
"
"==============================================
"=              >>> 插件管理 <<<              =
"==============================================
call plug#begin()

"--> 按键映射插件
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"--> 主题 
Plug 'morhetz/gruvbox'
"--> 文件管理
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"->defx支持插件
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
"->coc代码提示插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"->fzf模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()
"
"
"
"=====================================
"              插件配置
"-------------------------------------
"--> Defx文件管理配置
"-------------------------------------
call defx#custom#option('_',{
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'botright',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'toggle': 1, 
    \ 'resume': 1
    \})

"-->打开文件树
map <silent><C-e> :Defx<CR>
"-> 默认情况下自动打开文件树
" autocmd vimenter * Defx
"-->键盘映射
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
"    IndentLinesDisable
    setl nospell
    setl signcolumn=no
    setl nonumber

    "->Define Key Mappings
    nnoremap <silent><buffer><expr> <CR>
	    \ defx#is_directory() ?
    	    \ defx#do_action('open_or_close_tree') :
    	    \ defx#do_action('drop',)
    nmap <silent><buffer><expr> <2-LeftMouse>
	    \ defx#is_directory() ?
    	    \ defx#do_action('open_or_close_tree') :
    	    \ defx#do_action('drop',)
    nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
    nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> C defx#do_action('copy')
    nnoremap <silent><buffer><expr> P defx#do_action('paste')
    nnoremap <silent><buffer><expr> M defx#do_action('rename')
    nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> + defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction
" Defx git图标配置
let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1
"
"==============================================
"=              >>> 显示设置 <<<              =
"==============================================
"-->主题颜色
"colorscheme gruvbox
"-->设置背景透明
highlight Normal guibg=NONE ctermbg=None
highlight NonText guibg=NONE ctermbg=None
"-->显示行号 == set nu
set number
"-->高亮当前行 == set cul
"set cursorline
"-->突出显示当前列 == set cuc
"set "cursorcolumn
"-->显示括号匹配
"set showmatch
"-->显示空格和tab键
set listchars=tab:>-,trail:-
"-->显示状态栏
set laststatus=2
"-->显示光标当前位置
set ruler
"-->开启语法高亮
syntax enable
"-->自动换行
set wrap
"-->末尾预留行
set scrolloff=3
"
"
"
"
"==============================================
"=              >>> 按键映射 <<<              =
"==============================================
"-->设置前缀键 即<Leader>键
let g:mapleader="\<Space>"
let g:maplocalleader=','
nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>Whichkey ','<CR>

"->保存和退出
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>W :wa<CR>
nmap <Leader>WQ :q<CR>
nmap <Leader>Q :q!<CR>
nmap <Leader>s :wq<CR>
"->窗口切换
nmap <Leader>nw <C-W><C-W>
nmap <Leader>hw <C-W>h
nmap <Leader>jw <C-W>j
nmap <Leader>kw <C-W>k
nmap <Leader>lw <C-W>l
"->窗口调整
nmap <Leader><left> <C-W><
nmap <Leader><right> <C-W>>
nmap <Leader><up> <C-W>-
nmap <Leader><down> <C-W>+
"->符号匹配设置
nmap <Leader>M %
"
"--> 输入设置
"->括号输入格式
inoremap {<CR> {<CR>}<Esc>O<Tab>
inoremap (<CR> (<CR>)<Esc>O<Tab>
inoremap [<CR> {<CR>}<Esc>O<Tab>
"->系统剪贴板映射
"->如果启用全局剪切板 则默认y p 会复制一份到 “+ 同下
map <C-Y> "+y<CR>
map <C-P> "+p<CR>
"
"
"
"
"
"
"
"
"==============================================
"=              >>> 格式设置 <<<              =
"==============================================
"-->设置智能tab
set smarttab
"-->设置tab长度
set softtabstop=4
"-->设置自动缩进的长度
set shiftwidth=4
"-->继承前一行的缩进方式，适用于多行注释
"set autoindent
"-->智能缩进 可以看作是autoindent的升级版
set smartindent
"设置C语言的缩进方式
"set cindent
"函数折叠
"set foldmethod=indent
"
"
"
"==============================================
"=              >>> 文件相关 <<<              =
"==============================================
"-->打开文件类型检测
"filetype on
"-->根据文件类型加载插件
"filetype plugin on
"-->根据文件类型设置缩进
"filetype indent on
"-->三条命令整合
filetype plugin indent on
"
"
"
"
"==============================================
"=              >>> 搜索相关 <<<              =
"==============================================
"-->开启实时搜索
set incsearch
"-->忽略大小写
set ignorecase
"-->智能大小写匹配
set smartcase
"-->搜索词高亮
set hlsearch
"-->取消上次搜索词高亮
exec "nohlsearch"
"
"
"
"
"==============================================
"=              >>> ide配置  <<<              =
"==============================================
map <F5> :call RunCode()<CR>
function! RunCode()
    exec "w"
    if &filetype == 'python'
	exec "!python %"
    endif
    if &filetype == 'c'
"	exec "!gcc % -o %<&& ./%<"
	exec "!gcc % -o %<&& %<"
    endif
endfunction

"-->python配置
"-->c++配置
