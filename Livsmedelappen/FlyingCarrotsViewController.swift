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
    @IBOutlet weak var greenBarLabel: UILabel!
    @IBOutlet weak var orangeBarLabel: UILabel!
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let graph = GKBarGraph(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        graph.dataSource = self
        graph.draw()
        view.addSubview(graph)
        
        if (manager.compare.count == 1) {
            greenBarLabel.text? = manager.compare[0].name
        }
        
        if (manager.compare.count == 2) {
            greenBarLabel.text? = manager.compare[0].name
            orangeBarLabel.text? = manager.compare[1].name
        }
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
        
        if manager.compare.count != 2 { return 0}
        
        switch index {
        case 0:
            if let cal = manager.compare[0].calories {
                return NSNumber(floatLiteral: cal * 0.1)
            }
            return NSNumber(floatLiteral: 0.0)
        case 1:
            if let cal = manager.compare[1].calories {
                return NSNumber(floatLiteral: cal * 0.1)
            }
            return NSNumber(floatLiteral: 0.0)
        case 2:
            if let pro = manager.compare[0].protein{
                return NSNumber(floatLiteral: pro * 10)
            }
            return NSNumber(floatLiteral: 0.0)
        case 3:
            if let pro = manager.compare[1].protein {
                return NSNumber(floatLiteral: pro * 10)
            }
            return NSNumber(floatLiteral: 0.0)
        case 4:
            if let soc = manager.compare[0].sugar {
                return NSNumber(floatLiteral: soc * 10)
            }
            return NSNumber(floatLiteral: 0.0)
        case 5:
            if let soc = manager.compare[1].sugar {
                return NSNumber(floatLiteral: soc * 10)
            }
            return NSNumber(floatLiteral: 0.0)
        default:
            return NSNumber(integerLiteral: 0)
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
    default:
        return "\(index)"
    }
    }
}
