//
//  ViewController.swift
//  FaceIt
//
//  Created by Cesar Ibarra on 5/19/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    //Model
    var expression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk) {
        didSet {
            updateUI()
        }
    }
 
    //View
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseSadness))
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
        }
    }
    
    
    @IBAction func toggleEyes(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func increaseSadness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyebrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Smile: 1.0, .Smirk: -0.5, .Frown: -1.0, .Grin: 0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -1, .Normal: 0.0]
}

