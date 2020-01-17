Shader "ShaderLab/MultiJulia"
{
	Properties
	{
		_Offset("Offset", Vector) = (0,0,2,2)
		_Zoom("Zoom", Float) = 3
		_MaxIter("Max Iteration", Float) = 255
		_Factor("Power Factor", Float) = 2
		_Const("C Component", Vector) = (0.01,0.01,0,0)
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

			float4 _Offset;
			float _Zoom;
			float _MaxIter;
			float _Factor;
			float4 _Const;

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

				/*
				zx = (zx * zx + zy * zy) ^ (n / 2) * cos(n * atan2(zy, zx)) + cx;
				zy = (zx * zx + zy * zy) ^ (n / 2) * sin(n * atan2(zy, zx)) + cy;
				*/

				//float2 c = float2(cos(_Time.y), sin(_Time.y)) * 0.7885; //animated one

				//_Factor = sin(_Time.w * .2) * _Factor;
				float2 c = float2(.01,.01);
				//float2 c = uv;
				float2 z = _Offset.xy + float2(uv.x - .5, uv.y - .5) * _Zoom;
				float iter;
				for (iter = 0; iter < _MaxIter; ++iter) {
					z = float2	(pow((z.x * z.x + z.y * z.y), (_Factor / 2)) * cos(_Factor * atan2(z.y,z.x)),
								(pow((z.x * z.x + z.y * z.y), (_Factor / 2)) * sin(_Factor * atan2(z.y, z.x)))) + _Const.xy;

					if (length(z >= 2)) break;
				}

				if (sqrt(iter / (_MaxIter)) == 0) {
					return 33.000001;
				}

				return sqrt(iter / (_MaxIter));
			}

			float4 frag(v2f i) : SV_Target
			{
				float julia = Julia(i.uv);
				float color = julia + 1 - (log2(abs(julia)));
				float3 n = hue2rgb(color);

				return float4(n,255);
			}

			ENDCG
		}
	}
}
