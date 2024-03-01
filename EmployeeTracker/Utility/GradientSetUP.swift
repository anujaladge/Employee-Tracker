//
//  GradientColor.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 15/02/24.
//

import UIKit
import QuartzCore

class GradientSetUP{
    
    static func applyGradient(view:UIView){
        
        // Create a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        
        // Define the colors for the gradient
        gradientLayer.colors = [UIColor.systemIndigo.cgColor, UIColor.systemBlue.cgColor]
        
        // Define the locations of the gradient colors (optional)
        gradientLayer.locations = [0.0, 1.0]
        
        // Set the start and end points of the gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Set the frame of the gradient layer to match the view's bounds
        gradientLayer.frame = view.bounds
        
        // Add the gradient layer as a sublayer to the view's layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}


