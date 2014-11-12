; 
; IDL Widget Interface Procedures. This Code is automatically 
;     generated and should not be modified.

; 
; Generated on:	04/10/2014 16:50.11
; 
pro WID_BASE_0_event, Event

  wTarget = (widget_info(Event.id,/NAME) eq 'TREE' ?  $
      widget_info(Event.id, /tree_root) : event.id)


  wWidget =  Event.top

  case wTarget of

    Widget_Info(wWidget, FIND_BY_UNAME='OkButton'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressOk, Event
    end
    else:
  endcase

end

pro WID_BASE_0, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_

  Resolve_Routine, 'about_gui_eventcb',/COMPILE_FULL_FILE  ; Load event callback routines
  
  WID_BASE_0 = Widget_Base( GROUP_LEADER=wGroup, UNAME='WID_BASE_0'  $
      ,XOFFSET=5 ,YOFFSET=5 ,SCR_XSIZE=300 ,SCR_YSIZE=200  $
      ,TITLE='JCPDS Reader - About' ,SPACE=3 ,XPAD=3 ,YPAD=3)

  
  OkButton = Widget_Button(WID_BASE_0, UNAME='OkButton' ,XOFFSET=83  $
      ,YOFFSET=128 ,SCR_XSIZE=113 ,SCR_YSIZE=26 ,/ALIGN_CENTER  $
      ,VALUE='Ok')

  
  WID_LABEL_0 = Widget_Label(WID_BASE_0, UNAME='WID_LABEL_0'  $
      ,XOFFSET=26 ,YOFFSET=13 ,SCR_XSIZE=226 ,SCR_YSIZE=23  $
      ,/ALIGN_CENTER ,VALUE='JCPDS Reader')

  
  WID_LABEL_1 = Widget_Label(WID_BASE_0, UNAME='WID_LABEL_1'  $
      ,XOFFSET=26 ,YOFFSET=44 ,SCR_XSIZE=226 ,SCR_YSIZE=23  $
      ,/ALIGN_CENTER ,VALUE='Made By Przemyslaw Dera and Morgan'+ $
      ' Roman')

  
  WID_LABEL_2 = Widget_Label(WID_BASE_0, UNAME='WID_LABEL_2'  $
      ,XOFFSET=26 ,YOFFSET=71 ,SCR_XSIZE=226 ,SCR_YSIZE=36  $
      ,/ALIGN_CENTER ,VALUE='For More Information, Contact'+ $
      ' pdera@hawaii.edu')

  Widget_Control, /REALIZE, WID_BASE_0

  XManager, 'WID_BASE_0', WID_BASE_0, /NO_BLOCK  

end
; 
; Empty stub procedure used for autoloading.
; 
pro about_gui, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_
  WID_BASE_0, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_
end
