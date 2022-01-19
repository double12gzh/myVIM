set encoding=utf-8
set nocompatible                                                    " explicitly get out of vi-compatible mode
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1

"在.vimrc中配置 cscopetag则在Ctrl + ]出现时出现选择 tag，
"若有同名函数，则手动进行选择；
"若想跳转到第一条匹配的只需要set nocscopetag即可。
set cscopetag


filetype off                                                        " required!

" This loads all the plugins in ~/.vim/bundle
" Use vundle plugin to manage all other plugins
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'
"Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'airblade/vim-gitgutter'
Plugin 'dgryski/vim-godef'
Plugin 'ervandew/supertab'                                          " Perform all your vim insert mode completions with Tab(https://github.com/ervandew/supertab)
Plugin 'flazz/vim-colorschemes'                                     " Color Schema(https://github.com/flazz/vim-colorschemes)
Plugin 'nvie/vim-flake8.git'                                        " Flake8 plugin for Vim(https://github.com/nvie/vim-flake8)
Plugin 'rodjek/vim-puppet'                                          " Puppet niceties for your Vim setup(https://github.com/rodjek/vim-puppet)
Plugin 'kien/ctrlp.vim'                                             " Fuzzy file, buffer, mru, tag, etc finder(https://github.com/kien/ctrlp.vim)
Plugin 'davidhalter/jedi-vim'                                       " Using the jedi autocompletion library for VIM
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'

"begin: markdown
Plugin 'suan/vim-instant-Markdown'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
"end: markdown

Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
"Plugin 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" vim-scripts repos
Plugin 'L9'
Plugin 'python.vim'
Plugin 'will133/vim-dirdiff'

" 自动载入ctags gtags
if version >= 800
    Plugin 'ludovicchabant/vim-gutentags'
    Plugin 'skywind3000/gutentags_plus'

    let $GTAGSLABEL = 'native-pygments'
    let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

    " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持：
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 如果使用 universal ctags 需要增加下面一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 禁用 gutentags 自动加载 gtags 数据库的行为
    " 避免多个项目数据库相互干扰
    " 使用plus插件解决问题
    let g:gutentags_auto_add_gtags_cscope = 0
    let g:gutentags_plus_nomap = 1

    " 预览 quickfix 窗口 ctrl-w z 关闭
    Plugin 'skywind3000/vim-preview'

    " P 预览 大p关闭
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
    noremap <Leader>u :PreviewScroll -1<cr>                         " 往上滚动预览窗口
    noremap <leader>d :PreviewScroll +1<cr>                         " 往下滚动预览窗口

    map <F5> :PreviewTag<CR>

    " 设置gutentags_plus
    noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
    noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
    noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
    noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
    noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
    noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
    noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
endif

Plugin 'w0rp/ale'
" 对应语言需要安装相应的检查工具
" https://github.com/w0rp/ale
"    let g:ale_linters_explicit = 1                                 " 除g:ale_linters指定，其他不可用
"    let g:ale_linters = {
"\   'cpp': ['cppcheck','clang','gcc'],
"\   'c': ['cppcheck','clang', 'gcc'],
"\   'python': ['pylint'],
"\   'bash': ['shellcheck'],
"\   'go': ['golint'],
"\}
"

let g:ale_sign_column_always = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
"let g:ale_set_quickfix = 1
"let g:ale_open_list = 1                                            " 打开quitfix对话框

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"let g:ale_sign_error = 'e'
let g:ale_sign_warning = 'w'
let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '⚡'
map <F8> ::ALEToggle<CR>

" vim-signify
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-fugitive'

" 设置要检查的VCS
let g:signify_vcs_list = ['git', 'hg']

" 插入模式下指定updatetime时间后无操作将缓存区交换文件写入磁盘
let g:signify_cursorhold_insert     = 1

" 正常模式下指定updatetime时间后无操作将缓存区交换文件写入磁盘
let g:signify_cursorhold_normal     = 1

" 缓冲区被修改时更新符号
let g:signify_update_on_bufenter    = 0

" vim获取焦点时更新符号
let g:signify_update_on_focusgained = 1

" 键盘映射
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDebug<CR>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

map <F9> ::SignifyDiff<CR>

call vundle#end()                                                   " required

filetype plugin indent on                                           " required


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :Plug foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"------------------------------------------------------------
" General Config

set ruler                                                           " Show ruler
set number                                                          " Line numbers are good
set backspace=indent,eol,start                                      " Allow backspace in insert mode
set history=1000                                                    " Store lots of :cmdline history
set showcmd                                                         " Show incomplete cmds down the bottom
set showmode                                                        " Show current mode down the bottom
set gcr=a:blinkon0                                                  " Disable cursor blink
set novisualbell                                                    " No sounds
set noerrorbells                                                    " No noise
set autoread                                                        " Reload files changed outside vim
set history=256                                                     " Number of things to remember in history
set showmatch                                                       " Show matching brackets
set laststatus=2                                                    " Always show status line
set t_Co=256                                                        " As I use dark background in mac, I also can use this colorscheme on mac
set nobackup
set nowb
set list listchars=tab:\ \ ,trail:·                                 " Display tabs and trailing spaces visually
set linebreak                                                       " Wrap lines at convenient points
set ts=4
set ignorecase

