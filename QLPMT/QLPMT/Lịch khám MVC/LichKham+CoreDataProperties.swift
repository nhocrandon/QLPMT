//
//  LichKham+CoreDataProperties.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/20/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import Foundation
import CoreData


extension LichKham {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LichKham> {
        return NSFetchRequest<LichKham>(entityName: "LichKham")
    }

    @NSManaged public var ghiChu: String?
    @NSManaged public var maLichKham: Int32
    @NSManaged public var ngayKham: NSDate?
    @NSManaged public var tenKhachHang: String?
    @NSManaged public var tinhTrang: Bool
//    @NSManaged public var lichKhamHoaDon: HoaDon?
//    @NSManaged public var phiKhamBenh: GiaTriMacDinh?

}
