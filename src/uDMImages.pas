unit uDMImages;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList;

type
  TDMImages = class(TDataModule)
    lstIconesPicMobGenerator: TImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMImages: TDMImages;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
