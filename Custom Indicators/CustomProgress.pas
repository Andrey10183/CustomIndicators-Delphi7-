unit CustomProgress;

interface

uses
    Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Graphics, Math,StdCtrls,CustomTypes;

type
   TDirection = (d_Up, d_Down, d_Right, d_left, d_rot);
   TCustomShape  =(sh_Rect,sh_Circule,sh_RoundRect);
   TLevelBehavior = (lb_CompletelyColored,lb_PartlyColored);
type
   TLevelSettings = record
      LevelActive:boolean;
      LevelShow:boolean;
      Level:integer;
   end;

    TCustomProgress = class(TImage)
    private
      FHeight:integer;
      FWidth:integer;
      FValue:integer;
      FRadiusX:integer;
      FRadiusY:integer;
      FCenterX:integer;
      FCenterY:integer;
      FUnitName:string;
      FShowCaption:boolean;
      FShowFrame:boolean;
      FAntiAliased:TAntialiased;
      FRadius:integer;
      FRadR:integer;
      FLevel1,FLevel2:integer;
      FLvl1Active,FLvl2Active:boolean;
      FShowLvl1,FShowLvl2:boolean;

      FShape:TCustomShape;
      FDirection:TDirection;
      BitMaptmp:TBitMap;
      BitMaptmpEx:TBitMap;
      FAABitmap:TBitMap;
      FInitialState:boolean;
      FCol1:TColor;
      FCol1Sec:TColor;
      FCol2:TColor;
      FCol2Sec:TColor;
      FCol3:TColor;
      FCol3Sec:TColor;
      FColorFrame:TColor;
      FLvl1Col,FLvl2Col:TColor;
      FCol1Acsept:TColor;
      FCol1SecAcsept:TColor;
      FCol2Acsept:TColor;
      FCol2SecAcsept:TColor;
      FCol3Acsept:TColor;
      FCol3SecAcsept:TColor;
      FFrameWidth:integer;
      FMult:integer;
      FFont:TFont;
      FDBuff:boolean;
      FLevelBehavior:TLevelBehavior;
      FLevel:TLevelSettings;
      FGradStyle:TGradfunc;
      FCol12,FCol12Sec,FCol23,FCol23Sec:TColor;

      {A1,B,C,D:integer;}

      FSP,FXDEP,FYDEP,FXEP,FYEP:integer;
      { Private declarations }
      procedure DrawProgress;
      procedure DrawProgressEx(var A:TBitMap);
      procedure SetValue(AValue:integer);
      procedure SetHeight(AValue:integer);
      procedure SetWidth(AValue:integer);
      procedure SetDirection(AValue:TDirection);

      procedure SetUnitName(AValue:String);
      procedure SetShowCaption(AValue:boolean);
      procedure SetCustomShape(AValue:TCustomShape);
      procedure SetShowFrame(AValue:boolean);
      procedure SetCol1(AValue:TColor);
      procedure SetCol1Sec(AValue:TColor);
      procedure SetCol2(AValue:TColor);
      procedure SetCol2Sec(AValue:TColor);
      procedure SetCol3(AValue:TColor);
      procedure SetCol3Sec(AValue:TColor);
      procedure SetColorFrame(AValue:TColor);
      procedure SetFrameWidth(AValue:integer);
      procedure SetRadius(AValue:integer);
      procedure XDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure YDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure RDraw(A:TBitMap);
      procedure RLDraw(A:TBitMap);
      procedure RRDraw(A:TBitMap);
      procedure XLDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure YLDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure RRXDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure RRYDraw(A:TBitMap;AStartPoint,ASign:Integer);
      procedure CalculateParam;
      function GetAAMultipler: Integer;
      procedure SetFAntiAliased(AValue:TAntialiased);
      procedure SetDBuff(AValue:boolean);
      procedure SetLevelBehavior(AValue:TLevelBehavior);
      procedure SetLevel1(AValue:integer);
      procedure SetLevel2(AValue:integer);
      procedure SetLevel1Show (AValue:boolean);
      procedure SetLevel2Show (AValue:boolean);
      procedure SetLevel(AValue:TLevelSettings);
      procedure SetGradientStyle(AValue:TGradfunc);
      function GetCurrGradCol(AMaxVal,APos,AVal,ALvl1,ALvl2,AMaxGrad,AGrad:integer):TColor;
      procedure GradColCalculate(AMaxVal,AVal,ALvl1,ALvl2:integer);
      procedure ShowLvlLine(A:TBitMap;AColor:TColor;AActive,AVisible:boolean;x1,y1,x2,y2:integer);
      function GetRectCoord(AValue,A,B,C,D:integer):TPoint;
      function GetRoundRectCoord(AValue,A,B,C,D:integer):TPoint;
      procedure SetCurrentColors;
      procedure SetLvl1Active(AValue:boolean);
      procedure SetLvl2Active(AValue:boolean);
      procedure SetLvl1Col(AValue:TColor);
      procedure SetLvl2Col(AValue:TColor);
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
      property Value:integer read FValue write SetValue;
      property HeightInd:integer read FHeight write SetHeight;
      property WidthInd:integer read FWidth write SetWidth;
      property Direction:TDirection read FDirection write SetDirection;
      property Col1:TColor read FCol1Acsept write SetCol1;
      property Col1Sec:TColor read FCol1SecAcsept write SetCol1Sec;
      property Col2:TColor read FCol2Acsept write SetCol2;
      property Col2Sec:TColor read FCol2SecAcsept write SetCol2Sec;
      property Col3:TColor read FCol3Acsept write SetCol3;
      property Col3Sec:TColor read FCol3SecAcsept write SetCol3Sec;
      property Font;
      property UnitName:string read FUnitName write SetUnitName;
      property ShowCaption:boolean read FShowCaption write SetShowCaption;
      property Shape:TCustomShape read FShape write SetCustomShape;
      property ShowFrame:boolean read FShowFrame write SetShowFrame;
      property FRameWidth:integer read FFrameWidth write SetFrameWidth;

      property ColorFarame:TColor read FColorFrame write SetColorFrame;
      property Radius:integer read FRadius write SetRadius;
      property AntiAliased: TAntialiased read FAntiAliased write SetFAntiAliased;
      property DblBuffered:boolean read FDBuff write SetDBuff;
      property LevelBehavior:TLevelBehavior read FLevelBehavior write SetLevelBehavior;
      property Level1:integer read FLevel1 write SetLevel1;
      property Level2:integer read FLevel2 write SetLevel2;
      property Level1Show:boolean read FShowLvl1 write SetLevel1Show;
      property Level2Show:boolean read FShowLvl2 write SetLevel2Show;
      property GradientStyle:TGradfunc read FGradStyle write SetGradientStyle;
      property Level:TLevelSettings read FLevel write SetLevel;
      property Level1Active:boolean read FLvl1Active write SetLvl1Active;
      property Level2Active:boolean read FLvl2Active write SetLvl2Active;
      property Level1Color:TColor read FLvl1Col write SetLvl1Col;
      property Level2Color:TColor read FLvl2Col write SetLvl2Col;
    end;

procedure Register;

implementation

uses DesignIntf;

const
   PRC:single=0.05; //define (in percents) color transitions on level crossing


procedure TCustomProgress.GradColCalculate(AMaxVal,AVal,ALvl1,ALvl2:integer);
begin
   FCol23:= GetGradColor(FCol2,FCol3,Round(AmaxVal*PRC*2),Round(AVal-(ALvl2-AmaxVal*PRC)));
   FCol23Sec:= GetGradColor(FCol2Sec,FCol3Sec,Round(AmaxVal*PRC*2),Round(AVal-(ALvl2-AmaxVal*PRC)));
   FCol12:= GetGradColor(FCol1,FCol2,Round(AmaxVal*PRC*2),Round(AVal-(ALvl1-AmaxVal*PRC)));
   FCol12Sec:= GetGradColor(FCol1Sec,FCol2Sec,Round(AmaxVal*PRC*2),Round(AVal-(ALvl1-AmaxVal*PRC)));
