" Plugins
source ~/.vimplugins/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('~/.vimplugins/{}')
"call pathogen#runtime_prepend_subdirectories('~/.vimplugins')

" Reasonably obvious
set nocp
set virtualedit=all
set number
set incsearch
set smartcase
set hlsearch
syntax on
filetype indent plugin on
set nowrap
set nostartofline
set wildmode=full
set wildmenu
set undolevels=100000
set textwidth=0
set smarttab
set expandtab
set cindent
set history=10000
set tags=tags;
set linebreak

" GUI
set guioptions=aegirlb
set guifont=Monospace\ 10
set guitablabel=%{exists('t:mytablabel')?t:mytablabel\ :''}

" Experimental
set autochdir
set sidescrolloff=5
set hidden
set selection=exclusive
set backup
set nowritebackup
set backupdir=~/vimtmp
set directory=~/vimtmp//
set infercase

" Personal preferences
set scrolloff=5
set laststatus=2
set mouse=a
set showcmd
set shiftwidth=2
set mousemodel=popup_setpos
set completeopt+=menuone
nnoremap <C-l> :nohl<Cr><C-l>
language en_US.utf8
nnoremap <F2> :set guifont=Monospace\ 8<Cr>
nnoremap <F3> :set guifont=Monospace\ 10<Cr>
nnoremap <F4> :set guifont=Monospace\ 12<Cr>
nnoremap <F5> :set guifont=Monospace\ 24<Cr>

colorscheme darkspectrum

" Code browsing
menu PopUp.Back <C-o>
menu PopUp.Tag <C-]>

" PHP
" Save and lint
nnoremap <Leader>s :w<Cr>:!php -l %<Cr>
" File put contents
nnoremap <Leader>f ifile_put_contents('/tmp/foobar.txt', $data, FILE_APPEND);<Esc>
" Get all args of a function
nnoremap <Leader>a iforeach(func_get_args() as $arg) { var_dump($arg); } die;<Esc>
nnoremap <Leader>d yiWovar_dump(<Esc>pa);die;<Esc>
" New file
nnoremap <Leader>< gg0i<?php<Cr><Cr>declare(strict_types=1);<Cr><Cr><Esc>

" Undo
set undodir=~/.vim/undodir
set undofile
set undoreload=100000 "maximum number lines to save for undo on a buffer reload

set statusline=%l,%c

" File types
"autocmd BufEnter *.js,*.css,*.html,*.twig set shiftwidth=2
"autocmd BufEnter *.php set shiftwidth=4

nnoremap \pd o/**<Cr>* @param<Cr>* @return<Cr>*/

" JavaScript long while loop
nnoremap <leader>jss ovar i =0; while (i<100000) { i++; console.log(i); }<Esc>

" NodeJS deep inspection of objects
nnoremap <leader>nd yiwovar util = require('util');console.log(util.inspect(<Esc>pa, false, null));<Esc>

" NodeJS write an inspected string to a file
nnoremap <leader>wf yiwovar util = require('util');var fs = require('fs');fs.writeFile('/tmp/foobar', util.inspect(<Esc>pa, false, null));<Esc>

" Promise fake-tap
nnoremap \jt o.then(function (x) {<Cr>})<Esc>

"" JS wrap with console.log
vnoremap <leader>cl yOconsole.log(<Cr><Esc>po)<Esc>

let g:jsx_ext_required = 0

" XML
" NOTE that the carriage return is intentional
map <leader>xm !%xmllint --format --recover -<CR>

" jshint validation
nnoremap <silent><F6> :JSHint<CR>
inoremap <silent><F6> <C-O>:JSHint<CR>
vnoremap <silent><F6> :JSHint<CR>

" show next jshint error
nnoremap <silent><F7> :lnext<CR>
inoremap <silent><F7> <C-O>:lnext<CR>
vnoremap <silent><F7> :lnext<CR>

" show previous jshint error
nnoremap <silent><F8> :lprevious<CR>
inoremap <silent><F8> <C-O>:lprevious<CR>
vnoremap <silent><F8> :lprevious<CR>

" Search with ignorecase even when there is noignorecase
nnoremap / /\c
nnoremap ? ?\c

" Syntastic
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_javascript_checkers = ['jshint', 'eslint']
let g:syntastic_javascript_eslint_args = '--reset'

" Taglist
"set statusline+=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%)
"let tlist_php_settings='php;c:class;f:functions;i:interfaces;d:constants'

set statusline+=%f
" Tagbar
"set statusline+=\ \ %{tagbar#currenttag('%s','')}

