//
//  DetailsView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

// Pressione, Modello 3D, Ossigeno, UV.

extension DetailsView {
    var details: [DetailItem] {
        [
            .init(title: "Pressure", measurement: Measurement(value: 3, unit: UnitPressure.hectopascals), foregroundColor: .blue, backgroundColor: .yellow),
        ]
    }
}

struct DetailsView: View {
    static let spacing = 10.0
    
    var body: some View {
        Text("Ciao")
    }
}

#Preview {
    DetailsView()
}
