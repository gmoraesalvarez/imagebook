unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Grids, ShellCtrls, StdCtrls, ColorBox, Buttons,JPEGLib, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    DrawGrid1: TDrawGrid;
    Image1: TImage;
    ImageList1: TImageList;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    ShellListView1: TShellListView;
    ShellTreeView1: TShellTreeView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure DrawGrid1Click(Sender: TObject);
    procedure DrawGrid1DblClick(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure PageControl1Change(Sender: TObject);
    procedure ShellListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ShellListView1DblClick(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  item:integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  item:=0;
end;

procedure TForm1.DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  leicon:TBitmap;

begin
  item:=aRow*DrawGrid1.ColCount+aCol;
  leicon:=TBitmap.Create;
  //ShowMessage(inttostr(acol)+'.'+inttostr(arow));
    DrawGrid1.Canvas.Brush.Color:=clGray;
  DrawGrid1.Canvas.Rectangle(ARect);
  if item < ImageList1.Count then
  begin
    //form1.Caption:=form1.Caption+'+';
    ImageList1.GetBitmap(item,leicon);
    DrawGrid1.Canvas.StretchDraw(ARect,leicon);
    //DrawGrid1.Canvas.TextOut(aRect.Left+2,aRect.Top+2,inttostr(item));
  end;
  if gdSelected in aState then DrawGrid1.Canvas.TextOut(aRect.Left,aRect.Top,'*');
  leicon.Free;
  //if item >DrawGrid1.ColCount*DrawGrid1.RowCount then item:=0;
end;

procedure TForm1.DrawGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin

end;

procedure TForm1.DrawGrid1Click(Sender: TObject);
begin

end;

procedure TForm1.DrawGrid1DblClick(Sender: TObject);
var
  sel:integer;
begin
  sel:=DrawGrid1.Selection.top*3+DrawGrid1.Selection.left;
  Image1.Picture.LoadFromFile(ShellListView1.Root+'/'+ShellListView1.Items[sel].Caption);
  Image1.Width:=600;
  Image1.Height:=Image1.Picture.Bitmap.Height div (Image1.Picture.Bitmap.Width div 600);

end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
end;

procedure TForm1.ShellListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
end;

procedure TForm1.ShellListView1DblClick(Sender: TObject);
begin
  //ListView1.Items.Add;
  //ListView1.Items[ListView1.Items.Count-1].Caption:='imagem';
  //ListView1.Items[ListView1.Items.Count-1].ImageIndex:=ImageList1.Count-1;
  //ShellListView1.ItemFocused.ImageIndex:=ImageList1.Count-1;

  //Image1.Picture.Assign(leicon.Picture);
end;

procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
var
  leicon:TImage;
  leimg:tbitmap;
  i:integer;
begin
  ImageList1.Clear;
  item:=0;

  leicon:=TImage.Create(self);
  leimg:=TBitmap.Create;
  leimg.Width:=256;
  leimg.Height:=256;

  for i:=0 to ShellListView1.Items.Count-1 do
  begin
    if LowerCase(ExtractFileExt(ShellListView1.Items[i].Caption)) = '.jpg' then
    begin
      DrawGrid1.RowCount:=(ShellListView1.Items.Count div 3);
      leicon.Picture.LoadFromFile(ShellListView1.Root+'/'+
        ShellListView1.Items[i].Caption);
      leimg.Canvas.StretchDraw(Rect(0,0,255,255),leicon.Picture.Bitmap);
      ImageList1.Add(leimg,nil);
      //Application.ProcessMessages;
      form1.Caption:=inttostr(ImageList1.Count);
    end;
  end;
  leicon.free;
  leicon.Free;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin

end;

end.

