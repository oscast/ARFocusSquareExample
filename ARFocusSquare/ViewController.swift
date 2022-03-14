//
//  ViewController.swift
//  ARFocusSquare
//
//  Created by Oscar Castillo on 3/13/22.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    var focusSquare: FocusSquare?
    
    var screenCenter: CGPoint {
        view.center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