end;

function TCustomProgress.GetCurrGradCol(AMaxVal,APos,AVal,ALvl1,ALvl2,AMaxGrad,AGrad:integer):TColor;
begin
   Result:=clNone;
   case FLevelBehavior of
      lb_PartlyColored:
            if (APos>=ALvl1) and (APos<=ALvl2) then
               Result:= GetGradColor(FCol2,FCol2Sec,AMaxGrad,AGrad) else
            if (APos>ALvl2) then
               Result:= GetGradColor(FCol3,FCol3Sec,AMaxGrad,AGrad)
            else Result:= GetGradColor(FCol1,FCol1Sec,AMaxGrad,AGrad);

      lb_CompletelyColored:
            if (AVal>=ALvl1-AMaxVal*PRC) and (AVal<=ALvl1+AMaxVal*PRC) then
               Result:= GetGradColor(FCol12,FCol12Sec,AMaxGrad-1,AGrad) else
            if  (AVal>=ALvl1+AMaxVal*PRC) and (AVal<=ALvl2-AMaxVal*PRC) then
               Result:= GetGradColor(FCol2,FCol2Sec,AMaxGrad-1,AGrad) else
            if (AVal>=ALvl2-AMaxVal*PRC) and (AVal<=ALvl2+AMaxVal*PRC) then
               Result:= GetGradColor(FCol23,FCol23Sec,AMaxGrad-1,AGrad)
            else
            if (AVal>ALvl2+AMaxVal*PRC) then
               Result:= GetGradColor(FCol3,FCol3Sec,AMaxGrad-1,AGrad)
            else Result:= GetGradColor(FCol1,FCol1Sec,AMaxGrad-1,AGrad);
      end;
end;



procedure Register;
begin
  RegisterComponents('CustomIndicators', [TCustomProgress]);
  RegisterPropertyEditor (TypeInfo (integer), TCustomProgress, 'Height', nil);
  RegisterPropertyEditor (TypeInfo (integer), TCustomProgress, 'Width', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TCustomProgress, 'Stretch', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TCustomProgress, 'Proportional', nil);
  RegisterPropertyEditor (TypeInfo (TPicture), TCustomProgress, 'Picture', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TCustomProgress, 'IncrementalDisplay', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TCustomProgress, 'Center', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TCustomProgress, 'AutoSize', nil);
  //RegisterPropertyEditor (TypeInfo (TLevelSettings), TCustomProgress, 'Level', nil);
end;

constructor TCustomProgress.Create(AOwner:TComponent);
begin
   inherited Create(AOwner);

   FDBuff:=true;
   BitMaptmpEx:=Graphics.TBitMap.Create;   BitMaptmpEx.Transparent:=true;
   FAABitmap:=Graphics.TBitMap.Create;     FAABitmap.Transparent:=true;
   FAABitmap.Width:=Width;
   FAABitmap.Height:=Height;
   FMult:=1;
   BitMaptmpEx.Width:=Width*FMult;
   BitMaptmpEx.Height:=Height*FMult;
   BitMaptmpEx.PixelFormat := pf24bit;
   FAABitmap.PixelFormat := pf24bit;
   
   FShowCaption:=true;
   FInitialState:=false;
   FHeight:=Height;
   FWidth:=Width;
   FValue:=0;

   FDirection:=d_Down;
   FShape:=sh_Circule;
   BitMapTmp:=Graphics.TBitMap.Create;
   BitMapTmp.Width:=FWidth;
   BitMapTmp.Height:=FHeight;
   BitMaptmp.Canvas.Brush.Style:=bsClear;
   BitMaptmp.Canvas.Brush.Color:=clGreen;
   BitMaptmp.Canvas.Pen.Color:=FCol1;
   BitMaptmp.Canvas.Pen.Width:=1;

   BitMaptmpEx.Canvas.Font.Size:=-15*FMult;
   BitMaptmp.Canvas.Font.Color:=clWhite;
   BitMaptmp.Canvas.Font.Size:=-15;
   BitMaptmp.Canvas.Font.Name:='Arial';
   FFont:=BitMapTmp.Canvas.Font;
   BitMapTmp.Transparent:=true;
   FUnitName:='%';
   Self.Transparent:=true;
   Font.Assign(BitMapTmp.Canvas.Font);
   Font.Color:=clWhite;

   FShowFrame:=true;
   FColorFrame:=clWhite;
   FFrameWidth:=2;
   FRadius:=20;
   FRadR:=FRadius*FMult;

   FAntiAliased:=aaNone;

   FLvl1Active:=false;
   FLvl2Active:=true;
   FLevel1:=35;
   FLevel2:=75;
   FShowLvl1:=false;
   FShowLvl2:=true;
   FCol1Acsept:=$00175923;
   FCol1SecAcsept:=$0041DA60;
   FCol2Acsept:=$00623C1C;
   FCol2SecAcsept:=$00CF8B54;
   FCol3Acsept:=$00131D8C;
   FCol3SecAcsept:=$003850F1;
   FLvl1Col:=clWhite;
   FLvl2Col:=clWhite;

   SetCurrentColors;

   FLevelBehavior:=lb_CompletelyColored;
   FGradStyle:=gf_cospi;

   FInitialState:=true;
end;

destructor TCustomProgress.Destroy;
begin
   inherited Destroy;
end;

procedure TCustomProgress.CalculateParam;
begin
   {FRadiusX:=(A.Width div 2)-FFrameWidth*FMult-(FMult div 2);
   FCenterX:=A.Width div 2;
   FRadiusY:=(A.Height div 2)-FFrameWidth*FMult-(FMult div 2);
   FCenterY:=A.Height div 2;
   FRadR:=FRadius*FMult;

   FSP:=FFrameWidth*FMult+(FMult div 2);
   FXEP:=A.Width-(FFrameWidth*FMult)-(FMult div 2);
   FYEP:=A.Height-(FFrameWidth*FMult)-(FMult div 2);
   FXDEP:=A.Width-2*(FFrameWidth*FMult)-(FMult div 2);
   FYDEP:=A.Height-2*(FFrameWidth*FMult)-(FMult div 2);

   A1:=A.Width div 2;
   B:=A1+A.Height;
   C:=B+A.Width;
   D:=C+A.Height;}
end;

//Draw X-direction for Circule Shape
procedure TCustomProgress.XDraw(A:TBitMap; AStartPoint,ASign:Integer);
var
   i,tmpi:integer;
   tmpAngle:single;
   il:integer;
   tmpLvl1,tmpLvl2:integer;
   maxVal:integer;
   //c1,c2,b1,b2:TColor;
