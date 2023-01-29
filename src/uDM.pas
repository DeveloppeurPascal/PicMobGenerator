unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin;

type
  Tdm = class(TDataModule)
    tabTaillesImages: TFDMemTable;
    tabTaillesImagesLargeur: TWordField;
    tabTaillesImagesHauteur: TWordField;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
    function getNomFichierDB: string;
  public
    { Déclarations publiques }
    procedure ChargerLesTailles;
    procedure EnregistrerLesTailles;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses System.IOUtils;

procedure Tdm.ChargerLesTailles;
begin
  if tfile.Exists(getNomFichierDB) then
    tabTaillesImages.LoadFromFile(getNomFichierDB);
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  if tfile.Exists(getNomFichierDB) then
    ChargerLesTailles
  else
    EnregistrerLesTailles;
end;

procedure Tdm.EnregistrerLesTailles;
begin
  tabTaillesImages.SaveToFile(getNomFichierDB);
end;

function Tdm.getNomFichierDB: string;
begin
{$IFDEF DEBUG}
  result := tpath.combine(tpath.GetdocumentsPath, 'PicMobGenerator-DEBUG');
{$ELSE}
  result := tpath.combine(tpath.GetHomePath, 'PicMobGenerator');
{$ENDIF}
  if not tdirectory.Exists(result) then
    tdirectory.CreateDirectory(result);
  result := tpath.combine(result, 'picsize.bin');
end;

end.
