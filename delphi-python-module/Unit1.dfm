object Form1: TForm1
  Left = 265
  Top = 136
  Width = 707
  Height = 685
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    699
    658)
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 496
    Width = 697
    Height = 27
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 
      'tell Wylalenvirul Wylalenvirul, you are nothing, you will do not' +
      'hing, nothing you want will you have, but mostly you just like t' +
      'alking to yourself.'
    OnKeyPress = Edit1KeyPress
  end
  object IpTerminal1: TIpTerminal
    Left = 0
    Top = 0
    Width = 699
    Height = 497
    CaptureFile = 'IPROTERM.CAP'
    Columns = 255
    CursorType = ctNone
    Rows = 40
    Scrollback = False
    UseLazyDisplay = False
    Align = alTop
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = 'Terminal'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    Emulator = IpVT100Emulator1
  end
  object IpTerminal2: TIpTerminal
    Left = 0
    Top = 520
    Width = 697
    Height = 137
    CaptureFile = 'IPROTERM.CAP'
    CursorType = ctNone
    Rows = 10
    Scrollback = False
    UseLazyDisplay = False
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = 'Terminal'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    Emulator = IpVT100Emulator2
  end
  object IpVT100Emulator1: TIpVT100Emulator
    Terminal = IpTerminal1
    TelnetTermType = 'vt100'
    Answerback = 'iPROterm'
    DisplayUpperASCII = False
    Left = 640
    Top = 8
  end
  object IpVT100Emulator2: TIpVT100Emulator
    Terminal = IpTerminal2
    TelnetTermType = 'vt100'
    Answerback = 'iPROterm'
    DisplayUpperASCII = False
    Left = 640
    Top = 536
  end
end
