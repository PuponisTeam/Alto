//
//  ModelView.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct ModelView: View {
    @Environment(\.altitudeService) private var altitudeService
    
    var zoomOut: Float?
    
    var model: (String, Float?) {
        switch(altitudeService.absoluteAltitude.value) {
        case 0...10:
            ("Moai.scn", 5)
        case 10...130:
            ("Colosseo.scn", 3)
        default:
            ("Pyramid.scn", 5)
        }
    }
    
    var body: some View {
        SceneKitView(sceneName: model.0, zoomOut: zoomOut == nil ? model.1 : zoomOut)
    }
}

#Preview {
    ModelView()
}
