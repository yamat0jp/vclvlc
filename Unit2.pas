unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.Objects, FmxPasLibVlcPlayerUnit, System.Actions, FMX.ActnList, FMX.Menus,
  PasLibVlcPlayerUnit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.ImageList, FMX.ImgList, FMX.Edit, FMX.EditBox, FMX.ComboTrackBar;

type
  TForm2 = class(TForm)
    FmxPasLibVlcPlayer1: TFmxPasLibVlcPlayer;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    ActionList1: TActionList;
    OpenDialog1: TOpenDialog;
    Action1: TAction;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Action2: TAction;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    ComboBox1: TComboBox;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    Action3: TAction;
    MenuItem8: TMenuItem;
    ListView1: TListView;
    Action4: TAction;
    Action5: TAction;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    Action6: TAction;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    Action7: TAction;
    MenuItem13: TMenuItem;
    PopupMenu1: TPopupMenu;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    StyleBook1: TStyleBook;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    Action9: TAction;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Action8: TAction;
    Switch1: TSwitch;
    Timer2: TTimer;
    ComboTrackBar1: TComboTrackBar;
    Label3: TLabel;
    procedure FmxPasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
      time: Int64);
    procedure Action1Execute(Sender: TObject);
    procedure TrackBar1Tracking(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
    procedure FmxPasLibVlcPlayer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FmxPasLibVlcPlayer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FmxPasLibVlcPlayer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure FmxPasLibVlcPlayer1Click(Sender: TObject);
    procedure FmxPasLibVlcPlayer1DblClick(Sender: TObject);
    procedure FmxPasLibVlcPlayer1DragDrop(Sender: TObject;
      const Data: TDragObject; const Point: TPointF);
    procedure FmxPasLibVlcPlayer1DragOver(Sender: TObject;
      const Data: TDragObject; const Point: TPointF;
      var Operation: TDragOperation);
    procedure FmxPasLibVlcPlayer1MediaPlayerEndReached(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ComboTrackBar1Change(Sender: TObject);
    procedure FmxPasLibVlcPlayer1MediaPlayerOpening(Sender: TObject);
    procedure FmxPasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
      position: Single);
  private
    { private êÈåæ }
    mpos: TPointF;
    mmove, mdown, dclick: Boolean;
    LastUpdate: Single;
    userTracking: Boolean;
    procedure DropURL(const name: string);
  public
    { public êÈåæ }
    title: string;
    filename: string;
    procedure Thumbnail;
    procedure PlayFilename;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses System.Threading, FMX.Platform, IniFiles;

const
  interval: Cardinal = 300;

procedure TForm2.Action1Execute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    filename := OpenDialog1.filename;
    FmxPasLibVlcPlayer1.Play(filename);
  end;
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  Panel1.Visible := not Panel1.Visible;
  Action2.Checked := Panel1.Visible;
end;

procedure TForm2.Action3Execute(Sender: TObject);
begin
  ListView1.Visible := not ListView1.Visible;
  Action3.Checked := ListView1.Visible;
  if ListView1.Visible then
    Thumbnail;
end;

procedure TForm2.Action4Execute(Sender: TObject);
var
  ms: Int64;
begin
  ms := FmxPasLibVlcPlayer1.GetVideoPosInMs - 10000;
  FmxPasLibVlcPlayer1.SetVideoPosInMs(ms);
end;

procedure TForm2.Action5Execute(Sender: TObject);
var
  ms: Int64;
begin
  ms := FmxPasLibVlcPlayer1.GetVideoPosInMs + 10000;
  FmxPasLibVlcPlayer1.SetVideoPosInMs(ms);
end;

procedure TForm2.Action6Execute(Sender: TObject);
begin
  case FormStyle of
    TFormStyle.Normal:
      FormStyle := TFormStyle.StayOnTop;
    TFormStyle.StayOnTop:
      FormStyle := TFormStyle.Normal;
  end;
end;

procedure TForm2.Action7Execute(Sender: TObject);
begin
  mdown := false;
  if FullScreen then
    FullScreen := false
  else
  begin
    FullScreen := true;
    if Panel1.Visible then
      Action2Execute(nil);
    if ListView1.Visible then
      Action3Execute(nil);
  end;
end;

procedure TForm2.Action8Execute(Sender: TObject);
begin
  MenuItem25.IsChecked := not MenuItem25.IsChecked;
  Switch1.IsChecked := MenuItem25.IsChecked;
end;

procedure TForm2.Action9Execute(Sender: TObject);
begin
  with FmxPasLibVlcPlayer1 do
    if IsPlay then
      MenuItem7Click(nil)
    else if IsPause then
      MenuItem6Click(nil)
    else
      Play(filename);
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
var
  i: Integer;
begin
  i := 0;
  case ComboBox1.ItemIndex of
    0:
      i := 50;
    1:
      i := 100;
    2:
      i := 150;
    3:
      i := 200;
    4:
      i := 400;
  end;
  with FmxPasLibVlcPlayer1 do
    if i <> GetPlayRate then
      SetPlayRate(i);
end;

procedure TForm2.ComboTrackBar1Change(Sender: TObject);
var
  num: Integer;
begin
  num := Round(ComboTrackBar1.Value);
  FmxPasLibVlcPlayer1.SetAudioVolume(num);
end;

procedure TForm2.DropURL(const name: string);
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(name);
  try
    s := ini.ReadString('InternetShortcut', 'URL', '');
  finally
    ini.Free;
  end;
  if s <> '' then
  begin
    filename := s;
    FmxPasLibVlcPlayer1.PlayYoutube(filename);
  end;
end;

procedure TForm2.FmxPasLibVlcPlayer1Click(Sender: TObject);
begin
  Timer2.Enabled := true;
end;

procedure TForm2.FmxPasLibVlcPlayer1DblClick(Sender: TObject);
begin
  dclick := true;
  mdown := false;
  case WindowState of
    TWindowState.wsNormal:
      WindowState := TWindowState.wsMaximized;
    TWindowState.wsMaximized:
      WindowState := TWindowState.wsNormal;
  end;
end;

procedure TForm2.FmxPasLibVlcPlayer1DragDrop(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
begin
  if Length(Data.Files) > 0 then
    filename := Data.Files[0]
  else
    filename := Data.Data.ToString;
  PlayFilename;
end;

procedure TForm2.FmxPasLibVlcPlayer1DragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.Move;
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerEndReached(Sender: TObject);
begin
  TThread.Queue(nil,
    procedure
    begin
      if MenuItem25.IsChecked then
        FmxPasLibVlcPlayer1.Play(filename)
      else
        FmxPasLibVlcPlayer1.Stop;
    end);
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
time: Int64);
begin
  Label2.Tag := FmxPasLibVlcPlayer1.GetVideoLenInMs;
  Label2.Text := FmxPasLibVlcPlayer1.GetVideoLenStr;
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerOpening(Sender: TObject);
begin
  Caption := ExtractFileName(filename);
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
position: Single);
begin
  if TThread.GetTickCount - LastUpdate > 100 then
  begin
    userTracking := false;
    LastUpdate := TThread.GetTickCount;
    TrackBar1.Value := position * 100;
    Label1.Text := FmxPasLibVlcPlayer1.GetVideoPosStr;
    userTracking := true;
  end;
