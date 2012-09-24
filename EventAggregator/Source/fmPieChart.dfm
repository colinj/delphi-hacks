object frmPieChart: TfrmPieChart
  Left = 0
  Top = 0
  Caption = 'Pie Chart'
  ClientHeight = 296
  ClientWidth = 300
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
    Width = 294
    Height = 247
    Legend.TextStyle = ltsRightValue
    Title.Font.Color = 4227072
    Title.Font.Height = -24
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TChart')
    Shadow.Visible = False
    View3D = False
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 524
    ExplicitHeight = 410
    object Series1: TPieSeries
      Marks.Arrow.Color = clBlack
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Style = psCircle
      Marks.Callout.Arrow.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 20
      Marks.BackColor = clWhite
      Marks.Color = clWhite
      Marks.Shadow.Color = 8487297
      Marks.Shadow.Visible = False
      Marks.Style = smsValue
      Marks.Transparency = 20
      Marks.Visible = True
      Shadow.Visible = False
      Gradient.Direction = gdRadial
      OtherSlice.Legend.Visible = False
      PieValues.Name = 'Pie'
      PieValues.Order = loNone
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 253
    Width = 300
    Height = 43
    Align = alBottom
    BevelEdges = [beTop]
    BevelInner = bvRaised
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 416
    ExplicitWidth = 530
    DesignSize = (
      300
      41)
    object btnClose: TButton
      Left = 210
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 440
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Track'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
  end
end
