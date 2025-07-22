//SHADERS MADE BY GTA 5 BORIS JULES AI FX AND MX

#include "ENBFeeder.fxh"

Texture2D TextureColor;
Texture2D TextureDepth;
Texture2D TextureOriginal;
Texture2D RenderTargetRGBA64F;
float4 Timer;
float4 ScreenSize;
float4 Weather;
float4 tempInfo2;

static const float2 rcpFrame = float2(ScreenSize.y, ScreenSize.y * ScreenSize.z);
float SharpDay < string UIName = "Sharpen Day"; float UIMin = 0.0; float UIMax = 10.0; > = { 1.8 };
float SharpNight < string UIName = "Sharpen Night"; float UIMin = 0.0; float UIMax = 10.0; > = { 1.6 };
int separator0 < string UIName = " "; int UIMin = 0; int UIMax = 0; > = { 0 };
float ldd < string UIName = "Noise Day:: lumDark"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.0001; > = { 0.0021 };
float lbd < string UIName = "Noise Day:: lumBright"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.0001; > = { 0.0021 };
float ldn < string UIName = "Noise Night:: lumDark"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.0001; > = { 0.0011 };
float lbn < string UIName = "Noise Night:: lumBright"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.0001; > = { 0.0011 };
int separator1 < string UIName = "  "; int UIMin = 0; int UIMax = 0; > = { 0 };
float DXAA < string UIName = "DXAA"; float UIMin = 0.0; float UIMax = 12.0; > = { 4.0 };
float SubPix < string UIName = "FXAA:: SubPixel"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.7 };
float EdgeThresh < string UIName = "FXAA:: EdgeThreshold"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.166 };
float EdgeThreshMin < string UIName = "FXAA:: EdgeThresholdMin"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.0833 };
int separator2 < string UIName = "   "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool rd < string UIName = "ScreenRainDrops"; > = { true };
float ra < string UIName = "RainDrops:: Amount"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 0.32 };
float ri < string UIName = "RainDrops:: Intensity"; float UIMin = 0.0; float UIMax = 10.0; > = { 1.0 };
float rs < string UIName = "RainDrops:: Scale"; float UIMin = 0.1; float UIMax = 5.0; > = { 0.52 };
float re < string UIName = "RainDrops:: Speed"; float UIMin = 0.0; float UIMax = 6.0; > = { 0.43 };
float rblur < string UIName = "RainDrops:: Blur"; float UIMin = 0.0; float UIMax = 1.5; > = { 0.0 };
float rvig < string UIName = "RainDrops:: Vignette"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
bool rf < string UIName = "RainDrops:: Force Enable"; > = { false };
//bool rp <string UIName="RainDrops:: Vehicle Physics";> = {true};
int separator3 < string UIName = "    "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool s_s < string UIName = "ScreenFrozenSnow"; > = { true };
int separator4 < string UIName = "     "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool rb_enable < string UIName = "Rainbow"; > = { true };
bool rb_double < string UIName = "Rainbow#1:: Double"; > = { false };
float rb_int < string UIName = "Rainbow#1:: Intensity"; float UIMin = 0.0; float UIMax = 0.4; float UIStep = 0.001; > = { 0.05 };
float rb_scale < string UIName = "Rainbow#1:: Size"; float UIMin = 0.0; float UIMax = 800.0; float UIStep = 1.0; > = { 130.0 };
float3 posrb < string UIName = "Rainbow#1:: Coord"; /*string UIType = "vector";*/ float UIStep = 5.0; > = { 600.0, -3000.0, 0.0 };
float3 rb_dir < string UIName = "Rainbow#1:: Dir"; string UIType = "vector"; > = { 0.5, 0.7, 0.5 };
bool rb_force < string UIName = "Rainbow#1:: Force Enable"; > = { false };
int miniseparator0 < string UIName = "- - - - - - - -"; int UIMin = 0; int UIMax = 0; > = { 0 };
bool rb2_double < string UIName = "Rainbow#2:: Double"; > = { false };
float rb2_int < string UIName = "Rainbow#2:: Intensity"; float UIMin = 0.0; float UIMax = 0.4; float UIStep = 0.001; > = { 0.05 };
float rb2_scale < string UIName = "Rainbow#2:: Size"; float UIMin = 0.0; float UIMax = 800.0; float UIStep = 1.0; > = { 90.0 };
float3 posrb2 < string UIName = "Rainbow#2:: Coord"; /*string UIType = "vector";*/ float UIStep = 5.0; > = { 3900.0, 5000.0, 8.0 };
float3 rb2_dir < string UIName = "Rainbow#2:: Dir"; string UIType = "vector"; > = { 0.5, 0.7, 0.5 };
bool rb2_force < string UIName = "Rainbow#2:: Force Enable"; > = { false };
int miniseparator1 < string UIName = "- - - - - - - - "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool rb3_double < string UIName = "Rainbow#3:: Double"; > = { false };
float rb3_int < string UIName = "Rainbow#3:: Intensity"; float UIMin = 0.0; float UIMax = 0.4; float UIStep = 0.001; > = { 0.11 };
float rb3_scale < string UIName = "Rainbow#3:: Size"; float UIMin = 0.0; float UIMax = 800.0; float UIStep = 1.0; > = { 40.0 };
float3 posrb3 < string UIName = "Rainbow#3:: Coord"; /*string UIType = "vector";*/ float UIStep = 5.0; > = { -1400.0, 4400.0, 1.0 };
float3 rb3_dir < string UIName = "Rainbow#3:: Dir"; string UIType = "vector"; > = { 0.5, 0.7, 0.5 };
bool rb3_force < string UIName = "Rainbow#3:: Force Enable"; > = { false };
int separator5 < string UIName = "      "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool blu < string UIName = "RadialBlur"; > = { false };
float bi < string UIName = "RadialBlur:: Intensity"; float UIMin = -0.3; float UIMax = 0.3; float UIStep = 0.001; > = { 0.1 };
int bs < string UIName = "RadialBlur:: Samples"; int UIMin = 32; int UIMax = 128; > = { 64 };
float2 bmsxy < string UIName = "RadialBlur:: Mask"; float UIMin = 0.0; float UIMax = 10.0; > = { 1.0, 1.0 };
float bms < string UIName = "RadialBlur:: Mask Size"; float UIMin = 0.0; float UIMax = 10.0; > = { 0.25 };
bool mf1 < string UIName = "RadialBlur:: Manual Focus: Left Click"; > = { false };
bool mf2 < string UIName = "RadialBlur:: Manual Focus: Right Click"; > = { false };
int separator6 < string UIName = "       "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool bvca < string UIName = "VertChroma"; > = { false };
float vca < string UIName = "VertChroma:: Intensity"; float UIMin = -0.0025; float UIMax = 0.0025; float UIStep = 0.0001; > = { 0.0005 };
bool bca < string UIName = "RadialChroma"; > = { false };
float rca < string UIName = "RadialChroma:: Intensity"; float UIMin = 0.001; float UIMax = 0.05; float UIStep = 0.001; > = { 0.006 };
int cat < string UIName = "RadialChroma:: Type"; int UIMin = 1; int UIMax = 6; > = { 1 };
int separator7 < string UIName = "        "; int UIMin = 0; int UIMax = 0; > = { 0 };
float ldistort < string UIName = "Lens Distortion (GoPro)"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
int separator8 < string UIName = "         "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool grid1 < string UIName = "CompositionGrid:: Golden Ratio"; > = { false };
bool grid2 < string UIName = "CompositionGrid:: Symmetry"; > = { false };
bool grid3 < string UIName = "CompositionGrid:: Golden Triangle"; > = { false };
bool grid4 < string UIName = "CompositionGrid:: Golden Triangle Flip"; > = { false };
float ddepth < string UIName = "Z-Depth"; float UIStep = 0.0001; > = { 0.0 };
int separator9 < string UIName = "          "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool useback < string UIName = "Background"; > = { false };
float fadein < string UIName = "Background:: Fade In"; float UIMin = 0.0; float UIStep = 0.5; > = { 38.0 };
float fadeout < string UIName = "Background:: Fade Out"; float UIMin = 0.0; float UIStep = 0.5; > = { 40.0 };
float scale < string UIName = "Background:: Scale"; float UIMin = 0.0; > = { 2.0 };
float2 pos < string UIName = "Background:: Position"; > = { 0.0, -1.25 };
bool unwrap < string UIName = "Background:: Unwrap texture"; > = { false };
int separator10 < string UIName = "           "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool cc < string UIName = "PhotoFilter:: Chroma Curve"; > = { false };
float ccm < string UIName = "PhotoFilter::   Chroma Curve"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.5 };
float ccb < string UIName = "PhotoFilter::   Chroma Curve Bright"; float UIMin = 0.0; float UIMax = 10.0; float UIStep = 0.001; > = { 0.81 };
bool bw < string UIName = "PhotoFilter:: Black&WhiteG"; > = { false };
float bwg < string UIName = "PhotoFilter::   Black&White Gamma"; float UIMin = 0.0; float UIMax = 10.0; float UIStep = 0.001; > = { 0.57 };
float bwb < string UIName = "PhotoFilter::   Black&White Bright"; float UIMin = 0.0; float UIMax = 10.0; float UIStep = 0.001; > = { 0.46 };
int separator11 < string UIName = "            "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool lut < string UIName = "Use LUT Texture"; > = { false };
float gli < string UIName = "LUT:: GLOBAL Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float ini < string UIName = "LUT:: INTERIOR Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float isi < string UIName = "LUT:: INTERIOR Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float idi < string UIName = "LUT:: INTERIOR Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float exni < string UIName = "LUT:: Extrasunny Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float exsi < string UIName = "LUT:: Extrasunny Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float exdi < string UIName = "LUT:: Extrasunny Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float clni < string UIName = "LUT:: Clear Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float clsi < string UIName = "LUT:: Clear Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float cldi < string UIName = "LUT:: Clear Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float cgni < string UIName = "LUT:: Clearing Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float cgsi < string UIName = "LUT:: Clearing Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float cgdi < string UIName = "LUT:: Clearing Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float coni < string UIName = "LUT:: Clouds Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float cosi < string UIName = "LUT:: Clouds Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float codi < string UIName = "LUT:: Clouds Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float ovni < string UIName = "LUT:: Overcast Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float ovsi < string UIName = "LUT:: Overcast Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float ovdi < string UIName = "LUT:: Overcast Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float smni < string UIName = "LUT:: Smog Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float smsi < string UIName = "LUT:: Smog Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float smdi < string UIName = "LUT:: Smog Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float foni < string UIName = "LUT:: Foggy Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float fosi < string UIName = "LUT:: Foggy Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float fodi < string UIName = "LUT:: Foggy Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float rani < string UIName = "LUT:: Rain Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float rasi < string UIName = "LUT:: Rain Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float radi < string UIName = "LUT:: Rain Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float thni < string UIName = "LUT:: Thunder Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float thsi < string UIName = "LUT:: Thunder Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float thdi < string UIName = "LUT:: Thunder Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float blni < string UIName = "LUT:: Blizzard Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float blsi < string UIName = "LUT:: Blizzard Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float bldi < string UIName = "LUT:: Blizzard Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float neni < string UIName = "LUT:: Neutral Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float nesi < string UIName = "LUT:: Neutral Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float nedi < string UIName = "LUT:: Neutral Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float snni < string UIName = "LUT:: Snow Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float snsi < string UIName = "LUT:: Snow Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float sndi < string UIName = "LUT:: Snow Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float slni < string UIName = "LUT:: Snowlight Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float slsi < string UIName = "LUT:: Snowlight Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float sldi < string UIName = "LUT:: Snowlight Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float xmni < string UIName = "LUT:: Xmas Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float xmsi < string UIName = "LUT:: Xmas Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float xmdi < string UIName = "LUT:: Xmas Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float hani < string UIName = "LUT:: Halloween Night Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float hasi < string UIName = "LUT:: Halloween Sunset Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float hadi < string UIName = "LUT:: Halloween Day Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.005; > = { 1.0 };
float4 Test1 < string UIName = "Test1"; string UIWidget = "color"; int UIHidden = 1; > ;
float4 Test2 < string UIName = "Test2"; string UIWidget = "color"; int UIHidden = 1; > ;
float4 Test3 < string UIName = "Test3"; string UIWidget = "color"; int UIHidden = 1; > ;
Texture2D lut_global < string ResourceName = "AaronX/LUT/global.png"; > ;
Texture2D i_night < string ResourceName = "AaronX/LUT/interior_night.png"; > ;
Texture2D i_sunset < string ResourceName = "AaronX/LUT/interior_sunset.png"; > ;
Texture2D i_day < string ResourceName = "AaronX/LUT/interior_day.png"; > ;
Texture2D lut_extrasunny_night < string ResourceName = "AaronX/LUT/w_extrasunny_night.png"; > ;
Texture2D lut_extrasunny_sunset < string ResourceName = "AaronX/LUT/w_extrasunny_sunset.png"; > ;
Texture2D lut_extrasunny_day < string ResourceName = "AaronX/LUT/w_extrasunny_day.png"; > ;
Texture2D lut_clear_night < string ResourceName = "AaronX/LUT/w_clear_night.png"; > ;
Texture2D lut_clear_sunset < string ResourceName = "AaronX/LUT/w_clear_sunset.png"; > ;
Texture2D lut_clear_day < string ResourceName = "AaronX/LUT/w_clear_day.png"; > ;
Texture2D lut_clearing_night < string ResourceName = "AaronX/LUT/w_clearing_night.png"; > ;
Texture2D lut_clearing_sunset < string ResourceName = "AaronX/LUT/w_clearing_sunset.png"; > ;
Texture2D lut_clearing_day < string ResourceName = "AaronX/LUT/w_clearing_day.png"; > ;
Texture2D lut_clouds_night < string ResourceName = "AaronX/LUT/w_clouds_night.png"; > ;
Texture2D lut_clouds_sunset < string ResourceName = "AaronX/LUT/w_clouds_sunset.png"; > ;
Texture2D lut_clouds_day < string ResourceName = "AaronX/LUT/w_clouds_day.png"; > ;
Texture2D lut_overcast_night < string ResourceName = "AaronX/LUT/w_overcast_night.png"; > ;
Texture2D lut_overcast_sunset < string ResourceName = "AaronX/LUT/w_overcast_sunset.png"; > ;
Texture2D lut_overcast_day < string ResourceName = "AaronX/LUT/w_overcast_day.png"; > ;
Texture2D lut_smog_night < string ResourceName = "AaronX/LUT/w_smog_night.png"; > ;
Texture2D lut_smog_sunset < string ResourceName = "AaronX/LUT/w_smog_sunset.png"; > ;
Texture2D lut_smog_day < string ResourceName = "AaronX/LUT/w_smog_day.png"; > ;
Texture2D lut_foggy_night < string ResourceName = "AaronX/LUT/w_foggy_night.png"; > ;
Texture2D lut_foggy_sunset < string ResourceName = "AaronX/LUT/w_foggy_sunset.png"; > ;
Texture2D lut_foggy_day < string ResourceName = "AaronX/LUT/w_foggy_day.png"; > ;
Texture2D lut_rain_night < string ResourceName = "AaronX/LUT/w_rain_night.png"; > ;
Texture2D lut_rain_sunset < string ResourceName = "AaronX/LUT/w_rain_sunset.png"; > ;
Texture2D lut_rain_day < string ResourceName = "AaronX/LUT/w_rain_day.png"; > ;
Texture2D lut_thunder_night < string ResourceName = "AaronX/LUT/w_thunder_night.png"; > ;
Texture2D lut_thunder_sunset < string ResourceName = "AaronX/LUT/w_thunder_sunset.png"; > ;
Texture2D lut_thunder_day < string ResourceName = "AaronX/LUT/w_thunder_day.png"; > ;
Texture2D lut_blizzard_night < string ResourceName = "AaronX/LUT/w_blizzard_night.png"; > ;
Texture2D lut_blizzard_sunset < string ResourceName = "AaronX/LUT/w_blizzard_sunset.png"; > ;
Texture2D lut_blizzard_day < string ResourceName = "AaronX/LUT/w_blizzard_day.png"; > ;
Texture2D lut_neutral_night < string ResourceName = "AaronX/LUT/w_neutral_night.png"; > ;
Texture2D lut_neutral_sunset < string ResourceName = "AaronX/LUT/w_neutral_sunset.png"; > ;
Texture2D lut_neutral_day < string ResourceName = "AaronX/LUT/w_neutral_day.png"; > ;
Texture2D lut_snow_night < string ResourceName = "AaronX/LUT/w_snow_night.png"; > ;
Texture2D lut_snow_sunset < string ResourceName = "AaronX/LUT/w_snow_sunset.png"; > ;
Texture2D lut_snow_day < string ResourceName = "AaronX/LUT/w_snow_day.png"; > ;
Texture2D lut_snowl_night < string ResourceName = "AaronX/LUT/w_snowlight_night.png"; > ;
Texture2D lut_snowl_sunset < string ResourceName = "AaronX/LUT/w_snowlight_sunset.png"; > ;
Texture2D lut_snowl_day < string ResourceName = "AaronX/LUT/w_snowlight_day.png"; > ;
Texture2D lut_xmas_night < string ResourceName = "AaronX/LUT/w_xmas_night.png"; > ;
Texture2D lut_xmas_sunset < string ResourceName = "AaronX/LUT/w_xmas_sunset.png"; > ;
Texture2D lut_xmas_day < string ResourceName = "AaronX/LUT/w_xmas_day.png"; > ;
Texture2D lut_hallo_night < string ResourceName = "AaronX/LUT/w_hallo_night.png"; > ;
Texture2D lut_hallo_sunset < string ResourceName = "AaronX/LUT/w_hallo_sunset.png"; > ;
Texture2D lut_hallo_day < string ResourceName = "AaronX/LUT/w_hallo_day.png"; > ;
Texture2D distor < string ResourceName = "AaronX/18673.dds"; > ;
Texture2D noisetex < string ResourceName = "AaronX/18690.png"; > ;
Texture2D backtex < string ResourceName = "AaronX/Background.png"; > ;
Texture2D gridtex < string ResourceName = "AaronX/CompositionGrid.png"; > ;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};
SamplerState Sampler3
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Border;
	AddressV = Border;
};