end;

procedure TForm2.FmxPasLibVlcPlayer1MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  mpos := TPointF.Create(X, Y);
  mdown := true;
  mmove := false;
end;

procedure TForm2.FmxPasLibVlcPlayer1MouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Single);
var
  p: TPointF;
begin
  if mdown then
  begin
    p := TPointF.Create(X, Y) - mpos;
    Left := Left + Round(p.X);
    Top := Top + Round(p.Y);
    mmove := true;
  end;
end;

procedure TForm2.FmxPasLibVlcPlayer1MouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  mdown := false;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FmxPasLibVlcPlayer1.EventsEnable;
  Action2.Checked := Panel1.Visible;
  ComboTrackBar1Change(nil);
  Caption := 'no title';
  if ParamCount > 2 then
  begin
    filename := ParamStr(1);
    PlayFilename;
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FmxPasLibVlcPlayer1.EventsDisable;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkESCAPE then
    FullScreen := false;
end;

procedure TForm2.ListView1Change(Sender: TObject);
var
  item: TListViewItem;
begin
  item := ListView1.Items[ListView1.ItemIndex];
  FmxPasLibVlcPlayer1.SetVideoPosInPercent(item.Tag);
end;

procedure TForm2.MenuItem3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.MenuItem6Click(Sender: TObject);
begin
  if FmxPasLibVlcPlayer1.IsPause then
    FmxPasLibVlcPlayer1.Resume;
end;

procedure TForm2.MenuItem7Click(Sender: TObject);
begin
  FmxPasLibVlcPlayer1.Pause;
end;

procedure TForm2.PlayFilename;
begin
  if ExtractFileExt(filename).ToLower = '.url' then
    DropURL(filename)
  else if filename <> '' then
    FmxPasLibVlcPlayer1.Play(filename);
end;

procedure TForm2.Thumbnail;
begin
  ListView1.Items.Clear;
  TTask.Run(
    procedure
    var
      Player: TFmxPasLibVlcPlayer;
      fname: string;
    begin
      Player := TFmxPasLibVlcPlayer.Create(nil);
      try
        fname := ExtractFileDir(ParamStr(0)) + '\snapshot.png';
        Player.Play(filename);
        Sleep(300);
        Player.Pause;
        for var i := 0 to 9 do
        begin
          Player.SetVideoPosInPercent(i * 10);
          Sleep(200);
          Player.SnapShot(fname, 50, 50);
          Sleep(200);
          TThread.Queue(nil,
            procedure
            var
              item: TListViewItem;
            begin
              item := ListView1.Items.Add;
              if FileExists(fname) then
                item.Bitmap.LoadFromFile(fname);
              item.Text := (i * 10).ToString;
              item.Tag := i * 10;
            end);
        end;
      finally
        Player.Free;
        TThread.Queue(nil,
          procedure
          begin
            if FileExists(fname) then
              DeleteFile(fname);
          end);
      end;
    end);
end;

procedure TForm2.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := false;
  if dclick or mmove then
    dclick := false
  else
    Action9Execute(nil);
end;

procedure TForm2.TrackBar1Tracking(Sender: TObject);
begin
  if userTracking then
    FmxPasLibVlcPlayer1.SetVideoPosInPercent(TrackBar1.Value);
end;

end.
