//
//  TableViewCell.swift
//  EPS_HomePage
//
//  Created by Abul Kashem on 10/10/22.
//

import UIKit

class sendInTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mButton.layer.cornerRadius = 8.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
