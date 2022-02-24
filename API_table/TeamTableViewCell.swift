//
//  TeamTableViewCell.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/24.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamNameLbl: UILabel!
    @IBOutlet weak var roundLbl: UILabel!
    @IBOutlet weak var WDLLbl: UILabel!
    @IBOutlet weak var goalDifferenceLbl: UILabel!
    @IBOutlet weak var ptsLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var teamBadgeImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
