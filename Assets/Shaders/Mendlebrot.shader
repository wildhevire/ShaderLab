Shader "ShaderLab/Mendlebrot"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Offset("Offset", Vector) = (.5,.5,0,0)
		_Zoom("Zoom", Float) = 2
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

            sampler2D _MainTex;
			float4 _Offset;
			float _Zoom;

			fixed4 frag(v2f i) : SV_Target
			{
				float2 c = (float2(i.uv.x -_Offset.x,i.uv.y - _Offset.y)) * _Zoom;
				float2 z;
				float iter;
				for (iter = 0; iter < 255; ++iter) {
					z = float2(z.x * z.x - z.y * z.y, 2*z.x*z.y) + c;
					if (length(z >= 2)) break;
				}

                return iter/255;
            }
            ENDCG
        }
    }
}
