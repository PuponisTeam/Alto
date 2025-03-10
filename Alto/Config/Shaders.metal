//
//  Shaders.metal
//  Test
//
//  Created by Alessio Garzia Marotta Brusco on 09/10/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 noise(float2 position, half4 currentColor) {
    float value = fract(sin(dot(position, float2(12.9898, 78.233))) * 43758.5453);
    return half4(value, value, value, 1) * currentColor.a;
}
