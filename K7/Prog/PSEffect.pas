unit PSEffect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, JPEG;

const
  Bmp32Styles = [118 .. 122];

type
  TEffectProc = procedure(Screen, Image: TBitmap; const Rect: TRect;
    Step: Integer; Progress: Integer);

procedure Effect001(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect002(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect003(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect004(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect005(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect006(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect007(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect008(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect009(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect010(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect011(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect012(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect013(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect014(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect015(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect016(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect017(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect018(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect019(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect020(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect021(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect022(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect023(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect024(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect025(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect026(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect027(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect028(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect029(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect030(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect031(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect032(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect033(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect034(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect035(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect036(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect037(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect038(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect039(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect040(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect041(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect042(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect043(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect044(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect045(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect046(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect047(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect048(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect049(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect050(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect051(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect052(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect053(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect054(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect055(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect056(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect057(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect058(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect059(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect060(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect061(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect062(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect063(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect064(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect065(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect066(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect067(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect068(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect069(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect070(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect071(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect072(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect073(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect074(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect075(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect076(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect077(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect078(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect079(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect080(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect081(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect082(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect083(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect084(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect085(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect086(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect087(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect088(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect089(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect090(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect091(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect092(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect093(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect094(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect095(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect096(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect097(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect098(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect099(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect100(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect101(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect102(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect103(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect104(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect105(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect106(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect107(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect108(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect109(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect110(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect111(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect112(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect113(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect114(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect115(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect116(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect117(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect118(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect119(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect120(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect121(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect122(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect123(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect124(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect125(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect126(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect127(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect128(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect129(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect130(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect131(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect132(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect133(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect134(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect135(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect136(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect137(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect138(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect139(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect140(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect141(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect142(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect143(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect144(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect145(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect146(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect147(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect148(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect149(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
procedure Effect150(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);

type
  TEffect = record
    Name: String;
    Proc: TEffectProc;
  end;

const
  CustomEffectName = 'Custom';
  PSEffects: array [1 .. 150] of TEffect = ((Name: 'Expand from right';
    Proc: Effect001), (Name: 'Expand from left'; Proc: Effect002),
    (Name: 'Slide in from right'; Proc: Effect003), (Name: 'Slide in from left';
    Proc: Effect004), (Name: 'Reveal from left'; Proc: Effect005),
    (Name: 'Reveal from right'; Proc: Effect006), (Name: 'Expand in from right';
    Proc: Effect007), (Name: 'Expand in from left'; Proc: Effect008),
    (Name: 'Expand in to middle'; Proc: Effect009),
    (Name: 'Expand out from middle'; Proc: Effect010),
    (Name: 'Reveal out from middle'; Proc: Effect011),
    (Name: 'Reveal in from sides'; Proc: Effect012),
    (Name: 'Expand in from sides'; Proc: Effect013), (Name: 'Unroll from left';
    Proc: Effect014), (Name: 'Unroll from right'; Proc: Effect015),
    (Name: 'Build up from right'; Proc: Effect016), (Name: 'Build up from left';
    Proc: Effect017), (Name: 'Expand from bottom'; Proc: Effect018),
    (Name: 'Expand from top'; Proc: Effect019), (Name: 'Slide in from bottom';
    Proc: Effect020), (Name: 'Slide in from top'; Proc: Effect021),
    (Name: 'Reveal from top'; Proc: Effect022), (Name: 'Reveal from bottom';
    Proc: Effect023), (Name: 'Expand in from bottom'; Proc: Effect024),
    (Name: 'Expand in from top'; Proc: Effect025),
    (Name: 'Expand in to middle (horiz)'; Proc: Effect026),
    (Name: 'Expand out from middle (horiz)'; Proc: Effect027),
    (Name: 'Reveal from middle (horiz)'; Proc: Effect028),
    (Name: 'Slide in from top / bottom'; Proc: Effect029),
    (Name: 'Expand in from top / bottom'; Proc: Effect030),
    (Name: 'Unroll from top'; Proc: Effect031), (Name: 'Unroll from bottom';
    Proc: Effect032), (Name: 'Expand from bottom'; Proc: Effect033),
    (Name: 'Expand in from top'; Proc: Effect034),
    (Name: 'Expand from bottom right'; Proc: Effect035),
    (Name: 'Expand from top right'; Proc: Effect036),
    (Name: 'Expand from top left'; Proc: Effect037),
    (Name: 'Expand from bottom left'; Proc: Effect038),
    (Name: 'Slide in from bottom right'; Proc: Effect039),
    (Name: 'Slide in from top right'; Proc: Effect040),
    (Name: 'Slide in from top left'; Proc: Effect041),
    (Name: 'Slide in from bottom left'; Proc: Effect042),
    (Name: 'Reveal from top left'; Proc: Effect043),
    (Name: 'Reveal from bottom left'; Proc: Effect044),
    (Name: 'Reveal from bottom right'; Proc: Effect045),
    (Name: 'Reveal from top right'; Proc: Effect046),
    (Name: 'Appear and Contract to top left'; Proc: Effect047),
    (Name: 'Appear and Contract to bottom left'; Proc: Effect048),
    (Name: 'Appear and Contract to bottom right'; Proc: Effect049),
    (Name: 'Appear and Contract to top right'; Proc: Effect050),
    (Name: 'Appear and Contract to middle'; Proc: Effect051),
    (Name: 'Expand out from centre'; Proc: Effect052),
    (Name: 'Reveal out from centre'; Proc: Effect053),
    (Name: 'Reveal in to centre'; Proc: Effect054),
    (Name: 'Quarters Reveal in to middle'; Proc: Effect055),
    (Name: 'Quarters Expand to middle'; Proc: Effect056),
    (Name: 'Quarters Slide in to middle'; Proc: Effect057),
    (Name: 'Curved Reveal from left'; Proc: Effect058),
    (Name: 'Curved Reveal from right'; Proc: Effect059),
    (Name: 'Bars in from right'; Proc: Effect060), (Name: 'Bars in from left';
    Proc: Effect061), (Name: 'Bars left then right'; Proc: Effect062),
    (Name: 'Bars right then left'; Proc: Effect063),
    (Name: 'Bars from both sides'; Proc: Effect064),
    (Name: 'Uneven shred from right'; Proc: Effect065),
    (Name: 'Uneven shred from left'; Proc: Effect066),
    (Name: 'Uneven shred out from middle (horiz)'; Proc: Effect067),
    (Name: 'Uneven shred in to middle (horiz)'; Proc: Effect068),
    (Name: 'Curved Reveal from top'; Proc: Effect069),
    (Name: 'Curved Reveal from bottom'; Proc: Effect070),
    (Name: 'Bars from bottom'; Proc: Effect071), (Name: 'Bars from top';
    Proc: Effect072), (Name: 'Bars top then bottom'; Proc: Effect073),
    (Name: 'Bars bottom then top'; Proc: Effect074),
    (Name: 'Bars from top and bottom'; Proc: Effect075),
    (Name: 'Unven shred from bottom'; Proc: Effect076),
    (Name: 'Uneven shred from top'; Proc: Effect077),
    (Name: 'Uneven shred from horizon'; Proc: Effect078),
    (Name: 'Uneven shred in to horizon'; Proc: Effect079),
    (Name: 'Curved reveal from top left'; Proc: Effect080),
    (Name: 'Curved reveal from top right'; Proc: Effect081),
    (Name: 'Curved reveal from bottom left'; Proc: Effect082),
    (Name: 'Curved reveal from bottom right'; Proc: Effect083),
    (Name: 'Circular reveal from centre'; Proc: Effect084),
    (Name: 'Circular reveal to centre'; Proc: Effect085),
    (Name: 'Criss Cross reveal from bottom right'; Proc: Effect086),
    (Name: 'Criss Cross reveal from top right'; Proc: Effect087),
    (Name: 'Criss Cross reveal from bottom left'; Proc: Effect088),
    (Name: 'Criss Cross reveal from top left'; Proc: Effect089),
    (Name: 'Criss Cross reveal bounce from top left'; Proc: Effect090),
    (Name: 'Criss Cross reveal bounce from bottom left'; Proc: Effect091),
    (Name: 'Criss Cross reveal bounce from top right'; Proc: Effect092),
    (Name: 'Criss Cross reveal bounce from bottom right'; Proc: Effect093),
    (Name: 'Criss Cross reveal from right top and bottom'; Proc: Effect094),
    (Name: 'Criss Cross reveal from left top and bottom'; Proc: Effect095),
    (Name: 'Criss Cross reveal from left right and bottom'; Proc: Effect096),
    (Name: 'Criss Cross reveal from left right and top'; Proc: Effect097),
    (Name: 'Criss Cross reveal from top left right and bottom';
    Proc: Effect098), (Name: 'Criss Cross reveal from bottom left top right';
    Proc: Effect099), (Name: 'Uneven shred from bottom and right';
    Proc: Effect100), (Name: 'Uneven shred from top and right';
    Proc: Effect101), (Name: 'Uneven shred from bottom and left';
    Proc: Effect102), (Name: 'Uneven shred from top and left'; Proc: Effect103),
    (Name: 'Uneven shred from horiz and right'; Proc: Effect104),
    (Name: 'Uneven shred from horiz and left'; Proc: Effect105),
    (Name: 'Uneven shred from bottom and vert middle'; Proc: Effect106),
    (Name: 'Uneven shred from top and vert middle'; Proc: Effect107),
    (Name: 'Uneven shred from centre'; Proc: Effect108),
    (Name: 'Uneven shred to centre'; Proc: Effect109),
    (Name: 'Reveal diagonal from top left'; Proc: Effect110),
    (Name: 'Reveal diagonal from top right'; Proc: Effect111),
    (Name: 'Reveal diagonal from bottom left'; Proc: Effect112),
    (Name: 'Reveal diagonal from bottom right'; Proc: Effect113),
    (Name: 'Diagonal sweep from top left bottom right anticlockwise';
    Proc: Effect114),
    (Name: 'Diagonal sweep from top left bottom right clockwise';
    Proc: Effect115), (Name: 'Starburst clockwise from center';
    Proc: Effect116), (Name: 'Triangular shred to top left'; Proc: Effect117),
    (Name: 'Fade'; Proc: Effect118), (Name: 'Pivot from top left';
    Proc: Effect119), (Name: 'Pivot from bottom left'; Proc: Effect120),
    (Name: 'Pivot from top right'; Proc: Effect121),
    (Name: 'Pivot from bottom right'; Proc: Effect122),
    (Name: 'Speckle appear from right'; Proc: Effect123),
    (Name: 'Speckle appear from left'; Proc: Effect124),
    (Name: 'Speckle appear from bottom'; Proc: Effect125),
    (Name: 'Speckle appear from top'; Proc: Effect126),
    (Name: 'Random squares appear'; Proc: Effect127), (Name: 'Push right';
    Proc: Effect128), (Name: 'Push left'; Proc: Effect129),
    (Name: 'Push and squeeze right'; Proc: Effect130),
    (Name: 'Push and squeeze left'; Proc: Effect131), (Name: 'Push down';
    Proc: Effect132), (Name: 'Push up'; Proc: Effect133),
    (Name: 'Push and sqeeze down'; Proc: Effect134),
    (Name: 'Push and sqeeze up'; Proc: Effect135), (Name: 'Blind vertically';
    Proc: Effect136), (Name: 'Blind horizontally'; Proc: Effect137),
    (Name: 'Uneven blind from left'; Proc: Effect138),
    (Name: 'Uneven blind from right'; Proc: Effect139),
    (Name: 'Uneven blind from top'; Proc: Effect140),
    (Name: 'Uneven blind from bottom'; Proc: Effect141),
    (Name: 'Rectangular shred'; Proc: Effect142), (Name: 'Sweep clockwise';
    Proc: Effect143), (Name: 'Sweep anticlockwise'; Proc: Effect144),
    (Name: 'Rectangles apear from left and disapear to right'; Proc: Effect145),
    (Name: 'Rectangles apear from right and disapear to left'; Proc: Effect146),
    (Name: 'Rectangles apear from up and disapear to bottom'; Proc: Effect147),
    (Name: 'Rectangles apear from bottom and disapear to up'; Proc: Effect148),
    (Name: 'Rotational rectangle'; Proc: Effect149), (Name: 'Rotational star';
    Proc: Effect150));

procedure MirrorCopyRect(Canvas: TCanvas; dstRect: TRect; Bitmap: TBitmap;
  srcRect: TRect; Horz, Vert: Boolean);
procedure MergeTransparent(dstBitmap, srcBitmap: TBitmap;
  Transparency: Integer);
procedure MergeRotate(dstBitmap, srcBitmap: TBitmap; xOrg, yOrg: Integer;
  Angle: Extended);
procedure RotatePoints(var Points: array of TPoint; xOrg, yOrg: Integer;
  Angle: Extended);

implementation

uses
  Math;

const
  MaxPixelCount = 32768;

type
  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array [0 .. MaxPixelCount] of TRGBQuad;
{$IFNDEF DELPHI4_UP}
  HRGN = THandle;
{$ENDIF}
  { Global Functions }

procedure MirrorCopyRect(Canvas: TCanvas; dstRect: TRect; Bitmap: TBitmap;
  srcRect: TRect; Horz, Vert: Boolean);
var
  T: Integer;
begin
  IntersectRect(srcRect, srcRect, Rect(0, 0, Bitmap.Width, Bitmap.Height));
  if Horz then
  begin
    T := dstRect.Left;
    dstRect.Left := dstRect.Right + 1;
    dstRect.Right := T - 1;
  end;
  if Vert then
  begin
    T := dstRect.Top;
    dstRect.Top := dstRect.Bottom + 1;
    dstRect.Bottom := T - 1;
  end;
  StretchBlt(Canvas.Handle, dstRect.Left, dstRect.Top,
    dstRect.Right - dstRect.Left, dstRect.Bottom - dstRect.Top,
    Bitmap.Canvas.Handle, srcRect.Left, srcRect.Top,
    srcRect.Right - srcRect.Left, srcRect.Bottom - srcRect.Top, SRCCOPY);
end;

// Both bitmaps must be equal size and 32 bit format.
procedure MergeTransparent(dstBitmap, srcBitmap: TBitmap;
  Transparency: Integer);
var
  dstPixel, srcPixel: PRGBQuad;
  InvertTransparency: Integer;
  bmpWidth, bmpHeight: Integer;
  x, y: Integer;
begin
  bmpWidth := srcBitmap.Width;
  bmpHeight := srcBitmap.Height;
  InvertTransparency := 100 - Transparency;
  for y := 0 to bmpHeight - 1 do
  begin
    srcPixel := srcBitmap.ScanLine[y];
    dstPixel := dstBitmap.ScanLine[y];
    for x := 0 to bmpWidth - 1 do
    begin
      dstPixel^.rgbRed := ((InvertTransparency * dstPixel^.rgbRed) +
        (Transparency * srcPixel^.rgbRed)) div 100;
      dstPixel^.rgbGreen := ((InvertTransparency * dstPixel^.rgbGreen) +
        (Transparency * srcPixel^.rgbGreen)) div 100;
      dstPixel^.rgbBlue := ((InvertTransparency * dstPixel^.rgbBlue) +
        (Transparency * srcPixel^.rgbBlue)) div 100;
      Inc(srcPixel);
      Inc(dstPixel);
    end;
  end;
end;

// Both bitmaps must be equal size and 32 bit format. Angle is in radians.
procedure MergeRotate(dstBitmap, srcBitmap: TBitmap; xOrg, yOrg: Integer;
  Angle: Extended);
var
  CosTheta, SinTheta: Extended;
  iCosTheta, iSinTheta: Integer;
  xSrc, ySrc: Integer;
  xDst, yDst: Integer;
  xPrime, yPrime: Integer;
  bmpWidth, bmpHeight: Integer;
  yPrimeSinTheta, yPrimeCosTheta: Integer;
  srcBits: PRGBQuadArray;
  dstBits: PRGBQuad;
begin
  SinCos(-Angle, SinTheta, CosTheta);
  iSinTheta := Trunc(SinTheta * (1 shl 16));
  iCosTheta := Trunc(CosTheta * (1 shl 16));
  bmpWidth := srcBitmap.Width;
  bmpHeight := srcBitmap.Height;
  srcBits := srcBitmap.ScanLine[bmpHeight - 1];
  dstBits := @(PRGBQuadArray(dstBitmap.ScanLine[0])[bmpWidth - 1]);
  yPrime := bmpHeight - yOrg;
  for yDst := bmpHeight - 1 downto 0 do
  begin
    yPrimeSinTheta := yPrime * iSinTheta;
    yPrimeCosTheta := yPrime * iCosTheta;
    xPrime := bmpWidth - xOrg;
    for xDst := bmpWidth - 1 downto 0 do
    begin
      xSrc := SmallInt((xPrime * iCosTheta - yPrimeSinTheta) shr 16) + xOrg;
      ySrc := SmallInt((xPrime * iSinTheta + yPrimeCosTheta) shr 16) + yOrg;
{$IFDEF DELPHI4_UP}
      if (DWORD(ySrc) < DWORD(bmpHeight)) and (DWORD(xSrc) < DWORD(bmpWidth))
      then
{$ELSE} // Delphi 3 compiler ignores unsigned type cast and generates signed comparison code!
      if (ySrc >= 0) and (ySrc < bmpHeight) and (xSrc >= 0) and (xSrc < bmpWidth)
      then
{$ENDIF}
      begin
        dstBits^ := srcBits[ySrc * bmpWidth + xSrc];
      end;
      Dec(dstBits);
      Dec(xPrime);
    end;
    Dec(yPrime);
  end;
end;

// Angle is in radians.
procedure RotatePoints(var Points: array of TPoint; xOrg, yOrg: Integer;
  Angle: Extended);
var
  Sin, Cos: Extended;
  xPrime, yPrime: Integer;
  I: Integer;
begin
  SinCos(Angle, Sin, Cos);
  for I := Low(Points) to High(Points) do
  begin
    xPrime := Points[I].x - xOrg;
    yPrime := Points[I].y - yOrg;
    Points[I].x := Round(xPrime * Cos - yPrime * Sin) + xOrg;
    Points[I].y := Round(xPrime * Sin + yPrime * Cos) + yOrg;
  end;
end;

{ Helper Functions }

function CreateBarRgn(x, y, W, H, S: Integer; XMode, YMode: Integer): HRGN;
var
  X1, Y1: Integer;
  Rgn, tRgn: HRGN;
begin
  Result := 0;
  if x <= W then
    Y1 := 0
  else
    Y1 := 5;
  while Y1 < H + 5 do
  begin
    if x > W then
    begin
      if XMode in [1, 4] then
        tRgn := CreateRectRgn(2 * W - x, Y1, W, Y1 + 5)
      else if XMode in [2, 5] then
        tRgn := CreateRectRgn(0, Y1, x - W, Y1 + 5)
      else
        tRgn := 0;
      Rgn := CreateRectRgn(0, Y1 - 5, W, Y1);
      if tRgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end;
    end
    else
    begin
      if (x + S) > W then
        x := W;
      if XMode in [1, 5] then
        Rgn := CreateRectRgn(W - x, Y1, W, Y1 + 5)
      else if XMode in [2, 4] then
        Rgn := CreateRectRgn(0, Y1, x, Y1 + 5)
      else if XMode = 3 then
      begin
        Rgn := CreateRectRgn(0, Y1 + 5, x, Y1 + 10);
        tRgn := CreateRectRgn(W - x, Y1, W, Y1 + 5);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end
      else
        Rgn := 0;
    end;
    if Result <> 0 then
    begin
      CombineRgn(Result, Result, Rgn, RGN_OR);
      DeleteObject(Rgn);
    end
    else
      Result := Rgn;
    Inc(Y1, 10)
  end;
  if y <= H then
    X1 := 0
  else
    X1 := 5;
  while X1 < W + 5 do
  begin
    if y > H then
    begin
      if YMode in [1, 4] then
        tRgn := CreateRectRgn(X1, 2 * H - y, X1 + 5, H)
      else if YMode in [2, 5] then
        tRgn := CreateRectRgn(X1, 0, X1 + 5, y - H)
      else
        tRgn := 0;
      Rgn := CreateRectRgn(X1 - 5, 0, X1, H);
      if tRgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end;
    end
    else
    begin
      if (y + S) > H then
        y := H;
      if YMode in [1, 5] then
        Rgn := CreateRectRgn(X1, H - y, X1 + 5, H)
      else if YMode in [2, 4] then
        Rgn := CreateRectRgn(X1, 0, X1 + 5, y)
      else if YMode = 3 then
      begin
        tRgn := CreateRectRgn(X1, H - y, X1 + 5, H);
        Rgn := CreateRectRgn(X1 + 5, 0, X1 + 10, y);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end
      else
        Rgn := 0;
    end;
    if Rgn <> 0 then
    begin
      if Result <> 0 then
      begin
        CombineRgn(Result, Result, Rgn, RGN_OR);
        DeleteObject(Rgn);
      end
      else
        Result := Rgn;
    end;
    Inc(X1, 10)
  end;
end;

function CreatePourRgn(x, y, W, H, XMode, YMode: Integer): HRGN;
var
  X1, Y1, N: Integer;
  Rgn, tRgn: HRGN;
begin
  Result := 0;
  if XMode <> 0 then
  begin
    if x < W then
      N := W div 7
    else
      N := 0;
    Y1 := 0;
    while Y1 < H do
    begin
      if XMode = 1 then
        Rgn := CreateRectRgn(W - x + Random(N) - Random(N), Y1, W,
          Y1 + 5 + H mod 5)
      else if XMode = 2 then
        Rgn := CreateRectRgn(0, Y1, x + Random(N) - Random(N), Y1 + 5 + H mod 5)
      else if XMode = 3 then
      begin
        Rgn := CreateRectRgn((W - x + Random(N) - Random(N)) div 2, Y1, W div 2,
          Y1 + 5 + H mod 5);
        tRgn := CreateRectRgn(W div 2, Y1, (W + x + Random(N) - Random(N))
          div 2, Y1 + 5 + H mod 5);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end
      else
      begin
        Rgn := CreateRectRgn(W - (x + Random(N) - Random(N)) div 2, Y1, W,
          Y1 + 5 + H mod 5);
        tRgn := CreateRectRgn(0, Y1, (x + Random(N) - Random(N)) div 2,
          Y1 + 5 + H mod 5);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end;
      if Result <> 0 then
      begin
        CombineRgn(Result, Result, Rgn, RGN_OR);
        DeleteObject(Rgn);
      end
      else
        Result := Rgn;
      Inc(Y1, 5);
    end;
  end;
  if YMode <> 0 then
  begin
    if y < H then
      N := H div 7
    else
      N := 0;
    X1 := 0;
    while X1 < W do
    begin
      if YMode = 1 then
        Rgn := CreateRectRgn(X1, H - y + Random(N) - Random(N),
          X1 + 5 + W mod 5, H)
      else if YMode = 2 then
        Rgn := CreateRectRgn(X1, 0, X1 + 5 + W mod 5, y + Random(N) - Random(N))
      else if YMode = 3 then
      begin
        Rgn := CreateRectRgn(X1, (H - y + Random(N) - Random(N)) div 2,
          X1 + 5 + W mod 5, H div 2);
        tRgn := CreateRectRgn(X1, H div 2, X1 + 5 + W mod 5,
          (H + y + Random(N) - Random(N)) div 2);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end
      else
      begin
        Rgn := CreateRectRgn(X1, H - (y + Random(N) - Random(N)) div 2,
          X1 + 5 + W mod 5, H);
        tRgn := CreateRectRgn(X1, 0, X1 + 5 + W mod 5,
          (y + Random(N) - Random(N)) div 2);
        CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
        DeleteObject(tRgn);
      end;
      if Result <> 0 then
      begin
        CombineRgn(Result, Result, Rgn, RGN_OR);
        DeleteObject(Rgn);
      end
      else
        Result := Rgn;
      Inc(X1, 5);
    end;
  end;
end;

function CreateSwarmRgn(x, y, W, H, XMode, YMode: Integer): HRGN;
var
  X1, Y1, N, M, I, J: Integer;
  Rgn, tRgn: HRGN;
begin
  Result := 0;
  if XMode <> 0 then
  begin
    if x < W then
      N := W div 10
    else
      N := 0;
    M := N div 20;
    if M < 2 then
      M := 2;
    Y1 := 0;
    while Y1 < H do
    begin
      if XMode = 1 then
      begin
        Rgn := CreateRectRgn(W - x, Y1, W, Y1 + M);
        for I := N div M downto 1 do
        begin
          if I > 3 * N div M div 4 then
            J := 0
          else
            J := 1;
          if Random(I) <= J then
          begin
            X1 := (W - x) - (I * M);
            tRgn := CreateRectRgn(X1, Y1, X1 + M, Y1 + M);
            CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
            DeleteObject(tRgn);
          end;
        end;
      end
      else
      begin
        Rgn := CreateRectRgn(0, Y1, x, Y1 + M);
        for I := N div M downto 1 do
        begin
          if I > 3 * N div M div 4 then
            J := 0
          else
            J := 1;
          if Random(I) <= J then
          begin
            X1 := x + (I * M);
            tRgn := CreateRectRgn(X1 - M, Y1, X1, Y1 + M);
            CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
            DeleteObject(tRgn);
          end;
        end;
      end;
      if Result <> 0 then
      begin
        CombineRgn(Result, Result, Rgn, RGN_OR);
        DeleteObject(Rgn);
      end
      else
        Result := Rgn;
      Inc(Y1, M div 2);
    end;
  end;
  if YMode <> 0 then
  begin
    if y < H then
      N := H div 10
    else
      N := 0;
    M := N div 20;
    if M < 2 then
      M := 2;
    X1 := 0;
    while X1 < W do
    begin
      if YMode = 1 then
      begin
        Rgn := CreateRectRgn(X1, H - y, X1 + M, H);
        for I := N div M downto 1 do
        begin
          if I > 3 * N div M div 4 then
            J := 0
          else
            J := 1;
          if Random(I) <= J then
          begin
            Y1 := (H - y) - (I * M);
            tRgn := CreateRectRgn(X1, Y1, X1 + M, Y1 + M);
            CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
            DeleteObject(tRgn);
          end;
        end;
      end
      else
      begin
        Rgn := CreateRectRgn(X1, 0, X1 + M, y);
        for I := N div M downto 1 do
        begin
          if I > 3 * N div M div 4 then
            J := 0
          else
            J := 1;
          if Random(I) <= J then
          begin
            Y1 := y + (I * M);
            tRgn := CreateRectRgn(X1, Y1 - M, X1 + M, Y1);
            CombineRgn(Rgn, Rgn, tRgn, RGN_OR);
            DeleteObject(tRgn);
          end;
        end;
      end;
      if Result <> 0 then
      begin
        CombineRgn(Result, Result, Rgn, RGN_OR);
        DeleteObject(Rgn);
      end
      else
        Result := Rgn;
      Inc(X1, M div 2);
    end;
  end;
end;

function CreateTriangleRgn(X1, Y1, X2, Y2, X3, Y3: Integer): HRGN;
var
  Pts: array [1 .. 3] of TPoint;
begin
  Pts[1].x := X1;
  Pts[1].y := Y1;
  Pts[2].x := X2;
  Pts[2].y := Y2;
  Pts[3].x := X3;
  Pts[3].y := Y3;
  Result := CreatePolygonRgn(Pts, High(Pts), WINDING);
end;

function CreateArcRgn(mX, mY, Radius: Integer; StartAngle, EndAngle: Extended;
  NumPts: Integer): HRGN;
type
  PtArray = array [0 .. 0] of TPoint;
var
  Pts: ^PtArray;
  Sin, Cos, Delta: Extended;
  I: Integer;
begin
  GetMem(Pts, (NumPts + 1) * SizeOf(TPoint));
  try
    Pts[0].x := mX;
    Pts[0].y := mY;
    Delta := (EndAngle - StartAngle) / NumPts;
    for I := 1 to NumPts do
    begin
      SinCos(StartAngle, Sin, Cos);
      Pts[I].x := mX + Round(Radius * Cos);
      Pts[I].y := mY + Round(Radius * Sin);
      StartAngle := StartAngle + Delta;
    end;
    Result := CreatePolygonRgn(Pts^, NumPts + 1, WINDING);
  finally
    FreeMem(Pts);
  end;
end;

procedure CalcParams(const Rect: TRect; Step: Integer; Progress: Integer;
  var W, H, x, y, Slice: Integer);
begin
  W := Rect.Right - Rect.Left;
  H := Rect.Bottom - Rect.Top;
  if W >= H then
  begin
    x := MulDiv(W, Progress, 100);
    y := MulDiv(x, H, W);
    Slice := MulDiv(W, Step, 90);
  end
  else
  begin
    y := MulDiv(H, Progress, 100);
    x := MulDiv(y, W, H);
    Slice := MulDiv(H, Step, 90);
  end;
end;

{$IFNDEF DELPHI4_UP}

function Min(A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}
{$IFNDEF DELPHI4_UP}

function Max(A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}
{ Transition Effects }

procedure Effect001(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect002(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Right := x;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect003(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  R.Right := (2 * W) - x;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect004(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := x - W;
  R.Right := x;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect005(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := x;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect006(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := W - x;
  R2.Left := W - x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect007(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := (2 * W) - x;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect008(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x - W;
  R2.Left := W - x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect009(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x - W;
  R1.Right := (2 * W) - x;
  R2.Left := (W - x) div 2;
  R2.Right := (W + x) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect010(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := (W - x) div 2;
  R.Right := (W + x) div 2;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect011(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := (W - x) div 2;
  R1.Right := (W + x) div 2;
  R2.Left := (W - x) div 2;
  R2.Right := (W + x) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect012(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := (x div 2) + 1;
  R2.Right := (x div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2) - 1;
  R1.Right := W;
  R2.Left := W - (x div 2) - 1;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect013(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := (x div 2) + 1;
  R2.Right := (W div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2) - 1;
  R1.Right := W;
  R2.Left := W div 2;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect014(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x;
  if R1.Left < W div 5 then
    R1.Right := R1.Left + x div 2
  else if (R1.Left + W div 5) > W then
    R1.Right := R1.Left + (W - x) div 2
  else
    R1.Right := R1.Left + W div 10;
  R2.Left := R1.Right;
  R2.Right := R2.Left + R1.Right - R1.Left;
  MirrorCopyRect(Screen.Canvas, R1, Image, R2, True, False);
  R1.Left := 0;
  R1.Right := x;
  R2.Left := 0;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect015(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := W - x;
  if (R1.Right + W div 5) > W then
    R1.Left := R1.Right - x div 2
  else if R1.Right < W div 5 then
    R1.Left := R1.Right - (W - x) div 2
  else
    R1.Left := R1.Right - W div 10;
  R2.Right := R1.Left;
  R2.Left := R2.Right - R1.Right + R1.Left;
  MirrorCopyRect(Screen.Canvas, R1, Image, R2, True, False);
  R1.Left := W - x;
  R1.Right := W;
  R2.Left := W - x;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect016(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := x;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := x;
  R1.Right := W;
  R2.Left := x;
  R2.Right := Min(x + W div S, W);
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect017(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := W - x;
  R1.Right := W;
  R2.Left := W - x;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Right := W - x;
  R2.Left := Max((W - x) - W div S, 0);
  R2.Right := W - x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect018(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Top := H - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect019(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect020(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Top := H - y;
  R.Bottom := (2 * H) - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect021(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Top := y - H;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect022(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := y;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect023(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := H - y;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect024(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := (2 * H) - y;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect025(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := y - H;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect026(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := y - H;
  R1.Bottom := (2 * H) - y;
  R2.Top := (H - y) div 2;
  R2.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect027(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := (H - y) div 2;
  R1.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect028(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := (H - y) div 2;
  R1.Bottom := (H + y) div 2;
  R2.Top := (H - y) div 2;
  R2.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect029(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := (y div 2) + 1;
  R2.Bottom := (y div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Top := H - (y div 2) - 1;
  R1.Bottom := H;
  R2.Top := H - (y div 2) - 1;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect030(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := (y div 2) + 1;
  R2.Bottom := (H div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Top := H - (y div 2) - 1;
  R1.Bottom := H;
  R2.Top := H div 2;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect031(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := y;
  if R1.Top < H div 5 then
    R1.Bottom := R1.Top + y div 2
  else if (R1.Top + H div 5) > H then
    R1.Bottom := R1.Top + (H - y) div 2
  else
    R1.Bottom := R1.Top + H div 10;
  R2.Top := R1.Bottom;
  R2.Bottom := R2.Top + R1.Bottom - R1.Top;
  MirrorCopyRect(Screen.Canvas, R1, Image, R2, False, True);
  R1.Top := 0;
  R1.Bottom := y;
  R2.Top := 0;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect032(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := H - y;
  if (R1.Bottom + H div 5) > H then
    R1.Top := R1.Bottom - y div 2
  else if R1.Bottom < H div 5 then
    R1.Top := R1.Bottom - (H - y) div 2
  else
    R1.Top := R1.Bottom - H div 10;
  R2.Bottom := R1.Top;
  R2.Top := R2.Bottom - R1.Bottom + R1.Top;
  MirrorCopyRect(Screen.Canvas, R1, Image, R2, False, True);
  R1.Top := H - y;
  R1.Bottom := H;
  R2.Top := H - y;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect033(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Bottom := y;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Top := y;
  R1.Bottom := H;
  R2.Top := y;
  R2.Bottom := Min(y + H div S, H);
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect034(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := H - y;
  R1.Bottom := H;
  R2.Top := H - y;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Top := 0;
  R1.Bottom := H - y;
  R2.Top := Max((H - y) - H div S, 0);
  R2.Bottom := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect035(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  R.Top := H - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect036(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect037(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Right := x;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect038(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Right := x;
  R.Top := H - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect039(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  R.Top := H - y;
  R.Right := (2 * W) - x;
  R.Bottom := (2 * H) - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect040(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := W - x;
  R.Top := y - H;
  R.Right := (2 * W) - x;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect041(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := x - W;
  R.Top := y - H;
  R.Right := x;
  R.Bottom := y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect042(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R := Rect;
  R.Left := x - W;
  R.Top := H - y;
  R.Right := x;
  R.Bottom := (2 * H) - y;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect043(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := x;
  R1.Bottom := y;
  R2.Right := x;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect044(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := x;
  R1.Top := H - y;
  R2.Right := x;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect045(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := W - x;
  R1.Top := H - y;
  R2.Left := W - x;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect046(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := W - x;
  R1.Bottom := y;
  R2.Left := W - x;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect047(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := (2 * W) - x;
  R1.Bottom := (2 * H) - y;
  R2.Right := x;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect048(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Right := (2 * W) - x;
  R1.Top := y - H;
  R2.Right := x;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect049(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x - W;
  R1.Top := y - H;
  R2.Left := W - x;
  R2.Top := H - y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect050(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x - W;
  R1.Bottom := (2 * H) - y;
  R2.Left := W - x;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect051(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := x - W;
  R1.Top := y - H;
  R1.Right := (2 * W) - x;
  R1.Bottom := (2 * H) - y;
  R2.Left := (W - x) div 2;
  R2.Top := (H - y) div 2;
  R2.Right := (W + x) div 2;
  R2.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect052(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R.Left := (W - x) div 2;
  R.Top := (H - y) div 2;
  R.Right := (W + x) div 2;
  R.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R, Image.Canvas, Rect);
end;

procedure Effect053(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := (W - x) div 2;
  R1.Top := (H - y) div 2;
  R1.Right := (W + x) div 2;
  R1.Bottom := (H + y) div 2;
  R2.Left := (W - x) div 2;
  R2.Top := (H - y) div 2;
  R2.Right := (W + x) div 2;
  R2.Bottom := (H + y) div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect054(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := 0;
  R1.Right := W;
  R1.Top := 0;
  R1.Bottom := y div 2;
  R2.Left := 0;
  R2.Right := W;
  R2.Top := 0;
  R2.Bottom := y div 2;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Right := W;
  R1.Top := H - (y div 2);
  R1.Bottom := H;
  R2.Left := 0;
  R2.Right := W;
  R2.Top := H - (y div 2);
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Right := x div 2;
  R1.Top := 0;
  R1.Bottom := H;
  R2.Left := 0;
  R2.Right := x div 2;
  R2.Top := 0;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2);
  R1.Right := W;
  R1.Top := 0;
  R1.Bottom := H;
  R2.Left := W - (x div 2);
  R2.Right := W;
  R2.Top := 0;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect055(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := 0;
  R1.Top := 0;
  R1.Right := (x div 2) + 1;
  R1.Bottom := (y div 2) + 1;
  R2.Left := 0;
  R2.Top := 0;
  R2.Right := (x div 2) + 1;
  R2.Bottom := (y div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Top := H - (y div 2) - 1;
  R1.Right := (x div 2) + 1;
  R1.Bottom := H;
  R2.Left := 0;
  R2.Top := H - (y div 2) - 1;
  R2.Right := (x div 2) + 1;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2) - 1;
  R1.Top := H - (y div 2) - 1;
  R1.Right := W;
  R1.Bottom := H;
  R2.Left := W - (x div 2) - 1;
  R2.Top := H - (y div 2) - 1;
  R2.Right := W;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2) - 1;
  R1.Top := 0;
  R1.Right := W;
  R1.Bottom := (y div 2) + 1;
  R2.Left := W - (x div 2) - 1;
  R2.Top := 0;
  R2.Right := W;
  R2.Bottom := (y div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect056(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := 0;
  R1.Top := 0;
  R1.Right := (x div 2) + 1;
  R1.Bottom := (y div 2) + 1;
  R2.Left := 0;
  R2.Top := 0;
  R2.Right := (W div 2) + 1;
  R2.Bottom := (H div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Top := H - (y div 2);
  R1.Right := (x div 2) + 1;
  R1.Bottom := H;
  R2.Left := 0;
  R2.Top := (H div 2) + 1;
  R2.Right := (W div 2) + 1;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2);
  R1.Top := H - (y div 2);
  R1.Right := W;
  R1.Bottom := H;
  R2.Left := (W div 2) + 1;
  R2.Top := (H div 2) + 1;
  R2.Right := W;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - (x div 2);
  R1.Top := 0;
  R1.Right := W;
  R1.Bottom := (y div 2) + 1;
  R2.Left := (W div 2) + 1;
  R2.Top := 0;
  R2.Right := W;
  R2.Bottom := (H div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect057(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1.Left := (x - W) div 2;
  R1.Right := (x div 2) + 1;
  R1.Top := 0;
  R1.Bottom := (H div 2) + 1;
  R2.Left := 0;
  R2.Right := (W div 2) + 1;
  R2.Top := 0;
  R2.Bottom := (H div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := (W div 2) - 1;
  R1.Right := W;
  R1.Top := (y - H) div 2;
  R1.Bottom := (y div 2) + 1;
  R2.Left := (W div 2) - 1;
  R2.Right := W;
  R2.Top := 0;
  R2.Bottom := (H div 2) + 1;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := W - x div 2;
  R1.Right := W + (W - x) div 2;
  R1.Top := (H div 2) - 1;
  R1.Bottom := H;
  R2.Left := (W div 2) + 1;
  R2.Right := W;
  R2.Top := (H div 2) - 1;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
  R1.Left := 0;
  R1.Right := (W div 2) + 1;
  R1.Top := H - y div 2;
  R1.Bottom := H + (H - y) div 2;
  R2.Left := 0;
  R2.Right := (W div 2) + 1;
  R2.Top := (H div 2) + 1;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect058(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(-(2 * W), -5, 2 * x, H + 5, 2 * W, 2 * W);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect059(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(W - 2 * x, -5, W + (2 * W), H + 5, 2 * W, 2 * W);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect060(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 0, W, H, S, 1, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect061(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 0, W, H, S, 2, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect062(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 0, W, H, S, 4, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect063(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 0, W, H, S, 5, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect064(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, 0, W, H, 0, 3, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect065(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, 0, W, H, 1, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect066(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, 0, W, H, 2, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect067(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, 0, W, H, 3, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect068(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, 0, W, H, 4, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect069(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(-5, -(2 * H), W + 5, 2 * y, 2 * H, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect070(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(-5, H - 2 * y, W + 5, H + (2 * H), 2 * H, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect071(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(0, 2 * y, W, H, S, 0, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect072(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(0, 2 * y, W, H, S, 0, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect073(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(0, 2 * y, W, H, S, 0, 4);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect074(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(0, 2 * y, W, H, S, 0, 5);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect075(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(0, y, W, H, 0, 0, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect076(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(0, y, W, H, 0, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect077(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(0, y, W, H, 0, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect078(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(0, y, W, H, 0, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect079(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(0, y, W, H, 0, 4);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect080(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(-(2 * W), -(2 * H), 2 * x, 2 * y, 2 * W, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect081(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(W - 2 * x, -(2 * H), W + (2 * W), 2 * y,
    2 * W, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect082(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(-(2 * W), H - 2 * y, 2 * x, H + (2 * H),
    2 * W, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect083(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(W - 2 * x, H - 2 * y, W + (2 * W), H + (2 * H),
    2 * H, 2 * H);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect084(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRoundRectRgn(W div 2 - x, H div 2 - y, W div 2 + x, H div 2 + y,
    9 * x div 5, 9 * y div 5);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect085(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateRectRgnIndirect(Rect);
  TmpRgn := CreateRoundRectRgn(x - W div 2, y - H div 2, 3 * W div 2 - x,
    3 * H div 2 - y, 9 * (W - x) div 5, 9 * (H - y) div 5);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect086(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 1, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect087(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 1, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect088(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 2, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect089(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 2, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect090(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 4, 4);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect091(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 4, 5);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect092(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 5, 4);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect093(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 5, 5);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect094(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, y, W, H, S, 1, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect095(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, y, W, H, S, 2, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect096(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, y, W, H, S, 3, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect097(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, y, W, H, S, 3, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect098(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(x, y, W, H, 0, 3, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect099(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 1, 1);
  TmpRgn := CreateBarRgn(2 * x, 2 * y, W, H, S, 2, 2);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_AND);
  DeleteObject(TmpRgn);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect100(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 1, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect101(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 1, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect102(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 2, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect103(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 2, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect104(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 1, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect105(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 2, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect106(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 3, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect107(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 3, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect108(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 3, 3);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect109(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreatePourRgn(x, y, W, H, 4, 4);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect110(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(0, 0, 2 * x, 0, 0, 2 * y);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect111(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(W, 0, W - 2 * x, 0, W, 2 * y);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect112(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(0, H, 2 * x, H, 0, H - 2 * y);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect113(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(W, H, W - 2 * x, H, W, H - 2 * y);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect114(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(0, H, 0, 0, x, H);
  TmpRgn := CreateTriangleRgn(W, H, W, 0, W - x, 0);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect115(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(W, 0, 0, 0, W, y);
  TmpRgn := CreateTriangleRgn(W, H, 0, H, 0, H - y);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect116(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateTriangleRgn(W div 2, H div 2, 0, H, 0, H - y);
  TmpRgn := CreateTriangleRgn(0, 0, x, 0, W div 2, H div 2);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreateTriangleRgn(W - x, H, W div 2, H div 2, W, H);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreateTriangleRgn(W div 2, H div 2, W, 0, W, y);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect117(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  I, J: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  if S > 1 then
    S := S div 2;
  x := x div S;
  y := y div S;
  W := W div S;
  H := H div S;
  for J := S downto 0 do
  begin
    for I := S downto 0 do
    begin
      TmpRgn := CreateTriangleRgn(I * W - x, J * H - y, I * W + x, J * H - y,
        I * W - x, J * H + y);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
        Rgn := TmpRgn;
    end;
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect118(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
begin
  MergeTransparent(Screen, Image, Progress);
end;

procedure Effect119(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
begin
  MergeRotate(Screen, Image, -1, -1, (100 - Progress) * PI / 200);
end;

procedure Effect120(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
begin
  MergeRotate(Screen, Image, -1, Rect.Bottom, (Progress - 100) * PI / 200);
end;

procedure Effect121(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
begin
  MergeRotate(Screen, Image, Rect.Right, -1, (Progress - 100) * PI / 200);
end;

procedure Effect122(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
begin
  MergeRotate(Screen, Image, Rect.Right, Rect.Bottom,
    (100 - Progress) * PI / 200);
end;

procedure Effect123(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateSwarmRgn(x, y, W, H, 1, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect124(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateSwarmRgn(x, y, W, H, 2, 0);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect125(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateSwarmRgn(x, y, W, H, 0, 1);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect126(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := CreateSwarmRgn(x, y, W, H, 0, 2);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect127(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  RandSeed := W * H;
  if S > 1 then
    S := S div 2;
  Rgn := 0;
  x := 0;
  while x < W do
  begin
    y := 0;
    while y < H do
    begin
      if Random(100) < Progress then
      begin
        TmpRgn := CreateRectRgn(x - S, y - S, x + S, y + S);
        if Rgn <> 0 then
        begin
          CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
          DeleteObject(TmpRgn);
        end
        else
          Rgn := TmpRgn;
      end;
      Inc(y, S);
    end;
    Inc(x, S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect128(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x;
  R1.Right := W;
  R2.Left := 0;
  R2.Right := W - x;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Left := 0;
  R1.Right := x;
  R2.Left := W - x;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect129(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := 0;
  R1.Right := W - x;
  R2.Left := x;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Left := W - x;
  R1.Right := W;
  R2.Left := 0;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect130(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := x;
  R1.Right := W;
  R2.Left := 0;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Left := 0;
  R1.Right := x;
  R2.Left := W - x;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect131(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Left := 0;
  R1.Right := W - x;
  R2.Left := 0;
  R2.Right := W;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Left := W - x;
  R1.Right := W;
  R2.Left := 0;
  R2.Right := x;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect132(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := y;
  R1.Bottom := H;
  R2.Top := 0;
  R2.Bottom := H - y;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Top := 0;
  R1.Bottom := y;
  R2.Top := H - y;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect133(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := 0;
  R1.Bottom := H - y;
  R2.Top := y;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Top := H - y;
  R1.Bottom := H;
  R2.Top := 0;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect134(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := y;
  R1.Bottom := H;
  R2.Top := 0;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Top := 0;
  R1.Bottom := y;
  R2.Top := H - y;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect135(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  R1, R2: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  R1 := Rect;
  R2 := Rect;
  R1.Top := 0;
  R1.Bottom := H - y;
  R2.Top := 0;
  R2.Bottom := H;
  Screen.Canvas.CopyRect(R1, Screen.Canvas, R2);
  R1.Top := H - y;
  R1.Bottom := H;
  R2.Top := 0;
  R2.Bottom := y;
  Screen.Canvas.CopyRect(R1, Image.Canvas, R2);
end;

procedure Effect136(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := W div S;
  R := Rect;
  R.Right := S * Progress div 100;
  while R.Left < W do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, S, 0);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect137(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := H div S;
  R := Rect;
  R.Bottom := S * Progress div 100;
  while R.Top < H do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect138(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := x;
  R := Rect;
  R.Right := S * Progress div 100;
  while R.Left < W do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, S, 0);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect139(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := x;
  R := Rect;
  R.Left := Rect.Right - S * Progress div 100;
  while R.Right >= 0 do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, -S, 0);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect140(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := y;
  R := Rect;
  R.Bottom := S * Progress div 100;
  while R.Top < H do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect141(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := y;
  R := Rect;
  R.Top := Rect.Bottom - S * Progress div 100;
  while R.Bottom >= 0 do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, -S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect142(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  I, J: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  x := x div S;
  y := y div S;
  if S > 1 then
    S := S div 2;
  W := W div S;
  H := H div S;
  for J := S downto 0 do
  begin
    for I := S downto 0 do
    begin
      TmpRgn := CreateRectRgn(I * W - x, J * H - y, I * W + x, J * H + y);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
        Rgn := TmpRgn;
    end;
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect143(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  mX, mY: Integer;
  PI2: Extended;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  mX := W div 2;
  mY := H div 2;
  PI2 := PI / 2;
  Rgn := CreateArcRgn(mX, mY, Ceil(Sqrt(Sqr(mX) + Sqr(mY))), -PI2,
    (PI * Progress / 50) - PI2, Progress);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect144(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  mX, mY: Integer;
  PI2: Extended;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  mX := W div 2;
  mY := H div 2;
  PI2 := PI / 2;
  Rgn := CreateArcRgn(mX, mY, Ceil(Sqrt(Sqr(mX) + Sqr(mY))), -PI2,
    (-PI * Progress / 50) - PI2, Progress);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect145(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  D: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := H div S;
  R := Rect;
  OffsetRect(R, 0, S div 2);
  D := S * Progress div 200;
  Dec(R.Top, D);
  R.Bottom := R.Top + 2 * D;
  while R.Top < H do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, S);
  end;
  S := x;
  R := Rect;
  R.Right := S * Progress div 100;
  while R.Left < W do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, S, 0);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect146(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  D: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := H div S;
  R := Rect;
  OffsetRect(R, 0, S div 2);
  D := S * Progress div 200;
  Dec(R.Top, D);
  R.Bottom := R.Top + 2 * D;
  while R.Top < H do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, S);
  end;
  S := x;
  R := Rect;
  R.Left := R.Right - S * Progress div 100;
  while R.Right >= 0 do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, -S, 0);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect147(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  D: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := W div S;
  R := Rect;
  OffsetRect(R, S div 2, 0);
  D := S * Progress div 200;
  Dec(R.Left, D);
  R.Right := R.Left + 2 * D;
  while R.Left < W do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, S, 0);
  end;
  S := y;
  R := Rect;
  R.Bottom := S * Progress div 100;
  while R.Top < H do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect148(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Rgn, TmpRgn: HRGN;
  D: Integer;
  R: TRect;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  Rgn := 0;
  S := W div S;
  R := Rect;
  OffsetRect(R, S div 2, 0);
  D := S * Progress div 200;
  Dec(R.Left, D);
  R.Right := R.Left + 2 * D;
  while R.Left < W do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, S, 0);
  end;
  S := y;
  R := Rect;
  R.Top := Rect.Bottom - S * Progress div 100;
  while R.Bottom >= 0 do
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    if Rgn <> 0 then
    begin
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
      DeleteObject(TmpRgn);
    end
    else
      Rgn := TmpRgn;
    OffsetRect(R, 0, -S);
  end;
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect149(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Pts: array [1 .. 4] of TPoint;
  mX, mY: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  mX := W div 2;
  mY := H div 2;
  x := x div 2;
  y := y div 2;
  Pts[1].x := mX - x;
  Pts[1].y := mY - y;
  Pts[2].x := mX + x;
  Pts[2].y := mY - y;
  Pts[3].x := mX + x;
  Pts[3].y := mY + y;
  Pts[4].x := mX - x;
  Pts[4].y := mY + y;
  RotatePoints(Pts, mX, mY, PI * Progress / 50);
  Rgn := CreatePolygonRgn(Pts, High(Pts), WINDING);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

procedure Effect150(Screen, Image: TBitmap; const Rect: TRect; Step: Integer;
  Progress: Integer);
var
  W, H, x, y, S: Integer;
  Pts: array [1 .. 8] of TPoint;
  mX, mY, dX, dY, hX, hY: Integer;
  Rgn: HRGN;
begin
  CalcParams(Rect, Step, Progress, W, H, x, y, S);
  mX := W div 2;
  mY := H div 2;
  dX := 2 * x;
  dY := 2 * y;
  hX := x div 2;
  hY := y div 2;
  Pts[1].x := mX - dX;
  Pts[1].y := mY;
  Pts[2].x := mX - hX;
  Pts[2].y := mY - hY;
  Pts[3].x := mX;
  Pts[3].y := mY - dY;
  Pts[4].x := mX + hX;
  Pts[4].y := mY - hY;
  Pts[5].x := mX + dX;
  Pts[5].y := mY;
  Pts[6].x := mX + hX;
  Pts[6].y := mY + hY;
  Pts[7].x := mX;
  Pts[7].y := mY + dY;
  Pts[8].x := mX - hX;
  Pts[8].y := mY + hY;
  RotatePoints(Pts, mX, mY, PI * Progress / 50);
  Rgn := CreatePolygonRgn(Pts, High(Pts), WINDING);
  SelectClipRgn(Screen.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  Screen.Canvas.Draw(0, 0, Image);
  SelectClipRgn(Screen.Canvas.Handle, 0);
end;

end.
