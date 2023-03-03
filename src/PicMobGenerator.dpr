program PicMobGenerator;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  fOutilsOptions in 'fOutilsOptions.pas' {frmOutilsOptions: TFrame},
  uDM in 'uDM.pas' {dm: TDataModule},
  uProjetPIMG in 'uProjetPIMG.pas',
  fEdition in 'fEdition.pas' {frmEdition: TFrame},
  u_urlOpen in '..\lib-externes\librairies\u_urlOpen.pas',
  uDMImages in 'uDMImages.pas' {DMImages: TDataModule},
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\sources\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\sources\Olf.FMX.AboutDialog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TDMImages, DMImages);
  Application.Run;
end.
