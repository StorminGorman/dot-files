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

" :map <c-z> :!bash<CR>
:nnoremap <Leader>l :ls<CR>:b<Space>
:set si ai 
:set expandtab
" :set number relativenumber autochdir
:set number relativenumber

execute pathogen#infect()
syntax on
filetype plugin indent on

call plug#begin()
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'paulkass/jira-vim', { 'do': 'pip install -r requirements.txt' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
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
 :nnoremap <C-m> <C-w>_<C-w>\|
 ":unmap <C-n>
 :nnoremap <leader>= <C-w>=
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
:nnoremap K {
:map J }
:map P <C-f>
:map { <C-b>b
 ":map ^[OA ^B
 ":map ^[OB ^F


" searching bindings
:map <C-d> :call Searchdartfiles('')<CR>
:map <C-s> :Files ~/work<CR>
:nnoremap <leader>' :Files ~/work<CR>
:nnoremap <leader>/ :call Searchbsi('')<CR>
:nnoremap <leader>; :call Searchdartworld('')<CR>
:map S :call Searchbsi('')<CR>
:map D :call Searchdartworld('')<CR>

" comment out 

let @c='0i//j'
let @v='0xxj'
let @q='xi/**/^[<80><fd>ahhp^[<80><fd>a^[<80><fd>a0'


":map <C-c> 0i//j
:map <C-c> @c
:map <C-x> @v

:map <C-u> :new \| r ! curl -s 


set clipboard=unnamed

let $FZF_DEFAULT_OPTS="--bind \"alt-j:down,alt-k:up\""


function! TypescriptModeOn()
  let g:netrw_list_hide='^.*.js.map$\|.*.js$'
  ":map <C-q> :call RunMocha()<CR>
  " GoTo code navigation.
  :nmap <silent> gd <Plug>(coc-definition)
  :nmap <silent> gy <Plug>(coc-type-definition)
  :nmap <silent> gi <Plug>(coc-implementation)
  :nmap <silent> gr <Plug>(coc-references)
endfunction

function! TypescriptModeOff()
  let g:netrw_list_hide=''
  :unmap <C-q>
endfunction

function! Searchbsi(query, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let args = copy(a:000)
  let agargs = '-G "\.(xml|json|csv|tex|py|pl|rb|js|sh|php|ts|dart|scss|css|html|conf|yaml|yml|sql|cpp|h|c|content)$" --ignore-dir WebHelp --ignore-dir node_modules --ignore-dir dist'
  let command = agargs . ' ' . fzf#shellescape(query) . ' ~/work/*'
  echo command
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

function! Searchdartworld(query, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let args = copy(a:000)
  let agargs = '-G "\.(dart)$" --ignore-dir WebHelp --ignore-dir node_modules --ignore-dir canvas'
  let command = agargs . ' ' . fzf#shellescape(query) . ' ~/work/dartlib ~/work/portico/client ~/work/AtriuumBuild/AtriuumData/dart'
  " echo command
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

function! Searchdartfiles(dir, ...)
"  :cd ~/work
  :call fzf#vim#ag(' ', fzf#vim#with_preview('up:60%'))
"  let args = {}
"  if !empty(a:dir)
"    if !isdirectory(expand(a:dir))
"      return s:warn('Invalid directory')
"    endif
"    let slash = (s:is_win && !&shellslash) ? '\\' : '/'
"    let dir = substitute(a:dir, '[/\\]*$', slash, '')
"    let args.dir = dir
"  else
"    let dir = s:shortpath()
"  endif
"
"  let args.options = ['-m', '--prompt', strwidth(dir) < &columns / 2 - 20 ? dir : '> ']
"  call s:merge_opts(args, get(g:, 'fzf_files_options', []))
"  return fzf#run({'source': 'find ~/work -name \*.dart', 'sink': 'edit'}, args, a:000)
endfunction

function! FirebaseEmulator() 
  split __FIREBASE_OUT__
  normal! ggdG
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:fire_job = job_start('/bin/bash -c "cd ~/work/portico/server && firebase emulators:start"', {
        \ 'out_io': 'buffer',
        \ 'out_name': '__FIREBASE_OUT__',
        \ 'err_io': 'buffer',
        \ 'err_name': '__FIREBASE_OUT__',
        \ 'exit_cb': 'FirebaseEmulatorExit',
        \ })

  if job_status(g:fire_job) == 'fail'
    echo 'Could not start firebase emulator'
    unlet g:fire_job
  endif
endfunction

function! FirebaseStop()
  call job_stop(g:fire_job)
  unlet g:fire_job
endfunction

function! FirebaseEmulatorExit(job, status) 
  call FirebaseStop()
endfunction

function! TWatch() 
  split __TSC_OUT__
  normal! ggdG
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:tsc_job = job_start('tsc -w', {
        \ 'out_io': 'buffer',
        \ 'out_name': '__TSC_OUT__',
        \ 'err_io': 'buffer',
        \ 'err_name': '__TSC_OUT__',
        \ 'exit_cb': 'TypescriptWatchExit',
        \ })

  if job_status(g:tsc_job) == 'fail'
    echo 'Could not start typescript watcher'
    unlet g:tsc_job
  endif
endfunction

function! TStop()
  call job_stop(g:tsc_job)
  unlet g:tsc_job
endfunction

function! FlutterTest(testname, device) 
  split __FLUTTER_TEST_OUT__
  normal! ggdG
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:fluttertest_job = job_start('flutter test -d ' . a:device . ' ' . a:testname, {
        \ 'out_io': 'buffer',
        \ 'out_name': '__FLUTTER_TEST_OUT__',
        \ 'err_io': 'buffer',
        \ 'err_name': '__FLUTTER_TEST_OUT__'
        \ })

  if job_status(g:fluttertest_job) == 'fail'
    echo 'Could not start flutter test'
    unlet g:fluttertest
  endif
endfunction

function! FlutterTestStop()
  call job_stop(g:fluttertest_job)
  unlet g:fluttertest_job
endfunction

function! TypescriptWatchExit(job, status) 
//  :call TStop()
endfunction

function! RunMocha() 
  split __MOCHA_OUT__
  normal! ggdG
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:mocha_job = job_start('mocha .', {
        \ 'out_io': 'buffer',
        \ 'out_name': '__MOCHA_OUT__',
/        \ 'err_io': 'buffer',
        \ 'err_name': '__MOCHA_OUT__',
        \ })

  if job_status(g:mocha_job) == 'fail'
    echo 'Could not start mocha'
    unlet g:mocha_job
  endif
endfunction

function! ProjectSwitch(project, branch) 
  split __PROJECTSWITCH_OUT__
  normal! ggdG
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:projectswitch_job = job_start('project-switch ' . a:project . ' ' . a:branch, {
        \ 'out_io': 'buffer',
        \ 'out_name': '__PROJECTSWITCH_OUT__',
        \ 'err_io': 'buffer',
        \ 'err_name': '__PROJECTSWITCH_OUT__',
        \ })

  if job_status(g:projectswitch_job) == 'fail'
    echo 'Could not start projectswitch'
    unlet g:projectswitch_job
  endif
endfunction

function! RunCMD(cmd, id) 
  let bufferName = "__" . a:id . "_OUT__" 
  execute "split" . bufferName
  normal! ggdG
  if exists("g:cmd_job_channel")
      let g:last_job = job_start(a:cmd, {'channel': g:cmd_job_channel})
      :q
      return
  endif

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let g:last_job = job_start(a:cmd, {
        \ 'out_io': 'buffer',
        \ 'out_name': bufferName,
        \ 'err_io': 'buffer',
        \ 'err_name': bufferName,
        \ })

  if job_status(g:last_job) == 'fail'
    echo 'Could not start ' . a:cmd
    unlet g:last_job
    return
  endif

  let g:cmd_job_channel = job_getchannel(g:last_job)
  let g:cmd_job_buffer = ch_getbufnr(g:cmd_job_channel, "out")
endfunction

function! Get(url) 
  :call job_start('curl -s ' . a:url)
endfunction

":inoremap <silent><expr> <TAB> coc#pum#next(1)
" :inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()

":inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

":inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
" :iunmap <Tab>
:exe 'inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"'
:exe 'inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"'


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

:map <C-e> :Explore<CR>

:set winheight=30

":noremap <C-
:noremap 1 :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>

autocmd FileType sql      let b:vimpipe_command="psql -d kristine"

" last buffer
:nnoremap <leader>] <C-^>


function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

command! -bang -nargs=* Bs
      \ call BufSel(<q-args>)

:nnoremap <leader>b :Bs 
