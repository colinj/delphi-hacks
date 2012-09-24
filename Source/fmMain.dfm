object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 327
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Edit5: TEdit
    Left = 40
    Top = 29
    Width = 153
    Height = 21
    TabOrder = 0
    OnExit = Edit5Exit
  end
  object Edit6: TEdit
    Left = 40
    Top = 56
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnExit = Edit5Exit
  end
  object Edit7: TEdit
    Left = 40
    Top = 83
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    OnExit = Edit5Exit
  end
  object Edit8: TEdit
    Left = 40
    Top = 110
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    OnExit = Edit5Exit
  end
  object btnPrev: TButton
    Left = 36
    Top = 172
    Width = 75
    Height = 25
    Caption = '<'
    TabOrder = 4
    OnClick = btnPrevClick
  end
  object btnNext: TButton
    Left = 133
    Top = 172
    Width = 75
    Height = 25
    Caption = '>'
    TabOrder = 5
    OnClick = btnNextClick
  end
  object btnBarChart: TButton
    Left = 140
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Bar Chart'
    TabOrder = 6
    OnClick = btnBarChartClick
  end
  object btnGrid: TButton
    Left = 36
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Grid'
    TabOrder = 7
    OnClick = btnGridClick
  end
  object btnPieChart: TButton
    Left = 94
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Pie Chart'
    TabOrder = 8
    OnClick = btnPieChartClick
  end
end
