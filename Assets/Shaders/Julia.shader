Shader "ShaderLab/Julia"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (.5,.5,.5,1)
		_Offset("Offset", Vector) = (0,0,2,2)
		_Zoom("Zoom", Float) = 3
		_MaxIter("Max Iteration", Float) = 255
		_Iter("Zoom", Float) = 0
	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;
					return o;
				}

				sampler2D _MainTex;
				float4 _Offset;
				fixed4 _Color;
				float _Zoom;
				float _MaxIter;
				float _Iter;

				float3 hue2rgb(float hue) {
					hue = frac(hue);
					float r = abs(hue * 6 - 3) - 1;
					float g = 2 - abs(hue * 6 - 2);
					float b = 2 - abs(hue * 6 - 4);
					float3 rgb = float3(r, g, b);
					return rgb;
				}

				
				float Julia(float2 uv) {
					/*
						for other pattern u can fine in https://en.wikipedia.org/wiki/Julia_set
						assign the real component to c.x and the imaginary component to c.y
					*/
				
						//float2 c = float2(cos(_Time.y), sin(_Time.y)) * 0.7885; //animated one
					float2 c = float2(-.8, 0.156);
					float2 z = _Offset.xy + float2(uv.x - .5, uv.y - .5) * _Zoom;
					float iter;
					for (iter = 0; iter < _MaxIter; ++iter) {
						z = float2(z.x * z.x - z.y  * z.y, 2 * z.x * z.y) + c;
						if (length(z >= 2)) break;
					}
					
					return sqrt(iter / _MaxIter);
				}

				float4 frag(v2f i) : SV_Target
				{
					float julia = Julia(i.uv);
					float3 col = hue2rgb(julia);;
					return float4(col,255);
				}

				ENDCG
			}
		}
}
