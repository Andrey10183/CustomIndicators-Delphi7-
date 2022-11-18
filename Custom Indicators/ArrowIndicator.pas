unit ArrowIndicator;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls,Graphics,Messages,StdCtrls,CustomTypes;

type
  TOptionScale = (ShowUpperScale,ShowLowerScale,ShowScaleFill,ScaleStretching,
                  ShowNormalRange,ShowAlarmRange,ShowWarningRange, ShowFrame,
                  ShowRoundFrame, ShowCaption);

  TArrowStyle = (as_Simple, as_triangle, as_rectangle);

  TOptionsScale = set of TOptionScale;

  TCoord = record
    XCenter:integer;
    YCenter:integer;
    XRadius:integer;
    YRadius:integer;
  end;

type
  TArrowIndicator = class(TImage)
  private
    { Private declarations }
    FArrRad:integer;
    FOptionsScale:TOptionsScale;
    FCaption:string;
    FRangeWidth:integer;
    FRangeShift:integer;
    FMaxValue:integer;
    FMinValue:integer;
    FNormalRange:Single;
    FWarningRange:Single;
    FAntiAliased: TAntialiased;
    FScaleW:integer;
    FScaleLW:integer;
    FFrameWidth:integer;
    FAngle:integer;
    FLScale:byte;
    FSScale:byte;
    FMeasure:integer;
    FCenterYRel:integer;
    FCenterXRel:integer;
    FRadiusYRel:integer;
    FRadiusXRel:integer;
    FAngle1:single;
    FAngle2:single;
    FValue:single;
    FColArrow:TColor;
    FColArrow2:TColor;
    FColScale:TColor;
    FColorLR:TColor;
    FColorSR:TColor;
    FColBackground:TColor;
    FColNormalRange:TColor;
    FColWarningRange:TColor;
    FColAlarmRange:TColor;
    FColorFrame:TColor;
    FGradStyle:TGradfunc;

    FHeight:integer;
    FWidth:integer;
    FInitState:boolean;
    BitMaptmp:TBitMap;
    ArrowBitMap:TBitMap;
    BitMaptmpEx:TBitMap;
    ArrowBitMapEx:TBitMap;
    FAABitmap:TBitMap;
    FStretching:boolean;
    FColFill1:TColor;
    FColFill2:TColor;
    FArrowWidth:integer;
    FArrowWhole:boolean;
    FArrowLength:integer;
    FDrowCount:integer;
    FArrowStyle:TArrowStyle;
    procedure DrowScale;
    procedure DrowScaleEx(A:TBitMap);
    procedure SetValue(AValue:single);
    procedure SetHeight(AValue:integer);
    procedure SetWidth(AValue:integer);
    procedure ArrowDraw(AVisible:boolean);
    procedure SetColScale(AColor:TColor);
    procedure SetColArrow(AColor:TColor);
    procedure SetColArrow2(AValue:TColor);
    procedure SetColorLR(AColor:TColor);
    procedure SetColorSR(AColor:TColor);
    procedure SetColBackground(AColor:TColor);
    procedure SetLScale(AValue:Byte);
    procedure SetSScale(AValue:Byte);
    procedure SetMaxValue(AValue:integer);
    procedure SetMinValue(AValue:integer);
    procedure SetAngle(AValue:integer);
    procedure SetScaleW(AValue:integer);
    procedure SetStretching(AValue:boolean);
    procedure SetColFill1(AValue:TColor);
    procedure SetColFill2(AValue:TColor);
    procedure SetColorFrame(AValue:TColor);
    procedure SetMeasureLen(AValue:integer);
    procedure SetArrowWidth(AValue:integer);
    procedure SetArrowLength(AValue:integer);
    procedure SetArrowWhole(AValue:boolean);
    procedure SetOptionsScale(AValue:TOptionsScale);
    procedure SetFAntiAliased(AValue: TAntialiased);
    procedure SetNormalRange(AValue: single);
    procedure SetWarningRange(AValue: single);
    procedure SetCaption(AValue: string);
    function GetAAMultipler: Integer;
    function GetParam(A:TBitMap;K:integer):TCoord;
    procedure DrawRanges(A:TBitMap;ASector:byte;x1,y1,x2,y2:integer);
    procedure SetGradientStyle(AValue:TGradfunc);
    procedure SetColNormRange(AValue:TColor);
    procedure SetColWarnRange(AValue:TColor);
    procedure SetColAlarmRange(AValue:TColor);
    procedure SetFrameWidth(AValue:integer);
    procedure SetArrowStyle(AValue:TArrowStyle);
    procedure SetArrowRadius(AValue:integer);
  protected
    { Protected declarations }
    procedure Resize;override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy;override;

  published
    { Published declarations }
    property Value:single read FValue write SetValue;
    property HeightInd:integer read FHeight write SetHeight;
    property WidthInd:integer read FWidth write SetWidth;
    property ColScale:TColor read FColScale write SetColScale;
    property ColArrow:TColor read FColArrow write SetColArrow;
    property ColArrow2:TColor read FColArrow2 Write SetColArrow2;
    property ColorLR:TColor read FColorLR write SetColorLR;
    property ColorSR:TColor read FColorSR write SetColorSR default clRed;
    property ColorFill1:TColor read FColFill1 write setColFill1;
    property ColorFill2:TColor read FColFill2 write setColFill2;
    property ColorFrame:TColor read FColorFrame write SetColorFrame;
    property ColBackground:TColor read FColBackground write SetColBackground;
    property ScaleHiStep:Byte read FLScale write SetLScale;
    property ScaleLoStep:Byte read FSScale write SetSScale;
    property ScaleMaxValue:integer read FMaxValue write SetMaxValue;
    property ScaleMinValue:integer read FMinValue write SetMinValue;
    property Font;
    property ScaleAngle:integer read FAngle write SetAngle;
    property ScaleWidth:integer read FScaleW write SetScaleW;
    property Stretching:boolean read FStretching write SetStretching;
    property ScaleMeasureLen:integer read FMeasure write SetMeasureLen;
    property ArrowWidth:integer read FArrowWidth write SetArrowWidth;
    property ArrowLength:integer read FArrowLength write SetArrowLength;
    property ArrowWhole:boolean read FArrowWhole write SetArrowWhole;
    property OptionsScale:TOptionsScale read FOptionsScale write SetOptionsScale;
    property AntiAliased: TAntialiased read FAntiAliased write SetFAntiAliased;
    property RangeNorm:single read FNormalRange write SetNormalRange;
    property RangeWarning:single read FWarningRange write SetWarningRange;
    property Caption:string read FCaption write SetCaption;
    property GradientStyle:TGradfunc read FGradStyle write SetGradientStyle;
    property ColRNorm:TColor read FColNormalRange write SetColNormRange;
    property ColRWarn:TColor read FColWarningRange write SetColWarnRange;
    property ColRAlarm:TColor read FColAlarmRange write SetColAlarmRange;
    property FrameWidth:integer read FFrameWidth write SetFrameWidth;
    property ArrowStyle:TArrowStyle read FArrowStyle write SetArrowStyle;
    property ArrowRaius:integer read FArrRad write SetArrowRadius;
  end;

