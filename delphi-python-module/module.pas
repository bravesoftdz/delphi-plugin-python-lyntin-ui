unit module;

interface
uses PythonEngine, Unit1, CSIntf, Forms, Classes, Windows;

var
  gFuncRecv : PPyObject;
  gFuncSend : PPyObject;
  gClosing : boolean;

procedure initdemodll; cdecl;

implementation

function run( Self, Args : PPyObject ) : PPyObject; far; cdecl;
begin
  gFuncSend := GetPythonEngine.FindFunction('lyntin.ui.kaiui','send');
  gFuncRecv := GetPythonEngine.FindFunction('lyntin.ui.kaiui','recv');

  if not Assigned(gFuncSend) then begin
    gApplication.MessageBox('gFuncSend not valid','kaiui:initdemodll',MB_OK);
  end;
  if not Assigned(gFuncRecv) then begin
    gApplication.MessageBox('gFuncSend not valid','kaiui:initdemodll',MB_OK);
  end;

  gApplication.CreateForm(TForm1,gForm);
  gApplication.Run();
  Result := GetPythonEngine.ReturnNone;
end;

function kill( Self, Args : PPyObject ) : PPyObject; far; cdecl;
begin
  gEngine.Py_DecRef(gFuncRecv);
  gEngine.Py_DecRef(gFuncSend);
  Result := GetPythonEngine.ReturnNone;
end;

procedure initdemodll;
begin
  gEngine := TPythonEngine.Create(nil);
  gEngine.AutoFinalize := False;
  gEngine.LoadDll;
  gModule := TPythonModule.Create(nil);
  gModule.Engine := gEngine;
  gModule.ModuleName := 'demodll';
  gModule.AddMethod( 'run', @run, 'no help yet...' );
  gModule.AddMethod( 'kill', @kill, 'no help yet...' );
  gModule.Initialize;
end;

initialization
  gApplication := TMyApplication.Create(nil);
  gApplication.Initialize;
  gClosing := false;
finalization
  gApplication.Free;
  gEngine.Free;
  gModule.Free;
end.
