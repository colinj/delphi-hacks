object frmPerson: TfrmPerson
  Left = 0
  Top = 0
  Caption = 'frmPerson'
  ClientHeight = 259
  ClientWidth = 527
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
    Left = 200
    Top = 27
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 200
    Top = 62
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 200
    Top = 99
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label4: TLabel
    Left = 200
    Top = 152
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 8
    Top = 59
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 8
    Top = 96
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '12'
    OnChange = Edit3Change
  end
  object Button1: TButton
    Left = 32
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 344
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit4'
    OnChange = Edit1Change
  end
end