procedure Register;

implementation

uses Dialogs,DesignIntf,Windows,Math,Forms;

const
  AngleGain=0.02;

procedure Register;
begin
  RegisterComponents('CustomIndicators', [TArrowIndicator]);
  RegisterPropertyEditor (TypeInfo (integer), TArrowIndicator, 'Height', nil);
  RegisterPropertyEditor (TypeInfo (integer), TArrowIndicator, 'Width', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TArrowIndicator, 'Stretch', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TArrowIndicator, 'Proportional', nil);
  RegisterPropertyEditor (TypeInfo (TPicture), TArrowIndicator, 'Picture', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TArrowIndicator, 'IncrementalDisplay', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TArrowIndicator, 'Center', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TArrowIndicator, 'AutoSize', nil);
end;

const
  PrcD:integer=1000;
  DCF:single = 0.90;

procedure TArrowIndicator.SetFAntiAliased(AValue: TAntialiased);
var
  K: Integer;
begin
   if AValue <> FAntiAliased then
   begin
      FAntiAliased := AValue;
      if FAntiAliased <> aaNone then
      begin
         K := GetAAMultipler;
         BitMaptmpEx.Width := Width * K;
         BitMaptmpEx.Height := Height * K;
         FAABitmap.Width:=Width;
         FAABitmap.Height:=Height;
      end
      else
      begin
         BitMaptmp.Width := Width;
         BitMaptmp.Height := Height;
      end;
      DrowScale;
  end;
end;

procedure TArrowIndicator.SetCaption(AValue: string);
begin
   if FCaption<>AValue then
   begin
      FCaption:=AValue;
      if (csDesigning in ComponentState) then DrowScale;
   end;
   if not (csDesigning in ComponentState) then DrowScale;
end;

procedure TArrowIndicator.SetColorFrame(AValue:TColor);
begin
   if FColorFrame<>AValue then
   begin
      FColorFrame:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetOptionsScale(AValue:TOptionsScale);
begin
  if FOptionsScale<>AValue then
  begin
    FOptionsScale:=AValue;
    DrowScale;
  end;
end;

procedure TArrowIndicator.CMFontChanged;
begin
  inherited;
  DrowScale;
end;

procedure TArrowIndicator.SetArrowLength(AValue:integer);
begin
   if FArrowLength<>AValue then
   begin
      FArrowLength:=AValue;
      if FArrowLength=0 then FArrowWidth:=1;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetArrowWhole(AValue:boolean);
begin
   if FArrowWhole<>AValue then
   begin
      FArrowWhole:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetArrowWidth(AValue:integer);
begin
   if (FArrowWidth<>AValue) then
   begin
      FArrowWidth:=AValue;
      if FArrowWidth=0 then FArrowWidth:=1;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetMeasureLen(AValue:integer);
begin
   if FMeasure<>AValue then
   begin
      FMeasure:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.setColFill1(AValue:TColor);
begin
   if FColFill1<>AValue then
   begin
      FColFill1:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.setColFill2(AValue:TColor);
begin
   if FColFill2<>AValue then
   begin
      FColFill2:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetStretching(AValue:boolean);
begin
   if FStretching<>AValue then
   begin
      FStretching:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetScaleW(AValue:integer);
begin
   if FScaleW<>AValue then
   begin
      if AValue<0 then AValue:=0;
      FScaleW:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetAngle(AValue:integer);
begin
   if FAngle<>AValue then
   begin
      if AValue=0 then FAngle:=1 else FAngle:=AValue;
      if AValue>=360 then FAngle:=359;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetMaxValue(AValue:integer);
begin
   if FMaxValue<>AValue then
   begin
      if AValue<=0 then AValue:=0;
      if AValue<=FMinValue then AValue:=FMinValue+1;
      FMaxValue:=AValue;
      FNormalRange:=(FMinValue+(FMaxValue-FMinValue)*0.7);
      FWarningRange:=(FNormalRange+(FMaxValue-FMinValue)*0.2);
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetMinValue(AValue:integer);
begin
   if FMinValue<>AValue then
   begin
      if AValue>=FMaxValue then AValue:=FMaxValue-1;
      FMinValue:=AValue;
      Value:= FMinValue;
      FNormalRange:=(FMinValue+(FMaxValue-FMinValue)*0.7);
      FWarningRange:=(FNormalRange+(FMaxValue-FMinValue)*0.2);
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetLScale(AValue:Byte);
begin
   if FLScale<>AValue then
   begin
      if AValue=0 then FLScale:=1 else FLScale:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetSScale(AValue:Byte);
begin
   if FSScale<>AValue then
   begin
      if AValue=0 then FSScale:=1 else FSScale:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.Resize;