struct VS_INPUT_POST
{
	float3 pos	: POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};
struct VS_OUTPUT_POST0
{
	float4 pos	: SV_POSITION;
	float3 txcoord0	: TEXCOORD0;
};
struct VS_OUTPUT_POSTRB
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	float3 txcoord1	: TEXCOORD1;
	float4 txcoord2 : TEXCOORD2;
};
struct VS_OUTPUT_POSTN
{
	float4 pos	: SV_POSITION;
	float4 txcoord0	: TEXCOORD0;
};
struct VS_OUTPUT_POSTC
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	int txcoord1 : TEXCOORD1;
	float3 txcoord2	: TEXCOORD2;
};
struct VS_OUTPUT_POSTRD
{
	float4 pos	: SV_POSITION;
	float4 txcoord0	: TEXCOORD0;
	nointerpolation float4 txcoord1 : TEXCOORD1;
};
struct VS_OUTPUT_POST3
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	float3 txcoord1	: TEXCOORD1;
};

VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}
VS_OUTPUT_POSTRB VS_Rb(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRB OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float4 rpos = mul(float4(posrb, 1.0), WorldViewProj);
	rpos.xyz /= rpos.w;
	rpos.xyz = rpos.xyz * float3(0.5, -0.5, -0.5) + float3(0.5, 0.5, 0.5);
	rpos.xy = IN.txcoord.xy - rpos.xy;
	rpos.xy = rpos.xy * DofProj.xy * rpos.w;
	OUT.txcoord1.xyz = rpos.x * float3(-0.707106781, 0.0, 0.707106781) + rpos.y * float3(-0.40824829, 0.81649658, -0.40824829) + rb_scale;
	rpos.x = -rpos.x;
	OUT.txcoord2.x = dot(rpos.xy, WorldView._m20_m21);
	OUT.txcoord2.y = rpos.w;
	float t = Test2.w ? GameTime : Weather.w;
	float nightm = lerp(lerp(0.2, 1.0, smoothstep(5.0, 5.2, t)), 0.2, smoothstep(21.0, 21.2, t));
	const float w[16] = { 0.0,0.1,0.1,0.1,0.11,0.1,0.2,0.12,0.2,0.2,0.0,0.1,0.0,0.11,0.0,0.0 };
	bool wt = ((w[(int)qWeather.x] + w[(int)qWeather.y]) > 0.2) && (qWeather.x != qWeather.y) && (qWeather.z > 0.01) && (qWeather.z < 0.99);
	OUT.txcoord2.z = rb_enable * (rpos.w > 0.0) * Test2[3] * nightm * saturate(wt + rb_force) * saturate(rcp(rpos.w) * 2000.0) * (ViewInverse3.z > -0.5);
	return OUT;
}
VS_OUTPUT_POSTRB VS_Rb2(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRB OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float4 rpos = mul(float4(posrb2, 1.0), WorldViewProj);
	rpos.xyz /= rpos.w;
	rpos.xyz = rpos.xyz * float3(0.5, -0.5, -0.5) + float3(0.5, 0.5, 0.5);
	rpos.xy = IN.txcoord.xy - rpos.xy;
	rpos.xy = rpos.xy * DofProj.xy * rpos.w;
	OUT.txcoord1.xyz = rpos.x * float3(-0.707106781, 0.0, 0.707106781) + rpos.y * float3(-0.40824829, 0.81649658, -0.40824829) + rb2_scale;
	rpos.x = -rpos.x;
	OUT.txcoord2.x = dot(rpos.xy, WorldView._m20_m21);
	OUT.txcoord2.y = rpos.w;
	float t = Test2.w ? GameTime : Weather.w;
	float nightm = lerp(lerp(0.2, 1.0, smoothstep(5.0, 5.2, t)), 0.2, smoothstep(21.0, 21.2, t));
	const float w[16] = { 0.0,0.1,0.1,0.1,0.11,0.1,0.2,0.12,0.2,0.2,0.0,0.1,0.0,0.11,0.0,0.0 };
	bool wt = ((w[(int)qWeather.x] + w[(int)qWeather.y]) > 0.2) && (qWeather.x != qWeather.y) && (qWeather.z > 0.01) && (qWeather.z < 0.99);
	OUT.txcoord2.z = rb_enable * (rpos.w > 0.0) * Test2[3] * nightm * saturate(wt + rb2_force) * saturate(rcp(rpos.w) * 2000.0) * (ViewInverse3.z > -0.5);
	return OUT;
}
VS_OUTPUT_POSTRB VS_Rb3(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRB OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float4 rpos = mul(float4(posrb3, 1.0), WorldViewProj);
	rpos.xyz /= rpos.w;
	rpos.xyz = rpos.xyz * float3(0.5, -0.5, -0.5) + float3(0.5, 0.5, 0.5);
	rpos.xy = IN.txcoord.xy - rpos.xy;
	rpos.xy = rpos.xy * DofProj.xy * rpos.w;
	OUT.txcoord1.xyz = rpos.x * float3(-0.707106781, 0.0, 0.707106781) + rpos.y * float3(-0.40824829, 0.81649658, -0.40824829) + rb3_scale;
	rpos.x = -rpos.x;
	OUT.txcoord2.x = dot(rpos.xy, WorldView._m20_m21);
	OUT.txcoord2.y = rpos.w;
	float t = Test2.w ? GameTime : Weather.w;
	float nightm = lerp(lerp(0.2, 1.0, smoothstep(5.0, 5.2, t)), 0.2, smoothstep(21.0, 21.2, t));
	const float w[16] = { 0.0,0.1,0.1,0.1,0.11,0.1,0.2,0.12,0.2,0.2,0.0,0.1,0.0,0.11,0.0,0.0 };
	bool wt = ((w[(int)qWeather.x] + w[(int)qWeather.y]) > 0.2) && (qWeather.x != qWeather.y) && (qWeather.z > 0.01) && (qWeather.z < 0.99);
	OUT.txcoord2.z = rb_enable * (rpos.w > 0.0) * Test2[3] * nightm * saturate(wt + rb3_force) * saturate(rcp(rpos.w) * 2000.0) * (ViewInverse3.z > -0.5);
	return OUT;
}
VS_OUTPUT_POSTN VS_RBlur(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTN OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float2 focpoint = PlayerPos.w ? PlayerPos.xy : float2(0.48, 0.6);
	if (mf1)focpoint = tempInfo2.xy;
	if (mf2)focpoint = tempInfo2.zw;
	focpoint = focpoint - IN.txcoord.xy;
	focpoint.y *= ScreenSize.w;
	OUT.txcoord0.zw = focpoint * bi;
	return OUT;
}
VS_OUTPUT_POSTN VS_RDR2Noise(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTN OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float t = Test2.w ? GameTime : Weather.w;
	float t0 = smoothstep(5.5, 6.1, t);
	float t1 = smoothstep(20.5, 20.9, t);
	OUT.txcoord0.z = lerp(lerp(ldn, ldd, t0), ldn, t1);
	OUT.txcoord0.w = lerp(lerp(lbn, lbd, t0), lbn, t1);
	return OUT;
}
VS_OUTPUT_POST0 VS_CAS(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST0 OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float t = Test2.w ? GameTime : Weather.w;
	float t0 = smoothstep(5.5, 6.1, t);
	float t1 = smoothstep(20.5, 20.9, t);
	float m = lerp(SharpNight, SharpDay, t0);
	OUT.txcoord0.z = lerp(m, SharpNight, t1);
	return OUT;
}
VS_OUTPUT_POSTRD VS_Water(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRD OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float2 uv = IN.txcoord.xy * 2.0 - 1.0;
	uv *= rs;
	uv.y *= -ScreenSize.w;
	OUT.txcoord0.zw = uv;
	float wa = TextureOriginal.SampleLevel(Sampler1, IN.txcoord.xy, 0).w;
	float isweno = (Test1.x > 0.0) && (Test1.x < 10.0);
	isweno = isweno ? Test1.x : 0.0;
	float isLoad = Test2.w ? isweno : (wa == 0.0) * 0.75;
	float amount = isLoad * ra * (1.0 - rf) + rf * 0.75 * ra;
	OUT.txcoord1.x = smoothstep(-0.5, 1.0, amount) * 2.0;
	OUT.txcoord1.y = smoothstep(0.0, 0.5, amount);
	OUT.txcoord1.z = (rf || (rd && (ViewInverse3.z < 900.0) && (amount > 0.0)));
	OUT.txcoord1.w = Timer.x * re * 1000.0;
	return OUT;
}
VS_OUTPUT_POSTRD VS_W2(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRD OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	OUT.txcoord1.xy = rcpFrame * rblur;
	return OUT;
}
VS_OUTPUT_POSTRD VS_Frozen(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTRD OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float t = Test2.w ? GameTime : Weather.w;
	float t0 = smoothstep(5.7, 6.6, t);
	float t1 = smoothstep(20.4, 21.0, t);
	float m = lerp(0.55, 3.98, t0);
	OUT.txcoord1.x = lerp(m, 0.55, t1);
	float wa = TextureOriginal.SampleLevel(Sampler1, IN.txcoord.xy, 0).w;
	OUT.txcoord1.y = Test2.w ? Test3.x : (wa == 0.33333334);
	return OUT;
}
VS_OUTPUT_POSTC VS_RCA(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTC OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	OUT.txcoord1 = rca * 1600;
	float3 offset;
	switch (cat) {
	case 1:offset = float3(1.0, 2.0, 4.0); break;
	case 2:offset = float3(2.0, 1.0, 4.0); break;
	case 3:offset = float3(1.0, 4.0, 2.0); break;
	case 4:offset = float3(2.0, 4.0, 1.0); break;
	case 5:offset = float3(4.0, 2.0, 1.0); break;
	case 6:offset = float3(4.0, 1.0, 2.0); break;
	}
	OUT.txcoord2 = 1.0 / (rca * 1600) * offset;
	return OUT;
}
VS_OUTPUT_POST3 VS_Background(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST3 OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float2 uv = IN.txcoord.xy * float2(2.0, -2.0) + float2(-1.0, 1.0);
	uv *= DofProj.xy;
	OUT.txcoord1.xyz = mul(float3(uv, -1.0), (float3x3)ViewInverse);
	return OUT;
}
VS_OUTPUT_POST VS_Up1(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(2, 2, 1) + float3(1, -1, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}
VS_OUTPUT_POST VS_Up2(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(2, 2, 1) + float3(-1, -1, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}
VS_OUTPUT_POST VS_Up3(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(2, 2, 1) + float3(1, 1, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}
VS_OUTPUT_POST VS_Up4(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(2, 2, 1) + float3(-1, 1, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}

float GTA5linearDepth(float depth)
{
	depth = 1.0 - depth;
	depth = DofProj.w - depth;
	depth = 1.0 + depth;
	depth = DofProj.z / depth;
	return depth;
}

float4 PS_p(VS_OUTPUT_POST IN) : SV_Target
{
	return float4(TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz, 1);
}
float4 PS_Post0(VS_OUTPUT_POST IN) : SV_Target
{
	return float4(TextureOriginal.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz, 1);
}

float4 PS_DXAA(VS_OUTPUT_POST IN) : SV_Target
{
	float4 a,aa,a_;
	a.x = TextureColor.GatherGreen(Sampler1, IN.txcoord0.xy, int2(-2,2)).y;
	a.y = TextureColor.GatherGreen(Sampler1, IN.txcoord0.xy, int2(-2,-2)).y;
	a.z = a.x + a.y;
	a.w = TextureColor.GatherGreen(Sampler1, IN.txcoord0.xy, int2(2,2)).y;
	aa.x = TextureColor.GatherGreen(Sampler1, IN.txcoord0.xy, int2(2,-2)).y;
	aa.y = aa.x + a.w;
	a.x = a.x + a.w;
	a.y = aa.x + a.y;
	aa.yw = -aa.y + a.z;
	a.z = a.x - a.y;
	a.x = a.y + a.x;
	a.x = max(0.0, a.x * 0.015625);
	a.y = min(abs(a.z), abs(aa.w));
	aa.xz = -a.z;
	a = min(DXAA, max(-DXAA, aa * rcp(a.x + a.y)));
	aa.yw = ScreenSize.y * ScreenSize.z;
	aa.xz = ScreenSize.y;
	a = aa * a;
	aa = a * float4(-0.5,-0.5,0.5,0.5) + IN.txcoord0.xyxy;
	a = a.zwzw * float4(-0.1666667,-0.1666667,0.1666667,0.1666667) + IN.txcoord0.xyxy;
	a_.xyz = TextureColor.SampleLevel(Sampler1, aa.xy, 0).xyz;
	aa.xyz = TextureColor.SampleLevel(Sampler1, aa.zw, 0).xyz;
	aa.xyz = (a_.xyz + aa.xyz) * 0.25;
	a_.xyz = TextureColor.SampleLevel(Sampler1, a.xy, 0).xyz;
	a.xyz = TextureColor.SampleLevel(Sampler1, a.zw, 0).xyz;
	a.xyz = (a_.xyz + a.xyz) * 0.25 + aa.xyz;
	a.w = 1;
	return a;
}

float4 PS_Luma(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz;
	return float4(res, dot(saturate(res), float3(0.2126, 0.7152, 0.0722)));
}

float4 PS_FXAA(VS_OUTPUT_POST IN) : SV_Target
{
	float2 posM = IN.txcoord0.xy;
	float4 rgbyM = RenderTargetRGBA64F.SampleLevel(Sampler1, posM, 0);
	float4 luma4A = RenderTargetRGBA64F.GatherAlpha(Sampler1, posM);
	float4 luma4B = RenderTargetRGBA64F.GatherAlpha(Sampler1, posM, int2(-1, -1));
	float maxSM = max(luma4A.x, rgbyM.w);
	float minSM = min(luma4A.x, rgbyM.w);
	float maxESM = max(luma4A.z, maxSM);
	float minESM = min(luma4A.z, minSM);
	float maxWN = max(luma4B.z, luma4B.x);
	float minWN = min(luma4B.z, luma4B.x);
	float rangeMax = max(maxWN, maxESM);
	float rangeMin = min(minWN, minESM);
	float rangeMaxScaled = rangeMax * EdgeThresh;
	float range = rangeMax - rangeMin;
	float rangeMaxClamped = max(EdgeThreshMin, rangeMaxScaled);
	bool earlyExit = range < rangeMaxClamped;
	if (earlyExit) return rgbyM;
	float lumaNE = RenderTargetRGBA64F.SampleLevel(Sampler1, posM, 0, int2(1, -1)).w;
	float lumaSW = RenderTargetRGBA64F.SampleLevel(Sampler1, posM, 0, int2(-1, 1)).w;
	float lumaNS = luma4B.z + luma4A.x;
	float lumaWE = luma4B.x + luma4A.z;
	float subpixRcpRange = 1.0 / range;
	float subpixNSWE = lumaNS + lumaWE;
	float edgeHorz1 = (-2.0 * rgbyM.w) + lumaNS;
	float edgeVert1 = (-2.0 * rgbyM.w) + lumaWE;
	float lumaNESE = lumaNE + luma4A.y;
	float lumaNWNE = luma4B.w + lumaNE;
	float edgeHorz2 = (-2.0 * luma4A.z) + lumaNESE;
	float edgeVert2 = (-2.0 * luma4B.z) + lumaNWNE;
	float lumaNWSW = luma4B.w + lumaSW;
	float lumaSWSE = lumaSW + luma4A.y;
	float edgeHorz4 = (abs(edgeHorz1) * 2.0) + abs(edgeHorz2);
	float edgeVert4 = (abs(edgeVert1) * 2.0) + abs(edgeVert2);
	float edgeHorz3 = (-2.0 * luma4B.x) + lumaNWSW;
	float edgeVert3 = (-2.0 * luma4A.x) + lumaSWSE;
	float edgeHorz = abs(edgeHorz3) + edgeHorz4;
	float edgeVert = abs(edgeVert3) + edgeVert4;
	float subpixNWSWNESE = lumaNWSW + lumaNESE;
	float lengthSign = rcpFrame.x;
	bool horzSpan = edgeHorz >= edgeVert;
	float subpixA = subpixNSWE * 2.0 + subpixNWSWNESE;
	if (!horzSpan) luma4B.z = luma4B.x;
	if (!horzSpan) luma4A.x = luma4A.z;
	if (horzSpan) lengthSign = rcpFrame.y;
	float subpixB = (subpixA * (1.0 / 12.0)) - rgbyM.w;
	float gradientN = luma4B.z - rgbyM.w;
	float gradientS = luma4A.x - rgbyM.w;
	float lumaNN = luma4B.z + rgbyM.w;
	float lumaSS = luma4A.x + rgbyM.w;
	bool pairN = abs(gradientN) >= abs(gradientS);
	float gradient = max(abs(gradientN), abs(gradientS));
	if (pairN) lengthSign = -lengthSign;
	float subpixC = saturate(abs(subpixB) * subpixRcpRange);

	float2 posB;
	posB.x = posM.x;
	posB.y = posM.y;
	float2 offNP;
	offNP.x = (!horzSpan) ? 0.0 : rcpFrame.x;
	offNP.y = (horzSpan) ? 0.0 : rcpFrame.y;
	if (!horzSpan) posB.x += lengthSign * 0.5;
	if (horzSpan) posB.y += lengthSign * 0.5;

	float2 posN;
	posN.x = posB.x - offNP.x;
	posN.y = posB.y - offNP.y;
	float2 posP;
	posP.x = posB.x + offNP.x;
	posP.y = posB.y + offNP.y;
	float subpixD = ((-2.0) * subpixC) + 3.0;
	float lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN, 0).w;
	float subpixE = subpixC * subpixC;
	float lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP, 0).w;

	if (!pairN) lumaNN = lumaSS;
	float gradientScaled = gradient * 1.0 / 4.0;
	float lumaMM = rgbyM.w - lumaNN * 0.5;
	float subpixF = subpixD * subpixE;
	bool lumaMLTZero = lumaMM < 0.0;

	lumaEndN -= lumaNN * 0.5;
	lumaEndP -= lumaNN * 0.5;
	bool doneN = abs(lumaEndN) >= gradientScaled;
	bool doneP = abs(lumaEndP) >= gradientScaled;
	if (!doneN) posN.x -= offNP.x;
	if (!doneN) posN.y -= offNP.y;
	bool doneNP = (!doneN) || (!doneP);
	if (!doneP) posP.x += offNP.x;
	if (!doneP) posP.y += offNP.y;

	if (doneNP) {
		if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
		if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
		if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
		if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
		doneN = abs(lumaEndN) >= gradientScaled;
		doneP = abs(lumaEndP) >= gradientScaled;
		if (!doneN) posN.x -= offNP.x;
		if (!doneN) posN.y -= offNP.y;
		doneNP = (!doneN) || (!doneP);
		if (!doneP) posP.x += offNP.x;
		if (!doneP) posP.y += offNP.y;

		if (doneNP) {
			if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
			if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
			if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
			if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
			doneN = abs(lumaEndN) >= gradientScaled;
			doneP = abs(lumaEndP) >= gradientScaled;
			if (!doneN) posN.x -= offNP.x;
			if (!doneN) posN.y -= offNP.y;
			doneNP = (!doneN) || (!doneP);
			if (!doneP) posP.x += offNP.x;
			if (!doneP) posP.y += offNP.y;

			if (doneNP) {
				if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
				if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
				if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
				if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
				doneN = abs(lumaEndN) >= gradientScaled;
				doneP = abs(lumaEndP) >= gradientScaled;
				if (!doneN) posN.x -= offNP.x;
				if (!doneN) posN.y -= offNP.y;
				doneNP = (!doneN) || (!doneP);
				if (!doneP) posP.x += offNP.x;
				if (!doneP) posP.y += offNP.y;

				if (doneNP) {
					if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
					if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
					if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
					if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
					doneN = abs(lumaEndN) >= gradientScaled;
					doneP = abs(lumaEndP) >= gradientScaled;
					if (!doneN) posN.x -= offNP.x * 1.5;
					if (!doneN) posN.y -= offNP.y * 1.5;
					doneNP = (!doneN) || (!doneP);
					if (!doneP) posP.x += offNP.x * 1.5;
					if (!doneP) posP.y += offNP.y * 1.5;

					if (doneNP) {
						if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
						if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
						if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
						if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
						doneN = abs(lumaEndN) >= gradientScaled;
						doneP = abs(lumaEndP) >= gradientScaled;
						if (!doneN) posN.x -= offNP.x * 2.0;
						if (!doneN) posN.y -= offNP.y * 2.0;
						doneNP = (!doneN) || (!doneP);
						if (!doneP) posP.x += offNP.x * 2.0;
						if (!doneP) posP.y += offNP.y * 2.0;

						if (doneNP) {
							if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
							if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
							if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
							if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
							doneN = abs(lumaEndN) >= gradientScaled;
							doneP = abs(lumaEndP) >= gradientScaled;
							if (!doneN) posN.x -= offNP.x * 2.0;
							if (!doneN) posN.y -= offNP.y * 2.0;
							doneNP = (!doneN) || (!doneP);
							if (!doneP) posP.x += offNP.x * 2.0;
							if (!doneP) posP.y += offNP.y * 2.0;

							if (doneNP) {
								if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
								if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
								if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
								if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
								doneN = abs(lumaEndN) >= gradientScaled;
								doneP = abs(lumaEndP) >= gradientScaled;
								if (!doneN) posN.x -= offNP.x * 2.0;
								if (!doneN) posN.y -= offNP.y * 2.0;
								doneNP = (!doneN) || (!doneP);
								if (!doneP) posP.x += offNP.x * 2.0;
								if (!doneP) posP.y += offNP.y * 2.0;

								if (doneNP) {
									if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
									if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
									if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
									if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
									doneN = abs(lumaEndN) >= gradientScaled;
									doneP = abs(lumaEndP) >= gradientScaled;
									if (!doneN) posN.x -= offNP.x * 2.0;
									if (!doneN) posN.y -= offNP.y * 2.0;
									doneNP = (!doneN) || (!doneP);
									if (!doneP) posP.x += offNP.x * 2.0;
									if (!doneP) posP.y += offNP.y * 2.0;

									if (doneNP) {
										if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
										if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
										if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
										if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
										doneN = abs(lumaEndN) >= gradientScaled;
										doneP = abs(lumaEndP) >= gradientScaled;
										if (!doneN) posN.x -= offNP.x * 4.0;
										if (!doneN) posN.y -= offNP.y * 4.0;
										doneNP = (!doneN) || (!doneP);
										if (!doneP) posP.x += offNP.x * 4.0;
										if (!doneP) posP.y += offNP.y * 4.0;

										if (doneNP) {
											if (!doneN) lumaEndN = RenderTargetRGBA64F.SampleLevel(Sampler1, posN.xy, 0).w;
											if (!doneP) lumaEndP = RenderTargetRGBA64F.SampleLevel(Sampler1, posP.xy, 0).w;
											if (!doneN) lumaEndN = lumaEndN - lumaNN * 0.5;
											if (!doneP) lumaEndP = lumaEndP - lumaNN * 0.5;
											doneN = abs(lumaEndN) >= gradientScaled;
											doneP = abs(lumaEndP) >= gradientScaled;
											if (!doneN) posN.x -= offNP.x * 8.0;
											if (!doneN) posN.y -= offNP.y * 8.0;
											doneNP = (!doneN) || (!doneP);
											if (!doneP) posP.x += offNP.x * 8.0;
											if (!doneP) posP.y += offNP.y * 8.0;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	float dstN = posM.x - posN.x;
	float dstP = posP.x - posM.x;
	if (!horzSpan) dstN = posM.y - posN.y;
	if (!horzSpan) dstP = posP.y - posM.y;
	bool goodSpanN = (lumaEndN < 0.0) != lumaMLTZero;
	float spanLength = (dstP + dstN);
	bool goodSpanP = (lumaEndP < 0.0) != lumaMLTZero;
	float spanLengthRcp = 1.0 / spanLength;
	bool directionN = dstN < dstP;
	float dst = min(dstN, dstP);
	bool goodSpan = directionN ? goodSpanN : goodSpanP;
	float subpixG = subpixF * subpixF;
	float pixelOffset = (dst * (-spanLengthRcp)) + 0.5;
	float subpixH = subpixG * SubPix;
	float pixelOffsetGood = goodSpan ? pixelOffset : 0.0;
	float pixelOffsetSubpix = max(pixelOffsetGood, subpixH);
	if (!horzSpan) posM.x += pixelOffsetSubpix * lengthSign;
	if (horzSpan) posM.y += pixelOffsetSubpix * lengthSign;
	return float4(TextureColor.SampleLevel(Sampler1, posM, 0).xyz, 1);
}

float4 PS_Down1(VS_OUTPUT_POST IN) : SV_Target
{
	if (IN.txcoord0.x > 0.499999 || IN.txcoord0.y > 0.499999) return 0;
	return float4(TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy * 2.0, 0).xyz, 1);
}
float4 PS_Down2(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, (IN.txcoord0.xy + float2(-0.5,0.0)) * 2.0, 0).xyz;
	if (IN.txcoord0.x < 0.499999 || IN.txcoord0.y > 0.499999) res = 0;
	res += RenderTargetRGBA64F.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	return float4(res, 1);
}
float4 PS_Down3(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, (IN.txcoord0.xy + float2(0.0,-0.5)) * 2.0, 0).xyz;
	if (IN.txcoord0.x > 0.499999 || IN.txcoord0.y < 0.499999) res = 0;
	res += RenderTargetRGBA64F.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	return float4(res, 1);
}
float4 PS_Down4(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, (IN.txcoord0.xy + float2(-0.5,-0.5)) * 2.0, 0).xyz;
	if (IN.txcoord0.x < 0.499999 || IN.txcoord0.y < 0.499999) res = 0;
	res += RenderTargetRGBA64F.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	return float4(res, 1);
}

float4 PS_Rb(VS_OUTPUT_POSTRB IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	if (IN.txcoord2.z > 0.0) {
		float3 dir = normalize(IN.txcoord1.xyz);
		float3 r = saturate(1.0 - abs((float3(51.4, 50.7, 50.0) - degrees(acos(dot(rb_dir, dir)))) * 0.7));
		float3 rainbow = (r * r * 3.0 - 2.0 * r * r * r) * rb_int;
		if (rb_double) {
			r = saturate(1.0 - abs((float3(50.0, 51.1, 52.2) - degrees(acos(dot(rb_dir, dir * 1.14)))) * 0.5));
			rainbow += (r * r * 3.0 - 2.0 * r * r * r) * rb_int * 0.561;
		}
		rainbow *= saturate(1.0 - (IN.txcoord2.x * 0.01 + 1.0));
		float depth = GTA5linearDepth(TextureDepth.SampleLevel(Sampler1, IN.txcoord0.xy, 0).x);
		res += rainbow * IN.txcoord2.z * (depth > IN.txcoord2.y);
	}
	return float4(res,1);
}
float4 PS_Rb2(VS_OUTPUT_POSTRB IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	if (IN.txcoord2.z > 0.0) {
		float3 dir = normalize(IN.txcoord1.xyz);
		float3 r = saturate(1.0 - abs((float3(51.4, 50.7, 50.0) - degrees(acos(dot(rb2_dir, dir)))) * 0.7));
		float3 rainbow = (r * r * 3.0 - 2.0 * r * r * r) * rb2_int;
		if (rb2_double) {
			r = saturate(1.0 - abs((float3(50.0, 51.1, 52.2) - degrees(acos(dot(rb2_dir, dir * 1.14)))) * 0.5));
			rainbow += (r * r * 3.0 - 2.0 * r * r * r) * rb2_int * 0.561;
		}
		rainbow *= saturate(1.0 - (IN.txcoord2.x * 0.01 + 1.0));
		float depth = GTA5linearDepth(TextureDepth.SampleLevel(Sampler1, IN.txcoord0.xy, 0).x);
		res += rainbow * IN.txcoord2.z * (depth > IN.txcoord2.y);
	}
	return float4(res,1);
}
float4 PS_Rb3(VS_OUTPUT_POSTRB IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	if (IN.txcoord2.z > 0.0) {
		float3 dir = normalize(IN.txcoord1.xyz);
		float3 r = saturate(1.0 - abs((float3(51.4, 50.7, 50.0) - degrees(acos(dot(rb3_dir, dir)))) * 0.7));
		float3 rainbow = (r * r * 3.0 - 2.0 * r * r * r) * rb3_int;
		if (rb3_double) {
			r = saturate(1.0 - abs((float3(50.0, 51.1, 52.2) - degrees(acos(dot(rb3_dir, dir * 1.14)))) * 0.5));
			rainbow += (r * r * 3.0 - 2.0 * r * r * r) * rb3_int * 0.561;
		}
		rainbow *= saturate(1.0 - (IN.txcoord2.x * 0.01 + 1.0));
		float depth = GTA5linearDepth(TextureDepth.SampleLevel(Sampler1, IN.txcoord0.xy, 0).x);
		res += rainbow * IN.txcoord2.z * (depth > IN.txcoord2.y);
	}
	return float4(res,1);
}

float4 PS_Photo(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	float gray = dot(res, float3(0.2126, 0.7152, 0.0722));

	if (cc) { res = length(res) * pow(normalize(res), ccm) * ccb; }
	if (bw) { res = pow(gray, bwg) * bwb; }

	if (cc || bw)
	{
		float3 noize = IN.txcoord0.xyy + 4.0;
		noize = float3(1000, 76.9231, 8.13008) * Timer.x * noize.x * noize.y;
		noize.yz = floor(noize.yz);
		noize.xy = (noize.yz * float2(-13, -123) + noize.x) + 1.0;
		noize.x = noize.x * noize.y;
		noize.y = floor(noize.x * 100.0);
		noize.x = (noize.y * -0.01 + noize.x) - 0.006;
		noize.y = gray;
		noize.x = noize.x * 250.0 + noize.y;
		noize.xz = float2(-0.5, 1) + noize.xy;
		noize.y = saturate(-(noize.y / noize.z) * 4.0 + 1.0);
		res *= noize.x * noize.y * 0.1 + 1.0;

		float noise = noisetex.Load(int3((int2)v0.xy & int2(63, 63), 0)).x * 2.0 - 1.0;
		res = saturate(noise * 0.0091 + res);
	}

	return float4(res, 1);
}

float3 CLutFunc(Texture2D CLut_tex, float3 res, float intensity)
{
	float2 CLut_Size = float2(256.0, 16.0);
	CLut_tex.GetDimensions(CLut_Size.x, CLut_Size.y);
	float2 CLut_pSize = rcp(CLut_Size);
	float3 color = res * (CLut_Size.y - 1.0);
	float4 CLut_UV;
	CLut_UV.w = floor(color.z);
	CLut_UV.xy = (color.xy + 0.5) * CLut_pSize;
	CLut_UV.x += CLut_UV.w * CLut_pSize.y;
	CLut_UV.z = CLut_UV.x + CLut_pSize.y;
	color = lerp(CLut_tex.SampleLevel(Sampler1, CLut_UV.xy, 0).xyz, CLut_tex.SampleLevel(Sampler1, CLut_UV.zy, 0).xyz, color.z - CLut_UV.w);
	return lerp(res, color, intensity);
}
float3 lut_t(float3 night, float3 sunset, float3 day)
{
	float t0 = smoothstep(5.1, 5.7, GameTime);
	float t1 = smoothstep(8.6, 10.5, GameTime);
	float t2 = smoothstep(18.4, 18.9, GameTime);
	float t3 = smoothstep(20.6, 21.2, GameTime);
	float3 t = lerp(night, sunset, t0);
	t = lerp(t, day, t1);
	t = lerp(t, sunset, t2);
	t = lerp(t, night, t3);
	return t;
}
float3 lut_w(float3 res)
{
	float3 extra_night = CLutFunc(lut_extrasunny_night, res, exni);
	float3 extra_sunset = CLutFunc(lut_extrasunny_sunset, res, exsi);
	float3 extra_day = CLutFunc(lut_extrasunny_day, res, exdi);
	float3 clear_night = CLutFunc(lut_clear_night, res, clni);
	float3 clear_sunset = CLutFunc(lut_clear_sunset, res, clsi);
	float3 clear_day = CLutFunc(lut_clear_day, res, cldi);
	float3 clearing_night = CLutFunc(lut_clearing_night, res, cgni);
	float3 clearing_sunset = CLutFunc(lut_clearing_sunset, res, cgsi);
	float3 clearing_day = CLutFunc(lut_clearing_day, res, cgdi);
	float3 clouds_night = CLutFunc(lut_clouds_night, res, coni);
	float3 clouds_sunset = CLutFunc(lut_clouds_sunset, res, cosi);
	float3 clouds_day = CLutFunc(lut_clouds_day, res, codi);
	float3 overcast_night = CLutFunc(lut_overcast_night, res, ovni);
	float3 overcast_sunset = CLutFunc(lut_overcast_sunset, res, ovsi);
	float3 overcast_day = CLutFunc(lut_overcast_day, res, ovdi);
	float3 smog_night = CLutFunc(lut_smog_night, res, smni);
	float3 smog_sunset = CLutFunc(lut_smog_sunset, res, smsi);
	float3 smog_day = CLutFunc(lut_smog_day, res, smdi);
	float3 foggy_night = CLutFunc(lut_foggy_night, res, foni);
	float3 foggy_sunset = CLutFunc(lut_foggy_sunset, res, fosi);
	float3 foggy_day = CLutFunc(lut_foggy_day, res, fodi);
	float3 rain_night = CLutFunc(lut_rain_night, res, rani);
	float3 rain_sunset = CLutFunc(lut_rain_sunset, res, rasi);
	float3 rain_day = CLutFunc(lut_rain_day, res, radi);
	float3 thunder_night = CLutFunc(lut_thunder_night, res, thni);
	float3 thunder_sunset = CLutFunc(lut_thunder_sunset, res, thsi);
	float3 thunder_day = CLutFunc(lut_thunder_day, res, thdi);
	float3 blizzard_night = CLutFunc(lut_blizzard_night, res, blni);
	float3 blizzard_sunset = CLutFunc(lut_blizzard_sunset, res, blsi);
	float3 blizzard_day = CLutFunc(lut_blizzard_day, res, bldi);
	float3 neutral_night = CLutFunc(lut_neutral_night, res, neni);
	float3 neutral_sunset = CLutFunc(lut_neutral_sunset, res, nesi);
	float3 neutral_day = CLutFunc(lut_neutral_day, res, nedi);
	float3 snow_night = CLutFunc(lut_snow_night, res, snni);
	float3 snow_sunset = CLutFunc(lut_snow_sunset, res, snsi);
	float3 snow_day = CLutFunc(lut_snow_day, res, sndi);
	float3 snowl_night = CLutFunc(lut_snowl_night, res, slni);
	float3 snowl_sunset = CLutFunc(lut_snowl_sunset, res, slsi);
	float3 snowl_day = CLutFunc(lut_snowl_day, res, sldi);
	float3 xmas_night = CLutFunc(lut_xmas_night, res, xmni);
	float3 xmas_sunset = CLutFunc(lut_xmas_sunset, res, xmsi);
	float3 xmas_day = CLutFunc(lut_xmas_day, res, xmdi);
	float3 hallo_night = CLutFunc(lut_hallo_night, res, hani);
	float3 hallo_sunset = CLutFunc(lut_hallo_sunset, res, hasi);
	float3 hallo_day = CLutFunc(lut_hallo_day, res, hadi);

	const float3 w[16] =
	{
		res,							//notfound
		lut_t(extra_night, extra_sunset, extra_day),		//extrasunny
		lut_t(clear_night, clear_sunset, clear_day),		//clear
		lut_t(clearing_night, clearing_sunset, clearing_day),	//clearing
		lut_t(clouds_night, clouds_sunset, clouds_day),		//clouds
		lut_t(overcast_night, overcast_sunset, overcast_day),	//overcast
		lut_t(smog_night, smog_sunset, smog_day),		//smog
		lut_t(foggy_night, foggy_sunset, foggy_day),		//foggy
		lut_t(rain_night, rain_sunset, rain_day),		//rain
		lut_t(thunder_night, thunder_sunset, thunder_day),	//thunder
		lut_t(blizzard_night, blizzard_sunset, blizzard_day),	//blizzard
		lut_t(neutral_night, neutral_sunset, neutral_day),	//neutral
		lut_t(snow_night, snow_sunset, snow_day),		//snow
		lut_t(snowl_night, snowl_sunset, snowl_day),		//snowlight
		lut_t(xmas_night, xmas_sunset, xmas_day),		//xmas
		lut_t(hallo_night, hallo_sunset, hallo_day)		//halloween
	};
	return lerp(w[(int)qWeather.x], w[(int)qWeather.y], qWeather.z);
}
float4 PS_Lut(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	[branch] if (lut)
	{
		res = CLutFunc(lut_global, res, gli);
		float3 interior_night = CLutFunc(i_night, res, ini);
		float3 interior_sunset = CLutFunc(i_sunset, res, isi);
		float3 interior_day = CLutFunc(i_day, res, idi);
		//res = lerp(lut_t(interior_night, interior_sunset, interior_day), lut_w(res), 1.0 - saturate(ExteriorInterior));
		res = lut_w(res);
	}
	return float4(res, 1);
}

float4 PS_Distort(VS_OUTPUT_POST IN) : SV_Target
{
	float2 uv = IN.txcoord0.xy * 2.0 - 1.0;
	uv *= 0.59;
	float lens = dot(uv, uv) + 1.0;
	uv = lerp(IN.txcoord0.xy, (uv * lens + 1.0) * 0.5, ldistort);
	float3 res = TextureColor.SampleLevel(Sampler1, uv, 0).xyz;
	return float4(res, 1);
}

float4 PS_RDR2Noise(VS_OUTPUT_POSTN IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz;
	float noise = noisetex.Load(int3((int2)v0.xy & int2(63, 63), 0)).x * 2.0 - 1.0;
	float lum = saturate(max(res.x, max(res.y, res.z)));
	lum = lum * lum;
	lum = lum * (IN.txcoord0.w - IN.txcoord0.z) + IN.txcoord0.z;
	res = saturate(noise * lum + res);
	return float4(res,1);
}

float4 PS_CAS(VS_OUTPUT_POST0 IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz;
	float3 A = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(-1,-1)).xyz;
	float3 B = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(0,-1)).xyz;
	float3 C = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(1,-1)).xyz;
	float3 D = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(-1,0)).xyz;
	float3 E = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(1,0)).xyz;
	float3 F = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(-1,1)).xyz;
	float3 G = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(0,1)).xyz;
	float3 H = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0, int2(1,1)).xyz;

	float3 minCol = min(min(min(D, res), min(E, B)), G);
	minCol += min(minCol, min(min(A, C), min(F, H)));

	float3 maxCol = max(max(max(D, res), max(E, B)), G);
	maxCol += max(maxCol, max(max(A, C), max(F, H)));

	float3 mix = -rcp(rsqrt(saturate(min(minCol, 2.0 - maxCol) * rcp(maxCol))) * 8.0);
	float3 cas = saturate((((B + D) + (E + G)) * mix + res) * rcp(1.0 + 4.0 * mix));
	return float4(lerp(res, cas, IN.txcoord0.z), 1);
}

