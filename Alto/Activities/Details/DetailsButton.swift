//
//  DetailsButton.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

struct DetailsButton: View {
    @Binding var isCompact: Bool
    
    var body: some View {
        Button(action: toggleIsCompact) {
            HStack {
                Image(systemName: isCompact ? "arrow.down.forward.and.arrow.up.backward" : "mountain.2.fill")
                
                if !isCompact {
                    Text("show.details.button.label")
                }
            }
            .font(.headline)
            .labelStyle(isCompact ? AnyLabelStyle(.titleAndIcon) : AnyLabelStyle(.titleAndIcon))
            
        }
        .buttonBorderShape(.roundedRectangle(radius: isCompact ? 60 : 16))
        .buttonStyle(.materialProminent(padding: isCompact ? 8 : 16))
    }
    
    private func toggleIsCompact() {
        withAnimation {
            isCompact.toggle()
        }
    }
}

#Preview {
    @Previewable @State var isCompact = false
    
    ZStack {
        Color(.customOrange).ignoresSafeArea()
        DetailsButton(isCompact: $isCompact)
    }
}
