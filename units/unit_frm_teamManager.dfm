object frm_teamManager: Tfrm_teamManager
  Left = 0
  Top = 0
  Caption = 'Team Manager'
  ClientHeight = 460
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 119
    Top = 427
    Width = 137
    Height = 41
    Caption = 'Button2'
    TabOrder = 0
  end
  object ListView1: TListView
    Left = 255
    Top = 240
    Width = 321
    Height = 201
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
        MinWidth = 100
      end
      item
        AutoSize = True
        Caption = 'Username'
      end
      item
        AutoSize = True
        Caption = 'Password'
      end>
    FlatScrollBars = True
    FullDrag = True
    GridLines = True
    IconOptions.AutoArrange = True
    IconOptions.WrapText = False
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = ListView1ColumnClick
    OnCompare = ListView1Compare
  end
  object list_contests: TListView
    Left = 8
    Top = 240
    Width = 161
    Height = 121
    Columns = <
      item
        Caption = 'Name'
      end>
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = list_contestsSelectItem
  end
  object Button3: TButton
    Left = 8
    Top = 431
    Width = 105
    Height = 33
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 200
    Top = 240
    Width = 73
    Height = 33
    Caption = 'Button4'
    TabOrder = 4
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 568
    Height = 226
    ActivePage = page_contestName
    TabOrder = 5
    object page_contestName: TTabSheet
      Caption = 'Contest'
      object Label1: TLabel
        Left = 40
        Top = 40
        Width = 98
        Height = 13
        Caption = 'Enter contest name:'
      end
      object edit_contestName: TEdit
        Left = 96
        Top = 59
        Width = 153
        Height = 21
        TabOrder = 0
        Text = '1st'
      end
    end
    object page_team: TTabSheet
      Caption = 'Teams'
      ImageIndex = 1
      object edit_teamName: TEdit
        Left = 107
        Top = 27
        Width = 146
        Height = 21
        MaxLength = 25
        TabOrder = 0
        Text = 'edit_teamName'
      end
      object edit_username: TEdit
        Left = 107
        Top = 54
        Width = 146
        Height = 21
        MaxLength = 10
        TabOrder = 1
        Text = 'edit_username'
      end
      object edit_password: TEdit
        Left = 107
        Top = 81
        Width = 146
        Height = 21
        MaxLength = 20
        TabOrder = 2
        Text = 'edit_password'
      end
      object btn_add: TButton
        Left = 436
        Top = 148
        Width = 113
        Height = 33
        Caption = 'Add'
        Default = True
        TabOrder = 3
        OnClick = btn_addClick
      end
      object CheckBox_username: TCheckBox
        Left = 259
        Top = 56
        Width = 62
        Height = 17
        Caption = 'Auto fill'
        TabOrder = 4
        OnClick = CheckBox_usernameClick
      end
      object CheckBox_pass: TCheckBox
        Left = 259
        Top = 83
        Width = 62
        Height = 17
        Caption = 'Auto fill'
        TabOrder = 5
        OnClick = CheckBox_passClick
      end
      object CheckBox_teamName: TCheckBox
        Left = 259
        Top = 29
        Width = 62
        Height = 17
        Caption = 'Auto fill'
        TabOrder = 6
        OnClick = CheckBox_teamNameClick
      end
      object edit_passChar: TEdit
        Left = 383
        Top = 81
        Width = 113
        Height = 21
        MaxLength = 50
        TabOrder = 7
        Text = '0123456789becca'
        Visible = False
      end
      object UpDown1: TUpDown
        Left = 361
        Top = 81
        Width = 16
        Height = 21
        Associate = edit_passCount
        Min = 4
        Max = 25
        Position = 8
        TabOrder = 8
        TabStop = True
        Visible = False
      end
      object edit_passCount: TEdit
        Left = 327
        Top = 81
        Width = 34
        Height = 21
        Alignment = taCenter
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 9
        Text = '8'
        Visible = False
        OnChange = edit_passCountChange
      end
      object edit_teamNameMask: TEdit
        Left = 327
        Top = 27
        Width = 74
        Height = 21
        MaxLength = 25
        TabOrder = 10
        Text = 'Team'
        Visible = False
      end
    end
    object page_time: TTabSheet
      Caption = 'Time'
      ImageIndex = 2
      object Label2: TLabel
        Left = 221
        Top = 46
        Width = 20
        Height = 13
        Caption = 'until'
        Visible = False
      end
      object Label3: TLabel
        Left = 275
        Top = 78
        Width = 44
        Height = 13
        Caption = '05:00:00'
      end
      object timeStart: TDateTimePicker
        Left = 117
        Top = 40
        Width = 98
        Height = 25
        Date = 0.208333333333333300
        Time = 0.208333333333333300
        DateFormat = dfLong
        Kind = dtkTime
        TabOrder = 0
      end
      object dateStart: TDateTimePicker
        Left = 72
        Top = 71
        Width = 141
        Height = 25
        Date = 41730.522858796300000000
        Time = 41730.522858796300000000
        DateFormat = dfLong
        TabOrder = 1
        Visible = False
      end
      object timeFinish: TDateTimePicker
        Left = 247
        Top = 40
        Width = 98
        Height = 25
        Date = 0.522858796299260600
        Time = 0.522858796299260600
        DateFormat = dfLong
        Kind = dtkTime
        TabOrder = 2
        Visible = False
        OnChange = timeFinishChange
      end
      object Button1: TButton
        Left = 456
        Top = 144
        Width = 89
        Height = 41
        Caption = 'btn_start'
        Default = True
        TabOrder = 3
        OnClick = Button1Click
      end
    end
  end
end
