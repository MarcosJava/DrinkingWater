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
    @IBOutlet weak var averageWaterDrunkLabel: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
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
                                  options: [.transitionFlipFromRight, .showHideTransitionViews], completion: { completed in
                                    
                                    if completed {
                                        self.setupGraphDisplay()
                                    }
                })
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
    
    func setupGraphDisplay() {
        
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        //  1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        
        //  3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunkLabel.text = "\(average)"
        
        // 4 - setup date formatter and calendar
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        // 5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }

}

