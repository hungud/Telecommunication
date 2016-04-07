unit FlexCelModule;

interface

uses
  VCL.FlexCel.Core, FlexCel.XlsAdapter, CRGrid;

  procedure flExportDBGridToExcel(Caption : string;
                                NameFile : string;
                                Grid : TCRDBGrid;
                                ShowColumnsDialog : Boolean = False;
                                LandscapePageOrientation : Boolean = False;
                                SaveToDisk: boolean = false);

implementation

procedure flExportDBGridToExcel(Caption : string;
                                NameFile : string;
                                Grid : TCRDBGrid;
                                ShowColumnsDialog : Boolean = False;
                                LandscapePageOrientation : Boolean = False;
                                SaveToDisk: boolean = false);
begin
//
end;

end.
