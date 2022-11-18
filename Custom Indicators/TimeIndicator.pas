unit TimeIndicator;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls,Graphics,CustomTypes;

type
   TFrameForm = (ffNone,ffRound,ffSquare,ffRoundSquare);
   TClockMarkers = (cmNone,cmTics,cmRounds,cmNumbers,cmSimple);
   
type
  TTimeIndicator = class(TImage)
  private
    { Private declarations }
    FClockEx:boolean;
    FLowTics:boolean;
    FClockMarkers:TClockMarkers;
    FFrameForm:TFrameForm;
    FOldTime:string;
    FTimer:TTimer;
    FInitState:boolean;
    FHeight:integer;
    FWidth:integer;
    FHourRad:integer;
    FMinRad:integer;
    FAntiAliased: TAntialiased;
    BitMaptmp:TBitMap;
    BitMaptmpEx:TBitMap;
    FAABitmap:TBitMap;
    FFrameWidth:integer;
    FHandHourWidth:integer;
    FHandMinWidth:integer;
    FTickWidth:integer;
    FColorFrame:TColor;
    FColorHour:TColor;
    FColorMinute:TColor;
    FColorMarker:TColor;
    procedure  DrowScaleEx(A:TBitMap);
    procedure  DrowScale;
    procedure  SetFAntiAliased(AValue: TAntialiased);
    function   GetAAMultipler: Integer;
    procedure Timer1Timer(Sender: TObject);
    procedure SetFrameForm(AValue: TFrameForm);
    procedure SetClockMarkers(AValue:TClockMarkers);
    procedure SetHeight(AValue:integer);
    procedure SetWidth(AValue:integer);

    procedure SetFrameWidth(AValue:integer);
    procedure SetHandHourWidth(AValue:integer);
    procedure SetHandMinWidth(AValue:integer);
    procedure SetTickWidth(AValue:integer);
    procedure SetColorFrame(AValue:TColor);
    procedure SetColorHour(AValue:TColor);
    procedure SetColorMinute(AValue:TColor);
    procedure SetColorMarker(AValue:TColor);
    procedure SetClockEx(AValue:boolean);
    procedure SetLowTics(AValue:boolean);
  protected
    { Protected declarations }
    procedure Resize;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy;override;
  published
    { Published declarations }
    property AntiAliased: TAntialiased read FAntiAliased write SetFAntiAliased;
    property FrameForm:TFrameForm read FFrameForm write SetFrameForm;
    property ClockMarkers: TClockMarkers read FClockMarkers write SetClockMarkers;
    property HeightInd:integer read FHeight write SetHeight;
    property WidthInd:integer read FWidth write SetWidth;
    property FrameWidth:integer read FFrameWidth write SetFrameWidth;
    property HandHourWidth:integer read FHandHourWidth write SetHandHourWidth;
    property HandMinWidth:integer read FHandMinWidth write SetHandMinWidth;
    property TickWidth:integer read FTickWidth write SetTickWidth;
    property ColorFrame:TColor read FColorFrame write SetColorFrame;
    property ColorHour:TColor read FColorHour write SetColorHour;
    property ColorMinute:TColor read FColorMinute write SetColorMinute;
    property ColorMarker:TColor read FColorMarker write SetColorMarker;
    property ClockEx:boolean read FClockEx write SetClockEx;
    property LowTics:boolean read FLowTics write SetLowTics;
  end;

procedure Register;

implementation

uses Windows,DesignIntf;

const
   FrameShift:integer=4;

procedure Register;
begin
  RegisterComponents('CustomIndicators', [TTimeIndicator]);
  RegisterPropertyEditor (TypeInfo (integer), TTimeIndicator, 'Height', nil);
  RegisterPropertyEditor (TypeInfo (integer), TTimeIndicator, 'Width', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TTimeIndicator, 'Stretch', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TTimeIndicator, 'Proportional', nil);
  RegisterPropertyEditor (TypeInfo (TPicture), TTimeIndicator, 'Picture', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TTimeIndicator, 'IncrementalDisplay', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TTimeIndicator, 'Center', nil);
  RegisterPropertyEditor (TypeInfo (boolean), TTimeIndicator, 'AutoSize', nil);
