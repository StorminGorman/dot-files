":autocmd! BufWritePost api_test_tool.dart 
":autocmd BufWritePost api_test_tool.dart :call RunCMD('dart run ' . expand('%'), 'DART')
"
runtime! debian.vim

syntax on

set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" set bg=light
set nowrap
set si ai 
set expandtab
set number relativenumber
set sw=2
set ts=2
set clipboard=unnamed
set winheight=30
colorscheme darkblue

" file type mappings
autocmd BufNewFile,BufRead *.content   set syntax=html
autocmd BufNewFile,BufRead *.hbs   set syntax=html
autocmd BufNewFile,BufRead CMake*   set filetype=cmake
autocmd BufNewFile,BufRead atriuum*conf   set filetype=xml

:nnoremap <Leader>l :ls<CR>:b<Space>

execute pathogen#infect()
syntax on
filetype plugin indent on

call plug#begin()
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'paulkass/jira-vim', { 'do': 'pip install -r requirements.txt' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
call plug#end()

let g:lsc_auto_map = v:true

" mappings for flutter
:map r :FlutterHotRestart<CR>

" mappings for vertical split window resize
:nnoremap <C-m> <C-w>_<C-w>\|
:nnoremap <leader>= <C-w>=

" mappings for window nav
:map <C-h> h
:map <C-j> j
:map <C-k> k
:map <C-l> l

" vimrc helpers
:map v :e ~/.vimrc
:map s :source ~/.vimrc
:autocmd! BufWritePost .vimrc
:autocmd BufWritePost .vimrc :source ~/.vimrc

:map vp :VimuxPromptCommand<CR>

" personal file nav
:nnoremap K {
:map J }
:map P <C-f>
:map { <C-b>b
:nnoremap <leader>] <C-^> 

" searching bindings
let $FZF_DEFAULT_OPTS="--bind \"alt-j:down,alt-k:up\""
:map <C-d> :call Searchdartfiles('')<CR>
:map <C-s> :Files ~/work<CR>
:nnoremap <leader>' :Files ~/work<CR>
:nnoremap <leader><CR> :Files<CR>
:nnoremap <leader>p :Ag<CR>
:nnoremap <leader>/ :call Searchbsi('')<CR>
:nnoremap <leader>; :call Searchdartworld('')<CR>
:map S :call Searchbsi('')<CR>
:map D :call Searchdartworld('')<CR>
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

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
  :call fzf#vim#ag(' ', fzf#vim#with_preview('up:60%'))
endfunction

" comment out 
let @c='0i//j'
:map <C-c> @c

let @v='0xxj'
:map <C-x> @v

" example of some crazy macro
let @q='xi/**/^[<80><fd>ahhp^[<80><fd>a^[<80><fd>a0'

" API Helper Mappings
:map <C-u> :new \| r ! curl -s 
function! Get(url) 
  :call job_start('curl -s ' . a:url)
endfunction

" Firebase stuff
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

function! TypescriptWatchExit(job, status) 
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

" Flutter

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


:exe 'inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"'
:exe 'inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"'

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

:map <C-e> :Explore<CR>


" SQL Format
:noremap 1 :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>
autocmd FileType sql      let b:vimpipe_command="psql -d kristine"

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


" BELOW HERE IS THE (altered) RECOMMENDED COC SETTINGS

" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.
set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
nnoremap <silent> <C-q> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
"    call feedkeys('K', 'in')
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
  autocmd FileType typescript,json,dart setl formatexpr=CocAction('formatSelected')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

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

