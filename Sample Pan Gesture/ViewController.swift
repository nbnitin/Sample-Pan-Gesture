//
//  ViewController.swift
//  Sample Pan Gesture
//
//  Created by Nitin Bhatia on 31/08/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mySampleView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    private var startPosition: CGPoint!
    private var originalHeight: CGFloat = 0
    private var topSafeArea : CGFloat = 10
    private var bottomSafeArea : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mySampleView.backgroundColor = UIColor.red
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(mySamplePanGestureFunction(_:)))
        mySampleView.addGestureRecognizer(panGesture)
        mySampleView.isUserInteractionEnabled = true
    }
    
    @objc func mySamplePanGestureFunction(_ sender : UIPanGestureRecognizer) {
        if sender.state == .began  {
            startPosition = sender.location(in: self.view)
            originalHeight = heightConstraint.constant
        }
        
        if sender.state == .changed {
            let endPosition = sender.location(in: self.view)
            let difference = endPosition.y - startPosition.y
            var newHeight = originalHeight - difference
            
            if view.bounds.height - newHeight < topSafeArea {
                newHeight = view.bounds.height - topSafeArea
                
            } else if newHeight < headerView.bounds.height + bottomSafeArea {
                newHeight = headerView.bounds.height
            }
            
            heightConstraint.constant = newHeight
        }
        
        if sender.state == .ended || sender.state == .cancelled {
            //Do Something if interested when dragging ended.
        }

    }


}

