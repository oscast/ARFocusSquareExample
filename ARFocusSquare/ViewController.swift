//
//  ViewController.swift
//  ARFocusSquare
//
//  Created by Oscar Castillo on 3/13/22.
//

import UIKit
import ARKit

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
        
        
    }
    
    func setupSceneView(sceneView: SCNView) {
        sceneView.delegate = self
        sceneView.showsStatistics = false
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true
    }
}

extension ViewController: ARSCNViewDelegate {
    
}


