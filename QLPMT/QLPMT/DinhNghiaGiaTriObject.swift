//
//  DinhNghiaGiaTriObject.swift
//  QLPMT
//
//  Created by gray buster on 10/3/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

public class DinhNghiaGiaTriObject {
    var ma: Int32
    var ten: String
    var note: String
    init(object: DinhNghiaGiaTri) {
        self.ma = object.maDinhNghia
        self.ten = object.tenDinhNghia!
        self.note = object.ghiChu!
    }
}
