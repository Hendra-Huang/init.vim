"-----Plugins-----"
call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'pbogut/deoplete-padawan', { 'for': ['php', 'html.twig'] }
"Plug 'arnaud-lb/vim-php-namespace', { 'for': ['php'] }
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Yggdroot/indentLine'
Plug 'bronson/vim-trailing-whitespace'
Plug 'gregsexton/MatchTag', { 'for': ['html', 'htwml.twig'] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'jaawerth/neomake-local-eslint-first', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
"Plug 'mxw/vim-jsx', { 'for': ['jsx'] }
Plug 'beyondwords/vim-twig', { 'for': 'html.twig' }
Plug 'kassio/neoterm'
Plug 'alvan/vim-closetag'
Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()


"-----Theme-----"
set termguicolors
"colorscheme busierbee
"colorscheme wombat256
colorscheme gruvbox
let g:gruvbox_italic=1
set background=dark
"let g:gruvbox_contrast_dark = 'soft'


"-----Plugins-Config-----"

"--Vim-Airline--"
let g:airline#extensions#tabline#enabled = 0 "buffer indicator
let g:airline_powerline_fonts = 1 "powerline font for airline
let g:airline_theme='gruvbox'
"let g:airline_theme='wombat'

"--NerdTree--"
map <C-n> : NERDTreeToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

"--NeoSnippets--"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"--Deoplete--"
let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources = {}
"let g:deoplete#sources['php'] = ['file', 'buffer', 'tag', 'member', 'padawan']
"let g:deoplete#sources['html.twig'] = ['file', 'buffer', 'tag', 'member', 'padawan']
"let g:deoplete#sources['javascript'] = ['file', 'buffer', 'tag', 'member', 'ternjs']
"let g:deoplete#sources['javascript.jsx'] = ['file', 'buffer', 'tag', 'member', 'ternjs']
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"--DeopletePadawan--"
"command! StartPadawan call deoplete#sources#padawan#StartServer()
"command! StopPadawan call deoplete#sources#padawan#StopServer()
"command! RestartPadawan call deoplete#sources#padawan#RestartServer()

"--DeopleteTernJS--"
"let g:tern_request_timeout = 1
"let g:tern_show_signature_in_pum = '0'

"--PHP-CS-Fixer--"
let g:php_cs_fixer_level = "symfony" "which level ?
let g:php_cs_fixer_fixers_list = "-psr0" "Disable PSR-0.
let g:php_cs_fixer_config = "default" "configuration
let g:php_cs_fixer_php_path = "php" "Path to PHP
let g:php_cs_fixer_dry_run = 0 "Call command with dry-run option
let g:php_cs_fixer_verbose = 0 "Return the output of command if 1, else an inline information.

"--VimJSX--"
"let g:jsx_ext_required = 0

"--NeoMake--"
let g:neomake_warning_sign = {
\ 'text': 'W',
\ 'texthl': 'WarningMsg',
\ }
let g:neomake_error_sign = {
\ 'text': 'E',
\ 'texthl': 'ErrorMsg',
\ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_php_enabled_makers = ['php']
let g:neomake_verbose = 1
autocmd! BufWritePost * Neomake

"--Vim-Flow--"
let g:flow#autoclose = '1'

"--Vim-Go--"
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

"--vim-php-namespace--"
"set tags+=.tags,.tags.vendors
"function! IPhpInsertUse()
    "call PhpInsertUse()
    "call feedkeys('a',  'n')
"endfunction
"autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
"autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"--vim-autotag--"
"let g:autotagTagsFile=".tags"

"--vim-closetag--"
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.twig,*.js"

"--vim-neoterm--"
tnoremap <Esc> <C-\><C-n>
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

"-----Vim-Config-----"
let g:user_emmet_leader_key='<C-a>'
let g:indentLine_enabled = 2
let g:indentLine_color_term = 132
let g:indentLine_faster = 1
autocmd QuickFixCmdPost *grep* cwindow

set et
set sw=4
set ts=4
set smarttab
set number
set autoindent
set copyindent
set smartindent
set smarttab
set foldmethod=indent
set foldlevel=99
set clipboard=unnamed
set mouse=a
set completeopt=longest,menuone,preview
set showcmd
set showmode
set backspace=indent,eol,start
let mapleader=','

syntax on

"-----Key-Mapping-----"
set pastetoggle=<F2>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-t> :tabnew<CR>
map <S-h> gT
map <S-l> gt
map <C-_> <C-w>_
tnoremap <Leader>e <C-\><C-n>

map <C-P> :FZF <CR>
map <F1> :FixWhitespace <CR>
autocmd! BufWritePre * FixWhitespace

"--NeoSnippets--"
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"-----Auto-Commands-----"

"--Auto-source-vimrc--"
augroup autosourcing
    autocmd!
    autocmd BufWritePost ~/.config/nvim/init.vim source %
augroup END

"--Sync-syntax--"
autocmd BufEnter * :syntax sync fromstart

"--Spacing-file-types--"
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
autocmd Filetype less setlocal ts=2 sts=2 sw=2
autocmd Filetype stylus setlocal ts=4 sts=4 sw=4
autocmd Filetype scss setlocal ts=4 sts=4 sw=4
autocmd Filetype twig setlocal ts=2 sts=2 sw=2
autocmd Filetype php setlocal ts=4 sts=4 sw=4
autocmd Filetype blade setlocal ts=4 sts=4 sw=4
autocmd Filetype html.twig setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype scala setlocal ts=4 sts=4 sw=4
