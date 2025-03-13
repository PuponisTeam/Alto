//
//  DetailItem.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 13/03/25.
//

import SwiftUI

struct DetailItem {
    enum Width {
        case half
        case full
        
        @MainActor var value: Double {
            switch self {
            case .full: 150
            case .half: 150/2 - DetailsView.spacing
            }
        }
    }
    
    enum Content {
        case measurement(_ data: Measurement<Unit>, color: Color)
        case view(_ view: AnyView)
    }
    
    let title: LocalizedStringKey
    let backgroundColor: Color
    let content: Content
    
    init(title: LocalizedStringKey, backgroundColor: Color, content: Content) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    init<V: View>(title: LocalizedStringKey, @ViewBuilder view: @escaping () -> V, backgroundColor: Color) {
        self.title = title
        content = .view(AnyView(view()))
        self.backgroundColor = backgroundColor
    }
    
    init(title: LocalizedStringKey, measurement: Measurement<Unit>, foregroundColor: Color, backgroundColor: Color) {
        self.title = title
        self.backgroundColor = backgroundColor
        content = .measurement(measurement, color: foregroundColor)
    }
}