begin
   maxVal:= FXEP-FSP;
   tmpi:=round(FValue*maxVal/100);
   tmpLvl2:=round(FLevel2*maxVal/100);
   tmpLvl1:=round(FLevel1*maxVal/100);

   GradColCalculate(maxVal,tmpi,tmpLvl1,tmpLvl2);

   for i:=1 to tmpi-1 do
   begin
      il:=GetGradPos(tmpi,i,FGradStyle);

      A.Canvas.Pen.Color:=GetCurrGradCol(maxVal,i,tmpi,tmpLvl1,tmpLvl2,tmpi,il);

      tmpAngle:=arcCos(((maxVal div 2)-i)/(maxVal div 2));
      A.Canvas.MoveTo(
                  AStartPoint+ASign*i,
                  Round(FCenterY+sin(tmpAngle)*FRadiusY));
      A.Canvas.LineTo(
                  AStartPoint+ASign*i,
                  Round(FCenterY-sin(tmpAngle)*FRadiusY));
   end;

   tmpAngle:=ArcCos(((maxVal div 2)-tmpLvl2)/(maxVal div 2));
   ShowLvlLine(A,FLvl2Col,FLvl2Active, FShowLvl2,
               AStartPoint+ASign*tmpLvl2,Round(FCenterY+sin(tmpAngle)*FRadiusY),
               AStartPoint+ASign*tmpLvl2,Round(FCenterY-sin(tmpAngle)*FRadiusY));

   tmpAngle:=ArcCos(((maxVal div 2)-tmpLvl1)/(maxVal div 2));
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,
               AStartPoint+ASign*tmpLvl1,Round(FCenterY+sin(tmpAngle)*FRadiusY),
               AStartPoint+ASign*tmpLvl1,Round(FCenterY-sin(tmpAngle)*FRadiusY));
end;

//Draw Y-direction for Circule Shape
procedure TCustomProgress.YDraw(A:TBitMap;AStartPoint,ASign:Integer);
var
   i,tmpi:integer;
   tmpAngle:single;
   il:integer;
   MaxVal:integer;
   tmpLvl1,tmpLvl2:integer;
begin
   MaxVal:=FYEP-FSP;
   tmpi:=round(FValue*MaxVal/100);
   tmpLvl2:=round(FLevel2*maxVal/100);
   tmpLvl1:=round(FLevel1*maxVal/100);

   GradColCalculate(maxVal,tmpi,tmpLvl1,tmpLvl2);

   for i:=1 to tmpi-1 do
   begin
      tmpAngle:=arcsin(((MaxVal div 2)-i)/(MaxVal div 2));
      il:=GetGradPos(tmpi-1,i,FGradStyle);
      A.Canvas.Pen.Color:=GetCurrGradCol(maxVal,i,tmpi,tmpLvl1,tmpLvl2,tmpi,il);
      A.Canvas.MoveTo(
                  Round(FCenterX+cos(tmpAngle)*FRadiusX),
                  AStartPoint+ASign*i);
      A.Canvas.LineTo(
                  Round(FCenterX-cos(tmpAngle)*FRadiusX),
                  AStartPoint+ASign*i);
   end;

   tmpAngle:=arcsin(((MaxVal div 2)-tmpLvl2)/(MaxVal div 2));
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,
               Round(FCenterX+cos(tmpAngle)*FRadiusX),AStartPoint+ASign*tmpLvl2,
               Round(FCenterX-cos(tmpAngle)*FRadiusX),AStartPoint+ASign*tmpLvl2);

   tmpAngle:=arcsin(((MaxVal div 2)-tmpLvl1)/(MaxVal div 2));
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,
               Round(FCenterX+cos(tmpAngle)*FRadiusX),AStartPoint+ASign*tmpLvl1,
               Round(FCenterX-cos(tmpAngle)*FRadiusX),AStartPoint+ASign*tmpLvl1);
end;

//Draw Rot-direction for Circule Shape
procedure TCustomProgress.RDraw(A:TBitMap);
var
   i:integer;
   il:integer;
   tmpY,xt,yt:integer;
   MaxVal,tmpVal,tmpLvl1,tmpLvl2:integer;
   xtl1,ytl1,xtl2,ytl2:integer;
begin
   {A.Canvas.Pen.Width:=3*FMult;
   tmpi:=Round(FValue*720/100);
   for i:=0 to tmpi-1 do
   begin
      if i>=((tmpi-1) div 2) then sign:=-1 else sign:=1;
      il:=il+sign;
      A.Canvas.Pen.Color:= GetGradColor(FColor,FColorSecondary,tmpi,il);

      A.Canvas.MoveTo(FCenterX,FCenterY);
      A.Canvas.LineTo(
         Round(cos(DegtoRad(i/2)-pi/2)*(FRadiusX-3*FMult))+FCenterX,
         Round(sin(DegtoRad(i/2)-pi/2)*(FRadiusY-3*FMult))+FCenterY);
   end;}
   MaxVal:=360;
   tmpVal:=Round(FValue*360/100);
   tmpLvl1:=Round(FLevel1*360/100);
   tmpLvl2:=Round(FLevel2*360/100);
   xtl1:=Round(cos(DegtoRad(FLevel1*360/100)-pi/2)*FRadiusX)+FCenterX;
   ytl1:=Round(sin(DegtoRad(FLevel1*360/100)-pi/2)*FRadiusY)+FCenterY;
   xtl2:=Round(cos(DegtoRad(FLevel2*360/100)-pi/2)*FRadiusX)+FCenterX;
   ytl2:=Round(sin(DegtoRad(FLevel2*360/100)-pi/2)*FRadiusY)+FCenterY;
   GradColCalculate(MaxVal,tmpVal,tmpLvl1,tmpLvl2);



   A.Canvas.Pen.Width:=2*FMult;

   xt:=Round(cos(DegtoRad(Value*360/100)-pi/2)*FRadiusX)+FCenterX;
   yt:=Round(sin(DegtoRad(Value*360/100)-pi/2)*FRadiusY)+FCenterY;
   for i:=0 to FRadiusX-1 do
   begin
      il:=GetGradPos(FRadiusX-1,i,FGradStyle);

      if FLevelBehavior=lb_PartlyColored then
      begin
         if tmpVal<tmpLvl1 then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FRadiusX,il);
            tmpY:=Round(FRadiusY*i/FRadiusX);
            if FValue<>0 then
            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xt,yt,FCenterX,0);
         end;
         if (tmpVal>=tmpLvl1) and(tmpVal<=tmpLvl2) then
         begin
            tmpY:=Round(FRadiusY*i/FRadiusX);
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FRadiusX,il);

            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xtl1,ytl1,FCenterX,0);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FRadiusX,il);
            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xt,yt,xtl1,ytl2);
         end;

         if tmpVal>tmpLvl2 then
         begin
            tmpY:=Round(FRadiusY*i/FRadiusX);
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FRadiusX,il);

            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xtl1,ytl1,FCenterX,0);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FRadiusX,il);
            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xtl2,ytl2,xtl1,ytl1);
            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,FRadiusX,il);
            A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,FCenterX-i,FCenterY-tmpY,
                        xt,yt,xtl2,ytl2);
         end;
      end else
      begin
         A.Canvas.Pen.Color:=GetCurrGradCol(maxVal,tmpVal,tmpVal,tmpLvl1,tmpLvl2,FRadiusX,il);
         tmpY:=Round(FRadiusY*i/FRadiusX);
         if FValue<>0 then
         A.Canvas.Arc(  FCenterX+i,FCenterY+tmpY,
                        FCenterX-i,FCenterY-tmpY,
                        xt,yt,
                        FCenterX,0);
      end;
   end;

   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,xtl1,ytl1,FCenterX,FCenterY);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,xtl2,ytl2,FCenterX,FCenterY);
end;

//Draw Rot-direction for Rect Shape
procedure TCustomProgress.RLDraw(A:TBitMap);
var
   i,Tmpi:integer;
   il:integer;
   Perimetr:integer;
   tmpLvl1,tmpLvl2:integer;
   A1,B,C,D:integer;
   APoint:TPoint;
