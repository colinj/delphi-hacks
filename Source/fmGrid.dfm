object frmGrid: TfrmGrid
  Left = 0
  Top = 0
  Caption = 'Grid Example'
  ClientHeight = 341
  ClientWidth = 353
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
    Top = 298
    Width = 353
    Height = 43
    Align = alBottom
    BevelEdges = [beTop]
    BevelInner = bvRaised
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 530
    DesignSize = (
      353
      41)
    object btnClose: TButton
      Left = 270
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 560
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 353
    Height = 298
    Align = alClient
    DefaultColWidth = 50
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    GradientEndColor = 16744448
    GradientStartColor = 16770250
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 1
  end
end
