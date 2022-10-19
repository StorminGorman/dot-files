" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set bg=light
set nowrap
autocmd BufNewFile,BufRead *.content   set syntax=html
autocmd BufNewFile,BufRead *.hbs   set syntax=html


:command S :e %:s?Include/??:s?\.h?.cpp?
:command I :e Include/%:s?.cpp?.h?
:command B :!make -j14 all-recursive
:command H :!make html

:map <c-z> :!bash<CR>
:nnoremap <Leader>l :ls<CR>:b<Space>
:set si ai 
:set expandtab
" :set number relativenumber autochdir
:set number relativenumber

call plug#begin()
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'paulkass/jira-vim', { 'do': 'pip install -r requirements.txt' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

let g:lsc_auto_map = v:true

" mappings for flutter
:map r :FlutterHotRestart<CR>

" mappings for paging
" :map ^[OA <C-bb>
" :map ^[OB <C-f>
" :map ^[OA ^Bb
" :map ^[OB ^F
" :map <S-K> <C-b>b
 ":map ^[OA ^B
 ":map ^[OB ^F

" mappings for vertical split window resize
 :map ^[OH 30^W<
 :map ^[OF 30^W>
 :map ^[[1~ 30^W<
 :map ^[[4~ 30^W>
 :map [25~ 30^W<
 :map [26~ 30^W>

" mappings for window nav
:map <C-h> h
:map <C-j> j
:map <C-k> k
:map <C-l> l

:map v :e ~/.vimrc
:map s :source ~/.vimrc

:map vp :VimuxPromptCommand<CR>

" set runtimepath^=~/.vim/bundle/ctrlp.vim
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_by_filename = 1

:set sw=2
:set ts=2

:map <C-z> :YcmCompleter FixIt
source /Users/bgorman/development/lsp-examples/vimrc.generated

:colorscheme darkblue

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

"function! Mysearch(text)
"        :call popup_notification(a:text, #{ line: 5, col: 10, height: 'WildMenu',} )
"endfunction
" mappings for paging
" :map ^[OA <C-bb>
" :map ^[OB <C-f>
:map K <C-b>b
:map J <C-f>
 ":map ^[OA ^B
 ":map ^[OB ^F

:map <C-d> :call Searchdartfiles('')<CR>
:map <C-s> :Files ~/development/bsi/workspace<CR>
:map S :call Searchbsi('')<CR>
:map D :call Searchdartworld('')<CR>

" comment out 

let @c='0i//j'
let @v='0xxj'
":map <C-c> 0i//j
:map <C-c> @c
:map <C-x> @v

:map <C-q> <C-w>b:%!tsc && mocha .<CR><C-w>p

set clipboard=unnamed

let $FZF_DEFAULT_OPTS="--bind \"alt-j:down,alt-k:up\""

function! Searchbsi(query, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let args = copy(a:000)
  let agargs = '-G "\.(xml|json|csv|tex|py|pl|rb|js|sh|php|ts|dart|scss|css|html|conf|yaml|yml|sql|cpp|h|c|content)$" --ignore-dir WebHelp --ignore-dir node_modules --ignore-dir dist'
  let command = agargs . ' ' . fzf#shellescape(query) . ' ~/development/bsi/workspace'
  " echo command
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

function! Searchdartworld(query, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let args = copy(a:000)
  let agargs = '-G "\.(dart)$" --ignore-dir WebHelp --ignore-dir node_modules --ignore-dir canvas'
  let command = agargs . ' ' . fzf#shellescape(query) . ' ~/development/bsi/workspace/dartlib ~/development/bsi/workspace/portico/client ~/development/bsi/workspace/AtriuumBuild/AtriuumData/dart'
  " echo command
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

function! Searchdartfiles(dir, ...)
  let args = {}
  if !empty(a:dir)
    if !isdirectory(expand(a:dir))
      return s:warn('Invalid directory')
    endif
    let slash = (s:is_win && !&shellslash) ? '\\' : '/'
    let dir = substitute(a:dir, '[/\\]*$', slash, '')
    let args.dir = dir
  else
    let dir = s:shortpath()
  endif

  let args.options = ['-m', '--prompt', strwidth(dir) < &columns / 2 - 20 ? dir : '> ']
  call s:merge_opts(args, get(g:, 'fzf_files_options', []))
"  args.source = 'find ~/development/bsi/workspace -name \*.dart';
  return fzf#run({'source': 'find ~/development/bsi/workspace -name \*.dart', 'sink': 'edit'}, args, a:000)
"  return fzf#run('files', args, a:000)
"  return s:fzf('files', args, a:000)
"  return s:fzf('files', args, a:000)
endfunction