float4 PS_Water(VS_OUTPUT_POSTRD f):SV_Target
{
	float4 y,w,z,x,s,r,T;if(f.txcoord1.z)y.xy=float2(.000833,.00011)*Test1.y,y.z=f.txcoord0.x<.5,y.yz=y.z?y.xy:-y.xy,w.xy=f.txcoord0.z*float2(30.,1.85)+y.yz,y.w=f.txcoord0.w*30+y.x,w.x=-Test1.z*.049+w.x,y.w=Test1.w*.012+y.w,z.x=floor(w.x),z.y=floor(y.w),x.x=frac(w.x),x.y=frac(y.w),w.xz=x.xy-.5,y.w=dot(z.xy,float2(107.45,3543.65)),z.xyz=float3(.13787,.11369,.1031)*y.w,z.xyz=frac(z.xyz),x.xyz=19.19+z.yxz,y.w=dot(z.zyx,x.xyz),z.xyz=z.xyz+y.w,x.xyz=z.zzy+z.yxx,z.xyz=x.xyz*z.xyz,z.xyz=frac(z.xyz),z.xy=z.xy-.5,w.xz=-z.xy*.7+w.xz,y.w=dot(w.xz,w.xz),y.w=sqrt(y.w),y.w=-.3+y.w,y.w=-3.33333*y.w,y.w=max(0,y.w),w.x=y.w*-2+3,y.w=y.w*y.w,y.w=w.x*y.w,w.x=10*z.z,w.x=frac(w.x),y.w=w.x*y.w,w.x=f.txcoord1.w+z.z,w.x=frac(w.x),w.z=40*w.x,w.z=min(1,w.z),w.w=w.z*-2+3,w.z=w.z*w.z,w.z=w.w*w.z,w.x=w.x-1.,w.x=-1.02564*w.x,w.x=min(1,w.x),w.w=w.x*-2+3,w.x=w.x*w.x,w.x=w.w*w.x,w.x=w.z*w.x,y.w=w.x*y.w,w.x=.75*f.txcoord1.w,w.z=f.txcoord0.w*1.85+w.x,w.z=Test1.y*.00011+w.z,z.x=-Test1.z*.006+w.y,w.y=Test1.w*.00171+w.z,w.z=12*z.x,w.z=floor(w.z),w.z=12345.6*w.z,w.z=sin(w.z),w.z=7658.76*w.z,w.z=frac(w.z),z.y=w.y+w.z,w.yz=float2(12,2)*z.xy,z.xy=floor(w.yz),w.w=dot(z.xy,float2(35.2,2376.1)),z.xyz=float3(.1031,.11369,.13787)*w.w,z.xyz=frac(z.xyz),x.xyz=19.19+z.yzx,w.w=dot(z.xyz,x.xyz),z.xyz=z.xyz+w.w,z.yw=z.xy+z.yz,z.xy=z.yw*z.zx,z.xy=frac(z.xy),x.xy=frac(w.yz),w.y=-1+x.y,w.zw=z.xy-.5,z.xz=float2(37,18.5)*f.txcoord0.w,z.x=sin(z.x),z.x=f.txcoord0.w*37+z.x,z.x=sin(z.x),z.w=.5-abs(w.z),z.x=z.x*z.w,w.z=z.x*w.w+w.z,s.x=.7*w.z,w.z=f.txcoord1.w+z.y,w.z=frac(w.z),w.w=1.17647*w.z,w.w=min(1,w.w),z.x=w.w*-2+3,w.w=w.w*w.w,w.w=z.x*w.w,w.z=-1+w.z,w.z=-6.66667*w.z,w.z=min(1,w.z),z.x=w.z*-2+3,w.z=w.z*w.z,w.z=z.x*w.z,w.z=w.w*w.z-.5,s.yz=w.z*.9+float2(.5,-.5),x.zw=x.x-.5,w.zw=-s.xy+x.zy,z.xy=float2(1,6)*w.zw,w.z=dot(z.xy,z.xy),w.z=sqrt(w.z),w.zw=float2(-.4,.02)+w.zw,w.z=-2.5*w.z,w.z=max(0,w.z),z.x=w.z*-2+3,z.y=rcp(s.z),w.y=saturate(z.y*w.y),z.y=w.y*-2+3,w.y=w.y*w.y,w.y=z.y*w.y,w.y=sqrt(w.y),w.w=saturate(25*w.w),z.y=w.w*-2+3,w.w=w.w*w.w,w.w=z.y*w.w,z.y=frac(z.z),z.y=x.y+z.y,s.w=-.5+z.y,z.yz=-s.xw+x.wy,z.y=dot(z.yz,z.yz),z.y=sqrt(z.y),z.y=-.3+z.y,z.y=-3.33333*z.y,z.y=max(0,z.y),z.z=z.y*-2+3,z.y=z.y*z.y,z.y=z.z*z.y,w.y=z.y*w.y,w.yz=w.yz*w.wz,w.y=z.x*w.z+w.y,w.y=f.txcoord1.y*w.y,y.w=y.w*f.txcoord1.x+w.y,y.w=-.3+y.w,y.w=saturate(.588235*y.w),w.y=y.w*-2+3,y.w=y.w*y.w,y.w=w.y*y.w,z.xyzw=float4(.001,0,0,.001)+f.txcoord0.zwzw,w.yz=z.xx*float2(30,1.85)+y.yz,w.w=z.y*30+y.x,w.y=-Test1.z*.049+w.y,w.w=Test1.w*.012+w.w,x.xy=floor(w.yw),s.xy=frac(w.yw),w.yw=s.xy-.5,z.x=dot(x.xy,float2(107.45,3543.65)),x.xyz=float3(.13787,.11369,.1031)*z.x,x.xyz=frac(x.xyz),s.xyz=19.19+x.yxz,z.x=dot(x.zyx,s.xyz),x.xyz=x.xyz+z.x,s.xyz=x.zzy+x.yxx,x.xyz=s.xyz*x.xyz,x.xyz=frac(x.xyz),x.xy=x.xy-.5,w.yw=-x.xy*.7+w.yw,w.y=dot(w.yw,w.yw),w.y=sqrt(w.y),w.y=-.3+w.y,w.y=-3.33333*w.y,w.y=max(0,w.y),w.w=w.y*-2+3,w.y=w.y*w.y,w.y=w.w*w.y,w.w=10*x.z,w.w=frac(w.w),w.y=w.y*w.w,w.w=f.txcoord1.w+x.z,w.w=frac(w.w),z.x=40*w.w,z.x=min(1,z.x),x.x=z.x*-2+3,z.x=z.x*z.x,z.x=x.x*z.x,w.w=-1+w.w,w.w=-1.02564*w.w,w.w=min(1,w.w),x.x=w.w*-2+3,w.w=w.w*w.w,w.w=x.x*w.w,w.w=z.x*w.w,w.y=w.y*w.w,w.w=z.y*1.85+w.x,w.w=Test1.y*.00011+w.w,x.x=-Test1.z*.006+w.z,w.z=Test1.w*.00171+w.w,w.w=12*x.x,w.w=floor(w.w),w.w=12345.6*w.w,w.w=sin(w.w),w.w=7658.76*w.w,w.w=frac(w.w),x.y=w.z+w.w,w.zw=float2(12,2)*x.xy,x.xy=floor(w.zw),z.x=dot(x.xy,float2(35.2,2376.1)),x.xyz=float3(.1031,.11369,.13787)*z.x,x.xyz=frac(x.xyz),s.xyz=19.19+x.yzx,z.x=dot(x.xyz,s.xyz),x.xyz=x.xyz+z.x,x.yw=x.xy+x.yz,x.xy=x.yw*x.zx,x.xy=frac(x.xy),s.xy=frac(w.zw),w.z=-1+s.y,x.xz=x.xy-.5,r.xy=float2(37,18.5)*z.yy,w.w=sin(r.x),w.w=z.y*37+w.w,w.w=sin(w.w),z.x=.5-abs(x.x),w.w=z.x*w.w,w.w=w.w*x.z+x.x,T.x=.7*w.w,w.w=f.txcoord1.w+x.y,w.w=frac(w.w),z.x=1.17647*w.w,z.x=min(1,z.x),z.y=z.x*-2+3,z.x=z.x*z.x,z.x=z.y*z.x,w.w=-1+w.w,w.w=-6.66667*w.w,w.w=min(1,w.w),z.y=w.w*-2+3,w.w=w.w*w.w,w.w=z.y*w.w,w.w=z.x*w.w-.5,T.yz=w.w*.9+float2(.5,-.5),s.zw=s.x-.5,z.xy=-T.xy+s.zy,x.xy=float2(1,6)*z.xy,w.w=dot(x.xy,x.xy),w.w=sqrt(w.w),w.w=-.4+w.w,w.w=-2.5*w.w,w.w=max(0,w.w),z.x=w.w*-2+3,w.w=w.w*w.w,x.x=rcp(T.z),w.z=saturate(x.x*w.z),x.x=w.z*-2+3,w.z=w.z*w.z,w.z=x.x*w.z,w.z=sqrt(w.z),z.y=.02+z.y,z.y=saturate(25*z.y),x.x=z.y*-2+3,z.y=z.y*z.y,z.y=x.x*z.y,x.x=frac(r.y),x.x=s.y+x.x,T.w=-.5+x.x,x.xy=-T.xw+s.wy,x.x=dot(x.xy,x.xy),x.x=sqrt(x.x),x.x=-.3+x.x,x.x=-3.33333*x.x,x.x=max(0,x.x),x.y=x.x*-2+3,x.x=x.x*x.x,x.x=x.y*x.x,w.z=x.x*w.z,w.z=w.z*z.y,w.z=z.x*w.w+w.z,w.z=f.txcoord1.y*w.z,w.y=w.y*f.txcoord1.x+w.z,w.y=-.3+w.y,w.y=saturate(.588235*w.y),w.z=w.y*-2+3,y.y=z.z*30+y.y,y.x=z.w*30+y.x,y.y=-Test1.z*.049+y.y,y.x=Test1.w*.012+y.x,z.xy=floor(y.yx),x.xy=frac(y.yx),y.xy=x.xy-.5,w.w=dot(z.xy,float2(107.45,3543.65)),x.xyz=float3(.13787,.11369,.1031)*w.w,x.xyz=frac(x.xyz),s.xyz=19.19+x.yxz,w.w=dot(x.zyx,s.xyz),x.xyz=x.xyz+w.w,s.xyz=x.zzy+x.yxx,x.xyz=s.xyz*x.xyz,x.xyz=frac(x.xyz),z.xy=x.xy-.5,y.xy=-z.xy*.7+y.xy,y.x=dot(y.xy,y.xy),y.x=sqrt(y.x),y.x=-.3+y.x,y.x=-3.33333*y.x,y.x=max(0,y.x),y.y=y.x*-2+3,y.x=y.x*y.x,y.x=y.y*y.x,y.y=10*x.z,y.y=frac(y.y),y.x=y.x*y.y,y.y=f.txcoord1.w+x.z,y.y=frac(y.y),w.w=40*y.y,w.w=min(1,w.w),z.x=w.w*-2+3,w.w=w.w*w.w,w.w=z.x*w.w,y.y=-1+y.y,y.y=-1.02564*y.y,y.y=min(1,y.y),z.x=y.y*-2+3,y.y=y.y*y.y,y.y=z.x*y.y,y.y=w.w*y.y,y.x=y.x*y.y,z.xy=float2(37,18.5)*z.w,y.y=z.w*1.85+w.x,y.z=z.z*1.85+y.z,y.y=Test1.y*.00011+y.y,x.x=-Test1.z*.006+y.z,y.y=Test1.w*.00171+y.y,y.z=12*x.x,y.z=floor(y.z),y.z=12345.6*y.z,y.z=sin(y.z),y.z=7658.76*y.z,y.z=frac(y.z),x.y=y.y+y.z,y.yz=float2(12,2)*x.xy,w.xw=floor(y.yz),w.x=dot(w.xw,float2(35.2,2376.1)),x.xyz=float3(.1031,.11369,.13787)*w.x,x.xyz=frac(x.xyz),s.xyz=19.19+x.yzx,w.x=dot(x.xyz,s.xyz),x.xyz=x.xyz+w.x,w.xw=x.xy+x.yz,w.xw=w.xw*x.zx,w.xw=frac(w.xw),x.xy=frac(y.yz),y.y=-1+x.y,s.xy=w.xw-.5,y.z=sin(z.x),y.z=z.w*37+y.z,y.z=sin(y.z),w.x=.5-abs(s.x),y.z=w.x*y.z,y.z=y.z*s.y+s.x,s.x=.7*y.z,y.z=f.txcoord1.w+w.w,y.z=frac(y.z),w.x=1.17647*y.z,w.x=min(1,w.x),w.w=w.x*-2+3,w.x=w.x*w.x,w.x=w.w*w.x,y.z=-1+y.z,y.z=-6.66667*y.z,y.z=min(1,y.z),w.w=y.z*-2+3,y.z=y.z*y.z,y.z=w.w*y.z,y.z=w.x*y.z-.5,s.yz=y.z*.9+float2(.5,-.5),x.zw=x.x-.5,w.xw=-s.xy+x.zy,z.xz=float2(1,6)*w.xw,y.z=dot(z.xz,z.xz),y.z=sqrt(y.z),y.z=-.4+y.z,y.z=-2.5*y.z,y.z=max(0,y.z),w.x=y.z*-2+3,y.z=y.z*y.z,z.x=rcp(s.z),y.y=saturate(z.x*y.y),z.x=y.y*-2+3,y.y=y.y*y.y,y.y=z.x*y.y,y.y=sqrt(y.y),w.w=.02+w.w,w.w=saturate(25*w.w),z.x=w.w*-2+3,w.yw=w.yw*w.yw,w.w=z.x*w.w,z.x=frac(z.y),z.x=x.y+z.x,s.w=-.5+z.x,z.xy=-s.xw+x.wy,z.x=dot(z.xy,z.xy),z.x=sqrt(z.x),z.x=-.3+z.x,z.x=-3.33333*z.x,z.x=max(0,z.x),z.y=z.x*-2+3,z.x=z.x*z.x,z.x=z.y*z.x,y.y=z.x*y.y,y.y=y.y*w.w,y.y=w.x*y.z+y.y,y.y=f.txcoord1.y*y.y,y.x=y.x*f.txcoord1.x+y.y,y.x=-.3+y.x,y.x=saturate(.588235*y.x),y.y=y.x*-2+3,y.x=y.x*y.x,w.x=w.z*w.y-y.w,w.y=y.y*y.x-y.w,y.x=1.-saturate(ExteriorInterior),y.xy=w.xy*y.xx,y.z=1.-Test2.y,y.xy=y.xy*y.zz,w.xyz=f.txcoord0.xxy-.5,y.z=100.*w.x,y.z=y.z*y.z,y.z=min(1,y.z),y.zw=y.xy*y.zz,w.xw=f.txcoord0.xy*float2(4.,1.)+float2(-2.,-.5),w.x=dot(w.xw,w.xw),w.x=min(1.,w.x),w.w=.055*Test2.x,w.w=min(1.,w.w),y.xy=y.xy*w.xx-y.zw,y.xy=w.w*y.xy+y.zw,y.zw=w.yz*float2(3,3)+float2(.03,-.24),y.z=dot(y.zw,y.zw),y.z=y.z*y.z+1.,y.z=saturate(-rvig+y.z),y.xy=y.xy*y.z;else y.xy=0.;y.w=bool(length(y.xy));y.xyz=TextureColor.SampleLevel(Sampler1,f.txcoord0.xy+ri*y.xy,0).xyz;return y;
};

