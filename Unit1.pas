unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  PasLibVlcPlayerUnit, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.Menus, Vcl.ComCtrls, DragDrop, DropTarget, DragDropFile;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    Speed2x: TAction;
    Play: TAction;
    PasLibVlcPlayer1: TPasLibVlcPlayer;
    PasLibVlcMediaList1: TPasLibVlcMediaList;
    Panel1: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Files1: TMenuItem;
    Play1: TMenuItem;
    Speed2x1: TMenuItem;
    TrackBar1: TTrackBar;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DropFileTarget1: TDropFileTarget;
    procedure Speed2xExecute(Sender: TObject);
    procedure PlayExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
      position: Single);
    procedure PasLibVlcPlayer1MediaPlayerTimeChanged(Sender: TObject;
      time: Int64);
    procedure PasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
      time: Int64);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    FileName: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FileName := OpenDialog1.FileName;
    PlayExecute(nil);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PasLibVlcPlayer1.EventsEnable;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  PasLibVlcPlayer1.EventsDisable;
end;

procedure TForm1.PasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
  time: Int64);
var
  t: NativeInt;
begin
  t := time div 1000;
  Label1.Caption := t.ToString;
  Label1.Tag := t;
end;

procedure TForm1.PasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
  TrackBar1.position := Trunc(position * 100);
end;

procedure TForm1.PasLibVlcPlayer1MediaPlayerTimeChanged(Sender: TObject;
  time: Int64);
var
  t: NativeInt;
begin
  t := time div 1000;
  Label2.Caption := t.ToString;
  Label1.Caption := (Label1.Tag - t).ToString;
end;

procedure TForm1.PlayExecute(Sender: TObject);
begin
  PasLibVlcPlayer1.Play(FileName);
end;

procedure TForm1.Speed2xExecute(Sender: TObject);
begin
  Speed2x.Checked := not Speed2x.Checked;
  if not Speed2x.Checked then
    PasLibVlcPlayer1.SetPlayRate(1)
  else
    PasLibVlcPlayer1.SetPlayRate(2); // 2î{ë¨
end;

end.