begin
   A1:=A.Width div 2;
   B:=A1+A.Height;
   C:=B+A.Width;
   D:=C+A.Height;
   Perimetr:=2*A.Height+2*A.Width;
   tmpi:=Round(FValue*Perimetr/100);
   tmpLvl1:=Round(FLevel1*Perimetr/100);
   tmpLvl2:=Round(FLevel2*Perimetr/100);
   GradColCalculate(Perimetr,tmpi,tmpLvl1,tmpLvl2);

   for i:=0 to tmpi-1 do
   begin
      il:=GetGradPos(tmpi,i,FGradStyle);
      A.Canvas.Pen.Color:=GetCurrGradCol(Perimetr,i,tmpi,tmpLvl1,tmpLvl2,Perimetr,il);

      APoint:=GetRectCoord(i,A1,B,C,D);
      A.Canvas.MoveTo(FCenterX,FCenterY);
      A.Canvas.LineTo(APoint.x,APoint.y);
   end;

   APoint:=GetRectCoord(tmpLvl1,A1,B,C,D);
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,APoint.X,APoint.y,FCenterX,FCenterY);
   APoint:=GetRectCoord(tmpLvl2,A1,B,C,D);
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl2,APoint.X,APoint.y,FCenterX,FCenterY);
end;

//Draw Rot-direction for RoundRect Shape
procedure TCustomProgress.RRDraw(A:TBitMap);
var
   i,Tmpi:integer;
   il:integer;
   Perimetr:integer;
   A1,B,C,D:integer;
   tmpLvl1,tmpLvl2:integer;
   APoint:TPoint;
begin
   A1:=A.Width div 2;
   B:=A1+A.Height;
   C:=B+A.Width;
   D:=C+A.Height;
   Perimetr:=2*A.Height+2*A.Width;
   A.Canvas.Pen.Width:=2*FMult;
   tmpi:=Round(FValue*Perimetr/100);
   tmpLvl1:=Round(FLevel1*Perimetr/100);
   tmpLvl2:=Round(FLevel2*Perimetr/100);
   GradColCalculate(Perimetr,tmpi,tmpLvl1,tmpLvl2);

   for i:=0 to tmpi-1 do
   begin
      il:=GetGradPos(tmpi,i,FGradStyle);
      A.Canvas.Pen.Color:=GetCurrGradCol(Perimetr,i,tmpi,tmpLvl1,tmpLvl2,Perimetr,il);

      APoint:=GetRoundRectCoord(i,A1,B,C,D);
      A.Canvas.MoveTo(FCenterX,FCenterY);
      A.Canvas.LineTo(APoint.X,APoint.Y);
   end;

   APoint:=GetRoundRectCoord(tmpLvl1,A1,B,C,D);
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,APoint.X,APoint.y,FCenterX,FCenterY);
   APoint:=GetRoundRectCoord(tmpLvl2,A1,B,C,D);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,APoint.X,APoint.y,FCenterX,FCenterY);
end;

//Draw X-direction for Rect Shape
procedure TCustomProgress.XLDraw(A:TBitMap;AStartPoint,ASign:Integer);
var
   i:integer;
   il:integer;
   maxVal,tmpi:integer;
   tmpLvl1,tmpLvl2:integer;
begin
   maxVal:=FXDEP;
   tmpi:=round(FValue*(FXDEP)/100);
   tmpLvl1:=round(FLevel1*(FXDEP)/100);
   tmpLvl2:=round(FLevel2*(FXDEP)/100);
   GradColCalculate(maxVal,tmpi,tmpLvl1,tmpLvl2);

   for i:=FSP to FYDEP do
   begin
      il:=GetGradPos(FYDEP-FSP,i,FGradStyle);
      if FLevelBehavior=lb_PartlyColored then
      begin
         if tmpi<=tmpLvl1 then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpi,i);
         end;
         if (tmpi>tmpLvl1) and (tmpi<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpLvl1,i);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint+ASign*tmpLvl1,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpi,i);
         end;
         if (tmpi>tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpLvl1,i);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint+ASign*tmpLvl1,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpLvl2,i);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,FYDEP-FSP,il);
            A.Canvas.MoveTo(AStartPoint+ASign*tmpLvl2,i);
            A.Canvas.LineTo(AStartPoint+ASign*tmpi,i);
         end;
      end;

      if FLevelBehavior=lb_CompletelyColored then
      begin
         A.Canvas.Pen.Color:=GetCurrGradCol(maxVal,tmpi,tmpi,tmpLvl1,tmpLvl2,FYDEP-FSP,il);
         A.Canvas.MoveTo(AStartPoint,i);
         A.Canvas.LineTo(AStartPoint+ASign*round(FValue*(FXDEP)/100),i);
      end;
   end;
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,AStartPoint+ASign*tmpLvl1,FSP,AStartPoint+ASign*tmpLvl1,FYEP);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,AStartPoint+ASign*tmpLvl2,FSP,AStartPoint+ASign*tmpLvl2,FYEP);
end;

//Draw Y-direction for Rect Shape
procedure TCustomProgress.YLDraw(A:TBitMap;AStartPoint,ASign:Integer);
var
   i:integer;
   il:integer;
   maxVal,tmpi:integer;
   tmpLvl1,tmpLvl2:integer;
begin
   maxVal:=FYDEP;
   tmpi:=round(FValue*(FYDEP)/100);
   tmpLvl1:=round(FLevel1*(FYDEP)/100);
   tmpLvl2:=round(FLevel2*(FYDEP)/100);
   GradColCalculate(maxVal,tmpi,tmpLvl1,tmpLvl2);

   for i:=FSP to FXDEP do
   begin
      il:=GetGradPos(FXDEP-FSP,i,FGradStyle);
      if FLevelBehavior=lb_PartlyColored then
      begin
         if tmpi<=tmpLvl1 then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpi);
         end;
         if (tmpi>tmpLvl1) and (tmpi<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpLvl1);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint+ASign*tmpLvl1);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpi);
         end;
         if (tmpi>tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpLvl1);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint+ASign*tmpLvl1);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpLvl2);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,FXDEP-FSP,il);
            A.Canvas.MoveTo(i,AStartPoint+ASign*tmpLvl2);
            A.Canvas.LineTo(i,AStartPoint+ASign*tmpi);
         end;
      end;

      if FLevelBehavior=lb_CompletelyColored then
      begin
         A.Canvas.Pen.Color:=GetCurrGradCol(maxVal,tmpi,tmpi,tmpLvl1,tmpLvl2,FXDEP-FSP,il);
         A.Canvas.MoveTo(i,AStartPoint);
         A.Canvas.LineTo(i,AStartPoint+ASign*tmpi);
      end;
   end;
   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,FSP,AStartPoint+ASign*tmpLvl1,FXEP,AStartPoint+ASign*tmpLvl1);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,FSP,AStartPoint+ASign*tmpLvl2,FXEP,AStartPoint+ASign*tmpLvl2);
end;

//Draw X-direction for RoundRect Shape
procedure TCustomProgress.RRXDraw(A:TBitMap;AStartPoint,ASign:Integer);
var
   tmpVal,i,tmpX:integer;
   il:integer;
   x1,x2,y:integer;
   at:single;
   MaxXVal,MaxYVal:integer;
   tmpLvl1,tmpLvl2:integer;
procedure DrowLi(ASig,a1,a2,a3,a4:integer);
begin
   if ((ASig>0) and (a3>a1)) or
      ((ASig<0) and (a3<a1)) then
   begin
      A.Canvas.MoveTo(a1,a2);
      A.Canvas.LineTo(a3,a4);
   end;
end;

