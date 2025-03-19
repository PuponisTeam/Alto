//
//  Model3DTile.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct Model3DTile: View {
    @Environment(\.altitudeService) private var altitudeService
    @State private var showingFullScreen = false
    @Namespace private var namespace
    
    private var model: ModelView.Model {
        switch altitudeService.absoluteAltitude.metersValue {
        case 0...10: .moai
        case 10...130: .colosseum
        default: .pyramid
        }
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
                Label("As tall as...", systemImage: "building.columns.fill")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
        }
        .fullScreenCover(isPresented: $showingFullScreen) {
            FullScreenModelView(model: model)
                .navigationTransition(.zoom(sourceID: "model", in: namespace))
        }
    }
}

#Preview {
    Model3DTile()
        .environment(\.altitudeService, .init())
}

