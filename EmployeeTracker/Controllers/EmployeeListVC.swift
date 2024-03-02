//
//  ViewController.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 15/02/24.
//

import UIKit

var HTTP = "https://65855313022766bcb8c85ff2.mockapi.io/employees/Employees"

class EmployeeListVC: UIViewController{
    
    @IBOutlet weak var employeeListTableview:UITableView!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    let networkManager = NetworkManager()
    var employeesInfo = [Employee]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.startAnimating()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font :UIFont.systemFont(ofSize: 21.0)]
        //navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        employeeListTableview.delegate = self
        employeeListTableview.dataSource = self
        employeeListTableview.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        employeeListTableview.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkManager.getData(urlString: HTTP, model: [Employee].self) { employeeInfo in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.hidesWhenStopped = true
                self.employeesInfo = employeeInfo
                self.employeeListTableview.reloadData()
            }
        }
    }
    
    
    @IBAction func navigateToEmployeeForm(_ sender: Any) {
        let employeeForm = storyboard?.instantiateViewController(withIdentifier: "EmployeeFormVC") as! EmployeeFormVC
        navigationController?.pushViewController(employeeForm, animated: true)
    }
    
    
    @objc func pullToRefresh(sender:UIRefreshControl){
        sender.endRefreshing()
        networkManager.getData(urlString: HTTP, model: [Employee].self) { employeeInfo in
            DispatchQueue.main.async {
                self.employeesInfo = employeeInfo
                self.employeeListTableview.reloadData()
            }
        }
    }

}

extension EmployeeListVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeListTableview.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        cell.empName?.text = employeesInfo[indexPath.row].empName
        cell.empEmail?.text = employeesInfo[indexPath.row].empEmail
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailVC") as! EmployeeDetailVC
        detailVC.empDetails = employeesInfo[indexPath.row]
        detailVC.index = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        editButtonItem.customView?.backgroundColor = UIColor.lightGray
//            if editingStyle == .delete {
//                networkManager.deleteData(urlString: HTTP, id: indexPath.row + 1)
//                employeesInfo.remove(at: indexPath.row)
//                // Delete the row from the table view
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                self.employeeListTableview.reloadData()
//            }
//        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                // Handle delete action here (e.g., remove item from data source)
                self.employeesInfo.remove(at: indexPath.row)
                self.networkManager.deleteData(urlString: HTTP, id: indexPath.row + 1)
                
                self.employeeListTableview.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }

            // Customize the delete button color
        deleteAction.backgroundColor = UIColor(red: 46/255, green: 96/255, blue: 178/255, alpha: 1.0) // Set your desired color

            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
            swipeConfiguration.performsFirstActionWithFullSwipe = false // Optional: Allow partial swipe to trigger action
            return swipeConfiguration
        }
    
    
}

