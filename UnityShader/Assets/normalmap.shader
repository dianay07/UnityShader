Shader "Custom/normalmap"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Smoothness("Smoothness", Range(0,1)) = 0.5
        _BumpMap("Normalmap", 2D) = "bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _Metallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            // x와 y에 특정 수를 더해주면 NormalMap의 강도 조절이 가능
            fixed3 n = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Normal = float3(n.x * 2, n.y * 2, n.z);
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
