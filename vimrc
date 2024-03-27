"" ------------------------
""  GENERAL 
"" ------------------------

set  nocompatible
filetype plugin indent on
syntax on
let g:is_posix = 1  " correctly highlight $() if filetype=sh
set wildmenu                        " visual autocomplete for command menu
set showmatch                       " highlight matching !!important!!
set showcmd                         " show command in bottom bar
"syntax enable
set linebreak
set noerrorbells
set autoindent
set expandtab
set smartindent
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set complete-=i
set rnu
set smartcase
set colorcolumn=80
set hidden      " switch b/w buffers without having to save first
set noswapfile
set nobackup
set undodir=~/.vim/undodir  " need to create dir if DNE
set undofile
set incsearch   " highlight matches from ? and /
set laststatus=2 
set wrapscan    " wrap search results
set splitbelow
set splitright
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set incsearch
set laststatus=2
set ruler
set wildmenu
set wildignore+=*/tmp/*,*.so,*.zcignore,*.zip  " ignore specific files and directories
set scrolloff=1
set sidescroll=1
set sidescrolloff=2
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set autoread
set history=1500
set tabpagemax=50
set viminfo^=!
setglobal tags-=./tags tags-=./tags; tags^=./tags;

" stop saving session option/view files 
set sessionoptions-=options
set viewoptions-=options


"  start cursor at previous sessions last line
if has("autocmd")
	  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	      \| exe "normal! g'\"" | endif
  endif

" remap CTRL-L to clear highlighting from 'hlsearch' AND call :diffupdate
nnoremap <silent> <C-L>
:nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>


"" ------------------------
"" REMAPS
"" ------------------------

" leader 


" recover accidentally deleted text with undo (`u` in normal mode)
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

#  tmux-like commands for better window navigation remaps (change to mirror tmux)
nnoremap <C-h> <C-w>h      
nnoremap <C-j> <C-w>j      
nnoremap <C-k> <C-w>k      
nnoremap <C-l> <C-w>l      
nnoremap <leader>, <C-w>w
nnoremap <silent> vv <C-w>v


"" ------------------------
""  VIM-PLUG
"" ------------------------

call plug#begin('~/.vim/plugged')

# core plugins 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-utils/vim-man'
Plug 'preservim/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
call plug#end()


"" ------------------------
"" PLUGIN CONFIG/REMAP
"" ------------------------


"" colorscheme
set t_Co=256
set background=dark
let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_uniform_diff_background = 1
"let g:nord_italic = 1
""let g:nord_italic_comments = 1
colorscheme nord

""  vim-airline configs.
set showtabline=2   " always show tabs
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline_left_sep = '>'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter ='short_path_improved'
let g:airline#extensions#tabline#buffer_min_count = 0

" undodir
noremap <leader>u :UndotreeShow<CR>

" tagbar
nmap <leader>b :TagbarToggle<CR>


"" vim-tmux navigator
let g:tmux_navigator_save_on_switch = 1     " write current buffer, but only if changed
let g:tmux_navigator_no_wrap = 1            " disable default wrapping behavior

"" vimux 
" creates new vimux prompt for running  terminal command  `<LEADER>vp`
map <Leader>vp :VimuxPromptCommand<CR>      

" `<LEADER> vl>` - run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" inspect runner pane		(used to inspect/grab part of command output)
map <Leader>vi :VimuxInspectRunner<CR>

" zoom the tmux runner pane		(zoom in on vimux prompt)
map <leader>vz :VimuxZoomRunner<CR>


"" ale

" lint on save only 
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0  " disable fixer 

" error symbols
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" error strings format 
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" easier error cycling w/ `CTRL-e` 
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" display number of errors/warnings in status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d. %d● ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

"" ultisnip super-tab enhanced TAB COMPLETE
"" better key bindings for UltiSnipsExpandTrigger
let g:SuperTabDefaultCompletionType = '<tab>'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"		" default is horizontal
" for custom snippets create <snip type>_custom.<snip file extension>`


function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
