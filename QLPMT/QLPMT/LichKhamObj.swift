//
//  LichKhamObj.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/19/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

struct LichKhamObj{
    var TenKH:String
    var GhiChu:String
    var NgayKham:Date
    var MaLichKham:Int
    var TinhTrang:Bool
    init(tenhk:String,ghichu:String,ngaykham:Date,malichkham:Int,tinhtrang:Bool) {
        TenKH = tenhk
        GhiChu = ghichu
        NgayKham = ngaykham
        MaLichKham = malichkham
        TinhTrang = tinhtrang
    }
    init(object:NSManagedObject){
        if(object.value(forKey: "tenKhachHang") != nil){
            TenKH = object.value(forKey: "tenKhachHang") as! String
        }
        else{TenKH=""}
        
        if(object.value(forKey: "ghiChu") != nil){
            GhiChu = object.value(forKey: "ghiChu") as! String
        }
        else{GhiChu=""}
        
        if(object.value(forKey: "ngayKham") != nil){
            NgayKham = object.value(forKey: "ngayKham") as! Date
        }
        else{NgayKham=Date()}
        
        if(object.value(forKey: "maLichKham") != nil){
            MaLichKham = object.value(forKey: "maLichKham") as! Int
        }
        else{MaLichKham=0}
        if(object.value(forKey: "tinhTrang") != nil){
            TinhTrang = object.value(forKey: "tinhTrang") as! Bool        }
        else{TinhTrang = false}
    }
}
