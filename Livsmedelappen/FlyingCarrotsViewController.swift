//
//  FlyingCarrotsViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-03-01.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class FlyingCarrotsViewController: UIViewController {
 
    @IBOutlet weak var smallCarrot: UILabel!
    @IBOutlet weak var smallCarrot2: UILabel!
    @IBOutlet weak var smallCarrot3: UILabel!
    @IBOutlet weak var smallCarrot4: UILabel!
    @IBOutlet weak var smallCarrot5: UILabel!
    @IBOutlet weak var smallCarrot6: UILabel!
    @IBOutlet weak var smallCarrot7: UILabel!
    @IBOutlet weak var bigCarrot: UILabel!
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [smallCarrot, smallCarrot2, smallCarrot3, smallCarrot4, smallCarrot5, smallCarrot6, smallCarrot7, bigCarrot])

        collision = UICollisionBehavior(items: [smallCarrot, smallCarrot2, smallCarrot3, smallCarrot4, smallCarrot5, smallCarrot6, smallCarrot7, bigCarrot])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
    }
    
    @IBAction func snapCarrot(_ sender: UITapGestureRecognizer) {
        let tapPosition = sender.location(in: view)
        dynamicAnimator.removeBehavior(gravity)
        dynamicAnimator.removeBehavior(collision)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.bigCarrot.center = tapPosition
            self.smallCarrot.center = tapPosition
            self.smallCarrot2.center = tapPosition
            self.smallCarrot3.center = tapPosition
            self.smallCarrot4.center = tapPosition
            self.smallCarrot5.center = tapPosition
            self.smallCarrot6.center = tapPosition
        }) { finished in
            NSLog("carrat animations done. DONE = \(finished)")
            UIView.animate(withDuration: 1.0, animations: {
                self.bigCarrot.center = self.view.center
                self.smallCarrot7.center = tapPosition
            })
        }
    }
    
}
