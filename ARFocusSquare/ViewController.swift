//
//  ViewController.swift
//  ARFocusSquare
//
//  Created by Oscar Castillo on 3/13/22.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var focusSquare: FocusSquare?
    
    var screenCenter: CGPoint {
        view.center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView(sceneView: self.sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func setupSceneView(sceneView: SCNView) {
        sceneView.delegate = self
        sceneView.showsStatistics = false
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor, self.focusSquare == nil else {return}
        
        // Adds the square the first time a new plane is found
        let square = FocusSquare()
        sceneView.scene.rootNode.addChildNode(square)
        focusSquare = square
    }
}


