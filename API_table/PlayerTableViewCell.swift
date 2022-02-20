//
//  PlayerTableViewCell.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/20.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerNOLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerRatingLbl: UILabel!
    @IBOutlet weak var playerPosLbl: UILabel!
    @IBOutlet weak var playerCountryLbl: UILabel!
    @IBOutlet weak var playerAgeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
