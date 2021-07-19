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
"Section: Basic

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
"set paste
"-->配置变更立即生效 
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"-->显示命令
set showcmd
"-->命令智能补全
set wildmenu





"==============================================
"=              >>> 插件管理 <<<              =
"==============================================
"Section: Plugin

call plug#begin()

"--> 按键映射插件
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"->coc代码提示插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"->snippets 代码片段补全插件
Plug 'honza/vim-snippets'
"--> 主题 
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'wadackel/vim-dogrun'
Plug 'tomasr/molokai'
Plug 'sainnhe/sonokai'
Plug 'rakr/vim-one'
"--> 括号自动补全
"Plug 'jiangmiao/auto-pairs'
"--> 底部状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
"->fzf模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"->markdown配置
"markdown 高亮插件 
"tabular plugin is used to format tables
Plug 'godlygeek/tabular'
"JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
"markdown预览插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
"Nerdcommenter代码注释插件
Plug 'preservim/nerdcommenter'

call plug#end()

"
"
"
"=====================================
"              插件配置
"-------------------------------------
"--> Defx文件管理配置
"-------------------------------------
"Section:Plugin.Defx

call defx#custom#option('_',{
    \ 'winwidth': 25,
    \ 'split': 'vertical',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'direction': 'topleft',
    \ 'toggle': 1, 
    \ 'resume': 1
    \})

"-->打开文件树
map <silent><C-e> :Defx -columns=icons:indent:filename:type<CR>
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


"-------------------------------------
"--> coc扩展配置
"-------------------------------------
"-> coc本体配置
"Section: Plugin.coc

" TextEdit might fail if hidden is not set.
set hidden
"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space () ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"--> prettier 代码格式化插件
"Section:Plugin.coc.prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader><C-l> <Plug>(coc-format-selected)

"--> snippets 代码片段插件
"Section:Plugin.coc.snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <C-TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<C-TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"--> 新的coc扩展配置 请复制这两行
"Section:Plugin.coc.new







"--> 新的coc扩展配置 请复制这两行
"Section:Plugin.coc.new





"-------------------------------------
"--> 底部状态栏配置
"-------------------------------------
"Section:Plugin.airline
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
let g:airline_theme='moloai'  " murmur配色不错

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'




"-------------------------------------
"--> vim-markdwon 高亮插件
"-------------------------------------
"Section:Plugin.vim-markdown

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format






"-------------------------------------
"--> markdown preview 配置
"-------------------------------------
"Section.Plugin.markdown-preview
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']




"-------------------------------------
"--> Nerdcommenter代码注释插件
"-------------------------------------
"Section:Plugin.nerdcommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1






"-------------------------------------
"--> 新的插件复制该部分
"-------------------------------------
"Section:Plugin.airline







"==============================================
"=              >>> 显示设置 <<<              =
"==============================================
"Section:Display
"-->设置背景透明
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
"-->主题颜色
" Important!!
if has('termguicolors')
    set termguicolors
endif

"Section:Display.colorscheme
" The configuration options should be placed before 
" `colorscheme sonokai`.
let g:sonokai_style = 'shusia' 
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai

" `colorscheme ayu`.
let ayucolor="light"  " for light version of theme
let ayucolor="dark"   " for dark version of theme
let ayucolor="mirage" " for mirage version of theme
"colorscheme ayu

" `colorscheme one`
let g:airline_theme='one'
let g:one_allow_italics = 1 " I love italic for comments
set background=dark        " for the light version
colorscheme one

"colorscheme molokai
"colorscheme gruvbox
"colorscheme dogrun



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
"set ruler
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
"Section:Keymapping
"-->设置前缀键 即<Leader>键
let g:mapleader="\<Space>"
let g:maplocalleader=','
nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>Whichkey ','<CR>

"->保存和退出
nmap <Leader>qq :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>W :wa<CR>
nmap <Leader><C-S> :wq<CR>
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
"inoremap {<CR> {<CR>}<Esc>O<Tab>
"inoremap (<CR> (<CR>)<Esc>O<Tab>
"inoremap [<CR> {<CR>}<Esc>O<Tab>
"->系统剪贴板映射
"->如果启用全局剪切板 则默认y p 会复制一份到 “+ 同下
"map <C-Y> "+y<CR>
"map <C-P> "+p<CR>





"==============================================
"=              >>> 格式设置 <<<              =
"==============================================
"Section:Format
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
"设置隐藏级别
"markdown中斜体 粗体等标记符号隐藏 0：不隐藏 1: 空格代替标识符 2:
"隐藏标识符
set conceallevel=0
"
"
"
"==============================================
"=              >>> 文件相关 <<<              =
"==============================================
"Section:File 
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
"SectionL:Search
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
"Section:IDE
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
