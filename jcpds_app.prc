HEADER
; IDL Visual Widget Builder Resource file. Version 1
; Generated on:	04/07/2014 15:56.23
VERSION 1
END

BaseWindow BASE 5 5 620 418
REALIZE "RealizeBase"
TLB
CAPTION "JCPDS File Editor"
XPAD = 3
YPAD = 3
SPACE = 3
BEGIN
  BrowseBox TEXT 81 21 432 23
  WIDTH = 20
  HEIGHT = 1
  END
  WID_LABEL_0 LABEL 16 26 59 18
  VALUE "JCPDS File"
  ALIGNLEFT
  END
  WID_LABEL_1 LABEL 9 101 18 18
  VALUE "K0"
  ALIGNLEFT
  END
  WID_LABEL_2 LABEL 9 126 26 18
  VALUE "KP"
  ALIGNLEFT
  END
  K0Box TEXT 37 96 73 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  KPBox TEXT 37 123 73 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  WID_LABEL_3 LABEL 115 237 82 18
  VALUE "Symmetry"
  ALIGNLEFT
  END
  WID_LABEL_4 LABEL 13 164 18 18
  VALUE "a"
  ALIGNLEFT
  END
  WID_LABEL_5 LABEL 13 188 18 18
  VALUE "b"
  ALIGNLEFT
  END
  aBox TEXT 37 159 73 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  WID_LABEL_6 LABEL 13 213 18 18
  VALUE "c"
  ALIGNLEFT
  END
  WID_LABEL_7 LABEL 9 243 27 18
  VALUE "alpha"
  ALIGNLEFT
  END
  WID_LABEL_8 LABEL 9 270 24 18
  VALUE "beta"
  ALIGNLEFT
  END
  WID_LABEL_9 LABEL 9 292 34 18
  VALUE "gamma"
  ALIGNLEFT
  END
  WID_LABEL_10 LABEL 9 317 18 18
  VALUE "V"
  ALIGNLEFT
  END
  bBox TEXT 37 185 73 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  cBox TEXT 37 212 73 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  alphaBox TEXT 51 240 59 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  betaBox TEXT 51 266 59 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  gammaBox TEXT 51 291 59 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  VBox TEXT 51 315 59 23
  WIDTH = 20
  HEIGHT = 1
  END
  AddButton PUSHBUTTON 149 153 79 24
  VALUE "Add Peak"
  ALIGNCENTER
  ONACTIVATE "OnPressAdd"
  END
  DeleteButon PUSHBUTTON 147 209 82 24
  VALUE "DeletePeak"
  ALIGNCENTER
  ONACTIVATE "OnPressDelete"
  END
  WID_LABEL_14 LABEL 17 54 50 18
  VALUE "Comment"
  ALIGNLEFT
  END
  CommentBox TEXT 81 47 512 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  WID_BASE_0_MBAR MENUBAR 0 0 0 0
  BEGIN
    FileMenu PUSHBUTTON 0 0 0 0
    VALUE "File"
    MENU
    BEGIN
      W_MENU_0 PUSHBUTTON 0 0 0 0
      VALUE "About"
      ONACTIVATE "OnPressAbout"
      END
      FileNew PUSHBUTTON 0 0 0 0
      VALUE "New"
      ONACTIVATE "OnPressNew"
      END
      FileOpen PUSHBUTTON 0 0 0 0
      VALUE "Open"
      ONACTIVATE "OnPressOpen"
      END
      FileSave PUSHBUTTON 0 0 0 0
      VALUE "Save"
      CHECKED_MENU
      ONACTIVATE "OnPressSave"
      END
      FileSaveAs PUSHBUTTON 0 0 0 0
      VALUE "Save As"
      ONACTIVATE "OnPressSaveAs"
      END
      FileImport PUSHBUTTON 0 0 0 0
      VALUE "Import"
      MENU
      SEPARATOR
      BEGIN
        FileImportText PUSHBUTTON 0 0 0 0
        VALUE "Import XPOW Text File"
        ONACTIVATE "ImportText"
        END
        FileImportJade PUSHBUTTON 0 0 0 0
        VALUE "Import from Jade"
        ONACTIVATE "ImportJade"
        END
      END
      FileClose PUSHBUTTON 0 0 0 0
      VALUE "Close"
      SEPARATOR
      ONACTIVATE "OnPressClose"
      END
    END
  END
  BrowseButton PUSHBUTTON 519 20 74 22
  VALUE "Browse"
  ALIGNCENTER
  ONACTIVATE "OnPressOpen"
  END
  K0DTBox TEXT 155 96 79 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  WID_LABEL_15 LABEL 115 101 33 18
  VALUE "K0DT"
  ALIGNLEFT
  END
  WID_LABEL_16 LABEL 115 126 32 18
  VALUE "KPDT"
  ALIGNLEFT
  END
  KPDTBox TEXT 155 123 79 23
  EDITABLE
  WIDTH = 20
  HEIGHT = 1
  END
  VoButton PUSHBUTTON 120 315 102 23
  VALUE "Calculate V"
  ALIGNCENTER
  ONACTIVATE "OnPressCalcV"
  END
  HKLTable TABLE 242 76 362 289
  REALIZE "OnRealizeTable"
  ONHANDLEEVENT "OnHandleTable"
  RESIZECOLUMNS
  N_ROWS = 100
  N_COLS = 5
  NUMCOLLABELS = 5
  COLLABEL "H"
  COLLABEL "K"
  COLLABEL "L"
  COLLABEL "D-Spc"
  COLLABEL "I"
  EDITABLE
  ONINSERTCHAR "OnInsertTable"
  ONINSERTSTRING "OnInsertTable"
  ONDELETE "OnDeleteTable"
  ONSELECT "OnSelectTable"
  ONCELLSELECT "OnCellSelectTable"
  END
  SymmetryDroplist DROPLIST 115 257 105 25
  NUMITEMS = 6
  ITEM "CUBIC"
  ITEM "HEXAGONAL"
  ITEM "RHOBOHEDRAL"
  ITEM "TETRAGONAL"
  ITEM "MONOCLINIC"
  ITEM "TRICLINIC"
  ONSELECT "OnChooseSymmetry"
  END
END
