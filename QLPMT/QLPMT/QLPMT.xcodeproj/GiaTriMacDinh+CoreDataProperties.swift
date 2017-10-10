//
//  GiaTriMacDinh+CoreDataProperties.swift
//  QLPMT
//
//  Created by gray buster on 10/4/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//
//

import Foundation
import CoreData


extension GiaTriMacDinh {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GiaTriMacDinh> {
        return NSFetchRequest<GiaTriMacDinh>(entityName: "GiaTriMacDinh")
    }

    @NSManaged public var giaTri: String?
    @NSManaged public var maDinhNghiaGiaTri: Int32
    @NSManaged public var maGiaTri: Int32
    @NSManaged public var dinhNghiaGiaTri: NSSet?
    @NSManaged public var lichKham: LichKham?
    @NSManaged public var loaiThuoc: Thuoc?

}

// MARK: Generated accessors for dinhNghiaGiaTri
extension GiaTriMacDinh {

    @objc(addDinhNghiaGiaTriObject:)
    @NSManaged public func addToDinhNghiaGiaTri(_ value: DinhNghiaGiaTri)

    @objc(removeDinhNghiaGiaTriObject:)
    @NSManaged public func removeFromDinhNghiaGiaTri(_ value: DinhNghiaGiaTri)

    @objc(addDinhNghiaGiaTri:)
    @NSManaged public func addToDinhNghiaGiaTri(_ values: NSSet)

    @objc(removeDinhNghiaGiaTri:)
    @NSManaged public func removeFromDinhNghiaGiaTri(_ values: NSSet)

}
