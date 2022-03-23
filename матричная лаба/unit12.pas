unit unit12;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure getDataToGrid(path : string; grid: TStringGrid);
var
  f : Text;
  n, m, i, j, buf: integer;
begin
  if path = '' then
  begin
       MessageDlg('Не ввели путь к файлу!', mtError, mbOKCancel, 0);
      exit;
  end;
  AssignFile(f, path);
  Reset(f);

  readln(f, n, m);

  grid.RowCount := n;
  grid.ColCount := m;

  for I := 0 to n - 1 do
  begin
      for J := 0 to m - 1 do
      begin
        read(f, buf);
        grid.Cells[J, I] := IntToStr(buf);
      end;
      readln(f);
  end;

  CloseFile(f);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  getDataToGrid(Edit1.Text, stringGrid1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  n1, n2, m1, m2, i, j, k, buf: integer;
begin
  n1 := stringgrid1.RowCount;
  n2 := stringgrid2.RowCount;

  m1 := stringGrid1.ColCount;
  m2 := stringGrid2.ColCount;

  if (comboBox1.Text = '+') then
  begin
    if (n1 <> n2) or (m1 <> m2) then
    begin
      MessageDlg('Размеры матриц должны совпадать!', mtError, mbOKCancel, 0);
      exit;
    end;

    stringgrid3.RowCount := n1;
    stringgrid3.ColCount := m1;

    for I := 0 to n1-1 do
    begin
        for J := 0 to m1-1 do
        begin
            buf := StrToInt(stringgrid1.Cells[j, i]) +  StrToInt(stringgrid2.Cells[j, i]);
            stringgrid3.Cells[j, i] := IntToStr(buf);
        end;
    end;
  end
  else if (combobox1.Text = '-') then
  begin
       if (n1 <> n2) or (m1 <> m2) then
        begin
          MessageDlg('Размеры матриц должны совпадать!', mtError, mbOKCancel, 0);
          exit;
        end;

        stringgrid3.RowCount := n1;
        stringgrid3.ColCount := m1;

        for I := 0 to n1-1 do
        begin
            for J := 0 to m1-1 do
            begin
                buf := StrToInt(stringgrid1.Cells[j, i]) -  StrToInt(stringgrid2.Cells[j, i]);
                stringgrid3.Cells[j, i] := IntToStr(buf);
            end;
        end;
  end
  else if (combobox1.Text = '*') then
  begin
       if (m1 <> n2) or (m2 <> n1) then
       begin
            MessageDlg('Количество столбцов первой матрицы должно быть равно количеству строк второй матрицы!', mtError, mbOKCancel, 0);
            exit;
       end;

       stringgrid3.RowCount := n1;
       stringgrid3.ColCount := m1;

       for I := 0 to n1-1 do
        begin
            for J := 0 to m1-1 do
            begin
                buf := 0;
                for k:=0 to stringgrid1.ColCount - 1 do
                    buf := buf + StrToInt(stringgrid1.Cells[k, i]) * StrToInt(stringgrid2.Cells[j, k]);
                stringgrid3.Cells[j, i] := IntToStr(buf);
            end;
        end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  getDataToGrid(Edit2.Text, stringGrid2);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := 'Матричный калькулятор';
  Form1.Color := clMoneyGreen;
end;

end.