syntax on                                                           " Turn on syntax highlight

" Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
set undodir=~/.vim/backups
set undofile

" Search Options
set incsearch                                                       " Find the next match as we type the search
set hlsearch                                                        " Hilight searches by default
set viminfo='100,f1                                                 " Save up to 100 marks, enable capital marks

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set incsearch

" Folds
set foldmethod=indent                                               " fold based on indent
set foldnestmax=3                                                   " deepest fold is 3 levels
set nofoldenable                                                    " dont fold by default

" Leader setting
let mapleader = ","                                                 " rebind <Leader> key

" ==== 系统剪切板复制粘贴 ====
" v 模式下复制内容到系统剪切板
vmap <Leader>c "+yy
" n 模式下复制一行到系统剪切板
nmap <Leader>c "+yy
" n 模式下粘贴系统剪切板的内容
nmap <Leader>v "+p

" Custom mappings
vnoremap < <gv                                                      " better indentation
vnoremap > >gv                                                      " better indentation
map <Leader>a ggVG                                                  " select all

" Movement
" bind Ctrl + <movement> keys to move around the windows,
" instead of using Ctrl + w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tabs
map <Leader>, <esc>:tabprevious<CR>
map <Leader>. <esc>:tabnext<CR>

" sort
vnoremap <Leader>s :sort<CR>

" Show trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//


"------------------------------------------------------------
" Schema settings, for iterm2 settings
"
" References:
"   http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
"   https://github.com/altercation/solarized


try
  colorscheme desert256
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

set hidden


"------------------------------------------------------------
" set file type indent
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " http://linux-wiki.cn/wiki/zh-hans/%E9%85%8D%E7%BD%AE%E5%9F%BA%E4%BA%8EVim%E7%9A%84Python%E7%BC%96%E7%A8%8B%E7%8E%AF%E5%A2%83
  autocmd FileType python set ai tabstop=4 shiftwidth=4 softtabstop=4 et
  " http://stackoverflow.com/questions/2063175/vim-insert-mode-comments-go-to-start-of-line
  autocmd FileType python set foldmethod=indent nosmartindent
augroup END


"------------------------------------------------------------
" Completion
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip                            " MacOSX/Linux

"------------------------------------------------------------
let NERDTreeWinPos=0
"let NERDTreeWinPos='left'
let NERDTreeWinSize=35
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']

" tag bar
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 35
map <F3> :Tagbar<CR>

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" ag
map <F6> :Ag<CR>
map <F7> :FZF<CR>


"------------------------------------------------------------
" Python

" http://linux-wiki.cn/wiki/zh-hans/%E9%85%8D%E7%BD%AE%E5%9F%BA%E4%BA%8EVim%E7%9A%84Python%E7%BC%96%E7%A8%8B%E7%8E%AF%E5%A2%83
" forbidden PyFlakes to use QuickFix, Press F7 will call flake8
let g:pyflakes_use_quickfix = 0

" ignore part of errors
let g:flake8_ignore="E501"

"------------------------------------------------------------
" Settings for ctrlp
let g:ctrlp_max_height = 30
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

"------------------------------------------------------------
" Settings for ctrlp
let g:ctrlp_max_height = 30
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]

map <F4> :CtrlPMixed<CR>
"------------------------------------------------------------
" Show Colume Vertical Line in column 74
"highlight ColorColumn ctermbg=gray
"set colorcolumn=74

"begin: setup vim-aireline
let g:airline_powerline_fonts = 1

"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"设置切换Buffer快捷键"
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline_theme='dark'

if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
"end: setup vim-aireline

" begin: setup indentLine
let g:indentLine_setColors = 1
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char='┆'
" end: setup indentLine

let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79

inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O

" begin: vim-go

" https://github.com/fatih/vim-go/wiki/Tutorial
set autowrite
let g:AutoClosePreserveDotReg = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:godef_split=2
let g:go_version_warning = 0
let g:go_fmt_autosave = 1

let g:go_highlight_types = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" end: vim-go

let g:ackprg = 'ag --nogroup --nocolor --column'

" ag 的时候不搜索文件名字中的关键字
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

let &t_TI = ""
let &t_TE = ""

" 如果希望自动出现代码提示而不是需要按ctrl+x+o才出现，可以把这行的注释去掉
au filetype go inoremap <buffer> . .<C-x><C-o>

" 只弹出代码提示，不补全
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
