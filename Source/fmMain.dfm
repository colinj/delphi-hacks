object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 515
  ClientWidth = 1045
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 232
    Top = 35
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 232
    Top = 70
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 232
    Top = 107
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label4: TLabel
    Left = 256
    Top = 168
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Edit1: TEdit
    Left = 40
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 40
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 40
    Top = 104
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '12'
    OnChange = Edit3Change
  end
  object Button1: TButton
    Left = 64
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 376
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit4'
    OnChange = Edit1Change
  end
  object Edit5: TEdit
    Left = 40
    Top = 325
    Width = 153
    Height = 21
    TabOrder = 5
  end
  object Edit6: TEdit
    Left = 40
    Top = 352
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 6
  end
  object Edit7: TEdit
    Left = 40
    Top = 379
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 7
  end
  object Edit8: TEdit
    Left = 40
    Top = 406
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 8
  end
  object Button2: TButton
    Left = 40
    Top = 460
    Width = 75
    Height = 25
    Caption = '<'
    TabOrder = 9
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 137
    Top = 460
    Width = 75
    Height = 25
    Caption = '>'
    TabOrder = 10
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 232
    Top = 404
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 11
    OnClick = Button4Click
  end
  object StringGrid1: TStringGrid
    Left = 528
    Top = 32
    Width = 385
    Height = 169
    ColCount = 4
    DefaultColWidth = 88
    DrawingStyle = gdsGradient
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 12
  end
  object Button5: TButton
    Left = 912
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 13
    OnClick = Button5Click
  end
end
