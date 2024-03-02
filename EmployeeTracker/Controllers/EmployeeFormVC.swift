//
//  PostViewController.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 15/02/24.
//

import UIKit

class EmployeeFormVC: UIViewController {
    
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var empEmailTextField: UITextField!
    @IBOutlet weak var empDesignationTextField: UITextField!
    @IBOutlet weak var empAddressTextfield: UITextField!
    @IBOutlet weak var submit: UIButton!
    let postData = NetworkManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postEmployeeInfo(_ sender: Any) {
        let employeeData = ["empName": empNameTextField.text!, "empEmail": empEmailTextField.text!, "empDesignation": empDesignationTextField.text!, "empAddress":empAddressTextfield.text!]
        postData.postData(urlString: HTTP, employeeData: employeeData)
        navigationController?.popViewController(animated: true)
        
    }
    
}
