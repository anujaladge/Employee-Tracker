//
//  TextFieldSetUp.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 16/02/24.
//

import UIKit

class TextFieldSetUp{
    
    static func setTextFieldSetUp(textField:UITextField,view:UIView){
        
        // Set up the bottom border
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.size.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor(red: 46/255, green: 96/255, blue: 178/255, alpha: 1.0).cgColor// Set your desired bottom border color
        textField.layer.addSublayer(bottomBorder)
        
        // Set up other properties or constraints as needed
        textField.frame = CGRect(x: 50, y: 200, width: 200, height: 40)
        view.addSubview(textField)
        
    }
}
