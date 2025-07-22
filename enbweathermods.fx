//----------------------ENB PRESET---------------------//
/* 	____________________       _________   _____   
	

													   */
/////////////////////////////////////////////////////////
//            JONAH           //
//-----------------------------------------------------//
//                	WEATHER MOD SETTINGS               //
//                         0.0.1                       //

float 	satLimit ;
float 	MinExposureDay  ;
float 	MaxExposureDay  ;
float 	fxcolorMixDay  ;
float 	fTintPercentDay  ;
float 	fTintPercentNight  ;
float 	AdaptationMinDay  ;
float 	AdaptationMaxDay  ;
float 	BrightnessDay  ;
float 	IntensityContrastDay  ;
float	GammaDay ;
float	GammaNight ;
float 	SaturationDay  ;
float 	ToneMappingOversaturationDay  ;
float 	ToneMappingCurveDay  ;
float	RedFilterDay  ;
float	GreenFilterDay  ;
float	BlueFilterDay  ;
float	DesatRDay  ;
float	DesatGDay  ;
float	DesatBDay  ;
float 	MinExposureDawn ;
float 	MinExposureSunrise ;
float 	MinExposureSunset ;
float 	MinExposureDusk ;
float 	MinExposureNight  ;
float 	MaxExposureNight  ;
float 	fxcolorMixNight  ;
float 	AdaptationMinNight  ;
float 	AdaptationMaxNight  ;
float 	BrightnessNight  ;
float 	IntensityContrastNight  ;
float 	SaturationNight  ;
float 	ToneMappingOversaturationNight  ;
float 	ToneMappingCurveNight  ;
bool 	use_colorhuefx = true;
bool 	use_colorsaturation  = false;
float 	hueMid = 0.5; 
float 	hueRange =0.45;
float	RedFilterNight  ;
float	GreenFilterNight  ;
float	BlueFilterNight  ;
float	DesatRNight  ;
float	DesatGNight  ;
float	DesatBNight  ;
bool 	ENABLE_HDRU2D = true;
float 	fKeyValueD  ;
float 	ShoulderStrengthD  ;
float 	LinearStrengthD  ;
float 	LinearAngleD  ;
float 	ToeStrengthD  ;
float 	ToeDenominatorD  ;
float 	ToeNumeratorD  ;
float 	LinearWhiteD  ;
float 	fKeyValueN  ;
float 	ShoulderStrengthN  ;
float 	LinearStrengthN  ;
float 	LinearAngleN  ;
float 	ToeStrengthN  ;
float 	ToeNumeratorN  ;
float 	ToeDenominatorN  ;
float 	LinearWhiteN  ;
float 	WeatherMultiN;
float 	WeatherMultiD;
float 	WeatherAddN;
float 	WeatherAddD;
float	CloudDensity;
float	CloudNoise;
float	CloudWindSpeed;
/////////////////////////////////////////////////////////
//              		VANILLA						   //
/////////////////////////////////////////////////////////

if (iWeatherMod == 0) {
 	
	WeatherMultiD=0.33;
	WeatherMultiN=0.65;
	WeatherAddN=0.5f;
	WeatherAddD=1.0f;
	satLimit = 1.0;
// DAY

 	MinExposureDay = 0.80 ;
 	MaxExposureDay = 2.0;
 	fxcolorMixDay = 0.300 ;

	
 	AdaptationMinDay = 0.0;
 	AdaptationMaxDay = 0.0f;
 	BrightnessDay = 0.85;
 	IntensityContrastDay = 1.30 ;
	GammaDay = 1.4;
 	SaturationDay = 2.55;
 	ToneMappingOversaturationDay = 300.0;
 	ToneMappingCurveDay = 10;
	
	RedFilterDay = 1.0;
	GreenFilterDay = 1.0;
	BlueFilterDay = 0.990;
	DesatRDay = 0.85;
	DesatGDay = 0.15 ;
	DesatBDay = 0.60;

	fKeyValueD = 1.135;
	ShoulderStrengthD = 0.25;
	LinearStrengthD = 0.4;
	LinearAngleD = 0.075;
	ToeStrengthD = 0.12;
	ToeDenominatorD = 0.5;
	ToeNumeratorD = 0.002;
	LinearWhiteD = 2.2;
	
// DAWN DUSK SUNRISE SUNSETS
 	MinExposureDawn = 1.35;
 	MinExposureSunrise = 1.5;
 	MinExposureSunset = 1.5;
 	MinExposureDusk = 1.35;

// NIGHT
 	MinExposureNight = 0.95 ;
 	MaxExposureNight = 1.0 ;
 	fxcolorMixNight = 0.15;

	
 	AdaptationMinNight = 0.001;
 	AdaptationMaxNight = 0.0f;
 	BrightnessNight = 0.25;
 	IntensityContrastNight = 1.2 ;
	GammaNight = 1.1;
 	SaturationNight = 2.4;
 	ToneMappingOversaturationNight = 150.0;
 	ToneMappingCurveNight = 5.0;
	
	RedFilterNight = 0.990;
	GreenFilterNight = 1.0;
	BlueFilterNight = 1.0;
	DesatRNight = 1.0;
	DesatGNight = 0.0;
	DesatBNight = 0.7; 
	
	fKeyValueN = 1.1;
	ShoulderStrengthN = 0.25;
	LinearStrengthN = 0.15;
	LinearAngleN = 0.07;
	ToeStrengthN = 0.02;
	ToeNumeratorN = 0.002 ;
	ToeDenominatorN = 1.0;
	LinearWhiteN = 1.0 ;
	
}

