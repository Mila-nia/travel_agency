unit uChild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, DB;

type
  TfmChild = class(TForm)
    MainMenu1: TMainMenu;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     child_id: integer;
     child_name: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChild: TfmChild;

implementation

uses Unit8, Unit2, Unit4;

{$R *.dfm}
procedure TfmChild.FormCreate(Sender: TObject);
begin
  DataSource1.Dataset :=dm.cdsChild;
end;

procedure TfmChild.N1Click(Sender: TObject);
begin
  fmNewChild.eName.Text :=' ';
  fmNewChild.eSurname.Text :=' ';
  fmNewChild.eLastname.Text :=' ';
  fmNewChild.ShowModal;
    if (fmNewChild.ModalResult = mrOk) then
  begin
    try
      dm.DCOMConnection1.AppServer.smAddChild(0, fmNewChild.eName.Text, fmNewChild.eSurname.Text, fmNewChild.eLastname.Text);
    except
      MessageDlg('������ ������', mtError, [mbOk], 0);
    end;
    dm.cdsChild.Refresh;
  end;
end;

procedure TfmChild.N4Click(Sender: TObject);
begin
 fmChild.Close;
end;

procedure TfmChild.N2Click(Sender: TObject);
begin
  begin
  fmNewChild.eName.Text :=dm.cdsChildNAME.Value;
  fmNewChild.eSurname.Text :=dm.cdsChildSURNAME.Value;
  fmNewChild.eLastname.Text :=dm.cdsChildLASTNAME.Value;;
  fmNewChild.ShowModal;
  if (fmNewChild.ModalResult = mrOk) then
  begin
    try
      dm.DCOMConnection1.AppServer.smAddChild(dm.cdsChildID.Value, fmNewChild.eName.Text,
               fmNewChild.eSurname.Text ,fmNewChild.eLastname.Text);
    except
      MessageDlg('������ ������', mtError, [mbOk], 0);
    end;
    dm.cdsChild.Refresh;
  end;
end;
end;

procedure TfmChild.N3Click(Sender: TObject);
begin
     MessageDlg('������� �������'''+ dm.cdsChildNAME.Value +''' ?', mtConfirmation, [mbYes, mbNo], 0);
     dm.DCOMConnection1.AppServer.smDeleteChild(dm.cdsChildID.Value);
     dm.cdsChild.Refresh;
end;

procedure TfmChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmNewClient.child_id := dm.cdsChildID.Value;
  fmNewClient.child_name :=  dm.cdsChildNAME.Value;
end;

end.
