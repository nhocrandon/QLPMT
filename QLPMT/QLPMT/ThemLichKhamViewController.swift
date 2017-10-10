//
//  ThemLichKhamViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/19/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ThemLichKhamViewController: UIViewController {
    var arrLichKham:Array<LichKhamObj> = []
    @IBOutlet weak var txtGhiChu: UITextField!
    @IBOutlet weak var txtTenKH: UITextField!    
    @IBOutlet weak var DatePK: UIDatePicker!
    @IBOutlet weak var rdbtnTinhTrang: UISwitch!
    //var LichKhamTemp:LichKhamObj? = nil
    func ChuyenManHinhLichKham(){
        dismiss(animated: true, completion: nil)
    }
    //var maxMa:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePK.minimumDate = Date()
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrLichKham.removeAll()
            for i in result{
                arrLichKham.append(LichKhamObj(object: i))
            }
            print(arrLichKham)
        }catch{}
    }
    @IBAction func abtnOk(_ sender: Any) {
        let ma = arrLichKham.count
        if(txtTenKH.text != "" && (txtGhiChu.text?.characters.count)! > 3){
        let newLichKham = NSEntityDescription.insertNewObject(forEntityName: "LichKham", into: QLPMTDatabase.getContext())
        newLichKham.setValue(DatePK.date, forKey: "ngayKham")
        newLichKham.setValue(txtTenKH.text, forKey: "tenKhachHang")
        newLichKham.setValue(txtGhiChu.text, forKey: "ghiChu")
        newLichKham.setValue(ma + 1, forKey: "maLichKham")
        newLichKham.setValue(rdbtnTinhTrang.isOn, forKey: "tinhTrang")
        
        do{
            try QLPMTDatabase.getContext().save()
        }catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
            }
            ChuyenManHinhLichKham()
        }
        else{
            let alert = UIAlertController(title: "Cảnh báo", message: "Bạn hãy kiểm tra lại trường còn trống & ghi chú >3 kí tự", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func abtnCancel(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

