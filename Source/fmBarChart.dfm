object frmBarChart: TfrmBarChart
  Left = 0
  Top = 0
  Caption = 'Bar Chart'
  ClientHeight = 459
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 524
    Height = 410
    Legend.TextStyle = ltsRightValue
    Title.Font.Color = 4227072
    Title.Font.Height = -24
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -5
    ExplicitTop = 34
    ExplicitWidth = 418
    ExplicitHeight = 250
    object Series1: TBarSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Style = smsValue
      Marks.Visible = True
      Gradient.Direction = gdTopBottom
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 416
    Width = 530
    Height = 43
    Align = alBottom
    BevelEdges = [beTop]
    BevelInner = bvRaised
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 1
    object btnClose: TButton
      Left = 440
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
end
