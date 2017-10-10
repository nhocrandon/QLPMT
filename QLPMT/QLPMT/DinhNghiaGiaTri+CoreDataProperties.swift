//
//  DinhNghiaGiaTri+CoreDataProperties.swift
//  QLPMT
//
//  Created by gray buster on 9/25/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//
//

import Foundation
import CoreData


extension DinhNghiaGiaTri {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DinhNghiaGiaTri> {
        return NSFetchRequest<DinhNghiaGiaTri>(entityName: "DinhNghiaGiaTri")
    }

    @NSManaged public var ghiChu: String?
    @NSManaged public var maDinhNghia: Int32
    @NSManaged public var tenDinhNghia: String?
//    @NSManaged public var giaTriMacDinh: GiaTriMacDinh?

}
