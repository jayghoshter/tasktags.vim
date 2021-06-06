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

augroup HiglightTODO
    autocmd!
    autocmd BufEnter * :silent! call matchadd('Success', '\[PASS\]', -1)
    autocmd BufEnter * :silent! call matchadd('Project', '\[PROJ:[^]]*\]', -1)
    autocmd BufEnter * :silent! call matchadd('Project', '\[PROJ]', -1)
    autocmd BufEnter * :silent! call matchadd('Success', '\[DONE\]', -1)
    autocmd BufEnter * :silent! call matchadd('Ongoing', '\[ONGO\]', -1)
    autocmd BufEnter * :silent! call matchadd('Ongoing', '\[PART\]', -1)
    autocmd BufEnter * :silent! call matchadd('Error', '\[PROB\]', -1)
    autocmd BufEnter * :silent! call matchadd('Error', '\[FAIL\]', -1)
    autocmd BufEnter * :silent! call matchadd('Task', '\[WORK\]', -1)
    autocmd BufEnter * :silent! call matchadd('Task', '\[TASK\]', -1)
    autocmd BufEnter * :silent! call matchadd('Task', '\[DCHK\]', -1)
    autocmd BufEnter * :silent! call matchadd('Task', '\[REVW\]', -1)
    autocmd BufEnter * :silent! call matchadd('Note', '\[NOTE\]', -1)
    autocmd BufEnter * :silent! call matchadd('Note', '\[MEET\]', -1)
    autocmd BufEnter * :silent! call matchadd('Wait', '\[WAIT\]', -1)
    autocmd BufEnter * :silent! call matchadd('Drop', '\[DROP\]', -1)
    autocmd BufEnter * :silent! call matchadd('Next', '\[NEXT\]', -1)
    autocmd BufEnter * :silent! call matchadd('Push', '\[PUSH\]', -1)
augroup END

augroup HighlightDND
    autocmd BufEnter * :silent! call matchadd('Ongoing', '@npc', -1)
    autocmd BufEnter * :silent! call matchadd('Wait', '@loc', -1)
    autocmd BufEnter * :silent! call matchadd('Success', '@DC[0-9][0-9]', -1)
    autocmd BufEnter * :silent! call matchadd('Project', '@scene', -1)
    autocmd BufEnter * :silent! call matchadd('Next', '@trial', -1)
    autocmd BufEnter * :silent! call matchadd('Error', '@combat', -1)
    autocmd BufEnter * :silent! call matchadd('Task', '@task', -1)
augroup  END


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
nnoremap ;x :call Tasker('NEXT')<CR> 
nnoremap ;t :call Tasker('TASK')<CR>
nnoremap ;o :call Tasker('ONGO')<CR>
nnoremap ;d :call Tasker('DONE')<CR>
nnoremap ;r :call Tasker('DROP')<CR>
nnoremap ;p :call Tasker('PROB')<CR>
nnoremap ;f :call Tasker('FAIL')<CR>
nnoremap ;n :call Tasker('NOTE')<CR>
nnoremap ;w :call Tasker('WAIT')<CR>
nnoremap ;u :call Tasker('PUSH')<CR>
nnoremap ;m :call Tasker('MEET')<CR>

" vnoremap ;e :call Tasker(' ')<CR>0f[ 
" vnoremap ;x :call Tasker('X')<CR> 
vnoremap ;x :call Tasker('NEXT')<CR> 
vnoremap ;t :call Tasker('TASK')<CR>
vnoremap ;o :call Tasker('ONGO')<CR>
vnoremap ;d :call Tasker('DONE')<CR>
vnoremap ;r :call Tasker('DROP')<CR>
vnoremap ;p :call Tasker('PROB')<CR>
vnoremap ;f :call Tasker('FAIL')<CR>
vnoremap ;n :call Tasker('NOTE')<CR>
vnoremap ;w :call Tasker('WAIT')<CR>
vnoremap ;u :call Tasker('PUSH')<CR>
vnoremap ;m :call Tasker('MEET')<CR>

