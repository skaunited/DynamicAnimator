//
//  ViewController.swift
//  DynamicAnimator
//
//  Created by BAHRI Skander (i-BP - PROXIAD) on 21/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let circleSize: CGFloat = 350.0
    let ballSize: CGFloat = 25.0
    
    var animator: UIDynamicAnimator!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBlue

        let boundary = UIView(frame: CGRect(x: (view.frame.size.width - circleSize)/2.0,
                                            y: (view.frame.size.height - circleSize)/2.0,
                                            width: circleSize,
                                            height: circleSize))
        
        boundary.layer.borderColor = UIColor.white.cgColor
        boundary.layer.borderWidth = 2.0
        boundary.setCornerRadius(circleSize/2.0)
        view.addSubview(boundary)
        
        let yellowBall = UIView(frame: CGRect(x: (boundary.frame.size.width - ballSize)/2.0,
                                            y: (boundary.frame.size.height - ballSize)/2.0,
                                            width: ballSize,
                                            height: ballSize))
        yellowBall.backgroundColor = .systemYellow
        yellowBall.setCornerRadius(ballSize/2.0)
        boundary.addSubview(yellowBall)
        
        let greenBall = UIView(frame: CGRect(x: 1.17*(boundary.frame.size.width - ballSize)/2.0,
                                            y: (boundary.frame.size.height - ballSize)/2.0,
                                            width: ballSize,
                                            height: ballSize))
        greenBall.backgroundColor = .systemGreen
        greenBall.setCornerRadius(ballSize/2.0)
        boundary.addSubview(greenBall)
        
        let gravity = UIGravityBehavior(items: [yellowBall, greenBall])
        gravity.magnitude = 2.5
        
        let collision = UICollisionBehavior(items: [yellowBall, greenBall])
        collision.collisionMode = .boundaries
        collision.addBoundary(withIdentifier: "Boundary" as NSCopying,
                              for: UIBezierPath.init(ovalIn: boundary.bounds))
        
        let resistance = UIDynamicItemBehavior(items: [yellowBall, greenBall, boundary])
        resistance.elasticity = 1.09
        
        animator = UIDynamicAnimator(referenceView: boundary )
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(resistance)
    }
}

extension UIView {
    func setCornerRadius(_ amount: CGFloat) {
        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = amount
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