end;

procedure TTimeIndicator.Timer1Timer(Sender: TObject);
begin
   if copy(FOldTime,4,2)<>copy(FormatDateTime('hh:mm',SysUtils.Time),4,2) then
      DrowScale;
end;

destructor TTimeIndicator.Destroy;
begin
  FTimer.Enabled:=false;
  FTimer.Free;
  inherited Destroy;
end;

constructor TTimeIndicator.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  Height:=100;
  Width:=200;
  Transparent:=true;
  FHeight:=Height;
  FWidth:=Width;
  FAntiAliased:=aaNone;
  BitMapTmp:=Graphics.TBitMap.Create;
  BitMapTmp.Transparent:=true;
  BitMapTmp.Height:=Height;
  BitMapTmp.Width:=Width;

  BitMaptmpEx:=Graphics.TBitMap.Create;   BitMaptmpEx.Transparent:=true;
  FAABitmap:=Graphics.TBitMap.Create;     FAABitmap.Transparent:=true;
  FAABitmap.Width:=Width;
  FAABitmap.Height:=Height;
  BitMaptmpEx.PixelFormat := pf24bit;
  FAABitmap.PixelFormat := pf24bit;

  FTimer:=TTimer.Create(Self);
  FTimer.OnTimer:=Timer1Timer;
  FTimer.Interval:=1000;
  FTimer.Enabled:=true;
  FFrameForm:=ffRound;
  FClockMarkers:=cmNumbers;
  FFrameWidth:=5;
  FHandHourWidth:=6;
  FHandMinWidth:=3;
  FTickWidth:=1;
  FColorFrame:=clGray;
  FColorHour:=clGray;
  FColorMinute:=clGray;
  FColorMarker:=clGray;
  FClockEx:=true;
  FLowTics:=true;
  DrowScale;
  FInitState:=true;
end;

procedure TTimeIndicator.DrowScaleEx;
var
   min,hour:integer;
   AngleHour,AngleMin,Mid,Rad:single;
   K,i,j:integer;
   R : TRect;
   myDate : TDateTime;
