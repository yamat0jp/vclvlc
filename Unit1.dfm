object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 686
  ClientWidth = 965
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PasLibVlcPlayer1: TPasLibVlcPlayer
    Left = 0
    Top = 0
    Width = 780
    Height = 645
    Align = alClient
    SnapShotFmt = 'png'
    OnMediaPlayerTimeChanged = PasLibVlcPlayer1MediaPlayerTimeChanged
    OnMediaPlayerPositionChanged = PasLibVlcPlayer1MediaPlayerPositionChanged
    OnMediaPlayerLengthChanged = PasLibVlcPlayer1MediaPlayerLengthChanged
    MouseEventsHandler = mehComponent
  end
  object Panel1: TPanel
    Left = 780
    Top = 0
    Width = 185
    Height = 645
    Align = alRight
    TabOrder = 1
    object Button1: TButton
      Left = 56
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 645
    Width = 965
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 930
      Top = 1
      Width = 34
      Height = 39
      Align = alRight
      Caption = 'Label1'
      ExplicitHeight = 15
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 34
      Height = 39
      Align = alLeft
      Caption = 'Label2'
      ExplicitHeight = 15
    end
    object TrackBar1: TTrackBar
      Left = 35
      Top = 1
      Width = 895
      Height = 39
      Align = alClient
      Max = 100
      TabOrder = 0
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Play
            Caption = '&Play'
          end
          item
            Action = Speed2x
            Caption = '&Speed2x'
          end>
      end>
    Left = 400
    Top = 96
    StyleName = 'Platform Default'
    object Speed2x: TAction
      Caption = 'Speed2x'
      OnExecute = Speed2xExecute
    end
    object Play: TAction
      Caption = 'Play'
      OnExecute = PlayExecute
    end
  end
  object PasLibVlcMediaList1: TPasLibVlcMediaList
    Player = PasLibVlcPlayer1
    Left = 232
    Top = 120
  end
  object OpenDialog1: TOpenDialog
    Left = 420
    Top = 208
  end
  object MainMenu1: TMainMenu
    Left = 288
    Top = 56
    object Files1: TMenuItem
      Caption = 'Files'
      object Play1: TMenuItem
        Action = Play
      end
      object Speed2x1: TMenuItem
        Action = Speed2x
      end
    end
  end
  object DropFileTarget1: TDropFileTarget
    DragTypes = [dtCopy, dtLink]
    Target = PasLibVlcPlayer1
    OptimizedMove = True
    Left = 624
    Top = 168
  end
end
