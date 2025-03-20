//
//  FullScreenModelView.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI

struct FullScreenModelView: View {
    let model: ModelView.Model
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ModelView(model: model, zoomOut: true)
                    .background(Color.offBlack.noiseEffect())
                    .ignoresSafeArea()
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundStyle(.white)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.pressable)
            }
        }
    }
}

#Preview {
    @Previewable @State var showModel3DView: Bool = false
    FullScreenModelView(model: .moai)
}
