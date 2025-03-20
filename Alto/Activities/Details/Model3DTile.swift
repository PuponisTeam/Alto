//
//  Model3DTile.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct Model3DTile: View {
    let altitudeService: AltitudeService
    @State private var model: ModelView.Model
    @State private var showingFullScreen = false
    @Namespace private var namespace
    
    init(altitudeService: AltitudeService) {
        self.altitudeService = altitudeService
        _model = State(wrappedValue: ModelView.Model(altitude: altitudeService.absoluteAltitude.metersValue))
    }
    
    var body: some View {
        Button {
            showingFullScreen.toggle()
        } label: {
            Tile(.half) {
                ModelView(model: model, allowsCameraControl: false)
                    .matchedTransitionSource(id: "model", in: namespace)
            } background: {
                Color.offBlack
                    .noiseEffect()
            } label: {
                Label("As tall as", systemImage: "building.columns.fill")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
        }
        .fullScreenCover(isPresented: $showingFullScreen) {
            FullScreenModelView(model: model)
                .navigationTransition(.zoom(sourceID: "model", in: namespace))
        }
        .onChange(of: altitudeService.absoluteAltitude.value) {
            model = ModelView.Model(altitude: altitudeService.absoluteAltitude.metersValue)
        }
    }
}

#Preview {
    Model3DTile(altitudeService: AltitudeService())
}

