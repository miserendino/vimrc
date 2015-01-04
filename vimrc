set nocompatible                " choose no compatibility with legacy vi
set showmode
set ruler
set mouse=a
colorscheme desert
syntax enable
"" For regular expressions turn magic on
set magic
" Be smart when using tabs ;)
set smarttab
set autoindent                  " provide indentation
set smartindent
set relativenumber              " show relativenumber
set nofoldenable                 " disable folding
set confirm                       " prompt when existing from an unsaved file
set title                         " show file in titlebar
set cindent
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set nu                          " number of line
"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
"" Mapping
map <F1> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map! #2  :w              
map #5  :mak<CR>
map #8  :cn<CR>
map #7  :cp<CR>
:map #6 :!./a.out<CR>
"" Mark the cursor
set cursorline
set cursorcolumn
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"" Backup file
set backup
set writebackup
au BufWritePre * let &backupext = '%' . substitute(expand("%:p:h"), "/" , "%" , "g") . "%" . strftime("%Y.%m.%d.%H.%M.%S")
au VimLeave * !cp % ~/.vim_backups/$(echo %:p | sed 's/\(.*\/\)\(.*\)/\2\/\1/g' | sed 's/\//\%/g')$(date +\%Y.\%m.\%d.\%H.\%M.\%S).wq
set backupdir=~/.vim_backups/
" Auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc
"" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
fun! ViewUTF8()
  set encoding=utf-8
  set termencoding=big5
endfun
fun! UTF8()
  set encoding=utf-8
  set termencoding=big5
  set fileencoding=utf-8
  set fileencodings=ucs-bom,big5,utf-8,latin1
endfun
fun! Big5()
  set encoding=big5
  set fileencoding=big5
endfun
""Statusline
set laststatus=2
"set statusline=
"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? 
function! HighlightSearch()
    if &hls
   return 'H'
    else
   return ''
    endif
endfunction
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
"set statusline=[%n]\ %<%F\ \ \ [%M%R%H%W%Y][%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ @%{strftime(\"%H:%M:%S\")}


"These three functions are just for example.
"It might be that these three functions are irrelevant
"in example statuslines, but they demonstrate that
"functions can be used in statusline too.
fu! Percent()
  let byte = line2byte( line( "." ) ) + col( "." ) - 1
  let size = (line2byte( line( "$" ) + 1 ) - 1)
  return (byte * 100) / size
endf

fu! FileEncoding()
  if &fileencoding == ''
    return "is not set"
  else
    return &fenc
  endif
endf

fu! GlobalEncoding()
  if &fileencoding == ''
    return "is not set"
  else
    return &enc
  endif
endf

"And now the magical stuff!
"We define some statuslines at first.
let g:StatusLines{0}='[%1*%n%*]%= [%2*%03bD%* | %2*%5(0x%02BH%)%*] [%8oC=%1*%3{Percent()}%%%*] [%8c] : [%8l/%8L = %1*%3p%%%*]'
let g:StatusLines{1}='[%1*%n%*]%= [%1*GENC%* %10(%{GlobalEncoding()}%)] [%1*FENC%* %10(%{FileEncoding()}%)]'
let g:StatusLines{2}='[%1*%n%*]%= [%1*%F%*]'
let g:StatusLinesCurrent=-1

"And we map switching on some unused key.
map <F3> :call ToggleStatusLine()<CR>

"Function that switch between several statuslines
fu! ToggleStatusLine()
  let g:StatusLinesCurrent=g:StatusLinesCurrent+1
  if (!exists("g:StatusLines" . g:StatusLinesCurrent))
    let g:StatusLinesCurrent=0
  endif
  let &statusline=g:StatusLines{g:StatusLinesCurrent}
endf

"We use the first one as default.
call ToggleStatusLine()

"Because I used some highlighting in the example statuslines
"I put some highlighting definitions here too.
"The colours of statusline itself.
hi statusline term=inverse,bold cterm=inverse,bold ctermfg=white ctermbg=black
hi statuslinenc term=inverse,bold cterm=inverse,bold ctermfg=white ctermbg=black

"Some other colours used in statuslines.
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=white ctermbg=black
hi User2 term=inverse,bold cterm=inverse,bold ctermfg=white ctermbg=black
