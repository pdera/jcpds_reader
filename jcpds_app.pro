; 
; IDL Widget Interface Procedures. This Code is automatically 
;     generated and should not be modified.

; 
; Generated on:	04/07/2014 15:59.41
; 
pro BaseWindow_event, Event

  wTarget = (widget_info(Event.id,/NAME) eq 'TREE' ?  $
      widget_info(Event.id, /tree_root) : event.id)


  wWidget =  Event.top

  case wTarget of

    Widget_Info(wWidget, FIND_BY_UNAME='BaseWindow'): begin
    end
    Widget_Info(wWidget, FIND_BY_UNAME='AddButton'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressAdd, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='DeleteButon'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressDelete, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='W_MENU_0'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressAbout, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileNew'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressNew, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileOpen'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressOpen, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileSave'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressSave, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileSaveAs'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressSaveAs, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileImportText'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        ImportText, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileImportJade'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        ImportJade, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='FileClose'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressClose, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='BrowseButton'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressOpen, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='VoButton'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_BUTTON' )then $
        OnPressCalcV, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='HKLTable'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_TABLE_CH' )then $
        OnInsertTable, Event
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_TABLE_STR' )then $
        OnInsertTable, Event
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_TABLE_DEL' )then $
        OnDeleteTable, Event
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_TABLE_TEXT_SEL' )then $
        OnSelectTable, Event
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_TABLE_CELL_SEL' )then $
        OnCellSelectTable, Event
    end
    Widget_Info(wWidget, FIND_BY_UNAME='SymmetryDroplist'): begin
      if( Tag_Names(Event, /STRUCTURE_NAME) eq 'WIDGET_DROPLIST' )then $
        OnChooseSymmetry, Event
    end
    else:
  endcase

end

pro BaseWindow, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_

  Resolve_Routine, 'jcpds_app_eventcb',/COMPILE_FULL_FILE  ; Load event callback routines
  
  BaseWindow = Widget_Base( GROUP_LEADER=wGroup, UNAME='BaseWindow'  $
      ,XOFFSET=5 ,YOFFSET=5 ,SCR_XSIZE=620 ,SCR_YSIZE=418  $
      ,NOTIFY_REALIZE='RealizeBase' ,TITLE='JCPDS File Editor'  $
      ,SPACE=3 ,XPAD=3 ,YPAD=3 ,MBAR=WID_BASE_0_MBAR)

  
  BrowseBox = Widget_Text(BaseWindow, UNAME='BrowseBox' ,XOFFSET=81  $
      ,YOFFSET=21 ,SCR_XSIZE=432 ,SCR_YSIZE=23 ,XSIZE=20 ,YSIZE=1)

  
  WID_LABEL_0 = Widget_Label(BaseWindow, UNAME='WID_LABEL_0'  $
      ,XOFFSET=16 ,YOFFSET=26 ,SCR_XSIZE=59 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='JCPDS File')

  
  WID_LABEL_1 = Widget_Label(BaseWindow, UNAME='WID_LABEL_1'  $
      ,XOFFSET=9 ,YOFFSET=101 ,SCR_XSIZE=18 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='K0')

  
  WID_LABEL_2 = Widget_Label(BaseWindow, UNAME='WID_LABEL_2'  $
      ,XOFFSET=9 ,YOFFSET=126 ,SCR_XSIZE=26 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='KP')

  
  K0Box = Widget_Text(BaseWindow, UNAME='K0Box' ,XOFFSET=37  $
      ,YOFFSET=96 ,SCR_XSIZE=73 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  KPBox = Widget_Text(BaseWindow, UNAME='KPBox' ,XOFFSET=37  $
      ,YOFFSET=123 ,SCR_XSIZE=73 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  WID_LABEL_3 = Widget_Label(BaseWindow, UNAME='WID_LABEL_3'  $
      ,XOFFSET=115 ,YOFFSET=237 ,SCR_XSIZE=82 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='Symmetry')

  
  WID_LABEL_4 = Widget_Label(BaseWindow, UNAME='WID_LABEL_4'  $
      ,XOFFSET=13 ,YOFFSET=164 ,SCR_XSIZE=18 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='a')

  
  WID_LABEL_5 = Widget_Label(BaseWindow, UNAME='WID_LABEL_5'  $
      ,XOFFSET=13 ,YOFFSET=188 ,SCR_XSIZE=18 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='b')

  
  aBox = Widget_Text(BaseWindow, UNAME='aBox' ,XOFFSET=37  $
      ,YOFFSET=159 ,SCR_XSIZE=73 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  WID_LABEL_6 = Widget_Label(BaseWindow, UNAME='WID_LABEL_6'  $
      ,XOFFSET=13 ,YOFFSET=213 ,SCR_XSIZE=18 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='c')

  
  WID_LABEL_7 = Widget_Label(BaseWindow, UNAME='WID_LABEL_7'  $
      ,XOFFSET=9 ,YOFFSET=243 ,SCR_XSIZE=27 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='alpha')

  
  WID_LABEL_8 = Widget_Label(BaseWindow, UNAME='WID_LABEL_8'  $
      ,XOFFSET=9 ,YOFFSET=270 ,SCR_XSIZE=24 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='beta')

  
  WID_LABEL_9 = Widget_Label(BaseWindow, UNAME='WID_LABEL_9'  $
      ,XOFFSET=9 ,YOFFSET=292 ,SCR_XSIZE=34 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='gamma')

  
  WID_LABEL_10 = Widget_Label(BaseWindow, UNAME='WID_LABEL_10'  $
      ,XOFFSET=9 ,YOFFSET=317 ,SCR_XSIZE=18 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='V')

  
  bBox = Widget_Text(BaseWindow, UNAME='bBox' ,XOFFSET=37  $
      ,YOFFSET=185 ,SCR_XSIZE=73 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  cBox = Widget_Text(BaseWindow, UNAME='cBox' ,XOFFSET=37  $
      ,YOFFSET=212 ,SCR_XSIZE=73 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  alphaBox = Widget_Text(BaseWindow, UNAME='alphaBox' ,XOFFSET=51  $
      ,YOFFSET=240 ,SCR_XSIZE=59 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  betaBox = Widget_Text(BaseWindow, UNAME='betaBox' ,XOFFSET=51  $
      ,YOFFSET=266 ,SCR_XSIZE=59 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  gammaBox = Widget_Text(BaseWindow, UNAME='gammaBox' ,XOFFSET=51  $
      ,YOFFSET=291 ,SCR_XSIZE=59 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  VBox = Widget_Text(BaseWindow, UNAME='VBox' ,XOFFSET=51  $
      ,YOFFSET=315 ,SCR_XSIZE=59 ,SCR_YSIZE=23 ,XSIZE=20 ,YSIZE=1)

  
  AddButton = Widget_Button(BaseWindow, UNAME='AddButton'  $
      ,XOFFSET=149 ,YOFFSET=153 ,SCR_XSIZE=79 ,SCR_YSIZE=24  $
      ,/ALIGN_CENTER ,VALUE='Add Peak')

  
  DeleteButon = Widget_Button(BaseWindow, UNAME='DeleteButon'  $
      ,XOFFSET=147 ,YOFFSET=209 ,SCR_XSIZE=82 ,SCR_YSIZE=24  $
      ,/ALIGN_CENTER ,VALUE='DeletePeak')

  
  WID_LABEL_14 = Widget_Label(BaseWindow, UNAME='WID_LABEL_14'  $
      ,XOFFSET=17 ,YOFFSET=54 ,SCR_XSIZE=50 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='Comment')

  
  CommentBox = Widget_Text(BaseWindow, UNAME='CommentBox' ,XOFFSET=81  $
      ,YOFFSET=47 ,SCR_XSIZE=512 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  FileMenu = Widget_Button(WID_BASE_0_MBAR, UNAME='FileMenu' ,/MENU  $
      ,VALUE='File')

  
  W_MENU_0 = Widget_Button(FileMenu, UNAME='W_MENU_0' ,VALUE='About')
  
  FileNew = Widget_Button(FileMenu, UNAME='FileNew' ,VALUE='New')
  
  FileOpen = Widget_Button(FileMenu, UNAME='FileOpen' ,VALUE='Open')
  
  FileSave = Widget_Button(FileMenu, UNAME='FileSave' ,/CHECKED_MENU  $
      ,VALUE='Save')

  
  FileSaveAs = Widget_Button(FileMenu, UNAME='FileSaveAs'  $
      ,VALUE='Save As')

  
  FileImport = Widget_Button(FileMenu, UNAME='FileImport' ,/MENU  $
      ,/SEPARATOR ,VALUE='Import')

  
  FileImportText = Widget_Button(FileImport, UNAME='FileImportText'  $
      ,VALUE='Import XPOW Text File')

  
  FileImportJade = Widget_Button(FileImport, UNAME='FileImportJade'  $
      ,VALUE='Import from Jade')

  
  FileClose = Widget_Button(FileMenu, UNAME='FileClose' ,/SEPARATOR  $
      ,VALUE='Close')

  
  BrowseButton = Widget_Button(BaseWindow, UNAME='BrowseButton'  $
      ,XOFFSET=519 ,YOFFSET=20 ,SCR_XSIZE=74 ,SCR_YSIZE=22  $
      ,/ALIGN_CENTER ,VALUE='Browse')

  
  K0DTBox = Widget_Text(BaseWindow, UNAME='K0DTBox' ,XOFFSET=155  $
      ,YOFFSET=96 ,SCR_XSIZE=79 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  WID_LABEL_15 = Widget_Label(BaseWindow, UNAME='WID_LABEL_15'  $
      ,XOFFSET=115 ,YOFFSET=101 ,SCR_XSIZE=33 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='K0DT')

  
  WID_LABEL_16 = Widget_Label(BaseWindow, UNAME='WID_LABEL_16'  $
      ,XOFFSET=115 ,YOFFSET=126 ,SCR_XSIZE=32 ,SCR_YSIZE=18  $
      ,/ALIGN_LEFT ,VALUE='KPDT')

  
  KPDTBox = Widget_Text(BaseWindow, UNAME='KPDTBox' ,XOFFSET=155  $
      ,YOFFSET=123 ,SCR_XSIZE=79 ,SCR_YSIZE=23 ,/EDITABLE ,XSIZE=20  $
      ,YSIZE=1)

  
  VoButton = Widget_Button(BaseWindow, UNAME='VoButton' ,XOFFSET=120  $
      ,YOFFSET=315 ,SCR_XSIZE=102 ,SCR_YSIZE=23 ,/ALIGN_CENTER  $
      ,VALUE='Calculate V')

  
  HKLTable = Widget_Table(BaseWindow, UNAME='HKLTable' ,XOFFSET=242  $
      ,YOFFSET=76 ,SCR_XSIZE=362 ,SCR_YSIZE=289  $
      ,NOTIFY_REALIZE='OnRealizeTable' ,EVENT_FUNC='OnHandleTable'  $
      ,/EDITABLE ,/RESIZEABLE_COLUMNS ,COLUMN_LABELS=[ 'H', 'K', 'L',  $
      'D-Spc', 'I' ] ,XSIZE=5 ,YSIZE=100)

  
  SymmetryDroplist = Widget_Droplist(BaseWindow,  $
      UNAME='SymmetryDroplist' ,XOFFSET=115 ,YOFFSET=257  $
      ,SCR_XSIZE=105 ,SCR_YSIZE=25 ,VALUE=[ 'CUBIC', 'HEXAGONAL',  $
      'RHOBOHEDRAL', 'TETRAGONAL', 'MONOCLINIC', 'TRICLINIC' ])

  Widget_Control, /REALIZE, BaseWindow

  XManager, 'BaseWindow', BaseWindow, /NO_BLOCK  

end
; 
; Empty stub procedure used for autoloading.
; 
pro jcpds_app, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_
  BaseWindow, GROUP_LEADER=wGroup, _EXTRA=_VWBExtra_
end
