unit unit_frm_teamManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, inifiles,unit_functions,
  Vcl.ComCtrls,unit_frm_main, Vcl.Grids, Vcl.DBGrids, Data.DB, Bde.DBTables,DateUtils;

type
  Tfrm_teamManager = class(TForm)
    Button2: TButton;
    ListView1: TListView;
    list_contests: TListView;
    Button3: TButton;
    Button4: TButton;
    PageControl1: TPageControl;
    page_contestName: TTabSheet;
    Label1: TLabel;
    edit_contestName: TEdit;
    page_team: TTabSheet;
    edit_teamName: TEdit;
    edit_username: TEdit;
    edit_password: TEdit;
    btn_add: TButton;
    CheckBox_username: TCheckBox;
    CheckBox_pass: TCheckBox;
    CheckBox_teamName: TCheckBox;
    edit_passChar: TEdit;
    UpDown1: TUpDown;
    edit_passCount: TEdit;
    edit_teamNameMask: TEdit;
    page_time: TTabSheet;
    timeStart: TDateTimePicker;
    dateStart: TDateTimePicker;
    Label2: TLabel;
    timeFinish: TDateTimePicker;
    Button1: TButton;
    Label3: TLabel;
    procedure btn_addClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure list_contestsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure CheckBox_teamNameClick(Sender: TObject);
    procedure CheckBox_usernameClick(Sender: TObject);
    procedure CheckBox_passClick(Sender: TObject);
    procedure edit_passCountChange(Sender: TObject);
    procedure timeFinishChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    Descending: Boolean;
    SortedColumn: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frm_teamManager: Tfrm_teamManager;


implementation

{$R *.dfm}



procedure Tfrm_teamManager.btn_addClick(Sender: TObject);
var
  ini : tinifile;
  dir, teamName,teamUser,teamPass : string;
  teamNo : integer;
  I: Integer;
  bood : integer;
begin
  dir := extractfilepath(application.ExeName) + '\Contests\' + edit_contestName.Text + '\Teams\' + edit_username.Text;
  if CheckBox_teamName.Checked then
  begin
    teamNo := 0;
    repeat
      inc(teamNo);
      dir := extractfilepath(application.ExeName) + '\Contests\' + edit_contestName.Text + '\Teams\Team ' + inttostr(teamNo);
    until FileExists(dir + '\team.info.ini') = false;
    teamName := trim(edit_teamNameMask.Text) + ' ' + inttostr(teamNo);  //BECCA - add an edit for t
    edit_teamName.Text := teamName;
  end
  else teamName := trim(edit_teamName.Text);

  if CheckBox_pass.Checked then
  begin
    teamPass := randomPassword(strtoint(edit_passCount.Text),edit_passChar.Text);
    edit_password.Text := teamPass;
  end
  else teamPass := edit_password.Text;

  if CheckBox_username.Checked then
  begin
    teamUser := generateTeamName(teamName);
    edit_username.Text := teamUser;
  end
  else teamUser := trim(edit_username.Text);

  if not ForceDirectories(dir) then ShowMessage('New directory add failed with error : '+ IntToStr(GetLastError));
  ini := tinifile.Create(dir + '\team.info.ini');
  try
    ini.WriteString('Team Info' ,'name',teamName);
    ini.WriteString('Team Info','user',teamUser);
    ini.WriteString('Team Info','pass',teamPass);
  finally
    ini.Free;
  end;
end;

procedure Tfrm_teamManager.Button1Click(Sender: TObject);
begin
  startDateTime  := now;
  finishDateTime := now + timestart.Time;
  contestStarted := true;
  contestName    := edit_contestName.Text;
end;

procedure Tfrm_teamManager.Button3Click(Sender: TObject);
var
  dir : string;
  contests : TStringList;
  I: Integer;
  st: tstrings;
begin
  st := tstringlist.Create;
  list_contests.Items.Clear;
  contests := TStringList.Create;
  try
    dir :=  extractfilepath(application.ExeName) + '\Contests';
    GetSubDirectories(dir,contests);
    for I := 0 to contests.Count-1 do list_contests.Items.Add.Caption := ExtractFileName(ExcludeTrailingPathDelimiter(contests.Strings[I]));
  finally
    contests.Free;
  end;

