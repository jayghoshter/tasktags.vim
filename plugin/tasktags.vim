" Vim global plugin for adding tags '[XXXX]' to text
" 
" I use it with my work log-file as a daily 
" pseudo-task-management system.
"
" Maintainer: Jayghosh Rao <jayghoshter@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_tasktags")
  finish
endif
let g:loaded_tasktags = 1

let s:nord0_gui = "#2E3440"
let s:nord1_gui = "#3B4252"
let s:nord2_gui = "#434C5E"
let s:nord3_gui = "#4C566A"
let s:nord3_gui_bright = "#616E88"
let s:nord4_gui = "#D8DEE9"
let s:nord5_gui = "#E5E9F0"
let s:nord6_gui = "#ECEFF4"
let s:nord7_gui = "#8FBCBB"
let s:nord8_gui = "#88C0D0"
let s:nord9_gui = "#81A1C1"
let s:nord10_gui = "#5E81AC"
let s:nord11_gui = "#BF616A"
let s:nord12_gui = "#D08770"
let s:nord13_gui = "#EBCB8B"
let s:nord14_gui = "#A3BE8C"
let s:nord15_gui = "#B48EAD"

let s:nord1_term = "0"
let s:nord3_term = "8"
let s:nord5_term = "7"
let s:nord6_term = "15"
let s:nord7_term = "14"
let s:nord8_term = "6"
let s:nord9_term = "4"
let s:nord10_term = "12"
let s:nord11_term = "1"
let s:nord12_term = "11"
let s:nord13_term = "3"
let s:nord14_term = "2"
let s:nord15_term = "5"

function! s:hi(group, guifg, guibg, ctermbg)
    exec "hi " . a:group . " guifg=" . a:guifg . " guibg=" . a:guibg . " ctermbg=" . a:ctermbg
endfunction

call s:hi("Error", s:nord0_gui, s:nord11_gui, s:nord11_term)
call s:hi("Success", s:nord0_gui, s:nord14_gui, s:nord14_term)
call s:hi("Ongoing", s:nord0_gui, s:nord7_gui, s:nord7_term)
call s:hi("Task", s:nord0_gui, s:nord13_gui, s:nord13_term)
call s:hi("Note", s:nord0_gui, s:nord10_gui, s:nord10_term)
call s:hi("Wait", s:nord0_gui, s:nord15_gui, s:nord15_term)
call s:hi("Drop", s:nord0_gui, s:nord6_gui, s:nord6_term)
call s:hi("Next", s:nord0_gui, s:nord12_gui, s:nord12_term)
call s:hi("Push", s:nord0_gui, s:nord12_gui, s:nord12_term)
call s:hi("Project", s:nord0_gui, s:nord5_gui, s:nord5_term)
call s:hi("Dash", s:nord0_gui, s:nord4_gui, s:nord6_term)

call matchadd('Success', '\[PASS\]', -1)
call matchadd('Project', '\[PROJ:[^]]*\]', -1)
call matchadd('Project', '\[PROJ]', -1)
call matchadd('Success', '\[DONE\]', -1)
call matchadd('Ongoing', '\[ONGO\]', -1)
call matchadd('Ongoing', '\[PART\]', -1)
call matchadd('Error', '\[PROB\]', -1)
call matchadd('Error', '\[FAIL\]', -1)
call matchadd('Error', '\[CRIT\]', -1)
call matchadd('Task', '\[WORK\]', -1)
call matchadd('Task', '\[TASK\]', -1)
call matchadd('Task', '\[DCHK\]', -1)
call matchadd('Task', '\[REVW\]', -1)
call matchadd('Note', '\[NOTE\]', -1)
call matchadd('Note', '\[MEET\]', -1)
call matchadd('Wait', '\[WAIT\]', -1)
call matchadd('Drop', '\[DROP\]', -1)
call matchadd('Next', '\[NEXT\]', -1)
call matchadd('Push', '\[PUSH\]', -1)
call matchadd('Dash', '\[DASH\]', -1)

"" DnD Highlights
call matchadd('Ongoing', '@npc', -1)
call matchadd('Wait', '@loc', -1)
call matchadd('Success', '@DC[0-9][0-9]', -1)
call matchadd('Project', '@scene', -1)
call matchadd('Next', '@trial', -1)
call matchadd('Error', '@combat', -1)
call matchadd('Task', '@task', -1)


function! s:Tasker(tag)
    let l:line = getline('.')
    let l:lineno = line('.')
    if match(line, '- \['.a:tag.'\]')>-1 
        call setline(lineno, substitute(line, ' \['.a:tag.'\]', '', '') )
    elseif match(line, '\['.a:tag.'\]')>-1
        call setline(lineno, substitute(line, '\['.a:tag.'\] ', '', '') )
    elseif match(line, '- \[....\]')>-1
        call setline(lineno, substitute(line, '\[....\]', '\['.a:tag.']', '') )
    elseif match(line, '\[....\]')>-1
        call setline(lineno, substitute(line, '\[....\]', '\['.a:tag.']', '') )
    elseif match(line, '^\s*-')>-1
        call setline(lineno, substitute(line, '-', '- \['.a:tag.'\]', ''))
    else
        call setline(lineno, substitute(line, '^', '\['.a:tag.'\] ', ''))
    endif
endfunction

" nnoremap ;e :call Tasker(' ')<CR>0f[ 
nnoremap ;x :call <SID>Tasker('NEXT')<CR> 
nnoremap ;t :call <SID>Tasker('TASK')<CR>
nnoremap ;o :call <SID>Tasker('ONGO')<CR>
nnoremap ;d :call <SID>Tasker('DONE')<CR>
nnoremap ;r :call <SID>Tasker('DROP')<CR>
nnoremap ;p :call <SID>Tasker('PROB')<CR>
nnoremap ;f :call <SID>Tasker('FAIL')<CR>
nnoremap ;n :call <SID>Tasker('NOTE')<CR>
nnoremap ;w :call <SID>Tasker('WAIT')<CR>
nnoremap ;u :call <SID>Tasker('PUSH')<CR>
nnoremap ;m :call <SID>Tasker('MEET')<CR>
nnoremap ;c :call <SID>Tasker('CRIT')<CR>
nnoremap ;a :call <SID>Tasker('DASH')<CR>

" vnoremap ;e :call Tasker(' ')<CR>0f[ 
" vnoremap ;x :call Tasker('X')<CR> 
vnoremap ;x :call <SID>Tasker('NEXT')<CR> 
vnoremap ;t :call <SID>Tasker('TASK')<CR>
vnoremap ;o :call <SID>Tasker('ONGO')<CR>
vnoremap ;d :call <SID>Tasker('DONE')<CR>
vnoremap ;r :call <SID>Tasker('DROP')<CR>
vnoremap ;p :call <SID>Tasker('PROB')<CR>
vnoremap ;f :call <SID>Tasker('FAIL')<CR>
vnoremap ;n :call <SID>Tasker('NOTE')<CR>
vnoremap ;w :call <SID>Tasker('WAIT')<CR>
vnoremap ;u :call <SID>Tasker('PUSH')<CR>
vnoremap ;m :call <SID>Tasker('MEET')<CR>
vnoremap ;c :call <SID>Tasker('CRIT')<CR>
vnoremap ;a :call <SID>Tasker('DASH')<CR>

