//JONAHPN  lens shader

#include "ENBFeeder.fxh"

Texture2D TextureColor;
Texture2D TextureDepth;
float4 ScreenSize;
float ENightDayFactor;

SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerComparisonState Sampler5
{
	Filter = COMPARISON_MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
	ComparisonFunc = GREATER;
};

struct VS_INPUT_POST
{
	float3 pos	: POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POSTM
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	nointerpolation float mult : TEXCOORD1;
};
struct VS_OUTPUT_POST
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};
struct VS_OUTPUT_POSTQ
{
	float4 pos	: SV_POSITION;
	float4 txcoord0	: TEXCOORD0;
	float4 txcoord1	: TEXCOORD1;
};
struct VS_OUTPUT_POSTQ8
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	float4 txcoord1	: TEXCOORD1;
	float4 txcoord2	: TEXCOORD2;
};

//TRAINEE DE LUMIERE
float ii < string UIName = "Traînée de lumière:: Intensité"; float UIMin = 10.0; float UIMax = 500.0; float UIStep = 0.5; > = { 161.0 };
float th < string UIName = "Traînée de lumière:: Seuil"; float UIMin = 50.0; float UIMax = 900.0; float UIStep = 0.5; > = { 379.0 };//279ReflectionFresnel
float eld < string UIName = "Traînée de lumière:: Lumières d'urgence de jour"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.22 };
float eln < string UIName = "Traînée de lumière:: Lumières d'urgence de nuit"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.014 };
VS_OUTPUT_POSTM VS_Threshold(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTM OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(0.25, 0.25, 1) + float3(-0.75, 0.75, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	float dn = lerp(eln, eld, smoothstep(5.1, 6.8, GameTime));
	OUT.mult = lerp(dn, eln, smoothstep(19.8, 21.1, GameTime));
	return OUT;
}
VS_OUTPUT_POSTQ VS_LightStreak6(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTQ OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(0.5, 0.5, 1) + float3(-0.5, 0.5, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy * 0.25;
	float2 rcpFrame = float2(ScreenSize.y, ScreenSize.y * ScreenSize.z);
	float4 rot = WorldViewProj1.x * 4.0 + float4(-0.33, 0.7171976, 1.7643951, 0);
	sincos(rot.x, rot.x, rot.w);
	OUT.txcoord0.zw = rot.wx * rcpFrame;
	sincos(rot.y, rot.y, rot.w);
	OUT.txcoord1.xy = rot.wy * rcpFrame;
	sincos(rot.z, rot.z, rot.w);
	OUT.txcoord1.zw = rot.wz * rcpFrame;
	return OUT;
}
VS_OUTPUT_POSTQ8 VS_LightStreak8(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTQ8 OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(0.5, 0.5, 1) + float3(-0.5, 0.5, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy * 0.25;
	float2 rcpFrame = float2(ScreenSize.y, ScreenSize.y * ScreenSize.z);
	float4 rot = WorldViewProj1.x * 4.0 + float4(-0.33, 0.4553982, 1.2407963, 2.0261945);
	float2 rot2;
	sincos(rot.x, rot2.x, rot2.y);
	OUT.txcoord1.xy = rot2.yx * rcpFrame;
	sincos(rot.y, rot2.x, rot2.y);
	OUT.txcoord1.zw = rot2.yx * rcpFrame;
	sincos(rot.z, rot2.x, rot2.y);
	OUT.txcoord2.xy = rot2.yx * rcpFrame;
	sincos(rot.w, rot2.x, rot2.y);
	OUT.txcoord2.zw = rot2.yx * rcpFrame;
	return OUT;
}
VS_OUTPUT_POSTQ8 VS_LightStreakFH5(VS_INPUT_POST IN)
{
	VS_OUTPUT_POSTQ8 OUT;
	OUT.pos.xyz = IN.pos.xyz * float3(0.5, 0.5, 1) + float3(-0.5, 0.5, 0);
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy * 0.25;
	float2 rcpFrame = float2(ScreenSize.y, ScreenSize.y * ScreenSize.z);
	float4 rot = float4(0.0, 0.36, 1.57079633, 1.57079633 + 0.36);
	float2 rot2;
	sincos(rot.x, rot2.x, rot2.y);
	OUT.txcoord1.xy = rot2.yx * rcpFrame;
	sincos(rot.y, rot2.x, rot2.y);
	OUT.txcoord1.zw = rot2.yx * rcpFrame;
	sincos(rot.z, rot2.x, rot2.y);
	OUT.txcoord2.xy = rot2.yx * rcpFrame;
	sincos(rot.w, rot2.x, rot2.y);
	OUT.txcoord2.zw = rot2.yx * rcpFrame;
	return OUT;
}
VS_OUTPUT_POST VS_Blur(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy * 0.5;
	return OUT;
}
VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}

float4 PS_0() : SV_Target{ return 0; }

float4 PS_Threshold(VS_OUTPUT_POSTM IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(2,2)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(2,-2)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(-2,2)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(-2,-2)).xyz;
	res *= 0.25 * TextureDepth.SampleCmpLevelZero(Sampler5, IN.txcoord0.xy, 0.9975).x;
	//default threshold
	//res = pow(res, 4.0) * 6e-7;
	//to do: adaptation
	//skratzer threshold
	float maxlens = dot(res, 0.33333);
	float tempnor = rcp(th) * maxlens;
	maxlens = max(0.01, maxlens);
	res /= maxlens;
	maxlens = th + th;
	maxlens = pow(tempnor, maxlens);
	maxlens = min(maxlens, ii);
	tempnor = ii * maxlens;
	maxlens += th;
	maxlens = tempnor / maxlens;
	res *= maxlens;
	res = lerp(dot(res, 0.33333), res, 0.708);
	if (res.y * 1.6 < res.x || res.y * 1.4 < res.z)res *= IN.mult;
	//if (ENightDayFactor < 0.98)res = min(res, 0.98);
	return float4(res,1);
}

float4 PS_LightStreak6(VS_OUTPUT_POSTQ IN) : SV_Target
{
	float3 res = 0;
	[unroll] for (float i = 0.0; i < 1.01; i += 0.05)
	{
		float mult = exp2(-abs(i * 14.0 - 7.0));
		float bld = i * 26.0 - 13.0;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord0.zw * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.zw * bld, 0).xyz * mult;
	}
	return float4(res,1);
}
float4 PS_LightStreak8(VS_OUTPUT_POSTQ8 IN) : SV_Target
{
	float3 res = 0;
	[unroll] for (float i = 0.0; i < 1.01; i += 0.05)
	{
		float mult = exp2(-abs(i * 14.0 - 7.0));
		float bld = i * 26.0 - 13.0;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.zw * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord2.xy * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord2.zw * bld, 0).xyz * mult;
	}
	return float4(res,1);
}
float4 PS_LightStreakFH5(VS_OUTPUT_POSTQ8 IN) : SV_Target
{
	float3 res = 0;
	[unroll] for (float i = 0.0; i < 1.01; i += 0.05)
	{
		float mult = exp2(-abs(i * 14.0 - 7.0));
		float bld = i * 26.0 - 13.0;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.xy * bld, 0).xyz * 2.0 * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord1.zw * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord2.xy * bld, 0).xyz * mult;
		res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy + IN.txcoord2.zw * bld, 0).xyz * mult;
	}
	return float4(res,1);
}

