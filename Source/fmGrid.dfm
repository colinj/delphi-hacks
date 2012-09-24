object frmGrid: TfrmGrid
  Left = 0
  Top = 0
  Caption = 'Grid Example'
  ClientHeight = 260
  ClientWidth = 281
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFooter: TPanel
    Left = 0
    Top = 217
    Width = 281
    Height = 43
    Align = alBottom
    BevelEdges = [beTop]
    BevelInner = bvRaised
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 298
    ExplicitWidth = 353
    DesignSize = (
      281
      41)
    object btnClose: TButton
      Left = 198
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 270
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 281
    Height = 217
    Align = alClient
    DefaultColWidth = 50
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    GradientEndColor = 12615680
    GradientStartColor = 16766333
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 1
    OnDblClick = StringGrid1DblClick
    OnEnter = StringGrid1Enter
    OnExit = StringGrid1Exit
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ExplicitWidth = 353
    ExplicitHeight = 298
  end
end