" Fugitive
set statusline+=%<%=%{fugitive#statusline()}

" Session
" do not store global and local values in a session
set ssop-=options

" DBEXT
let g:dbext_default_profile_mySQL = 'type=MYSQL:user=root:passwd=:charset=utf8mb4:dbname='
" DBSetOption profile=mySQL

" JsBeautify
autocmd FileType javascript noremap <buffer>  \bj :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> \bh :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> \bc :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  \bj :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> \bh :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> \bc :call RangeCSSBeautify()<cr>

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore,lodash,angularjs,jasmine'

fun! CompleteMonths(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let res = []
    for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun
set completefunc=CompleteMonths


function! IndexByWord( wordlist )
    let temp_dict = {}
    for word in a:wordlist
        redir => result
        sil! exe ':g/' . word . '/#'
        redir END
        let tmp_list = split(strtrans(result),"\\^\@ *")
        let res_list = []
        call map(tmp_list, 'add(res_list,str2nr(matchstr(v:val,"^[0-9]*")))')
        let temp_dict[word]  = res_list
    endfor
    let result_list = []
    for key in sort(keys(temp_dict))
        call add(result_list, key . ' : ' . string(temp_dict[key])[1:-2])
    endfor
    return result_list
    "return join(result_list, "\n")
endfunction

" Search for string under cursor and also move the cursor in other windows to
" next instance of said string
":nnoremap \a :let currentWindow = winnr()<Cr>:windo /<C-r><C-w><Cr>:execute 'normal ' . currentWindow . '<C-v><C-w><C-v><C-w>'<Cr> 

"    function! NumberOfWindows()
"      let i = 1
"      while winbufnr(i) != -1
"        let i = i+1
"      endwhile
"      return i - 1
"    endfunction
"
"    function! SearchInOtherWindows(searchString, direction)
"        let currentWindow = winnr()
"        let i = 1
"        while i <= NumberOfWindows()
"            execute i . " wincmd w"
"            call search(a:searchString, a:direction)
"            let i = i + 1
"        endwhile
"        execute currentWindow . " wincmd w"
"
"    endfunction
"    
"    nmap * :call SearchInOtherWindows('<C-r><C-w>', '')<Cr>
"    nmap # :call SearchInOtherWindows('<C-r><C-w>', 'b')<Cr>
"    nmap n :call SearchInOtherWindows('<C-r><C-w>', '')<Cr>
"    nmap N :call SearchInOtherWindows('<C-r><C-w>', 'b')<Cr>
"
"    function! F(s)
"        let i = 4
"        if winnr() != i
"            execute i . " wincmd w"
"        endif
"        call search(a:s)
"    endfunction


"nnoremap <silent> <F4> :call <SID>SearchMode()<CR>
"function s:SearchMode()
"  if !exists('s:searchmode') || s:searchmode == 0
"    echo 'Search next: scroll hit to middle if not on same page'
"    nnoremap <silent> n n:call <SID>MaybeMiddle()<CR>
"    nnoremap <silent> N N:call <SID>MaybeMiddle()<CR>
"    let s:searchmode = 1
"  elseif s:searchmode == 1
"    echo 'Search next: scroll hit to middle'
"    nnoremap n nzz
"    nnoremap N Nzz
"    let s:searchmode = 2
"  else
"    echo 'Search next: normal'
"    nunmap n
"    nunmap N
"    let s:searchmode = 0
"  endif
"endfunction
"
"" If cursor is in first or last line of window, scroll to middle line.
"function s:MaybeMiddle()
"  if winline() == 1 || winline() == winheight(0)
"    normal! zz
"  endif
"endfunction

function! CenterWhenNotAtTheMiddle()
    let currentLine = winline() 
    let offsetFromMiddleLine = 5
    let lineBeforeTenMiddleLines = winheight(0) / 2 - offsetFromMiddleLine
    let lineAfterTenMiddleLines = winheight(0) / 2 + offsetFromMiddleLine
    if currentLine < lineBeforeTenMiddleLines 
        normal zz
    else
        if currentLine > lineAfterTenMiddleLines
            normal zz
        endif
    endif
endfunction

nnoremap n n:call CenterWhenNotAtTheMiddle()<Cr>
nnoremap N N:call CenterWhenNotAtTheMiddle()<Cr>

nnoremap <C-k>] :q<Cr>
nnoremap <C-k><C-]> :q!<Cr>

nnoremap <C-k><PageUp> :qa<Cr>
nnoremap <C-k><C-PageUp> :qa!<Cr>

nnoremap <C-k><PageDown> :wq<Cr>
nnoremap <C-k><C-PageDown> :wqa<Cr>

" Change 2 spaces to 4 spaces
"set ts=2 sts=2 noet
"retab!
"set ts=4 sts=4 et
"retab

" For N52TE game controller
nnoremap <C-k>] :q<Cr>
nnoremap <C-k><C-]> :q!<Cr>

nnoremap <C-k><PageUp> :qa<Cr>
nnoremap <C-k><C-PageUp> :qa!<Cr>

nnoremap <C-k><PageDown> :wq<Cr>
nnoremap <C-k><C-PageDown> :wqa<Cr>

