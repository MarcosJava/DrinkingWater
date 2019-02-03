//
//  CounterView.swift
//  DrinkingWater
//
//  Created by Marcos Felipe Souza on 31/01/19.
//  Copyright © 2019 Marcos. All rights reserved.
//

import UIKit

extension CGFloat {
    public static func radius(by degree: Double) -> CGFloat {
        return CGFloat(degree * .pi / 180)
    }
}

@IBDesignable class CounterView: UIView {
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable
    var counter: Int = 5 {
        didSet {
            if counter <= Constants.numberOfGlasses && counter >= 0 {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable
    var outlineColor: UIColor = UIColor.blue
    
    @IBInspectable
    var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        // 1. Define the center point of the view where you’ll rotate the arc around.
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 2. Calculate the radius based on the max dimension of the view.
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3. Define the start and end angles for the arc.
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        if startAngle == (135 * .pi / 180 ) && startAngle == .radius(by: 135){
            print("Sim Start")
        }
        if endAngle == ( 45 * .pi / 180) && endAngle == .radius(by: 45) {
            print("Sim End")
        }
        
        self.drawInnerlinePath(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle)
        self.drawOutlinePath(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle)
    }
    
    private func drawOutlinePath(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - Constants.halfOfLineWidth,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - Constants.arcWidth + Constants.halfOfLineWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)

        //4 - close the path
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
    }
    
    private func drawInnerlinePath(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        // 1. Create a path based on the center point, radius, and angles you just defined.
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - Constants.arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 2. Set the line width and color before finally stroking the path.
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
    }
    
}

