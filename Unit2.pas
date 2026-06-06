unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.Objects, FmxPasLibVlcPlayerUnit, System.Actions, FMX.ActnList, FMX.Menus,
  DragDrop, DropTarget, DragDropFile, PasLibVlcPlayerUnit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Gestures;

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
    Timer1: TTimer;
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
    procedure FmxPasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
      time: Int64);
    procedure FmxPasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
      position: Single);
    procedure Action1Execute(Sender: TObject);
    procedure TrackBar1Tracking(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
  private
    { private êÈåæ }
    mpos: TPointF;
    mdown, mdrag: Boolean;
  public
    { public êÈåæ }
    title: string;
    procedure Thumbnail;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses System.Threading, Winapi.Windows, Winapi.Messages, FMX.Platform.Win;

const
  interval: Cardinal = 300;

procedure TForm2.Action1Execute(Sender: TObject);
begin
  if OpenDialog1.Execute then
    FmxPasLibVlcPlayer1.Play(OpenDialog1.filename);
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  Panel1.Visible := not Panel1.Visible;
  if Panel1.Visible then
    FmxPasLibVlcPlayer1.EventsEnable
  else
    FmxPasLibVlcPlayer1.EventsDisable;
end;

procedure TForm2.Action3Execute(Sender: TObject);
begin
  ListView1.Visible := not ListView1.Visible;
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

procedure TForm2.ComboBox1Change(Sender: TObject);
var
  i: integer;
begin
  i := 0;
  case ComboBox1.ItemIndex of
    0:
      i := 100;
    1:
      i := 150;
    2:
      i := 200;
    3:
      i := 400;
  end;
  with FmxPasLibVlcPlayer1 do
    if i <> GetPlayRate then
      SetPlayRate(i);
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
  time: Int64);
begin
  Label2.Text := FmxPasLibVlcPlayer1.GetVideoLenStr;
end;

procedure TForm2.FmxPasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
  TrackBar1.Value := position;
end;

procedure TForm2.FmxPasLibVlcPlayer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  mpos := TPointF.Create(X, Y);
  mdown := true;
  mdrag := false;
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
  end;
  if p <> TPointF.Create(0, 0) then
    mdrag := true;
end;

procedure TForm2.FmxPasLibVlcPlayer1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  mdown := false;
  if not mdrag and FmxPasLibVlcPlayer1.IsPlay then
    MenuItem7Click(nil)
  else
    MenuItem6Click(nil);
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

procedure TForm2.Thumbnail;
begin
  ListView1.Items.Clear;
  TTask.Run(
    procedure
    var
      Player: TFmxPasLibVlcPlayer;
      item: TListViewItem;
      filename: string;
    begin
      filename := ExtractFileDir(ParamStr(0)) + '\snapshot.png';
      Player := TFmxPasLibVlcPlayer.Create(Self);
      try
        Player.Play(OpenDialog1.filename);
        Sleep(300);
        Player.Pause;
        Player.EventsEnable;
        for var i := 0 to 9 do
        begin
          Player.SetVideoPosInPercent(i * 10);
          Player.SnapShot(filename, 50, 50);
          item := ListView1.Items.Add;
          item.Bitmap.LoadFromFile(filename);
          item.Text := (i * 10).ToString;
          item.Tag := i * 10;
        end;
      finally
        Player.Free;
        DeleteFile(PWideChar(filename));
      end;
    end);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Label1.Text := FmxPasLibVlcPlayer1.GetVideoPosStr;
end;

procedure TForm2.TrackBar1Tracking(Sender: TObject);
var
  Value: Single;
begin
  Value := FmxPasLibVlcPlayer1.GetVideoPosInPercent;
  if (Value < TrackBar1.Value * 100 - 1) or (Value > TrackBar1.Value * 100 + 1)
  then
    FmxPasLibVlcPlayer1.SetVideoPosInPercent(TrackBar1.Value * 100);
end;

end.
