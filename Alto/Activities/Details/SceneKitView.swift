//
//  SceneKitView.swift
//  Alto
//
//  Created by Michele Coppola on 17/03/25.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable{

    var sceneName:String
    var zoomOut: Float? = nil
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView=SCNView()
        sceneView.scene = loadScene()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.init(white: 1, alpha: 0)
        
        if let zoomOut = zoomOut {
            
            
            if let model = sceneView.scene?.rootNode.childNodes.first{
                model.position.y += zoomOut
            }
        }

        return sceneView
    }

    func updateUIView(_ view: SCNView, context: Context) {

    }

    func loadScene()->SCNScene?{
        return SCNScene(named: sceneName)
    }


}

#Preview {
    SceneKitView(sceneName: "Moai.scn")
}
