;Buddy file for JCPDS functions


pro update_reflections
	common filevar,jcpds,fname

	widget_control,widloc('HKLTable'),get_value=table_struct

	rs_struct=replicate({D0:0.0,D:0.0,INTEN:0.0,H:0,K:0,L:0},size(table_struct,/n_elements))
	for i=0,size(table_struct,/n_elements)-1 do begin
		rs_struct[i].D0=table_struct[i].D
		rs_struct[i].D=table_struct[i].D
		rs_struct[i].INTEN=table_struct[i].I
		rs_struct[i].H=table_struct[i].H
		rs_struct[i].K=table_struct[i].K
		rs_struct[i].L=table_struct[i].L
	endfor
	jcpds->set_reflections,rs_struct

	;print,jcpds->get_reflections()
end

pro display_reflections
	;THIS PROCEDURE IS NOW OBSOLETE, I AM KEEPING IT JUST IN CASE
	common filevar,jcpds,fname
	common reflections,rs
	;; creates a common block with a struct to show reflectoins
	;; true list is a list of strings
	;; stringlist is a string to be used for display
	;; struct is the structure itself
	rs=jcpds->get_reflections()
	sz=size(rs,/n_elements)

	list=string(rs[0].h,format='(I4)')+string(rs[0].k,format='(I4)')$
		+string(rs[0].l,format='(I4)')+string(rs[0].d0,format='(F12.4)')$
		+string(rs[0].inten,format='(I10)')
	print,list
	for i=1, sz-1 do begin
		list=[list,string(rs[i].h,format='(I4)')+string(rs[i].k,format='(I4)')$
			+string(rs[i].l,format='(I4)')+string(rs[i].d0,format='(F12.4)')$
			+string(rs[i].inten,format='(I10)')]
	endfor
	widget_control,widloc('JCPDSList'),set_value=list

	rs_struct=rs
end

pro update_gui
	;specific procedure to update the gui from the object
	common filevar,jcpds,fname
	;restore,'file_variables.sav' ; get the name fohyr jcpds out of it
	;update each individual thing based off the object
	;needs widloc function
	widget_control,widloc('CommentBox'),set_value=jcpds->get_comment()
	widget_control,widloc('aBox'),set_value=stringy(jcpds->get_a())
	widget_control,widloc('bBox'),set_value=stringy(jcpds->get_b())
	widget_control,widloc('cBox'),set_value=stringy(jcpds->get_c())
	widget_control,widloc('K0Box'),set_value=stringy(jcpds->get_k0())
	widget_control,widloc('KPBox'),set_value=stringy(jcpds->get_kP())
	widget_control,widloc('alphaBox'),set_value=stringy(jcpds->get_alpha())
	widget_control,widloc('betaBox'),set_value=stringy(jcpds->get_beta())
	widget_control,widloc('gammaBox'),set_value=stringy(jcpds->get_gamma())
	widget_control,widloc('VBox'),set_value=stringy(jcpds->get_V())
	widget_control,widloc('K0DTBox'),set_value=stringy(jcpds->get_k0dt())
	widget_control,widloc('KPDTBox'),set_value=stringy(jcpds->get_KPDT())

	;;for the droplist
	widget_control,widloc('SymmetryDroplist'),get_value=selectionlist
	sym=jcpds->get_symmetry()
	loc=where(selectionlist eq sym)
	widget_control,widloc('SymmetryDroplist'),set_droplist_select=loc

	;display_reflections
	update_table
end


pro update_object
	;this procedure updates the object from the gui
	;I know there are better ways to do this, LOL

	common filevar,jcpds,fname
	jcpds->set_comment,widval('CommentBox')
	jcpds->set_a,widval('aBox')
	jcpds->set_b,widval('bBox')
	jcpds->set_c,widval('cBox')
	jcpds->set_a0,widval('aBox')
	jcpds->set_b0,widval('bBox')
	jcpds->set_c0,widval('cBox')

	jcpds->set_alpha,widval('alphaBox')
	jcpds->set_beta,widval('betaBox')
	jcpds->set_gamma,widval('gammaBox')
	jcpds->set_k0,widval('K0Box')
	jcpds->set_kp,widval('KPBox')
	jcpds->set_K0DT,widval('K0DTBox')
	jcpds->set_KPDT,widval('KPDTBox')
	jcpds->set_v,widval('VBox')

	;for the droplist
	loc=widget_info(widloc('SymmetryDroplist'),/droplist_select)
	selectionlist=widval('SymmetryDroplist')
	jcpds->set_symmetry,selectionlist[loc]



	;update_reflections

	update_reflections

end

