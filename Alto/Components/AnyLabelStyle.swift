//
//  AnyLabelStyle.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

struct AnyLabelStyle: LabelStyle {
    private let _makeBody: (LabelStyleConfiguration) -> AnyView
    
    init<S: LabelStyle>(_ style: S) {
        self._makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }
    
    func makeBody(configuration: LabelStyleConfiguration) -> some View {
        _makeBody(configuration)
    }
}
