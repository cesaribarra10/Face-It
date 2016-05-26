//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Cesar Ibarra on 5/22/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionsFaces: Dictionary<String,FacialExpression> = [
        "angry": FacialExpression(eyes:.Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationvc = segue.destinationViewController
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionsFaces[identifier] {
                    facevc.expression = expression
                    if let sendingButting = sender as? UIButton {
                        facevc.navigationItem.title = sendingButting.currentTitle
                    }
                }
            }
        }
    }
}