begin
  inherited Resize;
  if not ((csLoading in ComponentState) or
            (csReading in ComponentState)) then
  if FInitState then
  begin
    BitMapTmp.Height:= Height;
    BitMapTmp.Width:= Width;
    BitMapTmpEx.Height:=GetAAMultipler*Height;
    BitMapTmpEx.Width:=GetAAMultipler*Width;
    FAABitmap.Height:=Height;
    FAABitmap.Width:=Width;

    ArrowBitMap.Height:=Height;
    ArrowBitMap.Width:=Width;
    FWidth:=Width;
    FHeight:=Height;
    DrowScale;
  end;
end;

function TArrowIndicator.GetAAMultipler: Integer;
begin
  case FAntiAliased of
    aaBiline: Result := 2;
    aaTriline: Result := 3;
    aaQuadral: Result := 4;
    else Result := 1
  end
end;

procedure TArrowIndicator.SetColScale(AColor:TColor);
begin
   if FColScale<>AColor then
   begin
      FColScale:=AColor;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColArrow(AColor:TColor);
begin
  if FColArrow<>AColor then
  begin
      FColArrow:=AColor;
      DrowScale;
  end;
end;

procedure TArrowIndicator.SetColorLR(AColor:TColor);
begin
   if FColorLR<>AColor then
   begin
      FColorLR:=AColor;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColorSR(AColor:TColor);
begin
   if FColorSR<>AColor then
   begin
      FColorSR:=AColor;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColBackground(AColor:TColor);
begin
   if FColBackground<>AColor then
   begin
      FColBackground:=AColor;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetHeight(AValue:integer);
begin
   if AValue<>FHeight then
   begin
      BitMapTmp.Height:= AValue;
      BitMapTmpEx.Height:=AValue*GetAAMultipler;
      FAABitmap.Height:=AValue;
      ArrowBitMap.Height:=Avalue;
      FHeight:=AValue;
      Height:=FHeight;
      if FInitState then
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetWidth(AValue:integer);
begin
   if AValue<>FWidth then
   begin
      BitMapTmp.Width:= AValue;
      ArrowBitMap.Width:=AValue;
      BitMapTmpEx.Width:=AValue*GetAAMultipler;
      FAABitmap.Width:=AValue;
      FWidth:=AValue;
      Width:=FWidth;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetValue(AValue:single);
begin
  if AValue>FMaxValue then AValue:= FMaxValue;
  if AValue<FMinValue then AValue:=FMinValue;
  FValue:=AValue;
  ArrowDraw(true);
end;

procedure TArrowIndicator.ArrowDraw;
var
  tmpAngle:real;
  i,il:integer;
  x1,y1:single;
