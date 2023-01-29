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
  FMX.Grid;

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
