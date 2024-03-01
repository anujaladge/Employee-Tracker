//
//  DeleteEmployeeDataVC.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 19/02/24.
//

import UIKit

class DeleteEmployeeDataVC: UIViewController {
    
    @IBOutlet weak var empID: UITextField!
    
    @IBOutlet weak var empName: UILabel!
    
    var employeeDetail:Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empID.text = employeeDetail?.id
        empID.isUserInteractionEnabled = false
        empName.text = employeeDetail?.empName
    }
    
    @IBAction func deleteData(_ sender: UIButton) {
    }
    

}
