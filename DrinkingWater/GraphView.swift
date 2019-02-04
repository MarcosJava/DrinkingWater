//
//  GraphView.swift
//  DrinkingWater
//
//  Created by Marcos Felipe Souza on 03/02/19.
//  Copyright © 2019 Marcos. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

    @IBInspectable
    var startColor: UIColor  = .red
    
    @IBInspectable
    var endColor: UIColor = .green
    
    private struct Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        roundedCorner(rect)
        fillupGradienteColor()
        
        //calculate the x point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            //Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        // calculate the y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y // Flip the graph
        }
        
        // draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        // set up the points line
        let graphPath = UIBezierPath()
        
        // go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        // add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()

        
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        //context.saveGState()
        
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y:height))
        clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
        clippingPath.close()
        
        //4 - add the clipping path to the context
        clippingPath.addClip()
        
        //5 - check clipping path - temporary code
        UIColor.green.setFill()
        let rectPath = UIBezierPath(rect: rect)
        rectPath.fill()
        //end temporary code
        
    }
    
    private func roundedCorner(_ rect: CGRect) {
        //Rounded Corners like roundBound .
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
    }
    
    private func fillupGradienteColor() {
        //CG drawing functions need to know the context in which they will draw, so you use the UIKit method UIGraphicsGetCurrentContext() to obtain the current context
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor];
        
        // All contexts have a color space. This could be CMYK or grayscale, but here you’re using the RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // The color stops describe where the colors in the gradient change over. In this example, you only have two colors, red going to green, but you could have an array of three stops, and have red going to blue going to green. The stops are between 0 and 1, where 0.33 is a third of the way through the gradient.
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        //Create the actual gradient, defining the color space, colors and color stops.
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // Finally, you draw the gradient.
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }

}
