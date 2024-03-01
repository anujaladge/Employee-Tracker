//
//  EmployeeCell.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 15/02/24.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var empImage: UIImageView!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
