


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for lack of another handy place to put 'em, here are the zencoding shortcuts:
" each shortcut is preceded by a <C-Y> 
" 
" COMMA (insert mode) : Expand Abbreviation
" COMMA (visual Mode) : Wrap with abbreviation (abbreviation supplied at the "Tag:" prompt)
" n : next insertion point
" N : previous insertion point
" d : Select inner tag
" D : Select outer tag
" k : delete node
" j : toggle self closed node state (deletes contents when closing, not restored when opening)
" / : toggle comment (outer node)
" a : make an anchor from a URL
" A : make Block quote from a URL
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" --------------------------------------------------
" System specific preferences
" --------------------------------------------------

if substitute(system('uname'), "\n", "", "") == "Darwin"
	cd ~/Dev/

	" START A NEW R SESSION (OSX ONLY?)
	" cab newR !open -n /Applications/r.app
	cab newR !open -n "/Applications/Revolution R Open.app"

else

	set shell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
	cd h:\

endif 

" --------------------------------------------------
" GUI PREFERENCES
" --------------------------------------------------

" SHOW TABS AND TRAILING SPACES AND EOL CHARACTERS IN LIST MODE (:SET LIST)
set listchars=tab:>-,trail:-,eol:$ 

" TAB / SHIFT SETTINGS
set columns=90 lines=50 number tabstop=4 shiftwidth=4 ruler nowrap

" IGNORE CASE WHEN SEARCHING
set ic 

" GUI BAR IN VIM?  SERIOUSLY?
set guioptions-=T

" MY FAVORITE FONT, (AND SOME OTHER OPTIONS)
set guifont=Lucida\ Console:h15
"set guifont=Courier:h10:cANSI
"set guifont=Courier\ New:h13:cANSI:10
"set guifont=Courier\ New\ Bold:h13
"set guifont=Courier:h12:cANSI:12

"ENABLE CODE FOLDING 
set fen foldcolumn=4 

"ENABLE HORIZONTAL SCROLL BAR
set guioptions+=b 

" ENABLE HORIZONTAL SCROLL BAR
set guioptions+=b 

" THE LISF OF FILES NOT TO SHOW IN NETRW
" (Swap files, pyc files, and vim buffers)
let g:netrw_list_hide = '.*\.sw.$,.*\.pyc$,.*\~'

" TURN ON THE VISUAL BELL AND TURN OFF THE (AUDIO) ERROR BELL (PC ONLY) 
set vb noeb
" note that "set vb" does not work in mac vim.   Istead, see 
" "System Preferences -> Accessability -> Audio"
" and check the box for flash the screen when an alert sound occures
" Next, under "System Preferences ->  Sounds",  turn down the 'Alert volume'

" KEEP A NICE LONG HISTORY OF COMMANDS
set history=1000

" A NICE DARK, PLAYFUL THEME
colorscheme deepBlueOcean2

"I RATHER DISLIKE VIRTUALEDIT, EXCEPT IN BLOCK MODE
set ve=block


"-- " TELL VIM TO USE AN UNDO FILE
"-- set undofile
"-- " SET A DIRECTORY TO STORE THE UNDO HISTORY
"-- set undodir=h:/vimUndo/


let g:vimrplugin_term = "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal"


"--------------------------------------------------
" start pathogen
"--------------------------------------------------
" http://www.vim.org/scripts/script.php?script_id=2332
execute pathogen#infect() 

"--------------------------------------------------
" indentline settings: 
" https://github.com/Yggdroot/indentLine 
"--------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

"--------------------------------------------------
" MAPPINGS
"--------------------------------------------------

" lower case command in visual mode remapped to the <c-u>
vnoremap <c-u> u
vnoremap u <esc>u

" REPEAT AND JUMP TO THE NEXT LINE UP
nnoremap H .j
nnoremap L .k

" MAP REDO TO THE 'R' KEY (FOR SYMETRY WITH THE 'U' KEY)
nmap r <C-R>

" NAVIGATION BETWEEN WINDOW BUFFERS

" jump up and down open windows
nnoremap <c-h> <c-w>W
nnoremap <c-l> <c-w>w

" loop over the open bufferes in the current window
nmap <c-j> :bnext<CR>
nmap <c-k> :bprevious<CR>

" windows only commands? - the mac goldtouch keyboard uses <d-l> instead...
nmap <a-l> i<C-R>=line('.')<CR><esc>
imap <a-l> <C-R>=line('.')<CR>
nmap <a-1> V<a-1>
nmap <a-2> V<a-2>


