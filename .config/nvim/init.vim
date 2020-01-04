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
set fileencodings=utf-8,usc-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"-->启用鼠标
set mouse=a
set selection=exclusive
"set selectmode=mouse.key
"-->启用粘贴 避免插入模式下粘贴内容时出现缩进变形问题
"set paste
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

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'morhetz/gruvbox'

call plug#end()
"
"
"
"
"--------------> 插件配置
"
"
"
"
"==============================================
"=              >>> 显示设置 <<<              =
"==============================================
"-->主题颜色
" colorscheme gruvbox
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
"
"
"
"--> 输入设置
"->括号输入格式
inoremap {<CR> {<CR>}<Esc>O<Tab>
inoremap (<CR> (<CR>)<Esc>O<Tab>
inoremap [<CR> {<CR>}<Esc>O<Tab>
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
"
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