begin
   if FAntiAliased = aaNone then
      BitBlt(ArrowBitMap.Canvas.Handle, 0, 0, BitMapTmp.Width,
         BitMapTmp.Height, BitMapTmp.Canvas.Handle, 0, 0, SRCCOPY) else
      BitBlt(ArrowBitMap.Canvas.Handle, 0, 0, FAABitmap.Width,
         FAABitmap.Height, FAABitmap.Canvas.Handle, 0, 0, SRCCOPY);


   tmpAngle:=FAngle1-(FAngle1-FAngle2)*(1-(FValue-FMinValue)/(FMaxValue-FMinValue));
   ArrowBitMap.Canvas.Pen.Color:=FColArrow;

   case FArrowStyle of
      as_Simple:
         begin
            ArrowBitMap.Canvas.Pen.Width:=FArrowWidth;

            if FArrowWhole then
            begin
               ArrowBitMap.Canvas.MoveTo(Round(FCenterXRel),Round(FCenterYRel));
               ArrowBitMap.Canvas.LineTo(
                  Round(cos(tmpAngle)*((FRadiusXRel)+FScaleW)+(FCenterXRel)),
                  Round(sin(tmpAngle)*((FRadiusYRel)+FScaleW)+(FCenterYRel)));
            end else
            begin
               ArrowBitMap.Canvas.MoveTo(
                  Round(cos(tmpAngle)*(FRadiusXRel-FArrowLength)+FCenterXRel),
                  Round(sin(tmpAngle)*(FRadiusYRel-FArrowLength)+FCenterYRel));
               ArrowBitMap.Canvas.LineTo(
                  Round(cos(tmpAngle)*(FRadiusXRel+FScaleW)+FCenterXRel),
                  Round(sin(tmpAngle)*(FRadiusYRel+FScaleW)+FCenterYRel));
            end;
         end;
      as_triangle:
         begin
            ArrowBitMap.Canvas.Pen.Width:=2;
            ArrowBitMap.Canvas.Brush.Color:=FColArrow;
            for i:=0 to FArrRad do
            begin
               il:=GetGradPos(FArrRad,i,gf_Linear);
               ArrowBitMap.Canvas.Pen.Color:=GetGradColor(FColArrow,FColArrow2,FArrRad,il);
               if (FCenterYRel<FHeight-FArrRad) and ArrowWhole then
               begin
                  ArrowBitMap.Canvas.MoveTo(
                     Round(cos(tmpAngle+pi/2)*i+(FCenterXRel)),
                     Round(sin(tmpAngle+pi/2)*i+(FCenterYRel)));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle-pi/2)*i+(FCenterXRel)),
                     Round(sin(tmpAngle-pi/2)*i+(FCenterYRel)));
               end else
               begin
                  {ArrowBitMap.Canvas.MoveTo(
                     Round(cos(tmpAngle+i/700*(FAngle1-FAngle2))*(FRadiusXRel-1*FRangeShift-8*FMeasure-FArrowLength)+(FCenterXRel)),
                     Round(sin(tmpAngle+i/700*(FAngle1-FAngle2))*(FRadiusXRel-1*FRangeShift-8*FMeasure-FArrowLength)+(FCenterYRel)));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle-i/700*(FAngle1-FAngle2))*(FRadiusXRel-1*FRangeShift-8*FMeasure-FArrowLength)+(FCenterXRel)),
                     Round(sin(tmpAngle-i/700*(FAngle1-FAngle2))*(FRadiusXRel-1*FRangeShift-8*FMeasure-FArrowLength)+(FCenterYRel)));}
                  x1:=Round(cos(tmpAngle+pi/2)*i);
                  y1:=Round(sin(tmpAngle+pi/2)*i);
                  ArrowBitMap.Canvas.MoveTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure-FArrowLength)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure-FArrowLength)+(FCenterYRel)+y1));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));
                  x1:=Round(cos(tmpAngle-pi/2)*i);
                  y1:=Round(sin(tmpAngle-pi/2)*i);
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure-FArrowLength)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure-FArrowLength)+(FCenterYRel)+y1));
               end;

               if (FCenterYRel<FHeight-FArrRad) and ArrowWhole then ArrowBitMap.Canvas.Ellipse(
                  Round(FCenterXRel-(FArrRad*0.8)),Round(FCenterYRel-(FArrRad*0.8)),
                  Round(FCenterXRel+(FArrRad*0.8)),Round(FCenterYRel+(FArrRad*0.8)));
            end;
         end;
      as_rectangle:
         begin
            ArrowBitMap.Canvas.Pen.Width:=2;
            ArrowBitMap.Canvas.Brush.Color:=FColArrow;
            for i:=0 to FArrRad do
            begin
               if (FCenterYRel<FHeight-FArrRad) and ArrowWhole then
               begin
               il:=GetGradPos(FArrRad,i,gf_Linear);
               ArrowBitMap.Canvas.Pen.Color:=GetGradColor(FColArrow,FColArrow2,FArrRad,il);
               x1:=cos(tmpAngle+pi/2)*i;
               y1:=sin(tmpAngle+pi/2)*i;
               ArrowBitMap.Canvas.MoveTo(
                     Round(x1+(FCenterXRel)),
                     Round(y1+(FCenterYRel)));
               ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-8*FMeasure)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-8*FMeasure)+(FCenterYRel)+y1));
               ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));

               x1:=cos(tmpAngle-pi/2)*i;
               y1:=sin(tmpAngle-pi/2)*i;
               ArrowBitMap.Canvas.MoveTo(
                     Round(x1+(FCenterXRel)),
                     Round(y1+(FCenterYRel)));
               ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-8*FMeasure)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-8*FMeasure)+(FCenterYRel)+y1));
               ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));
               end else
               begin
                  il:=GetGradPos(FArrRad,i,gf_Linear);
                  ArrowBitMap.Canvas.Pen.Color:=GetGradColor(FColArrow,FColArrow2,FArrRad,il);
                  x1:=cos(tmpAngle+pi/2)*i;
                  y1:=sin(tmpAngle+pi/2)*i;
                  ArrowBitMap.Canvas.MoveTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-5*FMeasure-FArrowLength)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-5*FMeasure-FArrowLength)+(FCenterYRel)+y1));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-5*FMeasure)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-5*FMeasure)+(FCenterYRel)+y1));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));

                  x1:=cos(tmpAngle-pi/2)*i;
                  y1:=sin(tmpAngle-pi/2)*i;
                  ArrowBitMap.Canvas.MoveTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-5*FMeasure-FArrowLength)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-5*FMeasure-FArrowLength)+(FCenterYRel)+y1));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-5*FMeasure)+(FCenterXRel)+x1),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-5*FMeasure)+(FCenterYRel)+y1));
                  ArrowBitMap.Canvas.LineTo(
                     Round(cos(tmpAngle)*(FRadiusXRel-1*FRangeShift-3*FMeasure)+(FCenterXRel)),
                     Round(sin(tmpAngle)*(FRadiusYRel-1*FRangeShift-3*FMeasure)+(FCenterYRel)));
               end;
            end;
            if (FCenterYRel<FHeight-FArrRad) and ArrowWhole then ArrowBitMap.Canvas.Ellipse(
                  Round(FCenterXRel-(FArrRad*1)),Round(FCenterYRel-(FArrRad*1)),
                  Round(FCenterXRel+(FArrRad*1)),Round(FCenterYRel+(FArrRad*1)));
         end;
   end;

   Picture.Bitmap:=ArrowBitMap;
   //Canvas.Draw(0, 0, ArrowBitMap);
end;

destructor TArrowIndicator.Destroy;
begin
  inherited Destroy;
end;

constructor TArrowIndicator.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  BitMapTmp:=Graphics.TBitMap.Create;     BitMapTmp.Transparent:=true;
  ArrowBitMap:=Graphics.TBitMap.Create;   ArrowBitMap.Transparent:=true;
  BitMaptmpEx:=Graphics.TBitMap.Create;   BitMaptmpEx.Transparent:=true;
  ArrowBitMapEx:=Graphics.TBitMap.Create; ArrowBitMapEx.Transparent:=true;
  FAABitmap:=Graphics.TBitMap.Create;     FAABitmap.Transparent:=true;
  FAABitmap.Width:=Width;
  FAABitmap.Height:=Height;
  BitMaptmpEx.PixelFormat := pf24bit;
  ArrowBitMapEx.PixelFormat := pf24bit;
  FAABitmap.PixelFormat := pf24bit;
  FInitState:=false;

  FDrowCount:=0;
  FCaption:='mV';
  FAntiAliased:=aaNone;
  Transparent:=true;
  FOptionsScale:=[ShowLowerScale,ShowScaleFill,
                  ShowNormalRange,ShowAlarmRange,ShowWarningRange];

  FColScale:=clSkyBlue;
  FColorLR:=clSkyBlue;
  FColorSR:=clSkyBlue;
  FColorFrame:=clWhite;
  FFrameWidth:=1;
  FColBackground:=clBlack;
  FColNormalRange:=clGreen;
  FColWarningRange:=clYellow;
  FColAlarmRange:=clRed;
  Height:=249;
  Width:=273 ;
  FHeight:=Height;
  FWidth:=Width;
  BitMapTmp.Height:=Height;
  BitMapTmp.Width:=Width;
  ArrowBitMap.Height:=Height;
  ArrowBitMap.Width:=Width;
  FScaleW:=10;
  FScaleLW:=2;
  FAngle:=250;
  FMaxValue:=50;
  FMinValue:=0;
  FRangeWidth:=2;
  FRangeShift:=8;
  FNormalRange:=(FMinValue+(FMaxValue-FMinValue)*0.7);
  FWarningRange:=(FNormalRange+(FMaxValue-FMinValue)*0.2);
  FGradStyle:=gf_linear;

  FLScale:=10;
  FSScale:=4;
  FMeasure:=5;
  FArrowWidth:=1;
  FArrowWhole:=true;
  FArrowLength:=20;
  FValue:=FMinValue;
  FArrRad:=10;
  FArrowStyle:=as_Simple;
  FColArrow:=clSilver;
  FColArrow2:=$00292929;

  BitMapTmp.Canvas.Font.Name:='Calibri';
  BitMapTmp.Canvas.Font.Size:=12;
  Font:=BitMapTmp.Canvas.Font;
  Font.Color:=clWhite;
  FStretching:=false;
  FColFill1:=$00800040;
  FColFill2:=$00408000;

  FInitState:=true;
