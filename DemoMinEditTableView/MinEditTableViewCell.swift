//
//  MinEditTableViewCell.swift
//  DemoMinEditTableView
//
//  Created by Manas Mishra on 26/03/21.
//

import UIKit

class MinEditTableViewCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ num: Int) {
        self.numLabel.text = "\(num)"
    }
    
}
