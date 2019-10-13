unit uPlugin;

interface

uses
  ToolsAPI;

type
  TPlugin = class(TInterfacedObject, IOTAWizard,
    IOTAMenuWizard)
  private
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    function GetMenuText: string;
    procedure VisualizarDataSet(Sender: TObject);
  public
    constructor Create;
  end;

function LoadPlugin(BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): boolean; stdcall;

implementation

uses
  ShellAPI, Windows, VCL.Menus, View.Visualizador;

function LoadPlugin(BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): boolean; stdcall;
begin
  result := True;
  RegisterProc(TPlugin.Create);
end;

{ TPlugin }

procedure TPlugin.AfterSave;
begin

end;

procedure TPlugin.BeforeSave;
begin

end;

constructor TPlugin.Create;
var
  MainMenu: TMainMenu;
  MenuDelphiInga: TMenuItem;
  MenuDataSet: TMenuItem;
begin
  MainMenu := (BorlandIDEServices as INTAServices).MainMenu;

  MenuDelphiInga := TMenuItem.Create(MainMenu);
  MenuDelphiInga.Name := 'DelphiInga';
  MenuDelphiInga.Caption := 'Delphi Inga';
  MainMenu.Items.Add(MenuDelphiInga);

  MenuDataSet := TMenuItem.Create(MainMenu);
  MenuDataSet.Name := 'VisualizarDataSet';
  MenuDataSet.Caption := 'View DataSet';
  MenuDataSet.OnClick := VisualizarDataSet;
  MenuDelphiInga.Add(MenuDataSet);
end;

procedure TPlugin.Destroyed;
begin

end;

procedure TPlugin.Execute;
begin
  ShellExecute(0, 'open', 'notepad.exe', nil, nil,
    SW_SHOWNORMAL);
end;

function TPlugin.GetIDString: string;
begin
  result := 'DelphiInga';
end;

function TPlugin.GetMenuText: string;
begin
  result := 'Open Notepad';
end;

function TPlugin.GetName: string;
begin
  result := 'DelphiInga';
end;

function TPlugin.GetState: TWizardState;
begin
  result := [wsEnabled];
end;

procedure TPlugin.Modified;
begin

end;

procedure TPlugin.VisualizarDataSet(Sender: TObject);
var
  Expressao: string;
  Texto: string;

  Thread: IOTAThread;

  CanModify: boolean;
  ResultAddr, ResultSize, ResultVal: Cardinal;

  fFormulario: TfVisualizador;
begin
  Texto := (BorlandIDEServices as IOTAEditorServices).
    TopView.GetBlock.Text;

  Expressao := Texto + '.SaveToFile(''D:\DelphiInga\Dados.xml'')';

  Thread := (BorlandIDEServices as IOTADebuggerServices).
    CurrentProcess.CurrentThread;

  Thread.Evaluate(Expressao,
    '', 0, CanModify, True, '', ResultAddr, ResultSize, ResultVal);

  fFormulario := TfVisualizador.Create(nil);
  fFormulario.ShowModal;
  fFormulario.Free;
end;

end.