end;

procedure TArrowIndicator.DrowScale;
var
  T:TCoord;
begin
  if FAntiAliased=aaNone then
  begin
    DrowScaleEx(BitMapTmp);
  end else
  begin
    DrowScaleEx(BitMapTmpEx);
    FastAntiAliasPicture(GetAAMultipler,BitMapTmpEx,FAABitmap);
  end;
  T:=GetParam(ArrowBitMap,1);
  FCenterYRel:=T.YCenter;
  FCenterXRel:=T.XCenter;
  FRadiusYRel:=T.YRadius;
  FRadiusXRel:=T.XRadius;
  ArrowDraw(true);
end;

procedure TArrowIndicator.DrowScaleEx;
  function CorrX(AAngle:single;AString:string):integer;
  const
   Zone:single=pi/10;
  begin
    Result:=0;
    if (AAngle>=0) and (AAngle<pi/2-Zone) then
      Result:=0;
    if (AAngle>=pi/2-Zone) or (AAngle<pi/2+Zone)then
      Result:=-1*(A.Canvas.TextWidth(AString) div 2);
    if (AAngle>pi/2+Zone) and (AAngle<pi) then
      Result:=-1*A.Canvas.TextWidth(AString);
    if (AAngle>=pi) and (AAngle<3*pi/2-Zone) then
      Result:=-1*A.Canvas.TextWidth(AString);;
    if (AAngle>=3*pi/2-Zone) and (AAngle<=3*pi/2+Zone) then
      Result:=-1*(A.Canvas.TextWidth(AString) div 2);
    if (AAngle>3*pi/2+Zone) and (AAngle<=2*pi{+Zone}) then
      Result:=0;
    if (AAngle>2*pi) and (AAngle<=2.5*pi-{0.1}Zone) then
      Result:=0;
      if (AAngle>2.5*pi-Zone) and (AAngle<=2.5*pi+Zone) then
    Result:=-1*(A.Canvas.TextWidth(AString) div 2);
end;

  function CorrY(AAngle:single;AString:string):integer;
  const
   Zone:single=pi/10;
  begin
    Result:=0;
    if (AAngle>=0) and (AAngle<Zone) then
    Result:=-1*(A.Canvas.TextHeight(AString) div 2);
    if (AAngle>=0+Zone) and (AAngle<pi/2) then
      Result:=0;
    if (AAngle>=pi/2) and (AAngle<pi-Zone) then
      Result:=0;
    if (AAngle>=pi-Zone) and (AAngle<pi+Zone) then
    Result:=-1*(A.Canvas.TextHeight(AString) div 2);
    if (AAngle>=pi+Zone) and (AAngle<3*pi/2) then
      Result:=-1*A.Canvas.TextHeight(AString);
    if (AAngle>=3*pi/2) and (AAngle<=2*pi-Zone) then
      Result:=-1*A.Canvas.TextHeight(AString);
    if (AAngle>=2*pi-Zone) and (AAngle<2*pi+Zone) then
    Result:=-1*(A.Canvas.TextHeight(AString) div 2);
  end;

var
  i,il:integer;
  tmpAngle,tmpAngle1,
  tmpAngleMin,tmpAngleWarn:single;
  tmpStr:string;
  DeltaAngle:single;
  TmpColor:TColor;
  K:integer;
  T:TCoord;
  CosA,SinA:single;
