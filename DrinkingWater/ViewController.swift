//
//  ViewController.swift
//  DrinkingWater
//
//  Created by Marcos Felipe Souza on 31/01/19.
//  Copyright © 2019 Marcos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    var counter: Int = 5 {
        didSet {
            guard counter >= 0 else { counter = 0; return }
            counterView.counter = counter
            counterLabel.text = String(describing: counter)
        }
    }
    
    var isGraphViewShowing: Bool = false {
        didSet {
            
            if isGraphViewShowing {
                UIView.transition(from: graphView,
                                  to: counterView,
                                  duration: 1.0,
                                  options: [.transitionFlipFromLeft, .showHideTransitionViews])
                
            } else {
                
                UIView.transition(from: counterView,
                                  to: graphView,
                                  duration: 1.0,
                                  options: [.transitionFlipFromRight, .showHideTransitionViews])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(counterTapView(_ :)))
        containerView.addGestureRecognizer(gestureTap)
    }

    @objc func counterTapView(_ gesture: UITapGestureRecognizer?) {
        isGraphViewShowing = !isGraphViewShowing
        
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        counter = button.isAddButton ? counter + 1 : counter - 1
    }

}

