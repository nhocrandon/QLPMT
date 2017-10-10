//
//  GiaTriMacDinhObj.swift
//  QLPMT
//
//  Created by Long Quách Phi on 10/2/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

struct GiaTriMacDinhObj {
        var GiaTri:String
        var MaDinhNghiaGiaTri:Int
        var MaGiaTri:Int
        init(giatri:String,madinhnghiagiatri:Int,magiatri:Int) {
            GiaTri = giatri
            MaDinhNghiaGiaTri = madinhnghiagiatri
            MaGiaTri = magiatri
        }
        init(object:NSManagedObject){
            if(object.value(forKey: "giaTri") != nil){
                GiaTri = object.value(forKey: "giaTri") as! String
            }
            else{GiaTri=""}
            if(object.value(forKey: "maDinhNghiaGiaTri") != nil){
                MaDinhNghiaGiaTri = object.value(forKey: "maDinhNghiaGiaTri") as! Int
            }
            else{MaDinhNghiaGiaTri=0}
            if(object.value(forKey: "maGiaTri") != nil){
                MaGiaTri = object.value(forKey: "maGiaTri") as! Int
            }
            else{MaGiaTri=0}
        }

}