begin
   MaxXVal:=FXEP-FSP;
   MaxYVal:=FYEP-FSP;
   tmpVal:=round(FValue*(FXEP-FSP)/100);
   tmpLvl1:=round(FLevel1*(FXEP-FSP)/100);
   tmpLvl2:=round(FLevel2*(FXEP-FSP)/100);
   GradColCalculate(MaxXVal,tmpVal,tmpLvl1,tmpLvl2);

   if FLevelBehavior=lb_CompletelyColored then
   for i:=0 to MaxYVal-1 do
   begin
      il:=GetGradPos(MaxYVal-1,i,FGradStyle);
      A.Canvas.Pen.Color:=GetCurrGradCol(MaxXVal,tmpVal,tmpVal,tmpLvl1,tmpLvl2,MaxYVal-1,il);

      y:=i+FSP;
      if (y<=FYEP-FRadR) and (y>=FSP+FRadr) then
      begin
         x1:=AStartPoint;
         x2:=AStartPoint+ASign*tmpVal;
         DrowLi(ASign,x1,y,x2,y);
      end;
      if y<=FRadr+FSP then
      begin
         at:=arccos((FRadr-i)/FRadr);
         tmpX:=FRadR-abs(round(cos(pi/2-at)*FRadr));
         x1:=AStartPoint+ASign*tmpX;
         x2:=AStartPoint+ASign*tmpVal;

         if TmpVal>MaxXVal-FRadr then
            if MaxXVal-tmpX<Tmpval then
               if (Asign>0) then x2:=FSP+MaxXVal-tmpX
               else x2:=FSP+tmpX;

         if ((x2>=x1) and (Asign>0)) or ((x2<=x1) and (Asign<0))then
         begin
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
               A.Canvas.Pen.Color:=GetCurrGradCol(MaxXVal,tmpVal,tmpVal,tmpLvl1,tmpLvl2,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);
         end;
      end;
   end;

   if FLevelBehavior=lb_PartlyColored then
   for i:=0 to MaxYVal-1 do
   begin
      il:=GetGradPos(MaxYVal-1,i,FGradStyle);

      y:=i+FSP;
      if (y<=FYEP-FRadR) and (y>=FSP+FRadr) then
      begin
         if tmpVal<tmpLvl1 then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint,y,AStartPoint+ASign*tmpVal,y);
         end;
         if (tmpVal<=tmpLvl2) and (tmpVal>=tmpLvl1) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint,y,AStartPoint+ASign*tmpLvl1,y);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint+ASign*tmpLvl1,y,AStartPoint+ASign*tmpVal,y);
         end;
         if (tmpVal>tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint,y,AStartPoint+ASign*tmpLvl1,y);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint+ASign*tmpLvl1,y,AStartPoint+ASign*tmpLvl2,y);
            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint+ASign*tmpLvl2,y,AStartPoint+ASign*tmpVal,y);
         end;
      end;
      if y<=FRadr+FSP then
      begin
         at:=arccos((FRadr-i)/FRadr);
         tmpX:=FRadR-abs(round(cos(pi/2-at)*FRadr));
         x1:=AStartPoint+ASign*tmpX;
         x2:=AStartPoint+ASign*tmpVal;

         if TmpVal>MaxXVal-FRadr then
            if MaxXVal-tmpX<Tmpval then
               if (Asign>0) then x2:=FSP+MaxXVal-tmpX else x2:=FSP+tmpX;

         if (tmpX<=tmpLvl1) and (tmpVal<=tmpLvl1) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);
         end;

         if (tmpX<=tmpLvl1) and (tmpVal>=tmpLvl1) and (tmpVal<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,x1,y,AStartPoint+Asign*tmpLvl1,y) else
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxYVal-1,MaxYVal-1-il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,x1,FYEP-i,AStartPoint+Asign*tmpLvl1,FYEP-i) else
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,AStartPoint+Asign*tmpLvl1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxYVal-1,MaxYVal-1-il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,AStartPoint+Asign*tmpLvl1,FYEP-i,x2,FYEP-i);
         end;

         if (tmpX<=tmpLvl1) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxYVal-1,il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,x1,y,AStartPoint+Asign*tmpLvl1,y) else
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxYVal-1,MaxYVal-1-il);
            if MaxXVal-tmpX>tmpLvl1 then DrowLi(ASign,x1,FYEP-i,AStartPoint+Asign*tmpLvl1,FYEP-i) else
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            if (MaxXVal-tmpX>tmpLvl2) and (tmpLvl1>MaxXVal-Fradr)then DrowLi(ASign,AStartPoint+Asign*tmpLvl1,y,AStartPoint+Asign*tmpLvl2,y)
            else DrowLi(ASign,AStartPoint+Asign*tmpLvl1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxYVal-1,MaxYVal-1-il);
            if MaxXVal-tmpX>tmpLvl2 then DrowLi(ASign,AStartPoint+Asign*tmpLvl1,FYEP-i,AStartPoint+Asign*tmpLvl2,FYEP-i) else
            DrowLi(ASign,AStartPoint+Asign*tmpLvl1,FYEP-i,x2,FYEP-i);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint+Asign*tmpLvl2,y,x2,y) ;
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,AStartPoint+Asign*tmpLvl2,FYEP-i,x2,FYEP-i);
         end;

         if (tmpX>=tmpLvl1) and (tmpVal>=tmpLvl1) and (tmpX<=tmpLvl2) and (tmpVal<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);
         end;

         if (tmpX>=tmpLvl1) and (tmpX<=tmpLvl2) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxYVal-1,il);
            if (MaxXVal-tmpX>tmpLvl2) then DrowLi(ASign,x1,y,AStartPoint+Asign*tmpLvl2,y) else
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxYVal-1,MaxYVal-1-il);
            if (MaxXVal-tmpX>tmpLvl2) then DrowLi(ASign,x1,FYEP-i,AStartPoint+Asign*tmpLvl2,FYEP-i) else
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxYVal-1,il);
            DrowLi(ASign,AStartPoint+Asign*tmpLvl2,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,AStartPoint+Asign*tmpLvl2,FYEP-i,x2,FYEP-i);
         end;

         if (tmpX>=tmpLvl2) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxYVal-1,il);
            DrowLi(ASign,x1,y,x2,y);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxYVal-1,MaxYVal-1-il);
            DrowLi(ASign,x1,FYEP-i,x2,FYEP-i);
         end;
      end;
   end;

   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,ASign*tmpLvl1+AStartPoint,FSP,ASign*tmpLvl1+AStartPoint,FYEP);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,ASign*tmpLvl2+AStartPoint,FSP,ASign*tmpLvl2+AStartPoint,FYEP);
end;

//Draw Y-direction for RoundRect Shape
procedure TCustomProgress.RRYDraw(A:TBitMap;AStartPoint,ASign:Integer);
var
   tmpVal,i,tmpX:integer;
   il:integer;
   x,y1,y2:integer;
   at:single;
   MaxXVal,MaxYVal:integer;
   tmpLvl1,tmpLvl2:integer;
procedure DrowLi(ASig,a1,a2,a3,a4:integer);
begin
   if ((ASig>0) and (a4>a2)) or
      ((ASig<0) and (a4<a2)) then
   begin
      A.Canvas.MoveTo(a1,a2);
      A.Canvas.LineTo(a3,a4);
   end;
end;