begin
  inc(FDrowCount);
  K:=GetAAMultipler;
  A.Canvas.Refresh;

  A.Canvas.Brush.Style:=bsClear;
  if Assigned(Parent) then
  begin
   A.Canvas.Brush.Color:=TPeekAtControl(Parent).Color;
   A.Canvas.Pen.Color:= TPeekAtControl(Parent).Color ;
  end;
  A.Canvas.Pen.Width:=1;
  A.Canvas.Rectangle(0,0,A.Width,A.Height);


  if ShowFrame in FOptionsScale then
  begin
      A.Canvas.Pen.Width:=FFrameWidth*K;
      A.Canvas.Pen.Color:=FColorFrame;
      if ShowRoundFrame in FOptionsScale then A.Canvas.RoundRect(2*K,2*K,A.Width-2*K,A.Height-2*K,20*K,20*K)
      else A.Canvas.Rectangle(2*K,2*K,A.Width-2*K,A.Height-2*K);
      A.Canvas.Pen.Width:=1;
      if Assigned(Parent) then A.Canvas.Pen.Color:=TPeekAtControl(Parent).Color;
      A.Canvas.MoveTo(0,0);A.Canvas.LineTo(Width,0);
      A.Canvas.LineTo(Width,Height);
      A.Canvas.LineTo(0,Height);
      A.Canvas.LineTo(0,0);
  end;

  A.Canvas.Font:=Font;
  A.Canvas.Font.Size:=A.Canvas.Font.Size*K;

  FAngle1:=(3*pi+{Grad2Rad(FAngle)}DegToRad(FAngle))/2;
  FAngle2:=FAngle1-{Grad2Rad(FAngle)}DegToRad(FAngle);

  T:=GetParam(A,K);
  FCenterYRel:=T.YCenter;
  FCenterXRel:=T.XCenter;
  FRadiusYRel:=T.YRadius;
  FRadiusXRel:=T.XRadius;

 
  for i:=0 to PrcD do
  begin
    A.Canvas.Pen.Width:=2;
    tmpAngle:=-1*i*(FAngle1-FAngle2)/PrcD+FAngle1;
    SinA:=sin(tmpAngle);CosA:=cos(tmpAngle);
    if ShowScaleFill in FOptionsScale then
    begin
      A.Canvas.Pen.Width:=2*K;
      il:=GetGradPos(PrcD,i,FGradStyle);
      A.Canvas.Pen.Color:=GetGradColor(FColFill1,FColFill2,PrcD,il);


      A.Canvas.MoveTo(
          Round(CosA*FRadiusXRel+FCenterXRel),
          Round(SinA*FRadiusYRel+FCenterYRel));
      A.Canvas.LineTo(
          Round(CosA*(FRadiusXRel+K*FScaleW)+FCenterXRel),
          Round(SinA*(FRadiusYRel+K*FScaleW)+FCenterYRel));
    end;
  end;

  if ShowLowerScale in FOptionsScale then
  begin
    A.Canvas.Pen.Color:=FColScale;
    A.Canvas.Pen.Width:=FScaleLW*K;
    A.Canvas.Arc
      (FCenterXRel-(FRadiusXRel),FCenterYRel-(FRadiusYRel),
      FCenterXRel+(FRadiusXRel),FCenterYRel+(FRadiusYRel),
      Round(cos(FAngle1)*(FRadiusXRel)+FCenterXRel),
      Round(sin(FAngle1)*(FRadiusYRel)+FCenterYRel),
      Round(cos(FAngle2)*(FRadiusXRel)+FCenterXRel),
      Round(sin(FAngle2)*(FRadiusYRel)+FCenterYRel));
  end;

  if ShowUpperScale in FOptionsScale then
  begin
    A.Canvas.Pen.Color:=FColScale;
    A.Canvas.Pen.Width:=FScaleLW*K;
    A.Canvas.Arc
      (FCenterXRel-(FRadiusXRel+K*FScaleW),FCenterYRel-(FRadiusYRel+K*FScaleW),
      FCenterXRel+(FRadiusXRel+K*FScaleW),FCenterYRel+(FRadiusYRel+K*FScaleW),
      Round(cos(FAngle1)*(FRadiusXRel)+FCenterXRel),
      Round(sin(FAngle1)*(FRadiusYRel)+FCenterYRel),
      Round(cos(FAngle2)*(FRadiusXRel)+FCenterXRel),
      Round(sin(FAngle2)*(FRadiusYRel)+FCenterYRel));
  end;

  if ShowNormalRange in FOptionsScale then
  begin
    DrawRanges(A,0,
      FCenterXRel-(FRadiusXRel-K*FRangeShift),FCenterYRel-(FRadiusYRel-K*FRangeShift),
      FCenterXRel+(FRadiusXRel-K*FRangeShift),FCenterYRel+(FRadiusYRel-K*FRangeShift));
  end;

  if ShowWarningRange in FOptionsScale then
  begin
    DrawRanges(A,1,
      FCenterXRel-(FRadiusXRel-K*FRangeShift),FCenterYRel-(FRadiusYRel-K*FRangeShift),
      FCenterXRel+(FRadiusXRel-K*FRangeShift),FCenterYRel+(FRadiusYRel-K*FRangeShift));
  end;

  if ShowAlarmRange in FOptionsScale then
  begin
    DrawRanges(A,2,
      FCenterXRel-(FRadiusXRel-K*FRangeShift),FCenterYRel-(FRadiusYRel-K*FRangeShift),
      FCenterXRel+(FRadiusXRel-K*FRangeShift),FCenterYRel+(FRadiusYRel-K*FRangeShift));
  end;


  for i:=0 to (FLScale*FSScale) do
  begin
      tmpAngle1:=(FAngle1-FAngle2)/(FLScale*FSScale)*i*-1+FAngle1;
      CosA:=cos(tmpAngle1);SinA:=sin(tmpAngle1);
      if ((i mod FSScale)=0) or (i=0) then
      begin
         A.Canvas.Pen.Color:=FColorLR;
         A.Canvas.Pen.Width:=2*K;
         A.Canvas.MoveTo(
            Round(CosA*FRadiusXRel+FCenterXRel),
            Round(SinA*FRadiusYRel+FCenterYRel));
         A.Canvas.LineTo(
            Round(CosA*(FRadiusXRel+K*FScaleW+K*FMeasure)+FCenterXRel),
            Round(SinA*(FRadiusYRel+K*FScaleW+K*FMeasure)+FCenterYRel));

         tmpStr:=FloatToStr(RoundTo(FMaxValue-(FMaxValue-FMinValue)*i/(FSScale*FLScale),-2));
         SetBkMode(A.Canvas.Handle, Windows.TRANSPARENT);
         A.Canvas.TextOut( Round(CosA*(FRadiusXRel+K*FScaleW+K*FMeasure)+FCenterXRel+CorrX(tmpAngle1,tmpstr)),
                           Round(SinA*(FRadiusYRel+K*FScaleW+K*FMeasure)+FCenterYRel+Corry(tmpAngle1,tmpstr)),
                           tmpStr);

      end else
      begin
         A.Canvas.Pen.Color:=FColorSR;
         A.Canvas.Pen.Width:=1*K;
         A.Canvas.MoveTo(
            Round(CosA*FRadiusXRel+FCenterXRel),
            Round(SinA*FRadiusYRel+FCenterYRel));
         A.Canvas.LineTo(
            Round(CosA*(FRadiusXRel+K*FScaleW)+FCenterXRel),
            Round(SinA*(FRadiusYRel+K*FScaleW)+FCenterYRel));
      end;
   end;

  if ShowCaption in FOptionsScale then
  if FAngle>=180 then
   A.Canvas.TextOut(
      FCenterXRel-A.Canvas.TextWidth(FCaption) div 2,
      FCenterYRel-((FRadiusYRel-K*FRangeShift) div 2)- A.Canvas.TextHeight('0') div 2,
      FCaption)
  else
   A.Canvas.TextOut(
      FCenterXRel-A.Canvas.TextWidth(FCaption) div 2,
      round(FCenterYRel-((FRadiusYRel-K*FRangeShift)-0.4*FAngle*(FRadiusYRel-K*FRangeShift)/360)- A.Canvas.TextHeight('0')/2),
      FCaption);

  if Assigned(Self.Parent) then
  begin
      if not Self.Parent.DoubleBuffered then Self.Parent.DoubleBuffered:=true;
  end;