pro update_parameters,ap=a1,bp=b1,cp=c1,alphap=aleph,betap=bet,gammap=gimmel,commentp=com
	;;updates parameters for a, b, c, alpha, beta, gamma and the comment and displays it
	;;on the gui. All arguments are optional arguments, names are the parameter
	;;name with a 'p' at the end for 'parameter'
	common filevar,jcpds
	if exist(com) ne 0 then jcpds->set_comment,com & widget_control,widloc('CommentBox'),set_value=jcpds->get_comment()
	if exist(a1) ne 0 then jcpds->set_a,float(a1)& jcpds->set_a0,float(a1) & widget_control,widloc('aBox'),set_value=stringy(jcpds->get_a0())
	if exist(b1) ne 0 then jcpds->set_b,float(b1) & jcpds->set_b0,float(b1) & widget_control,widloc('bBox'),set_value=stringy(jcpds->get_b0())
	if exist(c1) ne 0 then jcpds->set_c,float(c1) & jcpds->set_c0,float(c1) & widget_control,widloc('cBox'),set_value=stringy(jcpds->get_c0())
	if exist(aleph)ne 0 then jcpds->set_alpha,float(aleph) & widget_control,widloc('alphaBox'),set_value=stringy(jcpds->get_alpha())
	if exist(bet) ne 0 then jcpds->set_beta,float(bet) & widget_control,widloc('betaBox'),set_value=stringy(jcpds->get_beta())
	if exist(gimmel) ne 0 then jcpds->set_gamma,float(gimmel) & widget_control,widloc('gammaBox'),set_value=stringy(jcpds->get_gamma())



end

pro update_table

	   ; Establish error handler. When errors occur, the index of the
   ; error is returned in the variable Error_status:
   CATCH, Error_status
   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
   	  print, 'error is inside update table'
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG

      CATCH, /CANCEL
      return
   ENDIF
	common filevar,jcpds,fname

	rs=jcpds->get_reflections()
	sz=size(rs,/n_elements)

	widget_control,widloc('HKLTable'),insert_rows=(sz)

	;create  a new structure that matches the table
	tablestruct=replicate({H:0,K:0,L:0,D:0.0,I:0.0},sz)
	for i = 0,sz-1 do begin
		tablestruct[i].H=rs[i].H
		tablestruct[i].K=rs[i].K
		tablestruct[i].L=rs[i].L
		if rs[i].D ne 0 then begin
			tablestruct[i].D=rs[i].D
		endif else begin
			tablestruct[i].D=rs[i].D0
		endelse
		tablestruct[i].I=rs[i].INTEN
	endfor

	widget_control,widloc('HKLTable'),set_value=tablestruct

end

function read_reflections, fname,from;12
	;READS REFLECTIONS FROM A TEXT FILE
	catch,error_status
	if error_status ne 0 then begin
		token = dialog_message(string(error_status))
		print, !ERROR_STATE
		catch, /cancel
		return, 0
	endif

	n = file_len(fname)

	;hlist = fltarr(n)
	;klist = fltarr(n)
	;llist = fltarr(n)
	;mlist = fltarr(n)
	;dlist = fltarr(n)
	get_lun, lu
	openr, lu, fname

	;table=replicate(n,{0,0,0,0,0})

	;	 openr, lun, file, /get_lun
    ;readf, lun, line
    ;pos = strpos(line, ' ')
    ;tag = strupcase(strmid(line, 0, pos))
    ;value = strtrim(strmid(line, pos, 1000), 2)

	reflection = replicate({JCPDS_REFLECTION}, n-from)
	;print,reflection,'wee'
	i=0
	while not eof(lu) do begin
		reads,lu,line
	;	pos = strpos(line,' ')
	;	tag = strupcase(strmid(line,0,pos))
	;	value = strtrim(strmid(line,pos,1000),2)
	;	print,line
	;	print,pos,tag,value
		;if i ge from then begin
         ;   reflection[i].h = h
         ;   reflection[i].k = k
         ;   reflection[i].l = l
         ;   reflection[i].d0 = dspc
         ;   reflection[i].inten = intensity
		;endif else begin
		;endelse
		;i = i + 1
	endwhile
	close, lu
	free_lun, lu
	return, reflection
end

pro cut_table
	;this procedure cuts the table down to the required size

	   ; Establish error handler. When errors occur, the index of the
   ; error is returned in the variable Error_status:
   CATCH, Error_status

   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG
      ; Handle the error by extending A:

      CATCH, /CANCEL
      return
   ENDIF
	common filevar,jcpds,fname

	rs=jcpds->get_reflections()
	sz=size(rs,/n_elements)

	widget_control,widloc('HKLTable'),get_value=table
	;tbsz=size(table)&rows=tbsz[1]
	rows=size(table,/n_elements)
	;make the number of rows equal the number of reflections
	print,rows,sz
	help,tbsz
	widget_control,widloc('HKLTable'),/delete_rows,use_table_select=[-1,sz-1,5,rows-1]


end

pro delete_table
;a procedure that clears the table
	CATCH, Error_status

   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      print,'error is inside of delete table'
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG

      CATCH, /CANCEL
      return
   ENDIF
	widget_control,widloc('HKLTable'),get_value=table
	;	first, see if the table is a string instead of a struct
	type=size(table,/type)
	tbsz=size(table)
	case type of
		7: rows=tbsz[2]
		8: rows=size(table,/n_elements)
	else: return
	endcase
	widget_control,widloc('HKLTable'),/delete_rows,use_table_select=[0,0,5,rows-1]

end