begin
   MaxXVal:=FXEP-FSP;
   MaxYVal:=FYEP-FSP;
   tmpVal:=round(FValue*(FYEP-FSP)/100);
   tmpLvl1:=round(FLevel1*(FYEP-FSP)/100);
   tmpLvl2:=round(FLevel2*(FYEP-FSP)/100);
   GradColCalculate(MaxYVal,tmpVal,tmpLvl1,tmpLvl2);
   
   if FLevelBehavior=lb_CompletelyColored then
   for i:=0 to MaxXVal-1 do
   begin
      il:=GetGradPos(MaxXVal-1,i,FGradStyle);
      A.Canvas.Pen.Color:=GetCurrGradCol(MaxYVal,tmpVal,tmpVal,tmpLvl1,tmpLvl2,MaxXVal-1,il);

      x:=i+FSP;
      if (x<=FXEP-FRadR) and (x>=FSP+FRadr) then
      begin
         y1:=AStartPoint;
         y2:=AStartPoint+ASign*tmpVal;
         DrowLi(ASign,x,y1,x,y2);
      end;
      if x<=FRadr+FSP then
      begin
         at:=arccos((FRadr-i)/FRadr);
         tmpX:=FRadR-abs(round(cos(pi/2-at)*FRadr));
         y1:=AStartPoint+ASign*tmpX;
         y2:=AStartPoint+ASign*tmpVal;

         if TmpVal>MaxYVal-FRadr then
            if MaxYVal-tmpX<Tmpval then
               if (Asign>0) then y2:=FSP+MaxYVal-tmpX
               else y2:=FSP+tmpX;

         DrowLi(ASign,x,y1,x,y2);
         if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetCurrGradCol(MaxYVal,tmpVal,tmpVal,tmpLvl1,tmpLvl2,MaxXVal-1,MaxXVal-1-il);
         DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);
      end;
   end;

   if FLevelBehavior=lb_PartlyColored then
   for i:=0 to MaxXVal-1 do
   begin
      il:=GetGradPos(MaxXVal-1,i,FGradStyle);

      x:=i+FSP;
      if (x<=FXEP-FRadR) and (x>=FSP+FRadr) then
      begin
         if tmpVal<tmpLvl1 then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint,x,AStartPoint+ASign*tmpVal);
         end;
         if (tmpVal<=tmpLvl2) and (tmpVal>=tmpLvl1) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint,x,AStartPoint+ASign*tmpLvl1);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint+ASign*tmpLvl1,x,AStartPoint+ASign*tmpVal);
         end;
         if (tmpVal>tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint,x,AStartPoint+ASign*tmpLvl1);
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint+ASign*tmpLvl1,x,AStartPoint+ASign*tmpLvl2);
            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint+ASign*tmpLvl2,x,AStartPoint+ASign*tmpVal);
         end;
      end;
      if x<=FRadr+FSP then
      begin
         at:=arccos((FRadr-i)/FRadr);
         tmpX:=FRadR-abs(round(cos(pi/2-at)*FRadr));
         y1:=AStartPoint+ASign*tmpX;
         y2:=AStartPoint+ASign*tmpVal;

         if TmpVal>MaxYVal-FRadr then
            if MaxYVal-tmpX<Tmpval then
               if (Asign>0) then y2:=FSP+MaxYVal-tmpX else y2:=FSP+tmpX;

         if (tmpX<=tmpLvl1) and (tmpVal<=tmpLvl1) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxXVal-1,MaxXVal-1-il);
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);
         end;

         if (tmpX<=tmpLvl1) and (tmpVal>=tmpLvl1) and (tmpVal<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,x,y1,x,AStartPoint+Asign*tmpLvl1) else
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxXVal-1,MaxXVal-1-il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,FXEP-i,y1,FXEP-i,AStartPoint+Asign*tmpLvl1) else
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,x,AStartPoint+Asign*tmpLvl1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxXVal-1,MaxXVal-1-il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,FXEP-i,AStartPoint+Asign*tmpLvl1,FXEP-i,y2);
         end;

         if (tmpX<=tmpLvl1) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol1,FCol1Sec,MaxXVal-1,il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,x,y1,x,AStartPoint+Asign*tmpLvl1) else
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol1,FCol1Sec,MaxXVal-1,MaxXVal-1-il);
            if MaxYVal-tmpX>tmpLvl1 then DrowLi(ASign,FXEP-i,y1,FXEP-i,AStartPoint+Asign*tmpLvl1) else
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);

            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            if (MaxYVal-tmpX>tmpLvl2) and (tmpLvl1>MaxXVal-Fradr)then DrowLi(ASign,x,AStartPoint+Asign*tmpLvl1,x,AStartPoint+Asign*tmpLvl2)
            else DrowLi(ASign,x,AStartPoint+Asign*tmpLvl1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxXVal-1,MaxXVal-1-il);
            if MaxYVal-tmpX>tmpLvl2 then DrowLi(ASign,FXEP-i,AStartPoint+Asign*tmpLvl1,FXEP-i,AStartPoint+Asign*tmpLvl2) else
            DrowLi(ASign,FXEP-i,AStartPoint+Asign*tmpLvl1,FXEP-i,y2);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint+Asign*tmpLvl2,x,y2) ;
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxXVal-1,MaxXVal-1-il);
            DrowLi(ASign,FXEP-i,AStartPoint+Asign*tmpLvl2,FXEP-i,y2);
         end;

         if (tmpX>=tmpLvl1) and (tmpVal>=tmpLvl1) and (tmpX<=tmpLvl2) and (tmpVal<=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxXVal-1,MaxXVal-1-il);
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);
         end;

         if (tmpX>=tmpLvl1) and (tmpX<=tmpLvl2) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol2,FCol2Sec,MaxXVal-1,il);
            if (MaxYVal-tmpX>tmpLvl2) then DrowLi(ASign,x,y1,x,AStartPoint+Asign*tmpLvl2) else
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol2,FCol2Sec,MaxXVal-1,MaxXVal-1-il);
            if (MaxYVal-tmpX>tmpLvl2) then DrowLi(ASign,FXEP-i,y1,FXEP-i,AStartPoint+Asign*tmpLvl2) else
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);

            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxXVal-1,il);
            DrowLi(ASign,x,AStartPoint+Asign*tmpLvl2,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxXVal-1,MaxXVal-1-il);
            DrowLi(ASign,FXEP-i,AStartPoint+Asign*tmpLvl2,FXEP-i,y2);
         end;

         if (tmpX>=tmpLvl2) and (tmpVal>=tmpLvl2) then
         begin
            A.Canvas.Pen.Color:= GetGradColor(FCol3,FCol3Sec,MaxXVal-1,il);
            DrowLi(ASign,x,y1,x,y2);
            if FGradStyle=gf_linear then
            A.Canvas.Pen.Color:=GetGradColor(FCol3,FCol3Sec,MaxXVal-1,MaxXVal-1-il);
            DrowLi(ASign,FXEP-i,y1,FXEP-i,y2);
         end;
      end;
   end;

   ShowLvlLine(A,FLvl1Col,FLvl1Active,FShowLvl1,FSP,ASign*tmpLvl1+AStartPoint,FXEP,ASign*tmpLvl1+AStartPoint);
   ShowLvlLine(A,FLvl2Col,FLvl2Active,FShowLvl2,FSP,ASign*tmpLvl2+AStartPoint,FXEP,ASign*tmpLvl2+AStartPoint);
end;

procedure TCustomProgress.DrawProgress;
begin
   if FMult=1 then
   begin
      DrawProgressEx(BitMaptmp);
      Picture.Bitmap:= BitMaptmp;
   end else
   begin
      DrawProgressEx(BitMaptmpEx);
      FastAntiAliasPicture(FMult,BitMaptmpEx,FAABitmap);
      Picture.Bitmap:= FAABitmap;
   end;
end;

procedure TCustomProgress.DrawProgressEx(var A:TBitMap);
var
   TextL,TextH:integer;
   AString:string;
