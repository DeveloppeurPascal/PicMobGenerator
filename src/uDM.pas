(* C2PP
  ***************************************************************************

  Pic Mob Generator

  Copyright 2022-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://picmobgenerator.olfsoftware.fr/

  Project site :
  https://github.com/DeveloppeurPascal/PicMobGenerator

  ***************************************************************************
  File last update : 2025-10-16T10:42:44.979+02:00
  Signature : e2d9ef8c36c9fcfb66e1c9204f749253b163847a
  ***************************************************************************
*)

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
