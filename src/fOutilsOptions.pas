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
  File last update : 2025-10-16T10:42:44.975+02:00
  Signature : 511dede64b8bc7d803e4b61ed9deb25a878c0eba
  ***************************************************************************
*)

unit fOutilsOptions;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, uDM, System.Rtti, FMX.Grid.Style,
  Data.Bind.Controls, Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Bind.Navigator, FMX.ScrollBox,
  FMX.Grid, FMX.Objects;

type
  TfrmOutilsOptions = class(TFrame)
    ZoneFooter: TLayout;
    gbTaillesIcones: TGroupBox;
    sgTailles: TStringGrid;
    bnTailles: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    btnAnnuler: TButton;
    btnEnregistrer: TButton;
    rBackground: TRectangle;
    procedure FrameClick(Sender: TObject);
    procedure btnEnregistrerClick(Sender: TObject);
    procedure btnAnnulerClick(Sender: TObject);
  private
    class var maframe: TfrmOutilsOptions;
  protected
  public
    procedure Hide; override;
    class function getCurrent: TfrmOutilsOptions;
  end;

implementation

{$R *.fmx}
{ TfrmOutilsOptions }

procedure TfrmOutilsOptions.btnAnnulerClick(Sender: TObject);
begin
  dm.ChargerLesTailles;
  Hide;
end;

procedure TfrmOutilsOptions.btnEnregistrerClick(Sender: TObject);
begin
  dm.EnregistrerLesTailles;
  Hide;
end;

procedure TfrmOutilsOptions.FrameClick(Sender: TObject);
begin
  name := '';
end;

class function TfrmOutilsOptions.getCurrent: TfrmOutilsOptions;
begin
  if not assigned(maframe) then
    maframe := TfrmOutilsOptions.create(nil);
  result := maframe;
end;

procedure TfrmOutilsOptions.Hide;
begin
  visible := false;
end;

initialization

TfrmOutilsOptions.maframe := nil;

finalization

// if assigned(TfrmOutilsOptions.maframe) then
// TfrmOutilsOptions.maframe.free;

end.