begin
   FRadiusX:=(A.Width div 2)-FFrameWidth*FMult-(FMult div 2);
   FCenterX:=A.Width div 2;
   FRadiusY:=(A.Height div 2)-FFrameWidth*FMult-(FMult div 2);
   FCenterY:=A.Height div 2;
   FRadR:=FRadius*FMult;

   FSP:=FFrameWidth*FMult+(FMult div 2);
   FXEP:=A.Width-(FFrameWidth*FMult)-(FMult div 2);
   FYEP:=A.Height-(FFrameWidth*FMult)-(FMult div 2);
   FXDEP:=A.Width-2*(FFrameWidth*FMult)-(FMult div 2);
   FYDEP:=A.Height-2*(FFrameWidth*FMult)-(FMult div 2);

   A.Canvas.Refresh;

   if Assigned(Parent) then
   begin
      A.Canvas.Brush.Color:=TPeekAtControl(Parent).Color;
      A.Canvas.Pen.Color:= TPeekAtControl(Parent).Color ;
   end;

   A.Canvas.Rectangle(0,0,A.Width,A.Height);
   A.Canvas.Pen.Color:=FCol1;
   A.Canvas.Pen.Width:=1;

   if FShape=sh_Circule then
   case FDirection of
      d_Up:YDraw(A,FYEP,-1);
      d_Down:YDraw(A,FSP,1);
      d_Right:XDraw(A,FSP,1);
      d_left:XDraw(A,FXEP,-1);
      d_rot:RDraw(A);
   end;

   if FShape=sh_RoundRect then
      case FDirection of
         d_Up :RRYDraw(A,FYEP,-1);
         d_Down :RRYDraw(A,FSP,1);
         d_Right:RRXDraw(A,FSP,1);
         d_left:RRXDraw(A,FXEP,-1);
         d_rot:RRDraw(A);
      end;

   if FShape=sh_Rect then
      case FDirection of
         d_Up:YLDraw(A,A.Height-2*FFrameWidth*FMult-FMult div 2,-1);
         d_Down:YLDraw(A,FFrameWidth*FMult,1);
         d_Right:XLDraw(A,FFrameWidth*FMult,1);
         d_left:XLDraw(A,A.Width-2*FFrameWidth*FMult-FMult div 2,-1);
         d_rot:RLDraw(A);
      end;

   if FShowFrame then
   begin
      A.Canvas.Pen.Color:=FColorFrame;
      A.Canvas.Pen.Width:=FFrameWidth*FMult;
      A.Canvas.Pen.Style:=psSolid;
      A.Canvas.Brush.Style:=bsClear;

      if FShape=sh_Rect then
         A.Canvas.Rectangle(FFrameWidth*FMult+(FMult div 2),FFrameWidth*FMult+(FMult div 2),FXEP, FYEP);

      if FShape=sh_Circule then
         A.Canvas.Ellipse(FSP,FSP,FXEP,FYEP);

      if FShape=sh_RoundRect then
      begin
        A.Canvas.RoundRect(FSP,FSP,FXEP,FYEP,2*FRadr,2*FRadr);
      end;
   end;

   if FShowCaption then
   begin
      A.Canvas.Font:=font;
      A.Canvas.Font.Size:=A.Canvas.Font.Size*FMult;
      SetBkMode(A.Canvas.Handle, Windows.TRANSPARENT);
      if FUnitName=' ' then AString:=inttostr(FValue)+' ' else
         AString:=inttostr(FValue)+' '+FUnitName;
      TextL:=A.Canvas.TextWidth(AString);
      TextH:=A.Canvas.TextHeight(AString);
      A.Canvas.TextOut(FCenterX-(TextL div 2),FCenterY-(TextH div 2),AString);
   end;

   if Assigned(Self.Parent) and FDBuff then
   begin
      if not Self.Parent.DoubleBuffered then Self.Parent.DoubleBuffered:=true;
   end;
end;

function TCustomProgress.GetAAMultipler: Integer;
begin
   case FAntiAliased of
      aaBiline: Result := 2;
      aaTriline: Result := 3;
      aaQuadral: Result := 4;
      else Result := 1
  end
end;

procedure TCustomProgress.CMFontChanged;
begin
  inherited;
  DrawProgress;
end;

procedure TCustomProgress.Resize;
begin
   inherited Resize;
   if not ((csLoading in ComponentState) or
            (csReading in ComponentState)) then
   if FInitialState then
   begin
      if Width<2*FRadius then Fradius:=Width div 2;
      if Height<2*FRadius then Fradius:=Height div 2;
      FWidth:=    Width;
      FHeight:=   Height;
      BitMapTmp.Width:= Width;
      BitMapTmp.Height:= Height;
      BitMapTmpEx.Height:=FMUlt*Height;
      BitMapTmpEx.Width:=FMult*Width;
      FAABitmap.Height:=Height;
      FAABitmap.Width:=Width;
      CalculateParam;
      DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevel1(AValue:integer);
begin
   if AValue<>FLevel1 then
   begin
      if AValue>100 then AValue:=100;
      if AValue<5 then AValue:=5;
      if AValue>(FLevel2-round(100*PRC)) then
         AValue:=FLevel2-round(100*PRC);
      FLevel1:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevel2(AValue:integer);
begin
   if AValue<>FLevel2 then
   begin
      if AValue>95 then AValue:=95;
      if AValue<0 then AValue:=0;
      if AValue<(FLevel1+round(100*PRC)) then
         AValue:=FLevel1+round(100*PRC);
      FLevel2:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevel1Show (AValue:boolean);
begin
   if AValue<>FShowLvl1 then
   begin
      FShowLvl1:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevel2Show (AValue:boolean);
begin
   if AValue<>FShowLvl2 then
   begin
      FShowLvl2:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetHeight(AValue:integer);
begin
   if AValue<>FHeight then
   begin
      if 2*FRadius>AValue then Fradius:=AValue div 2;{AValue:=2*FRadius;}
      BitMapTmp.Height:= AValue;
      FHeight:=AValue;
      Height:=FHeight;
      BitMapTmpEx.Height:=AValue*FMult;
      FAABitmap.Height:=AValue;
      CalculateParam;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetWidth(AValue:integer);
begin
   if AValue<>FWidth then
   begin
      if 2*FRadius>AValue then Fradius:=AValue div 2;{AValue:=2*FRadius;}
      BitMapTmp.Width:= AValue;
      FWidth:=AValue;
      Width:=FWidth;
      BitMapTmpEx.Width:=AValue*FMult;
      FAABitmap.Width:=AValue;
      CalculateParam;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetDirection(AValue:TDirection);
begin
   if AValue<>FDirection then
   begin
      FDirection:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCustomShape(AValue:TCustomShape);
begin
   if AValue<>FShape then
   begin
      FShape:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevelBehavior(AValue:TLevelBehavior);
begin
   if AValue<>FLevelBehavior then
   begin
      FLevelBehavior:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol1(AValue:TColor);
begin
   if AValue<>FCol1Acsept then
   begin
      FCol1Acsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetUnitName(AValue:String);
begin
   if (AValue<>FUnitName)then
   begin
      FUnitName:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetShowCaption(AValue:boolean);
begin
   if AValue<>FShowCaption then
   begin
      FShowCaption:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetFAntiAliased(AValue:TAntialiased);
begin
   if FAntiAliased<>AValue then
   begin
      FAntiAliased:=AValue;
      FMult:=GetAAMultipler;
      BitMaptmpEx.Width := Width * FMult;
      BitMaptmpEx.Height := Height * FMult;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetShowFrame(AValue:boolean);
begin
   if AValue<>FShowFrame then
   begin
      FShowFrame:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetDBuff(AValue:boolean);
begin
   if AValue<>FDBuff then
   begin
      FDBuff:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol1Sec(AValue:TColor);
begin
   if AValue<>FCol1SecAcsept then
   begin
      FCol1SecAcsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetColorFrame(AValue:TColor);
