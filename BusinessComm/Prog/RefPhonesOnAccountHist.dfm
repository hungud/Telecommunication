inherited RefPhonesOnAccountHistForm: TRefPhonesOnAccountHistForm
  Caption = 'RefPhonesOnAccountHistForm'
  ClientHeight = 558
  ClientWidth = 987
  Position = poMainFormCenter
  ExplicitWidth = 1003
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBr: TsToolBar
    Width = 987
    ExplicitWidth = 987
  end
  inherited CRGrid: TCRDBGrid
    Width = 987
    Height = 495
    DataSource = Dm.dsqPhonForAccHist
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_CITY'
        Title.Alignment = taCenter
        Width = 125
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_IS_ACTIVE_STR'
        Title.Alignment = taCenter
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACCOUNT_NUMBER'
        Title.Alignment = taCenter
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATE'
        Title.Alignment = taCenter
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILIAL_NAME'
        Title.Alignment = taCenter
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_FIO'
        Title.Alignment = taCenter
        Width = 146
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED'
        Title.Alignment = taCenter
        Width = 118
        Visible = True
      end>
  end
  inherited sPanel1: TsPanel
    Top = 524
    Width = 987
    ExplicitTop = 524
    ExplicitWidth = 987
    inherited sBsave: TsBitBtn
      Left = 696
      ExplicitLeft = 696
    end
    inherited sBClose: TsBitBtn
      Left = 835
      ExplicitLeft = 835
    end
  end
end