end;

function TArrowIndicator.GetParam;
  function WS(AValue:integer):integer;
  begin
    If A.Height>A.Width then Result:=AValue-Round(A.Width-A.Width*DCF) else Result:=AValue-Round(A.Height-A.Height*DCF);
  end;
  function CX:integer;
  begin
    Result:=A.Width div 2;
  end;
var
  Delta:single;
  T:TCoord;
  CosA,SinA:single;
begin
  CosA:=cos(FAngle1);SinA:=sin(FAngle1);
  if ScaleStretching in FOptionsScale then
  begin
    if FAngle>180 then T.XRadius:= Round((WS(A.Width)-K*FScaleW*(1-CosA)-K*FMeasure*(1-CosA)-A.Canvas.TextWidth(inttostr(FMaxValue))*(1-CosA))/2-K*FScaleW-A.Canvas.TextWidth(inttostr(FMaxValue))-K*FMeasure)
    else T.XRadius:=Round((WS(A.Width)-K*FScaleW*(1-CosA)-K*FMeasure*(1-CosA)-A.Canvas.TextWidth(inttostr(FMaxValue))*(1-CosA))/(2*CosA)-K*FScaleW-A.Canvas.TextWidth(inttostr(FMaxValue))-K*FMeasure);
    T.XCenter:=CX;
    if FAngle>180 Then
      T.YRadius:=Round((WS(A.Height)-K*FScaleW*(1+SinA)-K*FMeasure*(1+SinA)-(A.Canvas.TextHeight('0')/cos(pi/2-FAngle1))*(1*SinA)-(A.Canvas.TextHeight('0')))/(1+SinA))
    else
      T.YRadius:=Round((WS(A.Height)-K*FScaleW-K*FMeasure-A.Canvas.TextHeight('0'))/(1+SinA));
      T.YCenter:=Round((A.Height-WS(A.Height))/2+T.YRadius+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure);
   end else
   begin
    if FAngle>180 then T.XRadius:= Round((WS(A.Width)-K*FScaleW*(1-CosA)-K*FMeasure*(1-CosA)-A.Canvas.TextWidth(inttostr(FMaxValue))*(1-CosA))/2-K*FScaleW-A.Canvas.TextWidth(inttostr(FMaxValue))-K*FMeasure)
    else T.XRadius:=Round((WS(A.Width)-K*FScaleW*(1-CosA)-K*FMeasure*(1-CosA)-A.Canvas.TextWidth(inttostr(FMaxValue))*(1-CosA))/(2*CosA)-K*FScaleW-A.Canvas.TextWidth(inttostr(FMaxValue))-K*FMeasure);
    T.XCenter:=CX;
    T.YRadius:=T.XRadius;
    If FAngle<=180 then
      Delta:=T.YRadius*(1+SinA)+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure
    else
      Delta:=(1+SinA)*(T.YRadius+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure);

    if Delta>WS(A.Height) then
    begin
      if FAngle>180 then T.YRadius:= Round((WS(A.Height)-(1+SinA)*(K*FScaleW+K*FMeasure)-2*A.Canvas.TextHeight('0'))/(1+SinA))
      else T.YRadius:= Round((WS(A.Height)-K*FScaleW-K*FMeasure-A.Canvas.TextHeight('0'))/(1+SinA));
      T.XRadius:= T.YRadius;

      If FAngle<=180 then
      Delta:=T.YRadius*(1+SinA)+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure
      else
      Delta:=(1+SinA)*(T.YRadius+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure);
    end;
    T.YCenter:=Round((A.Height-WS(A.Height))/2+(WS(A.Height)-Delta)/2+T.YRadius+K*FScaleW+A.Canvas.TextHeight('0')+K*FMeasure);
  end;
  Result:=T;
end;

procedure TArrowIndicator.DrawRanges;
var
   Angle1,Angle2:single;
   tmpAngleMin,tmpAngleWarn,DeltaAngle:single;
   K:integer;
   CosA1,SinA1:single;
   CosA2,SinA2:single;
