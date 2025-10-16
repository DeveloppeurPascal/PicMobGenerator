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
  File last update : 2025-10-16T10:42:44.974+02:00
  Signature : 10a17273f459da5ce72f2c19a2b5c426db2b0763
  ***************************************************************************
*)

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
