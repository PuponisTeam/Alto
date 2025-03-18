//
//  Model3DView.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct Model3DView: View {
    @Binding var showModel3DView: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    ModelView()
                        .background(Color.offBlack.noiseEffect())
                        .ignoresSafeArea()
                    
                    Text("You're as Alto as a Moai Statue!")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 12)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showModel3DView.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.customOrange)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var showModel3DView: Bool = false
    Model3DView(showModel3DView: $showModel3DView)
}