/////////////////////////////////////////////////////////
//              	NATURAL VISION          		   //
/////////////////////////////////////////////////////////

if (iWeatherMod == 1) {

	WeatherMultiD=1.0f;
	WeatherMultiN=1.0f;
	WeatherAddN=0.0f;
	WeatherAddD=0.0f;
 	satLimit = 1.0;
// DAY

 	MinExposureDay = 0.85 ;
 	MaxExposureDay = 2.0;
 	fxcolorMixDay = 0.250 ;

	
 	AdaptationMinDay = 0.0;
 	AdaptationMaxDay = 0.0f;
 	BrightnessDay = 0.95;
 	IntensityContrastDay = 1.3;
	GammaDay = 1.40;
 	SaturationDay = 2.65;
 	ToneMappingOversaturationDay = 300.0;
 	ToneMappingCurveDay = 20;
	
	RedFilterDay = 1.0;
	GreenFilterDay = 0.998;
	BlueFilterDay = 1.0;
	DesatRDay = 1.0;
	DesatGDay = 0.12 ;
	DesatBDay = 0.60;

	fKeyValueD = 1.05;
	ShoulderStrengthD = 0.25;
	LinearStrengthD = 0.4;
	LinearAngleD = 0.07;
	ToeStrengthD = 0.12;
	ToeDenominatorD = 0.5;
	ToeNumeratorD = 0.002;
	LinearWhiteD = 1.85;
	
// DAWN DUSK SUNRISE SUNSETS
 	MinExposureDawn = 1.1;
 	MinExposureSunrise = 1.25;
 	MinExposureSunset = 1.55;
 	MinExposureDusk = 1.35;

// NIGHT
 	MinExposureNight = 0.95 ;
 	MaxExposureNight = 1.0 ;
 	fxcolorMixNight = 0.15;

	
 	AdaptationMinNight = 0.001;
 	AdaptationMaxNight = 0.0f;
 	BrightnessNight = 0.25;
 	IntensityContrastNight = 1.2 ;
	GammaNight = 1.05;
 	SaturationNight = 2.4;
 	ToneMappingOversaturationNight = 150.0;
 	ToneMappingCurveNight = 10.0;
	
	RedFilterNight = 0.990;
	GreenFilterNight = 1.0;
	BlueFilterNight = 1.0;
	DesatRNight = 1.0;
	DesatGNight = 0.0;
	DesatBNight = 0.7; 
	
	fKeyValueN = 1.02;
	ShoulderStrengthN = 0.25;
	LinearStrengthN = 0.15;
	LinearAngleN = 0.07;
	ToeStrengthN = 0.02;
	ToeNumeratorN = 0.002 ;
	ToeDenominatorN = 1.0;
	LinearWhiteN = 1.0 ;

}

/////////////////////////////////////////////////////////
//              		VISUALV                  	   //
/////////////////////////////////////////////////////////

if (iWeatherMod == 2) {

	WeatherMultiD=0.65f;
	WeatherMultiN=1.0f;
	WeatherAddN=0.0f;
	WeatherAddD=0.75f;
 	satLimit = 1.0;
// DAY

 	MinExposureDay = 0.85 ;
 	MaxExposureDay = 1.0;
 	fxcolorMixDay = 0.275 ;

	
 	AdaptationMinDay = 0.0;
 	AdaptationMaxDay = 0.0f;
 	BrightnessDay = 1.0;
 	IntensityContrastDay = 1.3 ;
	GammaDay = 1.4;
 	SaturationDay = 2.5;
 	ToneMappingOversaturationDay = 300.0;
 	ToneMappingCurveDay = 9;
	
	RedFilterDay = 1.0;
	GreenFilterDay = 1.0;
	BlueFilterDay = 1.0;
	DesatRDay = 1.0;
	DesatGDay = 0.15 ;
	DesatBDay = 0.60;

	fKeyValueD = 1.15;
	ShoulderStrengthD = 0.25;
	LinearStrengthD = 0.4;
	LinearAngleD = 0.07;
	ToeStrengthD = 0.12;
	ToeDenominatorD = 0.5;
	ToeNumeratorD = 0.002;
	LinearWhiteD = 2.2;
	
// DAWN DUSK SUNRISE SUNSETS
 	MinExposureDawn = 1.35;
 	MinExposureSunrise = 1.5;
 	MinExposureSunset = 1.5;
 	MinExposureDusk = 1.35;

// NIGHT
 	MinExposureNight = 0.95 ;
 	MaxExposureNight = 1.0 ;
 	fxcolorMixNight = 0.15;

	
 	AdaptationMinNight = 0.001;
 	AdaptationMaxNight = 0.0f;
 	BrightnessNight = 0.25;
 	IntensityContrastNight = 1.2 ;
	GammaNight = 1.1;
 	SaturationNight = 2.4;
 	ToneMappingOversaturationNight = 150.0;
 	ToneMappingCurveNight = 5.0;
	
	RedFilterNight = 0.995;
	GreenFilterNight = 1.0;
	BlueFilterNight = 1.0;
	DesatRNight = 1.0;
	DesatGNight = 0.0;
	DesatBNight = 0.7; 
	
	fKeyValueN = 1.1;
	ShoulderStrengthN = 0.25;
	LinearStrengthN = 0.15;
	LinearAngleN = 0.07;
	ToeStrengthN = 0.02;
	ToeNumeratorN = 0.002 ;
	ToeDenominatorN = 1.0;
	LinearWhiteN = 1.0 ;

}