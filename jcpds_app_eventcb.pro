
pro OnPressOpen, Event
	common filevar,jcpds,fname

	CATCH, Error_status
	ok='pick';tells it to pick a file, prevents error #109
   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      case error_status of; ne -192 then begin
      ;no error will report if fname is undefined (user cancels on dialog box)
		-192: return;case if fname is undefined
		-109: begin
				ok=dialog_message('Some parts of the file are unreadable or unsolvable. Would you like to continue?',/question)
				if ok eq 'No' then return
			end
      	else:begin
      		PRINT, 'Error index: ', Error_status
      		PRINT, 'Error message: ', !ERROR_STATE.MSG
      		return
      	end
	  endcase

      CATCH, /CANCEL


   ENDIF
	if ok eq 'pick' then fname=dialog_pickfile(/Read,filter='*.jcpds')

	fname=check_filetype(fname,'jcpds')

	if fname ne '' then begin

		widget_control,widloc('BrowseBox'),set_value=fname
		jcpds=obj_new('JCPDS')
		jcpds->read_file,fname
		delete_table
		UPDATE_GUI
	endif else begin
		return
	endelse

end

pro OnPressSave, Event
	common filevar,jcpds,fname
	update_object; updates the object jcpds before saving
	  CATCH, Error_status

   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG


      CATCH, /CANCEL
      return
   ENDIF
   	update_object
	filebox=widval('BrowseBox')
;	if filebox ne fname then fname=filebox
	if exist(fname) ne 1 || fname eq ''|| filebox ne fname then begin

		;widget_control,widloc('BrowseBox'),get_value=fname
		fname=dialog_pickfile(/write,filter='*.jcpds',default_extension='jcpds',path=fname)

	endif
	widget_control,widloc('BrowseBox'),set_value=fname
	jcpds->write_file,fname



end



pro OnPressImport, Event
	common filevar,jcpds,fname
	print,jcpds->get_a()
end

pro OnPressClose, Event
	ok = dialog_message('Do you want to exit?',/question)
	if ok eq 'Yes' then begin
		widget_control,Event.top,/destroy
	endif else begin
		return
	endelse
end


pro OnPressAdd, Event
	common filevar,jcpds,fname
	;common reflections,rs

	;first, add a row to the table
	widget_control,widloc('HKLTable'),/insert_rows
	;rs=jcpds->get_reflections()
	;sz=size(rs,/n_elements)
	;make a new structure array of one longer with rs[0] as all values
	;rs2=replicate(rs[0],sz+1)

	widget_control,widloc('HKLTable'),get_value=table
	;update_reflections



end

pro OnPressDelete, Event
	print,'delete pressed'
	widget_control,widloc('HKLTable'),/delete_rows
	widget_control,widloc('HKLTable'),get_value=table
	;update_reflections


end

function OnHandleList, Event

	print,'list handled'
     return, Event ; By Default, return the event.


end

pro OnContextList, Event
	print,'list context'
end
;-----------------------------------------------------------------
; List Select Item Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_LIST, ID:0L, TOP:0L, HANDLER:0L, INDEX:0L, CLICKS:0L}
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   INDEX returns the index of the selected item. This index can be
;       used to subscript the array of names originally used to set
;       the widget's value. The CLICKS field returns either 1 or 2,
;       depending upon how the list item was selected. If the list
;       item is double-clicked, CLICKS is set to 2.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnSelectList, Event
	common reflections,rs_struct
	loc=widget_info(widloc('JCPDSList'),/list_select)
	widget_control,widloc('HKLBox_0'),set_value=stringy(rs_struct[loc].h);assign h
	widget_control,widloc('HKLBox_1'),set_value=stringy(rs_struct[loc].k);assign k
	widget_control,widloc('HKLBox_2'),set_value=stringy(rs_struct[loc].k);assign l
	widget_control,widloc('d_spcBox'),set_value=stringy(rs_struct[loc].d0);assign d-spc
	widget_control,widloc('IBox'),set_value=stringy(rs_struct[loc].inten);assign i

end



