inherited RefCountriesForm: TRefCountriesForm
  Left = 693
  Top = 290
  Caption = 'RefCountriesForm'
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage [0]
    Left = 280
    Top = 200
    Width = 105
    Height = 105
  end
  inherited TlBr: TsToolBar
    Height = 30
    ButtonHeight = 30
    ExplicitHeight = 30
    inherited btnInsert: TToolButton
      ExplicitHeight = 30
    end
    inherited btnEdit: TToolButton
      ExplicitHeight = 30
    end
    inherited btnDelete: TToolButton
      ExplicitHeight = 30
    end
    inherited btn4: TToolButton
      ExplicitHeight = 30
    end
    inherited btnPost: TToolButton
      ExplicitHeight = 30
    end
    inherited btnCancel: TToolButton
      ExplicitHeight = 30
    end
    inherited btn7: TToolButton
      ExplicitHeight = 30
    end
    inherited btnRefresh: TToolButton
      ExplicitHeight = 30
    end
    inherited btnFind: TToolButton
      ExplicitHeight = 30
    end
    inherited btnFiltr: TToolButton
      ExplicitHeight = 30
    end
    inherited btnExcel: TToolButton
      ExplicitHeight = 30
    end
    inherited btn1: TToolButton
      ExplicitHeight = 30
    end
    inherited btnFirst: TToolButton
      ExplicitHeight = 30
    end
    inherited btnMovePrev: TToolButton
      ExplicitHeight = 30
    end
    inherited btnPrev: TToolButton
      ExplicitHeight = 30
    end
    inherited btnNext: TToolButton
      ExplicitHeight = 30
    end
    inherited btnMoveNext: TToolButton
      ExplicitHeight = 30
    end
    inherited btnLast: TToolButton
      ExplicitHeight = 30
    end
  end
  inherited CRGrid: TCRDBGrid
    Top = 30
    Height = 332
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_COUNTRY_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_COUNTRY_ID;'
      'end;')
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_COUNTRY_ID'
  end
end
