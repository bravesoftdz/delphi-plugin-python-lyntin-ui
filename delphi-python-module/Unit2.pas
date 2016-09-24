unit Unit2;

interface

uses
  Classes, PythonEngine, strutils, syncobjs, Windows, messages;

type
  MessageFetcher = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    function GetDamnLine():string;    
  end;

var
  UpdateData: string;
  MyCS: TCriticalSection;

implementation

uses
  Unit1, CSIntf, Math, module;

function MessageFetcher.GetDamnLine():string;
var
  line : string;
  len : integer;
begin
  gEngine.Lock;
  try
    line := gEngine.EvalFunctionNoArgs(gFuncRecv);
  finally
    gEngine.Unlock;
  end;
//  if (line<>'') then begin
//    codesite.send('line',line);
{    len := length(line);
    if (line[len]=#13) then begin
      line := midstr(line,0,len-1);
      len := len-1;
    end;}
{    if (line[len]=#10) then begin
      line := midstr(line,0,len-1);
    end;}
//  end;
  result := line;
end;

procedure MessageFetcher.Execute;
var
  line : string;
begin
  while not gClosing do begin
    mycs.Acquire;
    try
      line := GetDamnLine();
      if (line='0') then begin
        continue;
      end;
      updatedata := updatedata + line;      
    finally
      mycs.Release;
    end;
    PostMessage(gForm.handle, WM_USER, 0, 0);
  end;
end;

initialization
  MyCS := TCriticalSection.Create();
  updatedata := '';
  Randomize;
finalization
  MyCS.Free;
end.
