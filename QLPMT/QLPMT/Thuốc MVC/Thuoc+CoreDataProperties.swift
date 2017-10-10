//
//  Thuoc+CoreDataProperties.swift
//  QLPMT
//
//  Created by gray buster on 9/27/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//
//

import Foundation
import CoreData


extension Thuoc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thuoc> {
        return NSFetchRequest<Thuoc>(entityName: "Thuoc")
    }

    @NSManaged public var donGia: NSDecimalNumber?
    @NSManaged public var donVi: String?
    @NSManaged public var loaiThuoc: Int32
    @NSManaged public var maThuoc: Int32
    @NSManaged public var soLuongTon: Int32
    @NSManaged public var tenThuoc: String?
//    @NSManaged public var chiTietDonThuoc: ChiTietDonThuoc?
//    @NSManaged public var chiTietHoaDon: ChiTietHoaDon?
    @NSManaged public var giaTriLoaiThuoc: GiaTriMacDinh?
}
