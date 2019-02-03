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
    @IBOutlet weak var counterLabel: UILabel!
    
    var counter: Int = 5 {
        didSet {
            guard counter >= 0 else { counter = 0; return }
            counterView.counter = counter
            counterLabel.text = String(describing: counter)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushButtonPressed(_ button: PushButton) {
        counter = button.isAddButton ? counter + 1 : counter - 1
    }

}

