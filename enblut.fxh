//----------------------------------------------------------------------------------------------//
//						Technique overload file for Silent Horizons ENB							//
//						  Makes it easier to include custom user LUTs							//
//----------------------------------------------------------------------------------------------//
//								==================================								//
//								//     Silent Horizons ENB      //								//
//								//								//								//
//								//		by JONAH		//								//
//								==================================								//
//----------------------------------------------------------------------------------------------//

//-----------------------//--------------//
#ifndef LUT_INIT_FINISHED// DONT CHANGE! //
//-----------------------//--------------//

//----------------------------------------------------------------------------------------------//
//										    LUT OPTIONS											//
//----------------------------------------------------------------------------------------------//

//Enables support for RevoLUTion LUTs and custom LUTs
#define ENABLE_REVO_SUPPORT		1 //[0-1]
#define ENABLE_RDR2_SUPPORT		1 //[0-1]
#define ENABLE_CUSTOM_LUTS		1 //[0-1]
#define ENABLE_CUSTOM_DNI_LUTS	0 //[0-1]


//----//--------------//
#else // DONT CHANGE! //
//----//--------------//

//----------------------------------------------------------------------------------------------//
//								      CUSTOM LUT TECHNIQUES										//
//----------------------------------------------------------------------------------------------//

//COLORFX_CUSTOM_LUT_TECH    (Unique internal name, "UI name", "LUT file name")
//COLORFX_CUSTOM_DNI_LUT_TECH(Unique internal name, "UI name", "LUT atlas file name")

// -> Use this technique macro to add custom LUTs to Silent Horizons
//    (the LUT texture size will be detected automaticaly)

// -> Copy your LUT file into "/enbseries/Textures/LUTs/Custom"
//    and change the "LUT File Name" here to the one of the LUT file.
//    You can also change the "UI Name" to the name that you want to see ingame.

// -> The DNI technique uses a texture atlas with three separate LUTs
//    for day, night and interiors. Look into the LUT tutorial if you
//    want to know how to make them.

// -> Use only UNCOMPRESSED texture formats like .png!
// -> Don't forget to set ENBALE_CUSTOM_LUTS (and ENABLE_CUSTOM_DNI_LUTS
//    if you want to use them) to 1 above!


COLORFX_CUSTOM_LUT_TECH(Custom1, "unsoundmind", "unsoundmind.png")
COLORFX_CUSTOM_LUT_TECH(Custom2, "Custom LUT - 2", "CustomLUT_2.png")
COLORFX_CUSTOM_LUT_TECH(Custom3, "Custom LUT - 3", "CustomLUT_3.png")
COLORFX_CUSTOM_LUT_TECH(Custom4, "Custom LUT - 4", "CustomLUT_4.png")
COLORFX_CUSTOM_LUT_TECH(Custom5, "Custom LUT - 5", "CustomLUT_5.png")


//----//--------------//
#endif// DONT CHANGE! //
//----//--------------//
