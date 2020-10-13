//
//  TableViewCell.swift
//  ios-notification-demo
//
//  Created by Mavin on 10/13/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(reminder: Reminder){
        self.titleLabel.text = reminder.title
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY at hh:mm a"
        self.dateLabel.text = formatter.string(from: reminder.date!)
        self.contentLabel.text = reminder.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
