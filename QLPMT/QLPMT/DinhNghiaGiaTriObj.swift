//
//  DinhNghiaGiaTriObj.swift
//  QLPMT
//
//  Created by Long Quách Phi on 10/3/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

struct DinhNghiaGiaTriObj{
    var GhiChu:String
    var MaDinhNghia:Int
    var TenDinhNghia:String
    init(ghichu:String,madinhnghia:Int,tendinhnghia:String) {
        GhiChu = ghichu
        MaDinhNghia = madinhnghia
        TenDinhNghia = tendinhnghia
    }
    init(object:NSManagedObject){
        if(object.value(forKey: "ghiChu") != nil){
            GhiChu = object.value(forKey: "ghiChu") as! String
        }
        else{GhiChu=""}
        if(object.value(forKey: "maDinhNghia") != nil){
            MaDinhNghia = object.value(forKey: "maDinhNghia") as! Int
        }
        else{MaDinhNghia=0}
        if(object.value(forKey: "tenDinhNghia") != nil){
            TenDinhNghia = object.value(forKey: "tenDinhNghia") as! String
        }
        else{TenDinhNghia=""}
    }
}
