//
//  EmployeeDetailVC.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 16/02/24.
//

import UIKit

class EmployeeDetailVC: UIViewController {
    
    @IBOutlet weak var empImage: UIImageView!
    @IBOutlet weak var empName: UITextField!
    @IBOutlet weak var empEmail: UITextField!
    @IBOutlet weak var empDesignation: UITextField!
    @IBOutlet weak var empAddress: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var empDetails :Employee?
    
    var index = 0
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empName.text = empDetails?.empName
        empEmail.text = empDetails?.empEmail
        empDesignation.text = empDetails?.empDesignation
        empAddress.text = empDetails?.empAddress
        id.text = empDetails?.id
        id.isUserInteractionEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loader.isHidden = true
    }
    
    
    @IBAction func update(_ sender: UIButton) {
        loader.isHidden = false
        loader.startAnimating()
        networkManager.putData(urlString: HTTP, id:Int(id.text!)!, data: ["empName":empName.text!,
                                                             "empEmail":empEmail.text!,
                                                             "empDesignation":empDesignation.text!,
                                                             "empAddress":empAddress.text!]) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.loader.stopAnimating()
                    self?.loader.hidesWhenStopped = true
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self?.navigationController?.popViewController(animated: true)
                    }
                    AlertBox.showAlert(title: "Update", message: "Update successfully", viewController: self!, actions: [okAction])
                }
            }
        }
    }
    
    
    @IBAction func deleteFromDatabase(_ sender: UIButton) {
        
        let okeyAction = UIAlertAction(title: "Okey", style: .default) {[weak self] (action) in
            self?.networkManager.deleteData(urlString: HTTP, id:Int((self?.empDetails!.id)!)!)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
            
        }
        AlertBox.showAlert(title: "Delete", message: "Do you want to delete this Employee Data", viewController: self, actions: [okeyAction,cancelAction])
    }
}