float4 PS_W2(VS_OUTPUT_POSTRD IN) : SV_Target
{
	float4 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0.0);
	float3 blur = res.xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + float2(IN.txcoord1.x, 0.0), 0).xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * float2(0.5, 0.86602540378), 0).xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * float2(-0.5, 0.86602540378), 0).xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + float2(-IN.txcoord1.x, 0.0), 0).xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * float2(-0.5, -0.86602540378), 0).xyz;
	blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * float2(0.5, -0.86602540378), 0).xyz;
	blur /= 7.0;
	res.xyz = lerp(res.xyz, blur, res.w);
	return res;
}

float4 PS_Frozen(VS_OUTPUT_POSTRD IN) : SV_Target
{
	float3 tex = distor.SampleLevel(Sampler2, IN.txcoord0.xy + Timer.x, 0).xyz;
	tex.xy -= 0.5;
	float vig = pow(1.0 - smoothstep(0.975, 0.05, length(IN.txcoord0.xy - 0.5) * IN.txcoord1.y), 7.0) * IN.txcoord1.y * s_s * (1.0 - saturate(ExteriorInterior));
	float noise = frac(sin(dot(IN.txcoord0.xy, float2(12.9898, 78.233))) * 43758.5453);
	noise *= 0.025 * vig + pow(tex.z, 4.0) * vig * IN.txcoord1.x;
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + tex.xy * vig, 0).xyz;
	res = lerp(res, 1.0, saturate(noise * 5.0));
	return float4(res,1);
}

