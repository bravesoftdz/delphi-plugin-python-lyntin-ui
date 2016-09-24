unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  CSIntf, PythonEngine, Unit2, StdCtrls, IpUtils, IpTerm, EmulVT, OoMisc,
  ADTrmEmu, TnEmulVT, strutils;

type
  TMyApplication = class(TApplication)
  end;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    IpTerminal1: TIpTerminal;
    IpVT100Emulator1: TIpVT100Emulator;
    IpTerminal2: TIpTerminal;
    IpVT100Emulator2: TIpVT100Emulator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    procedure WMUser(var Msg: TMsg); message WM_USER;
  public
    EditHistory: TStrings;
    procedure SendToMud(text:string);
  end;

var
  gForm : TForm1;
  gEngine : TPythonEngine;
  gModule : TPythonModule;
  gApplication : TMyApplication;
  gFetcher : MessageFetcher;

implementation

uses
  module, Math;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  gFetcher := MessageFetcher.Create(true);
  gFetcher.Resume();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  codesite.send('FormClose');
  gClosing := true;
  gFetcher.WaitFor();
  codesite.send('WaitFor completed');
  Action := caFree;
  gApplication.Terminate();
end;

procedure TForm1.WMUser(var Msg: TMsg);
var
  s,cline : string;
//  slist : TStrings;
  i,j,clen,rest : integer;
begin
//  slist := TStrings.Create;
//  slist.Text := s;

{  for i:=0 to slist.Count-1 do begin
    cline := slist[i];
    clen := length(cline);
    if clen>80 then begin
      slist[i] := midstr(s,1,80);
      for j:=0 to floor(clen/80) do begin
        if (j*)
        rest
        slist.Insert(i+j);
      end;
    end;
  end;}

  mycs.Acquire;
  try
    s := updatedata;
    updatedata := '';
  finally
    mycs.release();
  end;
  IpTerminal1.WriteString(s);
//  slist.Free;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  // on up arrow go to previous command
  // on down arrow go to next command
  // on return send command
  if (key=#13) then begin
    SendToMud(Edit1.Text);
    Edit1.SelectAll();
{  end else if () then begin

  end else if () then begin}

  end;
end;

procedure TForm1.SendToMud(text:string);
begin
  gEngine.Lock;
  try
    gEngine.EvalFunction(gFuncSend,[Edit1.Text+#13]);
  finally
    gEngine.Unlock;
  end;
end;

end.
