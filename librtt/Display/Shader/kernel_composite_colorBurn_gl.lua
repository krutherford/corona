local kernel = {}

kernel.language = "glsl"

kernel.category = "composite"

kernel.name = "colorBurn"

kernel.vertexData =
{
    {
        name = "alpha",
        default = 1,
        min = 0,
        max = 1,
        index = 0, -- v_UserData.x
    },
}

kernel.fragment =
[[
P_COLOR vec4 ColorBurn( in P_COLOR vec4 base, in P_COLOR vec4 blend )
{
    // TODO: Test for ( blend == 0 )???
    P_COLOR vec4 result = 1.0 - ( 1.0 - base ) / blend;
    return result;
}

P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
{
    P_COLOR vec4 base = texture2D( u_FillSampler0, texCoord );
    P_COLOR vec4 blend = texture2D( u_FillSampler1, texCoord );

    P_COLOR vec4 result = ColorBurn( base, blend );

    return mix( base, result, v_UserData.x ) * v_ColorScale;
}
]]

return kernel
