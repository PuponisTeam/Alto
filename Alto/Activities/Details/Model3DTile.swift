//
//  Model3DTile.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct Model3DTile: View {
    var body: some View {
        Tile(.half) {
            VStack {
                HStack {
                    Text("As tall as...")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
                ModelView(zoomOut: 0)
                    .frame(width: 100, height: 100)
            }
            
        } background: {
            Color.offBlack.noiseEffect()
        } label: {
            
        }
    }
}

#Preview {
    Model3DTile()
}