begin
   K:=GetAAMultipler;
   A.Canvas.Refresh;

   //Clearing Bitmap space
   A.Canvas.Brush.Style:=bsClear;
   if Assigned(Parent) then
   begin
      A.Canvas.Brush.Color:=TPeekAtControl(Parent).Color;
      A.Canvas.Pen.Color:= TPeekAtControl(Parent).Color ;
   end;
   A.Canvas.Rectangle(0,0,A.Width,A.Height);

   //Drawing Clock Frame
   A.Canvas.Pen.Color:=FColorFrame;
   A.Canvas.Pen.Width:=FFrameWidth*K;
   A.Canvas.Pen.Style:=psSolid;
   case FFrameForm of
      ffNone:;
      ffRound:
         A.Canvas.Ellipse( 0+FrameShift*K,         0+FrameShift*K,
                           A.Height-FrameShift*K,  A.Height-FrameShift*K);
      ffSquare:
         A.Canvas.Rectangle(  0+FrameShift*K,         0+FrameShift*K,
                              A.Height-FrameShift*K,  A.Height-FrameShift*K);
      ffRoundSquare:
         A.Canvas.RoundRect(  0+FrameShift*K,0+FrameShift*K,
                              A.Height-FrameShift*K,A.Height-FrameShift*K,
                              Round(A.Height*0.2),Round(A.Height*0.2));
   end;

   A.Canvas.Font.Height:=Round(A.Height*0.40);
   A.Canvas.Font.Color:=FColorFrame;
   A.Canvas.Font.Name:='arial';

   Mid:=A.Height/2; Rad:=pi/180;
   FOldTime:=FormatDateTime('hh:mm',SysUtils.Time);

   min:=strtoint(copy(FOldTime,4,2));
   hour:=strtoint(copy(FOldTime,1,2));
   FOldTime[3]:=':';

   //Drawing extended clock field
   if FClockEx then
   begin
      R := Rect(A.Width div 2,FrameShift, A.Width, FrameShift+A.Canvas.TextHeight('0'));
      A.Canvas.Pen.Width:=1*K;
      A.Canvas.Brush.Style:=bsClear;
      DrawText(A.Canvas.Handle, PAnsiChar(FOldTime), -1, R, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

      A.Canvas.Font.Height:=Round(A.Height*0.2);
      R := Rect(  A.Width div 2,Round(FrameShift+A.Height*0.40),
                  A.Width, Round(FrameShift+A.Height*0.40+A.Height*0.2));
      myDate:=SysUtils.Date;
      DrawText(A.Canvas.Handle, PAnsiChar(FormatDateTime('mmmm', myDate)), -1, R, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

      A.Canvas.Font.Height:=Round(A.Height*0.35);
      R := Rect(  A.Width div 2,Round(FrameShift+A.Height*0.40+A.Height*0.2),
                  A.Width, Round(FrameShift+A.Height*0.40+A.Height*0.20+A.Height*0.35));
      DrawText(A.Canvas.Handle, PAnsiChar(FormatDateTime('d,ddd', myDate)), -1, R, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
   end;
   FHourRad:=Round(A.Height*0.45/2);
   FMinRad:=Round(A.Height*0.65/2);
   AngleHour:=270+((hour*60+min)*360/720);
   AngleMin:=270+(min*360/60);

   //Drawing Hour hand
   A.Canvas.Pen.Color:=FColorHour;
   A.Canvas.Pen.Width:=FHandHourWidth*K;
   A.Canvas.MoveTo(  Round(Mid+cos((AngleHour+180)*Rad)*Mid*0.15),
                     Round(Mid+sin((AngleHour+180)*Rad)*Mid*0.15));
   A.Canvas.LineTo(  Round(Mid+cos(AngleHour*Rad)*FHourRad),
                     Round(Mid+sin(AngleHour*Rad)*FHourRad));


   //Drawing minute hand
   A.Canvas.Pen.Color:=FColorMinute;
   A.Canvas.Pen.Width:=FHandMinWidth*K;
   A.Canvas.MoveTo(  Round(Mid+cos((AngleMin+180)*Rad)*Mid*0.15),
                     Round(Mid+sin((AngleMin+180)*Rad)*Mid*0.15));
   A.Canvas.LineTo(  Round(Mid+cos(AngleMin*Rad)*FMinRad),
                     Round(Mid+sin(AngleMin*Rad)*FMinRad));

   if Assigned(Parent) then
   begin
      A.Canvas.Brush.Color:=TPeekAtControl(Parent).Color;
      A.Canvas.Pen.Color:= TPeekAtControl(Parent).Color ;
   end;
   A.Canvas.Pen.Width:=round(FHandHourWidth*0.1)*K;
   A.Canvas.MoveTo(  Round(Mid+cos((AngleHour+180)*Rad)*Mid*0.15),
                     Round(Mid+sin((AngleHour+180)*Rad)*Mid*0.15));
   A.Canvas.LineTo(  Round(Mid+cos(AngleHour*Rad)*FHourRad),
                     Round(Mid+sin(AngleHour*Rad)*FHourRad));
   A.Canvas.Pen.Width:=1*K;
   A.Canvas.Brush.Color:=FColorHour;
   A.Canvas.Ellipse( Round(Mid-A.Height*0.04), Round(Mid-A.Height*0.04),
                     Round(Mid+A.Height*0.04),Round( Mid+A.Height*0.04));
   if Assigned(Parent) then
   begin
      A.Canvas.Brush.Color:=TPeekAtControl(Parent).Color;
      A.Canvas.Pen.Color:= TPeekAtControl(Parent).Color ;
   end;
   A.Canvas.Ellipse( Round(Mid-A.Height*0.02), Round(Mid-A.Height*0.02),
                     Round(Mid+A.Height*0.02), Round(Mid+A.Height*0.02));
   A.Canvas.Brush.Color:=clBlack;
   A.Canvas.Pen.Color:=clGray;

   //Drawing Clock markers
   A.Canvas.Pen.Color:=FColorMarker;
   for i:=1 to 12 do
   begin
      if FLowTics then
      begin
         for j:=1 to 4 do
         begin
            A.Canvas.Pen.Color:=FColorMarker;
            A.Canvas.Pen.Width:=FTickWidth*K;
            A.Canvas.MoveTo(  Round(Mid+cos((270+30*(i-1)+6*j)*Rad)*Mid*0.80),
                              Round(Mid+sin((270+30*(i-1)+6*j)*Rad)*Mid*0.80));
            A.Canvas.LineTo(  Round(Mid+cos((270+30*(i-1)+6*j)*Rad)*Mid*0.75),
                              Round(Mid+sin((270+30*(i-1)+6*j)*Rad)*Mid*0.75));
         end;
      end;

      case FClockMarkers of
         cmNone:;
         cmTics:
            begin
               A.Canvas.Pen.Width:=2*FTickWidth*K;
               A.Canvas.MoveTo(  Round(Mid+cos((270+30*i)*Rad)*Mid*0.85),
                                 Round(Mid+sin((270+30*i)*pi/180)*Mid*0.85));
               A.Canvas.LineTo(  Round(Mid+cos((270+30*i)*Rad)*Mid*0.75),
                        Round(Mid+sin((270+30*i)*pi/180)*Mid*0.75));
            end;
         cmRounds:
            begin
               A.Canvas.Brush.Style:=bsClear;
               A.Canvas.Pen.Width:=2*FTickWidth*K;
               A.Canvas.Ellipse( Round(Mid+cos((270+30*i)*Rad)*Mid*0.77-A.Height*0.02),
                        Round(Mid+sin((270+30*i)*Rad)*Mid*0.77-A.Height*0.02),
                        Round(Mid+cos((270+30*i)*Rad)*Mid*0.77+A.Height*0.02),
                        Round(Mid+sin((270+30*i)*Rad)*Mid*0.77+A.Height*0.02));
            end;
         cmNumbers:
            begin
               A.Canvas.Pen.Width:=1*K;
               A.Canvas.Brush.Style:=bsClear;
               A.Canvas.Font.Size:=Round(A.Height*0.08);
               A.Canvas.TextOut( Round(Mid+cos((270+30*i)*Rad)*Mid*0.77-A.Canvas.TextWidth(inttostr(i))/2),
                                 Round(Mid+sin((270+30*i)*Rad)*Mid*0.77-A.Canvas.TextHeight('0')/2),
                                 inttostr(i));
            end;
         cmSimple:
            begin
               if (i mod 3)=0 then
               begin
                  A.Canvas.Brush.Color:=FColorMarker;
                  A.Canvas.Pen.Width:=Round(A.Height*0.02);
                  A.Canvas.Pen.Color:=clBlack;
                  A.Canvas.Rectangle(  Round(Mid+cos((270+30*i)*Rad)*Mid*0.75-A.Height*0.05),
                                       Round(Mid+sin((270+30*i)*Rad)*Mid*0.75-A.Height*0.05),
                                       Round(Mid+cos((270+30*i)*Rad)*Mid*0.75+A.Height*0.05),
                                       Round(Mid+sin((270+30*i)*Rad)*Mid*0.75+A.Height*0.05));

                  A.Canvas.Pen.Width:=Round(A.Height*0.03);
                  A.Canvas.Pen.Color:=clBlack;
                  A.Canvas.MoveTo(  Round(Mid+cos((270+30*i)*Rad)*Mid*0.85),
                                    Round(Mid+sin((270+30*i)*pi/180)*Mid*0.85));
                  A.Canvas.LineTo(  Round(Mid+cos((270+30*i)*Rad)*Mid*0.65),
                                    Round(Mid+sin((270+30*i)*pi/180)*Mid*0.65));
               end;
            end;
      end;
   end;
end;

procedure TTimeIndicator.DrowScale;
begin
   if FAntiAliased=aaNone then
   begin
      DrowScaleEx(BitMapTmp);
      Self.Picture.Bitmap:=BitMapTmp;
   end else
   begin
      DrowScaleEx(BitMapTmpEx);
      FastAntiAliasPicture( GetAAMultipler,BitMapTmpEx,FAABitmap);
      BitBlt(BitMapTmp.Canvas.Handle, 0, 0, FAABitmap.Width,
         FAABitmap.Height, FAABitmap.Canvas.Handle, 0, 0, SRCCOPY);
      Self.Picture.Bitmap:=BitMapTmp;
  end;
end;

function TTimeIndicator.GetAAMultipler: Integer;
begin
  case FAntiAliased of
    aaBiline: Result := 2;
    aaTriline: Result := 3;
    aaQuadral: Result := 4;
    else Result := 1
  end
end;

procedure TTimeIndicator.SetFAntiAliased(AValue: TAntialiased);
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

procedure TTimeIndicator.SetFrameForm(AValue: TFrameForm);
begin
   if AValue <> FFrameForm then
   begin
      FFrameForm:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetClockMarkers(AValue:TClockMarkers);
begin
   if AValue <> FClockMarkers then
   begin
      FClockMarkers:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.Resize;
begin
   inherited Resize;
   if not ((csLoading in ComponentState) or
            (csReading in ComponentState)) then
   if FInitState then
   begin
      if FClockEx then Width:=2*Height else Width:=Height;
      BitMapTmp.Height:= Height;
      BitMapTmp.Width:= Width;
      BitMapTmpEx.Height:=GetAAMultipler*Height;
      BitMapTmpEx.Width:=GetAAMultipler*Width;
      FAABitmap.Height:=Height;
      FAABitmap.Width:=Width;
      FWidth:=Width;
      FHeight:=Height;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetHeight(AValue:integer);
begin
   if AValue<>FHeight then
   begin
      BitMapTmp.Height:= AValue;
      BitMapTmpEx.Height:=AValue*GetAAMultipler;
      FAABitmap.Height:=AValue;
      FHeight:=AValue;
      Height:=FHeight;
      if FInitState then DrowScale;
   end;
end;

procedure TTimeIndicator.SetWidth(AValue:integer);
begin
   if AValue<>FWidth then
   begin
      BitMapTmp.Width:= AValue;
      BitMapTmpEx.Width:=AValue*GetAAMultipler;
      FAABitmap.Width:=AValue;
      FWidth:=AValue;
      Width:=FWidth;
      if FInitState then DrowScale;
   end;
end;

procedure TTimeIndicator.SetFrameWidth(AValue:integer);
begin
   if (FFrameWidth<>AValue) then
   begin
      FFrameWidth:=AValue;
      if FFrameWidth=0 then FFrameWidth:=1;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetHandHourWidth(AValue:integer);
begin
   if (FHandHourWidth<>AValue) then
   begin
      FHandHourWidth:=AValue;
      if FHandHourWidth=0 then FHandHourWidth:=1;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetHandMinWidth(AValue:integer);
begin
   if (FHandMinWidth<>AValue) then
   begin
      FHandMinWidth:=AValue;
      if FHandMinWidth=0 then FHandMinWidth:=1;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetTickWidth(AValue:integer);
begin
   if (FTickWidth<>AValue) then
   begin
      FTickWidth:=AValue;
      if FTickWidth=0 then FTickWidth:=1;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetColorFrame(AValue:TColor);
begin
   if FColorFrame<>AValue then
   begin
      FColorFrame:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetColorHour(AValue:TColor);
begin
   if FColorHour<>AValue then
   begin
      FColorHour:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetColorMinute(AValue:TColor);
begin
   if FColorMinute<>AValue then
   begin
      FColorMinute:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetColorMarker(AValue:TColor);
begin
   if FColorMarker<>AValue then
   begin
      FColorMarker:=AValue;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetClockEx(AValue:boolean);
begin
   if FClockEx<>AValue then
   begin
      FClockEx:=AValue;
      if FClockEx then Width:=2*FHeight else  Width:=FHeight;
      DrowScale;
   end;
end;

procedure TTimeIndicator.SetLowTics(AValue:boolean);
begin
   if FLowTics<>AValue then
   begin
      FLowTics:=AValue;
      DrowScale;
   end;
end;

end.
