//
//  FlyingCarrotsViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-03-01.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit
import GraphKit

class FlyingCarrotsViewController: UIViewController, GKBarGraphDataSource {
 
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
    var graph: GKBarGraph!
    let manager = DataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [smallCarrot, smallCarrot2, smallCarrot3, smallCarrot4, smallCarrot5, smallCarrot6, smallCarrot7, bigCarrot])

        collision = UICollisionBehavior(items: [smallCarrot, smallCarrot2, smallCarrot3, smallCarrot4, smallCarrot5, smallCarrot6, smallCarrot7, bigCarrot])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(gravity)
        //dynamicAnimator.addBehavior(collision)
        
        let graph = GKBarGraph(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        graph.dataSource = self
        graph.draw()
        view.addSubview(graph)
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
            NSLog("carrot animations done. DONE = \(finished)")
            UIView.animate(withDuration: 1.0, animations: {
                self.bigCarrot.center = self.view.center
                self.smallCarrot7.center = tapPosition
            })
        }
    }
    
    public func numberOfBars() -> Int {
        return 6
    }
    
    public func valueForBar(at index: Int) -> NSNumber {
        switch index {
        case 0:
            return NSNumber(integerLiteral: 0)
            // return NSNumber(floatLiteral: manager.compare[0].calories)
        case 1:
            return NSNumber(integerLiteral: 1)
        case 2:
            return NSNumber(integerLiteral: 60)
        case 3:
            return NSNumber(integerLiteral: 90)
        case 4:
            return NSNumber(integerLiteral: 10)
        case 5:
            return NSNumber(integerLiteral: 60)
        case 6:
            return NSNumber(integerLiteral: 90)
        case 7:
            return NSNumber(integerLiteral: 10)
        default:
            return NSNumber(integerLiteral: index * 100)
        }
    }
    
    public func colorForBar(at index: Int) -> UIColor {
        return (index % 2 == 0 ? UIColor.LivsmedelGreen() : UIColor.gk_carrot())
    }
    
    public func animationDurationForBar(at index: Int) -> CFTimeInterval {
        return 1.0
    }
    
    public func titleForBar(at index: Int) -> String {
        switch index {
        case 0:
            return "Cal"
        case 1:
            return ""
        case 2:
            return "Pro"
        case 3:
            return ""
        case 4:
            return "Soc"
        case 5:
            return ""
        case 6:
            return "Kol"
        case 7:
            return ""
        default:
            return "\(index)"
        }
        
    }
}
