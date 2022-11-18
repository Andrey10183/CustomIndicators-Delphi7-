unit CustomTypes;

interface

uses SysUtils, Controls, Graphics, Classes,ExtCtrls;

type
   TAntialiased = (aaNone, aaBiline, aaTriline, aaQuadral);
   TGradfunc = (gf_none,gf_linear,gf_LinearMirror,gf_cospi,gf_cos2pi,gf_cos3pi,gf_cos4pi);

type TPeekAtControl = class(TControl)
  public property Color;
  end;

  procedure FastAntiAliasPicture(AMult:integer;AInput:TBitMap;AOutput:TBitMap);
  function GetGradColor(A1Col,A2Col:TColor;Delta,Pos:integer):TColor;
  function GetGradPos(ADelta:integer;APos:integer;AType:TGradfunc):integer;

implementation

uses Windows;

const
  MaxPixelCount = MaxInt div SizeOf(TRGBTriple);

type
  PRGBArray = ^TRGBArray;
  TRGBArray = array[0..MaxPixelCount-1] of TRGBTriple;

procedure FastAntiAliasPicture;
var
  x, y, cx, cy, cxi: Integer;
  totr, totg, totb: Integer;
  Row1, Row2, Row3, Row4, DestRow: PRGBArray;
  i, k: Integer;
begin
  // For each row
  K := AMult; Row2 := nil; Row3 := nil; Row4 := nil;
  for Y := 0 to AOutput.Height - 1 do begin
    // We compute samples of K x K pixels
    cy := y*K;
    // Get pointers to actual, previous and next rows in supersampled bitmap
    Row1 := AInput.ScanLine[cy];
    if K > 1 then Row2 := AInput.ScanLine[cy+1];
    if K > 2 then Row3 := AInput.ScanLine[cy+2];
    if K > 3 then Row4 := AInput.ScanLine[cy+3];
    // Get a pointer to destination row in output bitmap
    DestRow := AOutput.ScanLine[y];
    // For each column...
    for x := 0 to AOutput.Width - 1 do begin
      // We compute samples of 3 x 3 pixels
      cx := x*K;
      // Initialize result color
      totr := 0; totg := 0; totb := 0;
      if K > 3 then begin
        for i := 0 to 3 do begin
          cxi := cx + i;
          totr := totr + Row1[cxi].rgbtRed + Row2[cxi].rgbtRed + Row3[cxi].rgbtRed + Row4[cxi].rgbtRed;
          totg := totg + Row1[cxi].rgbtGreen + Row2[cxi].rgbtGreen + Row3[cxi].rgbtGreen + Row4[cxi].rgbtGreen;
          totb := totb + Row1[cxi].rgbtBlue + Row2[cxi].rgbtBlue + Row3[cxi].rgbtBlue + Row4[cxi].rgbtBlue;
        end;
        DestRow[x].rgbtRed := totr div 16;
        DestRow[x].rgbtGreen := totg div 16;
        DestRow[x].rgbtBlue := totb div 16;
      end else if K > 2 then begin
        for i := 0 to 2 do begin
          cxi := cx + i;
          totr := totr + Row1[cxi].rgbtRed + Row2[cxi].rgbtRed + Row3[cxi].rgbtRed;
          totg := totg + Row1[cxi].rgbtGreen + Row2[cxi].rgbtGreen + Row3[cxi].rgbtGreen;
          totb := totb + Row1[cxi].rgbtBlue + Row2[cxi].rgbtBlue + Row3[cxi].rgbtBlue;
        end;
        DestRow[x].rgbtRed := totr div 9;
        DestRow[x].rgbtGreen := totg div 9;
        DestRow[x].rgbtBlue := totb div 9;
      end else if K > 1 then begin
        for i := 0 to 1 do begin
          cxi := cx + i;
          totr := totr + Row1[cxi].rgbtRed + Row2[cxi].rgbtRed;
          totg := totg + Row1[cxi].rgbtGreen + Row2[cxi].rgbtGreen;
          totb := totb + Row1[cxi].rgbtBlue + Row2[cxi].rgbtBlue;
        end;
        DestRow[x].rgbtRed := totr div 4;
        DestRow[x].rgbtGreen := totg div 4;
        DestRow[x].rgbtBlue := totb div 4;
      end else begin
        DestRow[x].rgbtRed   := Row1[cx].rgbtRed;
        DestRow[x].rgbtGreen := Row1[cx].rgbtGreen;
        DestRow[x].rgbtBlue  := Row1[cx].rgbtBlue;
      end;
    end;
  end