float4 PS_Blur(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(1,0)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(0,1)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(-1,0)).xyz;
	res += TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(0,-1)).xyz;
	res *= 0.2;
	return float4(res,1);
}

float4 PS_CA(VS_OUTPUT_POST IN) : SV_Target
{
	float3 res;
	res.x = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(-1,-1)).x;
	res.y = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0).y;
	res.z = TextureColor.SampleLevel(Sampler1, IN.txcoord0.xy, 0, int2(1,1)).z;
	return float4(res,1);
}

technique11 Quant < string UIName = "JONAHPN:: LENS V2"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Threshold()));
		SetPixelShader(CompileShader(ps_5_0, PS_Threshold()));
	}
}
technique11 Quant1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_LightStreak6()));
		SetPixelShader(CompileShader(ps_5_0, PS_LightStreak6()));
	}
}
technique11 Quant2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Blur()));
		SetPixelShader(CompileShader(ps_5_0, PS_Blur()));
	}
}
technique11 Quant3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_CA()));
	}
}

technique11 Quanto < string UIName = "JONAHPN:: LENS V3 PLUS FORT "; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Threshold()));
		SetPixelShader(CompileShader(ps_5_0, PS_Threshold()));
	}
}
technique11 Quanto1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_LightStreak8()));
		SetPixelShader(CompileShader(ps_5_0, PS_LightStreak8()));
	}
}
technique11 Quanto2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Blur()));
		SetPixelShader(CompileShader(ps_5_0, PS_Blur()));
	}
}
technique11 Quanto3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_CA()));
	}
}

technique11 Quantfh < string UIName = "JONAHPN:: LENS PLUS DOUX"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Threshold()));
		SetPixelShader(CompileShader(ps_5_0, PS_Threshold()));
	}
}
technique11 Quantfh1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0, PS_0()));
	}
	pass p1
	{
		SetVertexShader(CompileShader(vs_5_0, VS_LightStreakFH5()));
		SetPixelShader(CompileShader(ps_5_0, PS_LightStreakFH5()));
	}
}

technique11 Quantfh2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Blur()));
		SetPixelShader(CompileShader(ps_5_0, PS_Blur()));
	}
}
