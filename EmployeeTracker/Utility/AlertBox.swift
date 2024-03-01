//
//  AlertBox.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 19/02/24.
//

import UIKit

class AlertBox{
    static func showAlert(title: String, message: String, viewController: UIViewController, actions:[UIAlertAction]) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions{
            alertController.addAction(action)
        }

            

            viewController.present(alertController, animated: true, completion: nil)
        }}