float4 PS_RBlur(VS_OUTPUT_POSTN IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	if (blu)
	{
		float noise = noisetex.Load(int3((int2)v0.xy & int2(63, 63), 0)).x * 2.0 - 1.0;
		float2 fpoint = IN.txcoord0.zw * bmsxy;
		float mask = saturate(dot(fpoint, fpoint) * rcp(bms) * 1000.0);
		float3 blur = 0;
		for (float i = 0; i < bs; i++) {
			float2 rad = (noise * bi * 2.0 + float2(i, i * ScreenSize.z)) / bs * IN.txcoord0.zw * mask;
			blur += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + rad, 0).xyz;
		}
		res = blur / bs;
	}
	return float4(res,1);
}

float4 PS_VCA(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;

	if (bvca)
	{
		float2 uv = IN.txcoord0.xy * 0.5 + 0.5;
		uv = normalize(float2(uv.x * dot(uv, uv), 0.0)) * vca;
		//float noise = noisetex.Load(int3((int2)v0.xy & int2(63, 63), 0)).x * 2.0 - 1.0;
		//uv += noise * 0.0005;
		res = 0;
		res.x += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy - uv - uv, 0).x * 0.6666667;
		res.xy += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy - uv, 0).xy * float2(0.3333333, 0.25);
		res.y += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).y * 0.5;
		res.yz += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + uv, 0).yz * float2(0.25, 0.3333333);
		res.z += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + uv + uv, 0).z * 0.6666667;
	}

	return float4(res,1);
}
float4 PS_RCA(VS_OUTPUT_POSTC IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	if (bca) {
		res = 0;
		float2 uvx = 0;
		float2 uvy = 0;
		float2 uvz = 0;
		float2 vig = normalize(IN.txcoord0.xy - 0.5) * length(IN.txcoord0.xy - 0.5) * rca;
		for (int i = 0; i < IN.txcoord1; i++) {
			res.x += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + uvx, 0).x;
			res.y += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + uvy, 0).y;
			res.z += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + uvz, 0).z;
			uvx -= vig * IN.txcoord2.x;
			uvy -= vig * IN.txcoord2.y;
			uvz -= vig * IN.txcoord2.z;
		}
		res /= IN.txcoord1;
	}
	return float4(res, 1);
}

