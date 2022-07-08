if exists("g:loaded_opsort") || &cp || v:version < 700
  finish
endif
let g:loaded_opsort = 1

function! s:opsort(motion)
	if type(a:motion) == v:t_number
		let n = min([a:motion - 1, line("$") - line(".")])
		exec ".,.+" . n . "sort"
	elseif a:motion ==# "line" || a:motion ==# "char"
		'[,']sort
	elseif a:motion ==# "V" || a:motion ==# "v"
		exec "normal! \<c-\>\<c-n>"
		'<,'>sort
	elseif a:motion ==# "block"
		let [left, right] = sort([virtcol("'["), virtcol("']")], "n")
		let regex = '/\%>' . (left - 1) . 'v.*\%<' . (right + 2) . 'v/'
		exec "'[,']sort" regex "r"
	elseif a:motion ==# "\<c-v>"
		exec "normal! \<c-\>\<c-n>"
		let [left, right] = sort([virtcol("'<"), virtcol("'>")], "n")
		let regex = '/\%>' . (left - 1) . 'v.*\%<' . (right + 2) . 'v/'
		exec "'<,'>sort" regex "r"
	else
		echoe "Unknown motion " . a:motion . ", please report this to the maintainer(s)"
	endif
endfunction

nnoremap <silent> <plug>Opsort      <cmd>set operatorfunc=<SID>opsort<cr>g@
" TODO this seems like it works, do the visual mode handlers even need to exist?
xnoremap <silent> <plug>Opsort      <cmd>set operatorfunc=<SID>opsort<cr>g@
" xnoremap <silent> <Plug>Opsort      <cmd>call SortMotion(mode())<cr>
nnoremap <silent> <plug>OpsortLines <cmd>call <SID>opsort(v:count1) \| silent! call repeat#set("\<lt>Plug>OpsortLines", v:count1)<cr>

if !exists("g:opsort_no_mappings") || !g:opsort_no_mappings
	silent! xmap <unique> gs   <plug>Opsort
	silent! nmap <unique> gs   <plug>Opsort
	silent! nmap <unique> gss  <plug>OpsortLines
	silent! nmap <unique> gsgs <plug>OpsortLines
endif
