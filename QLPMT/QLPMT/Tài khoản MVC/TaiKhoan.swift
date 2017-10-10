//
//  DangNhap.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/15/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import Foundation

struct TaiKhoan {
    var email: String
    var name: String
    var password: String
    
    
    mutating func doiPassword(thanh passMoi: String) {
        if !(passMoi.isEmpty) {
            password = passMoi
        }
    }
    mutating func doiTen(thanh tenMoi: String) {
        if !(tenMoi.isEmpty) {
            name = tenMoi
        }
    }
}

