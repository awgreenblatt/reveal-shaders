/*
 * Copyright (c) 2012 Adobe Systems Incorporated. All rights reserved.
 * Copyright (c) 2012 Branislav Ulicny
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

precision mediump float;

attribute vec4 a_position;
attribute vec2 a_texCoord;

uniform mat4 u_projectionMatrix;

// This uniform values are passed in using CSS.
uniform float coneApex;
uniform float coneAngle;
uniform float pageRotation;
uniform vec3 pointLightPosition;

varying vec2 v_texCoord;

const float PI = 3.14159;
const float degToRad = PI / 180.0;

varying float pointLightIntensity;

// This page curl algorithm is from the publication "Deforming Pages of 3D Electronic Books"
// by Lichan Hong, Stuart K. Card, and Jindong (JD) Chen.
// Implemented with help from Chris Luke's article, "The anatomy of a page curl"

vec3 transform(vec3 pt)
{
    pt.x += 0.5;
    pt.y = 0.5 - pt.y;
    pt.z += 0.5;
    
    float coneAngleRad = coneAngle * degToRad;
    float pageRotationRad = pageRotation * degToRad;

    float cosConeAngle = cos(coneAngleRad);
    float sinConeAngle = sin(coneAngleRad);

    float cosPageRotation = cos(pageRotationRad);
    float sinPageRotation = sin(pageRotationRad);

    // Radius of the circle circumscribed by vertex (vi.x, vi.y) around coneApex on the x-y plane
    float r = sqrt((pt.x * pt.x) + pow((pt.y - coneApex), 2.0));

    // Now get the radius of the cone cross section intersected by our vertex in 3D space.
    float coneRad = r * sinConeAngle;

    // Angle subtended by arc |ST| on the cone cross section.
    float beta  = asin(pt.x / r) / sinConeAngle;

    vec3 vec = vec3(
        coneRad * sin(beta), 
        r + coneApex - coneRad * (1.0 - cos(beta)) * sinConeAngle,
        coneRad * (1.0 - cos(beta)) * cosConeAngle);

    // Apply a basic rotation transform around the y axis to rotate the curled page.
    // These two steps could be combined through simple substitution, but are left
    // separate to keep the math simple for debugging and illustrative purposes.
    vec3 newpos = vec3(
        (vec.x * cosPageRotation) - (vec.z * sinPageRotation),
        vec.y,
        (vec.x * sinPageRotation) + vec.z * cosPageRotation);

    newpos.x -= 0.5;
    newpos.y = 0.5 - newpos.y;

    return newpos;
}

void main()
{
    v_texCoord = a_texCoord;
    
    vec3 newpos = transform(a_position.xyz);

    vec3 newpos2 = transform(a_position.xyz + vec3(0.1, 0.0, 0.0));
    vec3 newpos3 = transform(a_position.xyz + vec3(0.0, 0.1, 0.0));

    vec3 v1 = newpos2 - newpos;
    vec3 v2 = newpos3 - newpos;
    vec3 normal = normalize(cross(v1, v2));

    vec3 lightVector = normalize(pointLightPosition - a_position.xyz);
    lightVector = pointLightPosition;
  
    pointLightIntensity = dot(normal, lightVector);

    gl_Position = u_projectionMatrix * vec4(newpos, 1.0);
}
