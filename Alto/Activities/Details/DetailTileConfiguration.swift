//
//  Detail.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 13/03/25.
//

import SwiftUI

struct DetailTileConfiguration<FS: ShapeStyle, BS: ShapeStyle> {
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
    
    let foregroundColor: FS
    let backgroundColor: BS
    let width: Width
}
