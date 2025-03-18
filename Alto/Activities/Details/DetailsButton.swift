//
//  DetailsButton.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

struct DetailsButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label("show.details.button.label", systemImage: "mountain.2.fill")
            .font(.headline)
        }
        .buttonBorderShape(.roundedRectangle(radius: 16))
        .buttonStyle(.pressable)
    }
}

#Preview {
    @Previewable @State var isCompact = false
    
    ZStack {
        Color(.customOrange).ignoresSafeArea()
        DetailsButton { }
    }
}