float4 PS_Background(VS_OUTPUT_POST3 IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	float4 grid = gridtex.SampleLevel(Sampler1, IN.txcoord0.xy, 0);
	if (grid1)res = lerp(res, res + grid.x, 0.25);
	if (grid2)res = lerp(res, res + grid.y, 0.25);
	if (grid3)res = lerp(res, res + grid.z, 0.25);
	if (grid4)res = lerp(res, res + grid.w, 0.25);
	float depth = GTA5linearDepth(TextureDepth.SampleLevel(Sampler1, IN.txcoord0.xy, 0).x);
	if (ddepth < 0.0)res = depth * abs(ddepth);
	if (ddepth > 0.0)res = 1.0 - depth * ddepth;
	if (useback) {
		float3 uv = normalize(IN.txcoord1.xyz);
		uv.x = atan2(uv.x, uv.y);
		uv.y = acos(uv.z);
		uv.xy += pos;
		uv.xy *= scale;
		float2 texSize; backtex.GetDimensions(texSize.x, texSize.y);
		uv.y *= texSize.x / texSize.y;
		float4 tex = (unwrap) ? backtex.SampleLevel(Sampler3, uv.xy, 0) : backtex.SampleLevel(Sampler2, uv.xy, 0);
		res = lerp(res, lerp(res, tex.xyz, tex.w), smoothstep(fadein, fadeout, depth));
	}
	return float4(res, 1);
}