begin
   if AValue<>FColorFrame then
   begin
      FColorFrame:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetFrameWidth(AValue:integer);
begin
   if AValue<>FFrameWidth then
   begin
      FFrameWidth:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetValue(AValue:integer);
begin
   if AValue<>FVAlue then
   begin
      if AValue>100 then AValue:= 100;
      if AValue<0 then AValue:=0;
      FValue:=AValue;
      DrawProgress;
   end;
end;

procedure TCustomProgress.SetRadius(AValue:integer);
begin
   if AValue<>FRadius then
   begin
      if AValue<=0 then AValue:=1;
      if Height>Width then
         if 2*AValue>Width then AValue:=Width div 2;
      if Height<Width then
         if 2*AValue>Height then AValue:=Height div 2;
      FRadius:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLevel(AValue:TLevelSettings);
begin
   if AValue.Level<>FLevel.Level then
   begin
      FLevel:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol2(AValue:TColor);
begin
   if AValue<>FCol2Acsept then
   begin
      FCol2Acsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol2Sec(AValue:TColor);
begin
   if AValue<>FCol2SecAcsept then
   begin
      FCol2SecAcsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol3(AValue:TColor);
begin
   if AValue<>FCol3Acsept then
   begin
      FCol3Acsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetCol3Sec(AValue:TColor);
begin
   if AValue<>FCol3SecAcsept then
   begin
      FCol3SecAcsept:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetGradientStyle(AValue:TGradfunc);
begin
   if AValue<>FGradStyle then
   begin
      FGradStyle:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.ShowLvlLine;
begin
   if AVisible and AActive then
   begin
      A.Canvas.Pen.Color:=AColor;
      A.Canvas.Pen.Width:=FMult;
      A.Canvas.MoveTo(x1,y1);
      A.Canvas.LineTo(x2,y2);
   end;
end;

function TCustomProgress.GetRectCoord(AValue,A,B,C,D:integer):TPoint;
var
   APoint:TPoint;
begin
   if AValue<A then
      begin
         APoint.X:=AValue+A;
         APoint.Y:=FSP;
         if APoint.X>FXEP then APoint.X:=FXEP;
      end else
      if (AValue<B) then
      begin
         APoint.X:=FXEP;
         APoint.Y:=AValue-A;
         if APoint.Y>FYEP then APoint.Y:=FYEP;
         if APoint.Y<FSP then APoint.Y:=FSP;
      end else
      if (AValue<C) then
      begin
         APoint.X:=FXEP-(AValue-B);
         APoint.Y:=FYEP;
         if APoint.X<FSP then APoint.X:=FSP;
      end else
      if (AValue<D) then
      begin
         APoint.X:=FSP;
         APoint.Y:=FYEP-(AValue-C);
         if APoint.Y<FSP then APoint.Y:=FSP;
      end else
      begin
         APoint.X:=(AValue-D);
         APoint.Y:=FSP;
         if APoint.X<FSP then APoint.X:=FSP;
      end;
   Result:=APoint;
end;

function TCustomProgress.GetRoundRectCoord(AValue,A,B,C,D:integer):TPoint;
var
   APoint:TPoint;
   at:single;
begin
   if AValue<A then
      begin
         APoint.X:=AValue+A;
         APoint.Y:=FSP;
         if APoint.X>FXEP then APoint.X:=FXEP;
      end else
      if (AValue<B) then
      begin
         APoint.X:=FXEP;
         APoint.Y:=AValue-A;
         if APoint.Y>FYEP then APoint.Y:=FYEP;
         if APoint.Y<FSP then APoint.Y:=FSP;
      end else
      if (AValue<C) then
      begin
         APoint.X:=FXEP-(AValue-B);
         APoint.Y:=FYEP;
         if APoint.X<FSP then APoint.X:=FSP;
      end else
      if (AValue<D) then
      begin
         APoint.X:=FSP;
         APoint.Y:=FYEP-(AValue-C);
         if APoint.Y<FSP then APoint.Y:=FSP;
      end else
      begin
         APoint.X:=(AValue-D);
         APoint.Y:=FSP;
         if APoint.X<FSP then APoint.X:=FSP;
      end;
      if (AValue>=A-FRadr) and (AValue<=A+FRadr) then
      begin
         at:=(2*Fradr-((A+FRadr)-AValue))*(pi/2)/(2*FRadr);
         APoint.X:=Round(FXEP-FRadr+cos(-pi/2+at)*FRadr);
         APoint.Y:=Round(FSP+Fradr+Sin(-pi/2+at)*FRadr);
      end;
      if (AValue>B-FRadr) and (AValue<B+FRadr) then
      begin
         at:=(2*Fradr-((B+FRadr)-AValue))*(pi/2)/(2*FRadr);
         APoint.X:=Round(FXEP-FRadr+cos(at)*FRadr);
         APoint.Y:=Round(FYEP-Fradr+Sin(at)*FRadr);
      end;
      if (AValue>C-Fradr) and (AValue<C+Fradr) then
      begin
         at:=(2*Fradr-((C+FRadr)-AValue))*(pi/2)/(2*FRadr);
         APoint.X:=Round(FSP+FRadr+cos(pi/2+at)*FRadr);
         APoint.Y:=Round(FYEP-Fradr+Sin(pi/2+at)*FRadr){+FMult};
      end;
      if (AValue>=D-FRadr) and (AValue<=D+Fradr) then
      begin
         at:=(2*Fradr-((D+FRadr)-AValue))*(pi/2)/(2*FRadr);
         APoint.X:=FSP+Round(FRadr+cos(pi+at)*FRadr);
         APoint.Y:=FSP+Round(Fradr+Sin(pi+at)*FRadr);
      end;
   Result:=APoint;
end;

procedure TCustomProgress.SetCurrentColors;
begin
   FCol1:=FCol1Acsept;
   FCol1Sec:=FCol1SecAcsept;

   if FLvl1Active and FLvl2Active then
   begin
      FCol2:=FCol2Acsept;
      FCol2Sec:=FCol2SecAcsept;
      FCol3:=FCol3Acsept;
      FCol3Sec:=FCol3SecAcsept;
   end;
   if FLvl1Active and (not FLvl2Active) then
   begin
      FCol2:=FCol2Acsept;
      FCol2Sec:=FCol2SecAcsept;
      FCol3:=FCol2Acsept;
      FCol3Sec:=FCol2SecAcsept;
   end;
   if (not FLvl1Active) and FLvl2Active then
   begin
      FCol2:=FCol1Acsept;
      FCol2Sec:=FCol1SecAcsept;
      FCol3:=FCol3Acsept;
      FCol3Sec:=FCol3SecAcsept;
   end;
   if (not FLvl1Active) and (not FLvl2Active) then
   begin
      FCol2:=FCol1Acsept;
      FCol2Sec:=FCol1SecAcsept;
      FCol3:=FCol1Acsept;
      FCol3Sec:=FCol1SecAcsept;
   end;
end;

procedure TCustomProgress.SetLvl1Active(AValue:boolean);
begin
   if AValue<>FLvl1Active then
   begin
      FLvl1Active:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLvl2Active(AValue:boolean);
begin
   if AValue<>FLvl2Active then
   begin
      FLvl2Active:=AValue;
      SetCurrentColors;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLvl1Col(AValue:TColor);
begin
   if AValue<>FLvl1Col then
   begin
      FLvl1Col:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

procedure TCustomProgress.SetLvl2Col(AValue:TColor);
begin
   if AValue<>FLvl2Col then
   begin
      FLvl2Col:=AValue;
      if FInitialState then DrawProgress;
   end;
end;

end.
