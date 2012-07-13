/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
import QtQuick 1.1
import Qt.labs.shaders 1.0

ShaderEffectItem {
    id: root

    property alias sourceItem: source.sourceItem

    property variant source: ShaderEffectSource {
        id: source
        hideSource: true
    }

    property real w: root.width

    fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform lowp sampler2D source;
        uniform lowp float qt_Opacity;
        uniform highp float w;
        void main(void)
        {
            highp float d = w - qt_TexCoord0.x * w;
            lowp float a = min(16.0, d) / 16.0;
            gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity * a;
        }
        "
}
