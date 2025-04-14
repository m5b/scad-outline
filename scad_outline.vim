" scad-outline.vim
" OpenSCAD sidebar outline navigator

function! ScadOutlineBuffer()
  let pattern = '^\s*\(module\|function\)\s\+\zs[a-zA-Z_][a-zA-Z0-9_]*'
  let lines = []
  let jumps = {}
  let symbols = []

  let lnum = 1
  for line in getline(1, '$')
    if line =~# pattern
      let name = matchstr(line, pattern)
      call add(lines, name)
      let jumps[name] = lnum
      call add(symbols, {'name': name, 'lnum': lnum})
    endif
    let lnum += 1
  endfor

  if empty(lines)
    echo "No modules or functions found."
    return
  endif

  let t:scad_outline_origin_win = win_getid()

  let winnr = bufwinnr('__ScadOutline__')
  if winnr != -1
    exec winnr . 'wincmd w'
  else
    rightbelow vertical 30split __ScadOutline__
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted nowrap
    setlocal filetype=scadoutline
  endif

  call setline(1, lines)
  nnoremap <silent><buffer> <CR> :call ScadJumpToLine()<CR>
  let b:scad_jumps = jumps
  let b:scad_symbols = symbols
endfunction

function! ScadJumpToLine()
  let name = getline('.')
  let lnum = get(b:scad_jumps, name, 0)
  if lnum > 0 && exists('t:scad_outline_origin_win')
    call win_gotoid(t:scad_outline_origin_win)
    call cursor(lnum, 1)
  else
    echo "Can't find target line or origin window."
  endif
endfunction

function! ScadToggleOutline()
  let outline_winnr = bufwinnr('__ScadOutline__')
  if outline_winnr != -1
    execute outline_winnr . 'wincmd c'
  else
    call ScadOutlineBuffer()
  endif
endfunction

command! ScadOutline call ScadOutlineBuffer()
command! ScadOutlineToggle call ScadToggleOutline()
nnoremap <F6> :ScadOutlineToggle<CR>