pro OnPressNew, Event
	common filevar,jcpds,fname

	; Establish error handler. When errors occur, the index of the
   ; error is returned in the variable Error_status:
   CATCH, Error_status

   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG
      ; Handle the error by extending A:

      CATCH, /CANCEL
   ENDIF

	jcpds = obj_new('JCPDS')

	;update_gui
	widget_control,widloc('BrowseBox'),set_value=''
	widget_control,widloc('CommentBox'),set_value=''
	widget_control,widloc('aBox'),set_value=''
	widget_control,widloc('bBox'),set_value=''
	widget_control,widloc('cBox'),set_value=''
	widget_control,widloc('K0Box'),set_value=''
	widget_control,widloc('KPBox'),set_value=''
	widget_control,widloc('alphaBox'),set_value=''
	widget_control,widloc('betaBox'),set_value=''
	widget_control,widloc('gammaBox'),set_value=''
	widget_control,widloc('VBox'),set_value=''
	widget_control,widloc('K0DTBox'),set_value=''
	widget_control,widloc('KPDTBox'),set_value=''
	widget_control,widloc('SymmetryDroplist'),set_droplist_select=0
	;to reset the table, it is led by rows
	widget_control,widloc('HKLTable'),get_value=table
	tbsz=size(table)&rows=tbsz[2]
	widget_control,widloc('HKLTable'),/delete_rows,use_table_select=[0,0,0,rows-1]
end



;
; Empty stub procedure used for autoloading.
;
pro jcpds_app_eventcb
end;-----------------------------------------------------------------
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_BUTTON, ID:0L, TOP:0L, HANDLER:0L, SELECT:0}
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   SELECT is set to 1 if the button was set, and 0 if released.
;       Normal buttons do not generate events when released, so
;       SELECT will always be 1. However, toggle buttons (created by
;       parenting a button to an exclusive or non-exclusive base)
;       return separate events for the set and release actions.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnPressSaveAs, Event
		common filevar,jcpds,fname
	update_object; updates the object jcpds before saving
	  CATCH, Error_status

   ;This statement begins the error handler:
   IF Error_status NE 0 THEN BEGIN
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG


      CATCH, /CANCEL
      return
   ENDIF
	filebox=widval('BrowseBox')
	if filebox ne fname then fname=filebox

	fname=dialog_pickfile(/write,filter='*.jcpds',default_extension='jcpds',path=fname)

	widget_control,widloc('BrowseBox'),set_value=fname
	jcpds->write_file,fname
end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_BUTTON, ID:0L, TOP:0L, HANDLER:0L, SELECT:0}
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   SELECT is set to 1 if the button was set, and 0 if released.
;       Normal buttons do not generate events when released, so
;       SELECT will always be 1. However, toggle buttons (created by
;       parenting a button to an exclusive or non-exclusive base)
;       return separate events for the set and release actions.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro ImportText, Event
	common filevar,jcpds,fname
	;;clear the table
	delete_table
	;;create new object
	;;read file
	;;retrieve file contents,create reflection structure
	;;get a new file name and save it if possible

	fname=dialog_pickfile(/read,filter='*.txt')
	if fname ne '' then begin
		fname=check_filetype(fname,'txt')

		jcpds=obj_new('JCPDS')

		flen=file_len(fname)

	;openr,lun,fname,/get_lun
		linnum=0
	;while (not eof(lun)) do begin
	;	readf,lun,line
	;	print,line
	;endwhile
	;close,lun
	;free_lun,lun

		comment=strtrim(get_line(fname,3)+' '+get_line(fname,4),1)
		widget_control,widloc('CommentBox'),set_value=comment
		comment=widval('CommentBox')


		parameters=strsplit(get_line(fname,7),' ',/extract)
		print,parameters

		print,'wee'
		update_parameters, ap=parameters[2],bp=parameters[3],cp=parameters[4],alphap=parameters[5], $
		betap=parameters[6],gammap=parameters[7],commentp=comment
	;print,read_reflections(fname,13)
	;	readit,fname
	len= file_len(fname)
	i=4
	while (1 eq 1) do begin

		finalline=strsplit(get_line(fname,i),' ',/extract)
		print,finalline
		if finalline[0] eq '2-THETA' then begin
				start=i
		endif
		if (strmid(get_line(fname,i),0,1) eq '=') || (i eq len) then begin
			finish=i
			break
		endif

		i=i+1
	endwhile
	;print,finish,start
	i=start
	reflections = replicate({JCPDS_REFLECTION},finish-start-1)
	nd=0
	while (1 eq 1) do begin
		i=i+1
		line=get_line(fname,i)
		if (strmid(line,0,1) eq '=') || (i eq len) then begin
			break
		endif else begin

			dtemp=strsplit(get_line(fname,i),' ',/extract)
			 		reflections[nd].d0 = dtemp[2]
                    reflections[nd].inten = dtemp[1]
                    reflections[nd].h = dtemp[3]
                    reflections[nd].k = dtemp[4]
                    reflections[nd].l = dtemp[5]
                    nd=nd+1
		endelse

	endwhile
	jcpds->set_hkl,reflections
	update_table
	cut_table

	; openr, lun, file, /get_lun
	; linnum=0
	; while (not eof(lun)) do begin
	 ;	 	case linnum of
	;			3: begin
	;
	;				end

	 ;	 	endcase
      ;      readf, lun, line
       ;     pos = strpos(line, ' ')
        ;    tag = strupcase(strmid(line, 0, pos))
         ;   value = strtrim(strmid(line, pos, 1000), 2)
          ;  case tag of
           ;     'COMMENT:'  :  begin
            ;        comment[ncomments] = value
             ;       ncomments = ncomments + 1
              ;   end
               ; 'K0:'  :  self.k0 = value
                ;'K0P:' :  self.k0p = value
