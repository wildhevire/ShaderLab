Shader "ShaderLab/Mandlebrot"
{
    Properties
    {
		_Offset("Offset", Vector) = (0,0,2,2)
		_Zoom("Zoom", Float) = 2
		_MaxIter("Max Iteration", Float) = 255
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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

			float4 _Offset;
			float _Zoom;
			float _MaxIter;

			float3 hue2rgb(float hue) {
				hue = frac(hue); //only use fractional part of hue, making it loop
				float r = abs(hue * 6 - 3) - 1; //red
				float g = 2 - abs(hue * 6 - 2); //green
				float b = 2 - abs(hue * 6 - 4); //blue
				float3 rgb = float3(r, g, b); //combine components
				//rgb = saturate(rgb); //clamp between 0 and 1
				return rgb;
			}

			
			float Mandlebrot(float2 uv) {
				//float2 c = (float2(uv.x - _Offset.x, uv.y - _Offset.y)) * _Zoom;

				float2 c = _Offset.xy + (uv-0.5) * _Zoom;
				float2 z;
				float iter;
				for (iter = 0; iter < _MaxIter; ++iter) {
					z = float2(z.x * z.x - z.y * z.y, 2 * z.x * z.y) + c;
					if (length(z >= 2)) break;
				}

				return sqrt(iter / _MaxIter);
			}

			float4 frag(v2f i) : SV_Target
			{
				float n = 1 - (log2(abs(Mandlebrot(i.uv))));
				float3 col = hue2rgb(n);
				
				return float4(col,255);	
				//return float4(hue2rgb(.5), 255);
            }
			
            ENDCG
        }
    }
}