" NAVIGATION AS ABOVE, BUT FOR THE MAC GOLDTOUCH KEYBOARD
" ˙ is the result of <c-h>
nnoremap ˙ <c-w>W
" ¬ is the result of <c-l>
nnoremap ¬ <c-w>w
" ∆ is the result of <c-j>
nmap ∆ :bnext<CR>
" ˚ is the result of <c-k>
nmap ˚ :bprevious<CR>



" DISABLE UNUSED COMMANDS TO ACCOMODATE MY BIG DUMB FINGERS
map <f1> <esc>
map <d-q> <esc>
imap <f1> <esc>
map <c-z> <esc>
:cnoremap wq w


" :cq is *always* a (very frustrating) mistake for me
:cnoremap cq <C-R>=CQ()<CR>
function CQ()
    let cmdtype = getcmdtype()
    if cmdtype == ':'
        " Perform Ex command map action
        return "cw"
    else 
        return "cq"
    endif
endfunction


lnoremap 3 ^[^#]*
lnoremap 8 ^[^*]*

"--------------------------------------------------
" COMMAND LINE ABBREVATIONS 
"--------------------------------------------------

"--------------------------------------------------
" ECLIM helpers
"--------------------------------------------------

" START THE SERVER
cab eclim !open /Applications/eclipse/eclimd

" STOP THE SERVER
cab noeclim ShutdownEclim

" abbreviation for :noautocmd vimgrep
:cnoremap vg <C-R>=VG()<CR>
function VG()
    let cmdtype = getcmdtype()
    if cmdtype == ':'
        " Perform Ex command map action
                                return "noautocmd vimgrep"
                else
                                return "vg"
    endif
endfunction

" ECLIM OPTIONS 
" for details see -  https://groups.google.com/forum/#!topic/eclim-user/QdamHqsV0YI 
" or - :h 'completeopt'
set completeopt=menuone,longest



" FIILETYPE SPECIFIC SHORTCUT FOR VIMGREP 
nnoremap <c-o> :vimgrep // <C-R>=b:search_ext<CR><left><left><left><left><left><left><left><left><left><left>

" Standard 
nnoremap <a-6> ggO<C-R>=b:comment_leader<CR> <esc>80a-<esc>o<C-R>=b:comment_leader<CR> Programmer: Jason Thorpe<esc>o<C-R>=b:comment_leader<CR> Date        <esc>:r !date<CR>kkJJo<C-R>=b:comment_leader<CR> Language:   <C-R>=b:fileType<CR><esc>o<C-R>=b:comment_leader<CR> Purpose:    <esc>o<C-R>=b:comment_leader<CR> Comments:   <esc>o<C-R>=b:comment_leader<CR> <esc>80a-<esc>j

" BUFFER FILE TYPE VARIABLES 
au FileType '' let b:fileType = 'Unknown' 
au FileType html let b:fileType = 'html' 
au FileType javascript let b:fileType = 'javascript' 
au FileType typescript let b:fileType = 'typescript' 
au FileType css let b:fileType = 'css' 
au FileType java let b:fileType = 'java' 
"au FileType vfp8 let b:fileType = 'VisualFoxPro (.prg) Version 9' 
au FileType vim let b:fileType = 'vim' 
au FileType r,*.r,*.site,.Rprofile let b:fileType = 'R (.r) Version 3.1.x' 
au FileType python let b:fileType = 'Python (.py) Version 2.7' 
au FileType sh let b:fileType = 'sh' 
au FileType autohotkey let b:fileType = 'AutoHotKey (.ahk)' 



"--------------------------------------------------
" FAST CODE COMMENTING 
"--------------------------------------------------

if substitute(system('uname'), "\n", "", "") == "Darwin"
	
	" note that on the mac goldtough the <d-3> key is 
	" where the <a-1> key is on the windows goldtouch

	nnoremap <d-1> :s/^<C-R>=b:comment_leader_long<CR>//e<CR>:nohls<cr>k
	nnoremap <d-2> :s/^<C-R>=b:comment_leader<CR>//e<CR>:nohls<cr>k
	nnoremap <d-3> :s/^/<C-R>=b:comment_leader<CR>/e<CR>:nohls<cr>j
	nnoremap <d-4> :s/^/<C-R>=b:comment_leader_long<CR>/e<CR>:nohls<cr>j

	vnoremap <d-1> :s/^<C-R>=b:comment_leader_long<CR>//e<CR>:nohls<cr>
	vnoremap <d-2> :s/^<C-R>=b:comment_leader<CR>//e<CR>:nohls<cr>
	vnoremap <d-3> :s/^\(.\)/<C-R>=b:comment_leader<CR>\1/e<CR>:nohls<cr>
	vnoremap <d-4> :s/^\(.\)/<C-R>=b:comment_leader_long<CR>\1/e<CR>:nohls<cr>

	" THIS COMMENTS OUT BLANK LINES AS WELL
	vnoremap <d-5> :s/^/<C-R>=b:comment_search_leader_long<CR>/e<cr>/<Up><Up><esc>:nohls<CR>

else 

	" CONSIDER
	"nnoremap <d-3> :s/^\(.\)/<C-R>=b:comment_leader<CR>\1/e<CR>:nohls<cr>j
	" INSTEAD OF 
	"nnoremap <d-3> :s/^/<C-R>=b:comment_leader<CR>/e<CR>:nohls<cr>j

	"nnoremap <a-1> :s/^<C-R>=b:comment_search_leader_long<CR>//e<cr>/<Up><Up><esc>k:nohls<CR>
	"nnoremap <a-1> V:s/^<C-R>=b:comment_search_leader_long<CR>//e<cr>/<Up><Up><esc>:nohls<CR>``
	"nnoremap <a-2> :s/^<C-R>=b:comment_search_leader<CR>//e<cr>/<Up><Up><esc>k:nohls<CR>
	nnoremap <a-3> 0i<C-R>=b:comment_leader<CR><esc>j
	nnoremap <a-4> 0i<C-R>=b:comment_leader_long<CR><esc>j

	vnoremap <a-1> :s/^<C-R>=b:comment_search_leader_long<CR>//e<cr>/<Up><Up><esc>:nohls<CR>``
	vnoremap <a-2> :s/^<C-R>=b:comment_search_leader<CR>//e<cr>/<Up><Up><esc>:nohls<CR>``
	vnoremap <a-3> :s/^\(.\+\)/<C-R>=b:comment_search_leader<CR>\1/e<cr>/<Up><Up><esc>:nohls<CR>``
	vnoremap <a-4> :s/^\(.\+\)/<C-R>=b:comment_search_leader_long<CR>\1/e<cr>/<Up><Up><esc>:nohls<CR>``

	" THIS COMMENTS OUT BLANK LINES AS WELL
	"vnoremap <a-3> :s/^/<C-R>=b:comment_leader<CR>/e<cr>/<Up><Up><esc>:nohls<CR>
	vnoremap <a-5> :s/^/<C-R>=b:comment_search_leader_long<CR>/e<cr>/<Up><Up><esc>:nohls<CR>
	"vnoremap <d-q> :qas/^/<C-R>=b:comment_leader_qc<CR>/<cr>

endif 


	" DEFAULT SETTINGS 
	au FileType '' let b:comment_search_leader = '#' 
	au FileType '' let b:comment_search_leader_long = '#-- ' 
	au FileType '' let b:comment_leader = '#' 
	au FileType '' let b:comment_leader_long = '#-- ' 
	au FileType '' let b:search_ext = '**/*.r  ' 

    " comment string  == '//'
    au FileType java,html,javascript,typescript,css let b:comment_search_leader = '\/\/' 
    au FileType java,html,javascript,typescript,css let b:comment_search_leader_long = '\/\/-- ' 
    au FileType java,html,javascript,typescript,css let b:comment_search_leader_qc = '\/\/' 
    au FileType java,html,javascript,typescript,css let b:comment_leader = '\/\/' 
    au FileType java,html,javascript,typescript,css let b:comment_leader_long = '\/\/-- ' 
    au FileType java,html,javascript,typescript,css let b:comment_leader_qc = '\/\/' 

	" FoxPro
    "au FileType vfp8 let b:comment_search_leader = '\*' 
    "au FileType vfp8 let b:comment_search_leader_long = '\*!\* ' 
    "au FileType vfp8 let b:comment_search_leader_qc = '\*qc\*' 
    "au FileType vfp8 let b:comment_leader = '*' 
    "au FileType vfp8 let b:comment_leader_long = '*!* ' 
    "au FileType vfp8 let b:comment_leader_qc = '*qc*' 
    "au FileType vfp8 let b:search_ext = '**/*.prg' 

    " set comment character according to filetype 
    " comment string  == '%'
    au FileType tex let b:comment_search_leader = '%' 
    au FileType tex let b:comment_search_leader_long = '%' 
    au FileType tex let b:comment_search_leader_qc = '%' 
    au FileType tex let b:comment_leader = '%' 
    au FileType tex let b:comment_leader_long = '%' 
    au FileType tex let b:comment_leader_qc = '%' 

    " set comment character according to filetype 
    " comment string  == '"'
    au FileType vim let b:comment_search_leader = '"' 
    au FileType vim let b:comment_search_leader_long = '"-- ' 
    au FileType vim let b:comment_search_leader_qc = '"' 
    au FileType vim let b:comment_leader = '"' 
    au FileType vim let b:comment_leader_long = '"-- ' 
    au FileType vim let b:comment_leader_qc = '"' 


    " comment string  == '#'

    au FileType sh,make,r,python let b:comment_search_leader = '#' 
    au FileType sh,make,r,python let b:comment_search_leader_long = '#-- ' 
    au FileType sh,make,r,python let b:comment_search_leader_qc = '#qc-' 
    au FileType sh,make,r,python let b:comment_leader = '#' 
    au FileType sh,make,r,python let b:comment_leader_long = '#-- ' 
    au FileType sh,make,r,python let b:comment_leader_qc = '#qc-' 
    au FileType python let b:search_ext = '**/*.py ' 
    au FileType r let b:search_ext = '**/*.r  ' 

    " comment character  == ';'

    au FileType autohotkey let b:comment_search_leader = ';' 
    au FileType autohotkey let b:comment_search_leader_long = ';-- ' 
    au FileType autohotkey let b:comment_search_leader_qc= ';qc ' 
    au FileType autohotkey let b:comment_leader = ';' 
    au FileType autohotkey let b:comment_leader_long = ';-- ' 
    au FileType autohotkey let b:comment_leader_qc= ';qc ' 
    
    " automatically reload vimrc when it's saved
    " not sure this is such a good idea
"    au BufWritePost _vimrc so ~/_vimrc


" --------------------------------------------------
" file read-write autocommands
" --------------------------------------------------

if !exists("autocommands_loaded")
	let autocommands_loaded = 1

	"------------------------------
	" FILE TYPES SPECIFID SETTINGS
	"------------------------------

	" GO 
    au BufFilePost,BufRead,BufNewFile *.go setlocal filetype=go syntax=go
	au filetype go setlocal mp=6g\ %

	" FOXPRO 
    " au BufFilePost,BufRead,BufNewFile  *.rmd setlocal filetype=markdown syntax=markdown

	" AutoHotKey
    au BufFilePost,BufRead,BufNewFile *.ahk setlocal syntax=autohotkey filetype=autohotkey 
	
	" R
    au BufFilePost,BufRead,BufNewFile *.r setlocal syntax=r filetype=r foldmethod=marker
    au BufFilePost,BufRead,BufNewFile *.rfmt setlocal syntax=r filetype=r foldmethod=marker
    "au BufFilePost,BufRead,BufNewFile *.rd setlocal syntax=r filetype=r foldmethod=marker
    au BufFilePost,BufRead,BufNewFile .Rprofile setlocal syntax=r filetype=r foldmethod=marker
    " NOTE TO SELF the default for foldmethod is 'manual'

	"Web stuff
	au BufRead,BufNewFile *.html setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 syntax=html filetype=html
	au BufRead,BufNewFile *.css setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 syntax=css filetype=css
	au BufRead,BufNewFile *.js setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 syntax=javascript filetype=javascript
	au BufRead,BufNewFile *.js setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 syntax=javascript filetype=javascript

	" MARKDOWN 
    au BufFilePost,BufRead,BufNewFile *.md setlocal filetype=markdown syntax=markdown
	
	"PYTHON 
	au BufFilePost,BufRead,BufNewFile *.py setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 syntax=python filetype=python

	"------------------------------
	" ENABLE LOG WRITERS
	"------------------------------
	au BufWritePre *.py call AppendToWriteLog( )
	au BufWritePre *.r call AppendToWriteLog( )
	au BufWritePre *.prg call AppendToWriteLog( )

	"------------------------------
	" FILE TYPE SPECIFIC MAPPINGS
	"------------------------------

	" MAPPINGS FOR typescritp
	au FileType typescript  :inoremap <buffer> >> =>

	" MAPPINGS FOR R 
    au FileType r inoremap <buffer> nid if(!inherits(data[,'denrollvisit'],'Date'))
    au FileType r iabb <buffer> _ <-
    au FileType r iabb <buffer> >< %>%
    au FileType r inoremap <buffer> dtos( format(as.Date(date(), "%a %b %d %H:%M:%S %Y"), "%Y%m%d")
    au FileType r iabb <buffer> as.Date( as.Date(as.character( ),'%m/%d/%Y')
    au FileType r inoremap <buffer> pdf( pdf( FileNameHere , width = par('din')[1],height = par('din')[2] )
    au FileType r inoremap <buffer> pbar pb <- winProgressBar(title = "progress bar", min = 0, max = total, width = 300)<CR>setWinProgressBar(pb, i, title=paste( round(i/total*100, 0), "% done"))<CR>close(pb)

	" MAPPINGS FOR SuperTab
	au FileType java,python let b:SuperTabDefaultCompletionType = '<c-x><c-u>'


	"-----------------------------------
	" MAC VIM GOES CRAZY WHEN FF=MAC
	"-----------------------------------
	" this comes last because I want the other changes to occure even if this fails due to ':set noma'
    au FileType r set ff=unix 
	au FileType python set ff=unix 



	"-----------------------------------
	" VIM (NETRW)
	"-----------------------------------
	au FileType pi_netrw.txt nnoremap L <c-l>


endif


" A FUNCTIN THAT LOGS THE CURRENT SET OF OPEN WINDOWS TO A LOCAL FILE

function AppendToWriteLog( )
"	let x = input(expand('%:p').'>')
	let lines = [ strftime("%c").','.expand('%:p')]
	let eventlog = expand('$VIMRUNTIME').'/writeEventLog'
	let lasteventlog = expand('$VIMRUNTIME').'/lastWriteEvent'
	if filewritable(eventlog)
		call writefile(lines,lasteventlog)
		call system("cat ".lasteventlog." >> ".eventlog)
	endif 
endfunction


" --------------------------------------------------
" RECORDING FILES USED IN EACH SESSTION
" --------------------------------------------------

"records the current list of open files 
au VimLeave,BufFilePost,BufUnload,BufDelete,BufReadPost,BufWritePost *.py,*.r,*.Rprofile,*.prg,*.txt,*.csv call RecordFiles()
    

if !exists("g:sessionid")
    let g:sessionid = strftime('%Y_%m_%d_%H_%M_%S')
endif 

if !isDirectory($HOME.'/.vimSessions')
    call mkdir($HOME.'/.vimSessions')
endif 


echo $HOME.'/'.g:sessionid.'_VimSession'

    function RecordFiles()
        exec 'redir! > '.$HOME.'/.vimSessions/'.g:sessionid.'_VimSession'
        silent! ls
        redir END
    endfunction

endif 


" --------------------------------------------------
" SYSTEM GENERATED STUFF BELOW
" --------------------------------------------------
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
let vimrplugin_r_args = "--no-restore --no-save" 
"set ffs=dos,mac,unix
set nocompatible
syntax enable
filetype plugin on
filetype indent on


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction





"nnoremap "y "*y
"nnoremap "p "*p
"noremap <silent> <c-l> :nohls<cr><c-l>
" un-high-light the search strings
"noremap <silent> <c-o> :nohls<cr><c-l>

" noremap <silent> <c-o> :nohls<cr><c-l>
" nnoremap <c-h> <c-w>W
" nnoremap <c-l> <c-w>w
" nnoremap <a-1> 0d4lk
" nnoremap <a-2> 0xk
" nnoremap <a-3> 0i#<esc>j
" nnoremap <a-4> 0i#-- <esc>j
" set guioptions-=T
" set ruler
" set nowrap
" 
" if !exists("autocommands_loaded")
"     let autocommands_loaded = 1
"     "go settings
"     au BufRead,BufNewFile *.go		set syntax=go
"     au BufRead,BufNewFile *.go		setlocal filetype=go
"     au filetype go		setlocal mp=6g\ %
"     "python settings
"     au BufRead,BufNewFile *.py set tabstop=8 expandtab shiftwidth=4 softtabstop=4
" endif
" set nolist
" iab :: :=
" iab _ <-
" iab __ _
" set lcs=tab:>-,trail:-
" set lines=60
" set columns=100
" set number
" set ignorecase
" set incsearch
" set hlsearch
" "set autoindent
" "set smartindent
" set cindent
" set shiftwidth=4
" set tabstop=4
" " Shortcuts for moving between tabs.
" " Alt-j to move to the tab to the left 
" "noremap <A-j> gT 
" " Alt-k to move to the tab to the 
" "right noremap <A-k> gt
" nmap r <C-R>

" A GUI FILE BROWSER
" cab sel browse e
