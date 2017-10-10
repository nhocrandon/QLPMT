//
//  LichKhamTableViewCell.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/18/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit

class LichKhamTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTenKH: UILabel!
    @IBOutlet weak var lblNgayKham: UILabel!
    @IBOutlet weak var lblTinhTrang: UILabel!
    @IBOutlet weak var txtviewGhiChu: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