end;

procedure Tfrm_teamManager.CheckBox_passClick(Sender: TObject);
begin
  if CheckBox_pass.Checked then
  begin
    edit_password.Enabled := false;
    edit_passCount.Visible := true;
    updown1.Visible := true;
    edit_passChar.Visible := true;
  end
  else
  begin
    edit_password.Enabled := true;
    edit_passCount.Visible := false;
    updown1.Visible := false;
    edit_passChar.Visible := false;
  end;
end;

procedure Tfrm_teamManager.CheckBox_teamNameClick(Sender: TObject);
begin
  if CheckBox_teamName.Checked then
  begin
    edit_teamName.Enabled := false;
    edit_username.Enabled := false;
    edit_password.Enabled := false;
    edit_teamNameMask.Visible := true;
    with CheckBox_username do
    begin
      Checked := true;
      Enabled := false;
    end;
    with CheckBox_pass do
    begin
      Checked := true;
      Enabled := false;
    end;
  end
  else
  begin
    CheckBox_username.Enabled := true;
    CheckBox_pass.Enabled := true;
    edit_teamName.Enabled := true;
    edit_teamNameMask.Visible := false;
  end;
end;

procedure Tfrm_teamManager.CheckBox_usernameClick(Sender: TObject);
begin
  if CheckBox_username.Checked then
    edit_username.Enabled := false
  else
    edit_username.Enabled := true;
end;

procedure Tfrm_teamManager.timeFinishChange(Sender: TObject);
begin
  if timeFinish.Time < timeStart.Time then timeFinish.Time := timeStart.Time;

  startDateTime  := Int(dateStart.Date) + Frac(timeStart.Time);
  finishDateTime := Int(dateStart.Date) + Frac(timeFinish.Time);
  label3.Caption := FormatDateTime('HH: MM : SS' , finishDateTime - startDateTime);
end;

procedure Tfrm_teamManager.edit_passCountChange(Sender: TObject);
begin
  try
    if strtoint(edit_passCount.Text) > 25  then edit_passCount.Text := '25';
  except
  end;
end;

procedure Tfrm_teamManager.FormCreate(Sender: TObject);
begin
 { timeStart.Time := RoundDateTimeToNearestInterval(now);
  timeFinish.Time:= RoundDateTimeToNearestInterval(IncHour(now,5));
  dateStart.MinDate := now;
  dateStart.MaxDate := IncMonth(now,5);}
end;

procedure Tfrm_teamManager.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
TListView(Sender).SortType := stNone;
if Column.Index<>SortedColumn then
begin
SortedColumn := Column.Index;
Descending := False;
end
else
Descending := not Descending;
TListView(Sender).SortType := stText;
end;

procedure Tfrm_teamManager.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
  if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  if Descending then Compare := -Compare;
end;

procedure Tfrm_teamManager.list_contestsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  dir : string;
  users : TStringList;
  ini : tinifile;
  I: Integer;
  u,p : string;
begin
  listView1.Items.Clear;
  usersList.Clear;
  users.Free;
  ini.Free;
  listview1.Items.BeginUpdate;
  usersList.BeginUpdate;

  users := TStringList.Create;

  try
    dir := extractfilepath(application.ExeName) + '\Contests\' + item.Caption + '\Teams\';
    GetSubDirectories(dir,users);
    for I := 0 to users.Count-1 do
    begin
      if FileExists(users.Strings[I] + '\team.info.ini') then
      begin
        ini := tinifile.Create(users.Strings[I] + '\team.info.ini');
        try
          with listView1.Items.Add do
            begin
              u := ini.ReadString('Team Info','user','UNKNOWN');
              p := ini.ReadString('Team Info','pass','UNKNOWN');
              Caption := ini.ReadString('Team Info','name','UNKNOWN');
              SubItems.Add(u);
              SubItems.Add(p);
              userslist.Add(u+ '=' +p);
            end;
        finally
          ini.Free;
        end;
      end;
    end;
  finally
    users.Free;
  end;
  listview1.Items.EndUpdate;
  usersList.EndUpdate;

end;

end.
