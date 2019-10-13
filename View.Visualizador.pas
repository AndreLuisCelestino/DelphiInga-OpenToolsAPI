unit View.Visualizador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids;

type
  TfVisualizador = class(TForm)
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
  end;

var
  fVisualizador: TfVisualizador;

implementation

{$R *.dfm}

procedure TfVisualizador.FormCreate(Sender: TObject);
begin
  // Aguarda meio segundo at� que o arquivo "Dados.xml" exista
  // Obs: n�o � a melhor abordagem!
  // O ideal � utilizar o m�todo "ProcessDebugEvents" da Interface IOTADebuggerServices
  // http://www.andrecelestino.com/delphi-criando-um-visualizador-de-datasets-com-o-open-tools-api-parte-4/
  repeat
    Sleep(500);
  until FileExists('D:\DelphiInga\Dados.xml');

  // Carrega o arquivo "Dados.xml" no DataSet
  ClientDataSet1.LoadFromFile('D:\DelphiInga\Dados.xml');
end;

end.