end;

function GetGradColor(A1Col,A2Col:TColor;Delta,Pos:integer):TColor;
begin
   Result:=RGB(round(GetRValue(A1Col)-(GetRValue(A1Col)-GetRValue(A2Col))/Delta*Pos),
               round(GetGValue(A1Col)-(GetGValue(A1Col)-GetGValue(A2Col))/Delta*Pos),
               round(GetBValue(A1Col)-(GetBValue(A1Col)-GetBValue(A2Col))/Delta*Pos));
end;

function GetGradPos(ADelta:integer;APos:integer;AType:TGradfunc):integer;
var
   tmpRes:integer;
begin
   case AType of
   gf_linear:
      begin
         tmpRes:=APos;
         if APos>ADelta then tmpRes:=ADelta;
         if APos<0 then tmpRes:=0;
         result:=tmpRes;
      end;
   gf_LinearMirror:
      begin
         {if APos>(ADelta/2) then tmpRes:=Round(ADelta/2-(APos-ADelta/2)) else tmpRes:=APos;
         if tmpRes>Round(ADelta/2) then tmpRes:=Round(ADelta/2);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;}
         if 2*APos>(ADelta) then tmpRes:=Round(ADelta-(2*APos-ADelta)) else tmpRes:=2*APos;
         if tmpRes>Round(ADelta) then tmpRes:=Round(ADelta);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;
      end;
   gf_cospi:
      begin
         tmpRes:=round(abs(sin(APos*pi/ADelta))*(ADelta));
         if tmpRes>Round(ADelta) then tmpRes:=Round(ADelta);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;
         {tmpRes:=round(abs(sin(APos*pi/ADelta))*(ADelta/2));
         if tmpRes>Round(ADelta/2) then tmpRes:=Round(ADelta/2);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;}
      end;
   gf_cos2pi:
      begin
         tmpRes:=round(abs(sin(APos*2*pi/ADelta))*(ADelta));
         if tmpRes>Round(ADelta) then tmpRes:=Round(ADelta);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;
         {tmpRes:=round(abs(sin(APos*2*pi/ADelta))*(ADelta/2));
         if tmpRes>Round(ADelta/2) then tmpRes:=Round(ADelta/2);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;}
      end;
   gf_cos3pi:
      begin
         tmpRes:=round(abs(sin(APos*3*pi/ADelta))*(ADelta));
         if tmpRes>Round(ADelta) then tmpRes:=Round(ADelta);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;
         {tmpRes:=round(abs(sin(APos*3*pi/ADelta))*(ADelta/2));
         if tmpRes>Round(ADelta/2) then tmpRes:=Round(ADelta/2);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;}
      end;
   gf_cos4pi:
      begin
         tmpRes:=round(abs(sin(APos*4*pi/ADelta))*(ADelta));
         if tmpRes>Round(ADelta) then tmpRes:=Round(ADelta);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;
         {tmpRes:=round(abs(sin(APos*4*pi/ADelta))*(ADelta/2));
         if tmpRes>Round(ADelta/2) then tmpRes:=Round(ADelta/2);
         if tmpRes<0 then tmpRes:=0;
         result:=tmpRes;}
      end;
   else Result:=0;
   end;
end;

end.
