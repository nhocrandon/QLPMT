//
//  GiaTriMacDinhTableViewCell.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit

class GiaTriMacDinhTableViewCell: UITableViewCell {
    @IBOutlet weak var lblGiaTri: UILabel!
    
    @IBOutlet weak var lblMaGiaTri: UILabel!
    @IBOutlet weak var lblMaDNGT: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