begin
   Angle1:=0;Angle2:=0;
   K:=GetAAMultipler;

   tmpAngleMin:=FAngle1-abs(FAngle1-FAngle2)*(1-(FNormalRange-FMinValue)/(FMaxValue-FMinValue));
   tmpAngleWarn:=FAngle1-abs(FAngle1-FAngle2)*(1-(FWarningRange-FMinValue)/(FMaxValue-FMinValue));

   DeltaAngle:=abs(FAngle1-FAngle2);
   case ASector of
   0: begin
         Angle1:= FAngle2;
         if ShowWarningRange in OptionsScale then
            Angle2:= tmpAngleMin-DeltaAngle*AngleGain else
               if ShowAlarmRange in OptionsScale then Angle2:= tmpAngleWarn-DeltaAngle*AngleGain else Angle2:=FAngle1;

         A.Canvas.Pen.Color:=FColNormalRange;
      end;
   1: begin
         if ShowNormalRange in OptionsScale then Angle1:= tmpAngleMin else Angle1:=FAngle2;
         if ShowAlarmRange in OptionsScale then
            Angle2:= tmpAngleWarn-DeltaAngle*AngleGain else Angle2:=FAngle1;
         A.Canvas.Pen.Color:=FColWarningRange;
      end;
   2: begin
         {Angle1:= tmpAngleWarn;
         Angle2:=FAngle1;
         A.Canvas.Pen.Color:=FColAlarmRange;}

         Angle1:= tmpAngleWarn;
         if not(ShowNormalRange in OptionsScale) and not (ShowWarningRange in OptionsScale) then Angle1:=FAngle2;
         Angle2:=FAngle1;
         A.Canvas.Pen.Color:=FColAlarmRange;
      end;
   end;

   CosA1:=cos(Angle1);SinA1:=sin(Angle1);
   CosA2:=cos(Angle2);SinA2:=sin(Angle2);
   A.Canvas.Pen.Width:=3*K;
   if Angle2<>Angle1 then
   if Angle2>Angle1 then
   A.Canvas.Arc
      (x1,y1,x2,y2,
      Round(CosA2*(FRadiusXRel)+FCenterXRel),
      Round(SinA2*(FRadiusYRel)+FCenterYRel),
      Round(CosA1*(FRadiusXRel)+FCenterXRel),
      Round(SinA1*(FRadiusYRel)+FCenterYRel)) else
      A.Canvas.Arc
      (x1,y1,x2,y2,
      Round(CosA1*(FRadiusXRel)+FCenterXRel),
      Round(SinA1*(FRadiusYRel)+FCenterYRel),
      Round(CosA2*(FRadiusXRel)+FCenterXRel),
      Round(SinA2*(FRadiusYRel)+FCenterYRel));

   A.Canvas.MoveTo(
      Round(CosA1*(FRadiusXRel-K*FRangeShift)+FCenterXRel),
      Round(SinA1*(FRadiusYRel-K*FRangeShift)+FCenterYRel));
   A.Canvas.LineTo(
      Round(CosA1*(FRadiusXRel-K*FRangeShift-K*FMeasure)+FCenterXRel),
      Round(SinA1*(FRadiusYRel-K*FRangeShift-K*FMeasure)+FCenterYRel));
   A.Canvas.MoveTo(
      Round(CosA2*(FRadiusXRel-K*FRangeShift)+FCenterXRel),
      Round(SinA2*(FRadiusYRel-K*FRangeShift)+FCenterYRel));
   A.Canvas.LineTo(
      Round(CosA2*(FRadiusXRel-K*FRangeShift-K*FMeasure)+FCenterXRel),
      Round(SinA2*(FRadiusYRel-K*FRangeShift-K*FMeasure)+FCenterYRel));
end;

procedure TArrowIndicator.SetNormalRange(AValue: single);
begin
   {if FNormalRange<>AValue then
   begin
      FNormalRange:=AValue;
      If AValue>=FWarningRange then FNormalRange:=FWarningRange-(FMaxValue-FMinValue)*(0.01);
      if AValue<FMinValue+(FMaxValue-FMinValue)*(0.01) then FNormalRange:=FMinValue+(FMaxValue-FMinValue)*(0.01);
      DrowScale;
   end;}
   if FNormalRange<>AValue then
   begin
      FNormalRange:=AValue;
      If AValue>=FWarningRange then FWarningRange:=FNormalRange+(FMaxValue-FMinValue)*(0.01);
      if AValue<FMinValue+(FMaxValue-FMinValue)*(0.01) then FNormalRange:=FMinValue+(FMaxValue-FMinValue)*(0.01);
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetWarningRange(AValue: single);
begin
   if FWarningRange<>AValue then
   begin
      FWarningRange:=AValue;
      if AValue<=FMinValue+(FMaxValue-FMinValue)*(0.01)*2 then FWarningRange:=FMinValue+(FMaxValue-FMinValue)*(0.01)*2;
      if AValue>=FMaxValue then FWarningRange:= FMaxValue-(0.01)*(FMaxValue-FMinValue);
      if AValue<=FNormalRange then FNormalRange:=FWarningRange-(0.01)*(FMaxValue-FMinValue);
      DrowScale;
   end;
   {if FWarningRange<>AValue then
   begin
      FWarningRange:=AValue;
      if AValue>=FMaxValue then FWarningRange:= FMaxValue-(0.01)*(FMaxValue-FMinValue);
      if AValue<=FNormalRange then FWarningRange:=FNormalRange+(0.01)*(FMaxValue-FMinValue);
      DrowScale;
   end;}
end;

procedure TArrowIndicator.SetGradientStyle(AValue:TGradfunc);
begin
   if AValue<>FGradStyle then
   begin
      FGradStyle:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColNormRange(AValue:TColor);
begin
   if FColNormalRange<>AValue then
   begin
      FColNormalRange:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColWarnRange(AValue:TColor);
begin
   if FColWarningRange<>AValue then
   begin
      FColWarningRange:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColAlarmRange(AValue:TColor);
begin
   if FColAlarmRange<>AValue then
   begin
      FColAlarmRange:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetFrameWidth(AValue:integer);
begin
   if FFrameWidth<>AValue then
   begin
      if AValue<=0 then AValue:=1;
      FFrameWidth:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetArrowStyle(AValue:TArrowStyle);
begin
   if FArrowStyle<>AValue then
   begin
      FArrowStyle:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetArrowRadius(AValue:integer);
begin
   if FArrRad <>AValue then
   begin
      if AValue<=0 then AValue:=1;
      FArrRad:=AValue;
      DrowScale;
   end;
end;

procedure TArrowIndicator.SetColArrow2(AValue:TColor);
begin
   if FColArrow2<>AValue then
   begin
      FColArrow2:=AValue;
      DrowScale;
   end;
end;

end.

