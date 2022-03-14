//
//  FocusSquare.swift
//  ARFocusSquare
//
//  Created by Oscar Castillo on 3/13/22.
//

import Foundation
import ARKit

class FocusSquare: SCNNode {
    
    override init() {
        super.init()
        
        let plane = SCNPlane(width: 0.001, height: 0.001)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "square")
        plane.firstMaterial?.isDoubleSided = true
        geometry = plane
        
        // Planes are vertical default so it has to be rotated.
        eulerAngles.x = GLKMathDegreesToRadians(-90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}