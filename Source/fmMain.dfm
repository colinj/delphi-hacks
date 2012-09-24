object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 327
  ClientWidth = 584
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
  object Edit5: TEdit
    Left = 16
    Top = 29
    Width = 153
    Height = 21
    TabOrder = 0
  end
  object Edit6: TEdit
    Left = 16
    Top = 56
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object Edit7: TEdit
    Left = 16
    Top = 83
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
  end
  object Edit8: TEdit
    Left = 16
    Top = 110
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 16
    Top = 164
    Width = 75
    Height = 25
    Caption = '<'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 113
    Top = 164
    Width = 75
    Height = 25
    Caption = '>'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 188
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 208
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Bar Chart'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 208
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Grid'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Memo1: TMemo
    Left = 320
    Top = 29
    Width = 241
    Height = 233
    Lines.Strings = (
      'Memo1')
    TabOrder = 9
  end
  object Button1: TButton
    Left = 113
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 10
  end
end
