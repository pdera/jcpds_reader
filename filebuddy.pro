
function file_len, fname
	openr, lu, fname,/get_lun
	i = 0
	a=''
	while not eof(lu) do $
	begin
		readf, lu, a
		i = i + 1
	endwhile
	close, lu
	free_lun,lu
	return, i
end

function get_line, fname,num
	;;extracts a line from a file and returns a string
	;;counts up from 0
	i=0
	;get_lun,lu
	line=''
	openr,lu,fname,/get_lun
	while not eof(lu) do begin
		readf,lu,line
		if i eq num then break
		i=i+1
	endwhile
	close,lu
	free_lun,lu
	return, line

end
pro readit, fname

openr,lu,fname,/get_lun
	while not eof(lu) do begin
		readf,lu,line
		print,line
	endwhile
	close,lu
	free_lun,lu
end


pro write_file, fname, lists
	get_lun, lu
	openw, lu, fname
	s = size(lists)
	rows = s[2]
	columns = s[1]
	for i = 0,rows-1 do begin
		queue = fltarr(columns)

		for j = 0,columns-1 do begin
			queue[j] = lists[j,i]

		endfor
		printf, lu, queue
	endfor
	close, lu
	free_lun,lu
end

function cut_filetype,fname
    txtpos=strpos(fname,'.',/reverse_search)
    return,strmid(fname,0,txtpos)
end



pro save_plot,fname,windownum
	wset,windownum
	make_tiff,fname
end

function find_type, variable
	type=size(variable)
	type=type[1]
	case type of
		0: type='undefined'
		1: type='byte'
		2: type='int'
		3: type='long'
		4: type='float'
		5: type='double'
		6: type='complex'
		7: type='string'
		8: type='struct'
		9: type='dcomplex'
		10:type='pointer'
		11:type='objref'
		12:type='uint'
		13:type='ulong'
		14:type='long64
		15:type='ulong64'
		else: Print, "Error."
	endcase
	return,type
end

function exist,variable
	;if the variable exists, it will return a 1, if it doesn't it will return a 0
		type=size(variable)
		type=type[1]
	case type of
		0: type=0
		else: type=1
	endcase
	return,type
end

function find_line,fname,word,endsearch = rev,multiline = multi
	;;finds a line in a file, if it finds a string, it will return it.
	;;can do reverse search, cannot do multiline
	if exist(multi) eq 0 then multi=0
	if exist(rev) eq 0 then rev=0
	if find_type(word) ne 'string' then begin
		print, 'not a string'
		return,''
	endif
	;;checking optional argument existence and if the string is a string
	openr,lu,fname,/get_lun;opening file
	line=''
	wordlen=strlen(word)
	while not eof(lu) do begin
		readf,lu,line
	endwhile

end

function check_filetype, fname,type
;;Checks the file type of an input file
;;both items must be a string
;;therefore, to check text.txt, input 'text.txt' and 'txt'
;;if the file is wrong, it will prompt the user to pick a new file
;;please input the filtype without the 'dot' so '.txt' will be just 'txt'
	on_error,2
	exist=strpos(fname,'.'+type,/reverse_search)
	len=strlen(fname)
	typelen=strlen(type)
	if len eq 0 then begin
		;check if the user wants to cancel, prevents infinite loops
		return, bee
	endif
	if exist eq -1 || typelen ne len-exist-1 then begin
		;checks if the type exists int the file and if the file name is in the right position
		error=dialog_message('File Type is not '+type+', please select a '+type+' file')
		fname=dialog_pickfile(/READ, FILTER = '*'+type)
		;recursively acts until user picks right filetype or cancels
		fname=check_filetype(fname,type)
	endif
	return, fname

end

pro make_tiff,fname,index=num
	;obsolete, keeping here just incase
	if find_type(num) eq 'undefined' then begin
		num=''
	endif
	image24=tvrd(true=1)
	image24=reverse(image24,3)
	fname=fname+'.tif'
	write_tiff,fname,image24,1
	SAVE, /VARIABLES, FILENAME = 'graph'+string(num)+'.sav'
end

pro make_jpg,fname,index=num
	fname=fname+'.jpeg'

	image3d = TVRD(TRUE=1)
    WRITE_JPEG, fname, image3d, TRUE=1, QUALITY=75

	if find_type(num) ne 'undefined' then begin
		savename='graph'+strtrim(string(num),1)+'.sav'
		print,savename
		SAVE, /VARIABLES, FILENAME = savename
	endif


end


pro show_image,fname

	;read_jpeg,fname,im,r,g,b
	imsize=size(im)
	device,decomposed=0
	TVLCT,r,g,b
	window,/FREE,xsize=imsize[1],ysize=imsize[2]
	TV,im

end

function range, x1, x2, n
	x1 = float(x1)
	x2 = float(x2)
	n = float(n)
	n = n[0]
	a = fltarr(n)
	dx = (x2-x1)/n
	for i=0,n-1 do begin
		a[i] = x1 + dx*i
	endfor
	return, a
end

function read_file, fname
	catch,error_status
	if error_status ne 0 then begin
		token = dialog_message(string(error_status))
		catch, /cancel
		return, 0
	endif
	n = file_len(fname)
	x = fltarr(n)
	y = fltarr(n)
	z = fltarr(n)
	get_lun, lu
	openr, lu, fname
	i=0
	while not eof(lu) do begin
		readf, lu, a, b, c
		x[i] = a
		y[i] = b
		z[i] = c
		i = i + 1
	endwhile
	close, lu
	free_lun, lu
	return, [[x], [y], [z]]
end

function stringy, number
	;makes a number into a string with out the BS that IDL gives you
	return, strmid(string(number),1)
end