technique11 Aaron < string UIName = "AaronX"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Up1()));
		SetPixelShader(CompileShader(ps_5_0, PS_Post0()));
	}
}
technique11 Aaron1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_DXAA()));
	}
}
technique11 Aaron2 < string RenderTarget = "RenderTargetRGBA64F"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Down1()));
	}
}
technique11 Aaron3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Up2()));
		SetPixelShader(CompileShader(ps_5_0, PS_Post0()));
	}
}
technique11 Aaron4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_DXAA()));
	}
}
technique11 Aaron5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Down2()));
	}
}
technique11 Aaron6 < string RenderTarget = "RenderTargetRGBA64F"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_p()));
	}
}

technique11 Aaron7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Up3()));
		SetPixelShader(CompileShader(ps_5_0, PS_Post0()));
	}
}
technique11 Aaron8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_DXAA()));
	}
}
technique11 Aaron9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Down3()));
	}
}
technique11 Aaron10 < string RenderTarget = "RenderTargetRGBA64F"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_p()));
	}
}

technique11 Aaron11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Up4()));
		SetPixelShader(CompileShader(ps_5_0, PS_Post0()));
	}
}
technique11 Aaron12
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_DXAA()));
	}
}
technique11 Aaron13
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Down4()));
	}
}

technique11 Aaron14 < string RenderTarget = "RenderTargetRGBA64F"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Luma()));
	}
}
technique11 Aaron15
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_FXAA()));
	}
}

