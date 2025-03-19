//
//  ModelView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 19/03/25.
//

import SceneKit
import SwiftUI

struct ModelView: UIViewRepresentable {
    enum Model: String {
        case moai = "Moai"
        case colosseum = "Colosseum"
        case pyramid = "Pyramid"
        
        var zoomLevel: Float? {
            switch self {
            case .moai:
                5
            case .colosseum:
                3
            case .pyramid:
                5
            }
        }
        
        var url: URL? {
            Bundle.main.url(
                forResource: rawValue,
                withExtension: "scn",
                subdirectory: "SceneKitAssets.scnassets"
            )
        }
    }
    
    let model: Model
    var allowsCameraControl = true
    
    var scene: SCNScene? {
        guard let url = model.url, let scene = try? SCNScene(url: url) else {
            return nil
        }
        
        scene.background.contents = UIColor(white: 1, alpha: 0)
        
        guard let zoomLevel = model.zoomLevel else { return scene }
        scene.rootNode.position.y += zoomLevel
        return scene
    }
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.backgroundColor = .clear
        view.scene = scene
        view.allowsCameraControl = allowsCameraControl
        view.autoenablesDefaultLighting = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
