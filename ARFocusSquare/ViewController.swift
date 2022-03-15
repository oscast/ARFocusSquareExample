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
    
    var screenCenter: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenCenter = view.center
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let viewCenter = CGPoint(x: size.width / 2, y: size.height / 2)
        screenCenter = viewCenter
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
        guard anchor is ARPlaneAnchor else {return}
        
        if focusSquare == nil {
            let rootNode = sceneView.scene.rootNode
            addFocusSquare(to: rootNode)
        }
    }
    
    func addFocusSquare(to node: SCNNode) {
        // Adds the square the first time a new plane is found
        let square = FocusSquare()
        node.addChildNode(square)
        // we keep the focus square reference to change it's position as we move the device
        focusSquare = square
        focusSquare?.isValid = false
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let square = focusSquare,
              let center = screenCenter,
              let raycastQuery = sceneView.raycastQuery(from: center, allowing: .existingPlaneInfinite, alignment: .horizontal)
        else { return }
        
        let results: [ARRaycastResult] = sceneView.session.raycast(raycastQuery)
        guard let firstResult = results.first else {
            square.isValid = false
            return
        }
        
        let worldTransform = firstResult.worldTransform
        let thirdColumnTransform = worldTransform.columns.3
        square.position = SCNVector3(thirdColumnTransform.x, thirdColumnTransform.y, thirdColumnTransform.z)
        square.isValid = true
    }
}