;                'DK0DT:'  :  self.dk0dt = value
 ;               'DK0PDT:' :  self.dk0pdt = value
  ;              'SYMMETRY:' : self.symmetry = strupcase(value)
   ;             'A:'      :  self.a0 = value
    ;            'B:'      :  self.b0 = value
     ;           'C:'      :  self.c0 = value
      ;          'ALPHA:'  :  self.alpha0 = value
       ;         'BETA:'   :  self.beta0 = value
        ;        'GAMMA:'  :  self.gamma0 = value
         ;       'VOLUME:' :  self.v0 = value
          ;      'ALPHAT:' :  self.alphat = value
           ;     'DALPHADT:' :  self.dalphadt = value
            ;    'DIHKL:'  :  begin
             ;       reads, value, dtemp
              ;      reflection[nd].d0 = dtemp[0]
               ;     reflection[nd].inten = dtemp[1]
                ;    reflection[nd].h = dtemp[2]
                 ;   reflection[nd].k = dtemp[3]
                  ;  reflection[nd].l = dtemp[4]
                   ; nd = nd + 1
                    ;end
;            endcase
;        endwhile
	endif
widget_control,widloc('BrowseBox'),set_value=cut_filetype(fname)
;this is a strange way to handle an error, but it is to help the user experience
;Basically, if the file name is different than what is in the browse box, then
;instead of 'saving' it will always do a 'save as' procedure, this way the file path
;shows up to the user, while forcing them to redefine the filename/location/type
;after importing and then saving
return
end

pro ImportJade, Event

end


;-----------------------------------------------------------------
; Notify Realize Callback Procedure.
; Argument:
;   wWidget - ID number of specific widget.
;
;
;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro RealizeBase, wWidget
	common_widgets,wWidget;;creates the easy access widget common block
	jcpds = obj_new('JCPDS')

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_BUTTON, ID:0L, TOP:0L, HANDLER:0L, SELECT:0}
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   SELECT is set to 1 if the button was set, and 0 if released.
;       Normal buttons do not generate events when released, so
;       SELECT will always be 1. However, toggle buttons (created by
;       parenting a button to an exclusive or non-exclusive base)
;       return separate events for the set and release actions.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnPressPrint, Event

end

pro OnPressCalcV, Event
		common filevar, jcpds, fname
	;;; this updates the object based on the gui
	jcpds->set_a,widval('aBox')
	jcpds->set_b,widval('bBox')
	jcpds->set_c,widval('cBox')
	jcpds->set_alpha,widval('alphaBox')
	jcpds->set_beta,widval('betaBox')
	jcpds->set_gamma,widval('gammaBox')

	;for the droplist

	loc=widget_info(widloc('SymmetryDroplist'),/droplist_select)
	selectionlist=widval('SymmetryDroplist')
	jcpds->set_symmetry,selectionlist[loc]


	v=jcpds->compute_v()
	widget_control,widloc('VBox'),set_value=stringy(jcpds->get_V())
	print,v

end
;-----------------------------------------------------------------
; Notify Realize Callback Procedure.
; Argument:
;   wWidget - ID number of specific widget.
;
;
;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnRealizeTable, wWidget
	;;makes the columns not freeking huge (the size of D-SPC)
	maxlen=strlen(' D-Spc');
	maxwidth=maxlen*!d.x_ch_size+8
	widget_control,wWidget,column_widths=maxwidth
	;widget_control,wWidget,column_widths=col_width,use_table_select=[-1,-1,3,3]
