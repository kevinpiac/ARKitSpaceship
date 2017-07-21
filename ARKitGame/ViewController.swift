//
//  ViewController.swift
//  ARKitGame
//
//  Created by Kevin Piacentini on 20/07/2017.
//  Copyright © 2017 Kevin Piacentini. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var counter:Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        addObject()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)

            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "ARShip" {
                    counter += 1
                    node.removeFromParentNode()
                    addObject()
                }
            }
        }
    }
    
    func addObject() {
        let ship = SpaceShip()
        ship.loadModel()
        
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPos, yPos, -1)
        
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    func randomPosition(lowerBound lower:Float, upperBound upper: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