technique11 Aaron16
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb()));
	}
}
technique11 Aaron17
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb2()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb2()));
	}
}
technique11 Aaron18
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb3()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb3()));
	}
}

technique11 Aaron19
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Photo()));
	}
}

technique11 Aaron20
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Lut()));
	}
}

technique11 Aaron21
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Distort()));
	}
}

technique11 Aaron22
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RDR2Noise()));
		SetPixelShader(CompileShader(ps_5_0, PS_RDR2Noise()));
	}
}

technique11 Aaron23
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_CAS()));
		SetPixelShader(CompileShader(ps_5_0, PS_CAS()));
	}
}

technique11 Aaron24
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Water()));
		SetPixelShader(CompileShader(ps_5_0, PS_Water()));
	}
}

technique11 Aaron25
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_W2()));
		SetPixelShader(CompileShader(ps_5_0, PS_W2()));
	}
}

technique11 Aaron26
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Frozen()));
		SetPixelShader(CompileShader(ps_5_0, PS_Frozen()));
	}
}

technique11 Aaron27
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RBlur()));
		SetPixelShader(CompileShader(ps_5_0, PS_RBlur()));
	}
}

technique11 Aaron28
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_VCA()));
	}
}

technique11 Aaron29
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RCA()));
		SetPixelShader(CompileShader(ps_5_0, PS_RCA()));
	}
}

technique11 Aaron30
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Background()));
		SetPixelShader(CompileShader(ps_5_0, PS_Background()));
	}
}

technique11 AaronL < string UIName = "AaronX low preset"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb()));
	}
}
technique11 AaronL1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb2()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb2()));
	}
}
technique11 AaronL2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Rb3()));
		SetPixelShader(CompileShader(ps_5_0, PS_Rb3()));
	}
}

technique11 AaronL3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Photo()));
	}
}

technique11 AaronL4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Lut()));
	}
}

technique11 AaronL5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_Distort()));
	}
}

technique11 AaronL6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RDR2Noise()));
		SetPixelShader(CompileShader(ps_5_0, PS_RDR2Noise()));
	}
}

technique11 AaronL7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Water()));
		SetPixelShader(CompileShader(ps_5_0, PS_Water()));
	}
}

technique11 AaronL8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_W2()));
		SetPixelShader(CompileShader(ps_5_0, PS_W2()));
	}
}

technique11 AaronL9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Frozen()));
		SetPixelShader(CompileShader(ps_5_0, PS_Frozen()));
	}
}

technique11 AaronL10
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RBlur()));
		SetPixelShader(CompileShader(ps_5_0, PS_RBlur()));
	}
}

technique11 AaronL11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_VCA()));
	}
}

technique11 AaronL12
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_RCA()));
		SetPixelShader(CompileShader(ps_5_0, PS_RCA()));
	}
}

technique11 AaronL13
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Background()));
		SetPixelShader(CompileShader(ps_5_0, PS_Background()));
	}
}