end
;-----------------------------------------------------------------
; Handle Event Callback Function.
; Argument:
;   Event structure:
;
;   {WIDGET_<type>, ID:0L, TOP:0L, HANDLER:0L,...}
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;
;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
function OnHandleTable, Event
	catch, error_status

	if error_status ne 0 then begin
	;if you try to edit a cell without the table loading any jcpds, you'll just get an error

		print, 'Error index: ',Error_status
		return,!ERROR_STATE.MSG

	endif

	; print,'Called on Handle'
	widget_control,widloc('HKLTable'),get_value=table
	update_reflections,table
    ; return, Event ; By Default, return the event.

end
;-----------------------------------------------------------------
; Table Insert Character Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_TEXT_CH, ID:0L, TOP:0L, HANDLER:0L, TYPE:0, OFFSET:0L,
;       CH:0B, X:0L, Y:0L }

;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   OFFSET is the (zero-based) insertion position that will result
;       after the character is inserted. CH is the ASCII value of the
;       character. X and Y give the zero-based address of the cell
;       within the table.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
;-----------------------------------------------------------------
; Table Insert String Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_TABLE_STR, ID:0L, TOP:0L, HANDLER:0L, TYPE:1, OFFSET:0L,
;       STR:'', X:0L, Y:0L }

;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   OFFSET is the (zero-based) insertion position that will result
;       after the character is inserted. STR is the string to be
;       inserted. X and Y give the zero-based address of the cell
;       within the table.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnInsertTable, Event
	print,'Called OnInsert'
end
;-----------------------------------------------------------------
; Table Delete Character(s) Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_TABLE_DEL, ID:0L, TOP:0L, HANDLER:0L, TYPE:2, OFFSET:0L,
;         LENGTH:0L, X:0L, Y:0L }

;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   OFFSET is the (zero-based) character position of the first
;       character to be deleted. It is also the insertion position
;       that will result when the characters have been deleted.
;       LENGTH gives the number of characters involved. A LENGTH of
;       zero indicates that no characters were deleted. X and Y give
;       the zero-based address of the cell within the table.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnDeleteTable, Event
	print,'Called OnDelete'
end
;-----------------------------------------------------------------
; Table Select Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_TABLE_SEL, ID:0L, TOP:0L, HANDLER:0L, TYPE:3, OFFSET:0L,
;       LENGTH:0L, X:0L, Y:0L }

;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   OFFSET is the (zero-based) character position of the first
;       character to be selected. LENGTH gives the number of
;       characters involved. A LENGTH of zero indicates that no
;       characters are selected, and the new insertion position is
;       given by OFFSET. X and Y give the zero-based address of the
;       cell within the table.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnSelectTable, Event
	print,'Called Onselect'
end
;-----------------------------------------------------------------
; Table Cell Select Callback Procedure
; Argument:
;   Event structure:
;
;   {WIDGET_TABLE_CELL_SEL, ID:0L, TOP:0L, HANDLER:0L, TYPE:4,
;       SEL_LEFT:0L, SEL_TOP:0L, SEL_RIGHT:0L, SEL_BOTTOM:0L}

;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   The range of cells selected is given by the zero-based indices
;       into the table specified by the SEL_LEFT, SEL_TOP, SEL_RIGHT,
;       and SEL_BOTTOM fields. When cells are deselected (either by
;       changing the selection or by clicking in the upper left
;       corner of the table) an event is generated in which the
;       SEL_LEFT, SEL_TOP, SEL_RIGHT, and SEL_BOTTOM fields contain
;       the value -1.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnCellSelectTable, Event
	print,'Called OnCellSelect'
end
;-----------------------------------------------------------------
; Droplist Select Item Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_DROPLIST, ID:0L, TOP:0L, HANDLER:0L, INDEX:0L }
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   INDEX returns the index of the selected item. This can be used to
;       index the array of names originally used to set the widget's
;       value.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnChooseSymmetry, Event

end
;-----------------------------------------------------------------
; Activate Button Callback Procedure.
; Argument:
;   Event structure:
;
;   {WIDGET_BUTTON, ID:0L, TOP:0L, HANDLER:0L, SELECT:0}
;
;   ID is the widget ID of the component generating the event. TOP is
;       the widget ID of the top level widget containing ID. HANDLER
;       contains the widget ID of the widget associated with the
;       handler routine.

;   SELECT is set to 1 if the button was set, and 0 if released.
;       Normal buttons do not generate events when released, so
;       SELECT will always be 1. However, toggle buttons (created by
;       parenting a button to an exclusive or non-exclusive base)
;       return separate events for the set and release actions.

;   Retrieve the IDs of other widgets in the widget hierarchy using
;       id=widget_info(Event.top, FIND_BY_UNAME=name)

;-----------------------------------------------------------------
pro OnPressAbout, Event
	print,'about pressed'
	about_gui
end
