//
//  DinhNghiaQuyDinhTableViewCell.swift
//  QLPMT
//
//  Created by gray buster on 9/25/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit

class DinhNghiaQuyDinhTableViewCell: UITableViewCell {
    @IBOutlet weak var maDinhNghia: UILabel!
    @IBOutlet weak var ghiChu: UITextView!
    @IBOutlet weak var tenDinhNghia: UILabel!
    
    var dinhNghiaGiaTri: DinhNghiaGiaTri? {
        didSet {
            capNhapUI()
        }
    }
    
    private func capNhapUI() {
        if let maDinhNghia = dinhNghiaGiaTri?.maDinhNghia {
            self.maDinhNghia?.text = String(maDinhNghia)
        }
        if let tenDinhNghia = dinhNghiaGiaTri?.tenDinhNghia {
            self.tenDinhNghia?.text = tenDinhNghia
        }
        if let ghiChu = dinhNghiaGiaTri?.ghiChu {
            self.ghiChu?.text = ghiChu
            self.ghiChu.isEditable = false
            self.ghiChu.isSelectable = false
        }
    }
    
}
