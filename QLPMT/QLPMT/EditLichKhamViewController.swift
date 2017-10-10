//
//  EditLichKhamViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/19/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class EditLichKhamViewController: UIViewController {
    var index:Int = 0;
    var arrLichKham:Array<LichKhamObj> = []
    @IBOutlet weak var txtGhiChu: UITextField!
    @IBOutlet weak var txtTenKH: UITextField!
    @IBOutlet weak var DatePK: UIDatePicker!
    @IBOutlet weak var rdbtnTinhTrang: UISwitch!
    func ChuyenManHinhLichKham(){
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    @IBAction func abtnXoa(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "Cảnh báo!", message: "Bạn có muốn xoá thông tin này không?", preferredStyle: .alert);
         alert.addAction(UIAlertAction(title: "Có", style: .destructive, handler: { (UIAlertAction) -> Void in
            var arr:Array<Any> = []
            let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
            request.returnsObjectsAsFaults = false
            do{
                let result = try QLPMTDatabase.getContext().fetch(request)
                arr.removeAll()
                for i in result{
                    arr.append(i)
                }
            }catch{}
            QLPMTDatabase.getContext().delete(arr[self.index] as! NSManagedObject)
            
            do{
                try QLPMTDatabase.getContext().save()
                
            }catch{
                print("loi khong the luu khi xoa")
            }
            self.arrLichKham.remove(at: self.index)
            self.ChuyenManHinhLichKham()
        }));
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: nil));
        present(alert, animated: true, completion: nil)
        //navigationController?.present(alert, animated: true, completion: nil)
        //present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrLichKham.removeAll()
            for i in result{
                arrLichKham.append(LichKhamObj(object: i))
            }
        }catch{}
        txtGhiChu.text = arrLichKham[index].GhiChu
        txtTenKH.text = arrLichKham[index].TenKH
        DatePK.date = arrLichKham[index].NgayKham
        rdbtnTinhTrang.isOn = arrLichKham[index].TinhTrang
    }

    @IBAction func abtnOk(_ sender: Any) {
        if(txtGhiChu.text != "" || txtTenKH.text != ""){
            let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
            
        do{
            arrLichKham[index].GhiChu = txtGhiChu.text!
            arrLichKham[index].NgayKham = DatePK.date
            arrLichKham[index].TinhTrang = rdbtnTinhTrang.isOn
            arrLichKham[index].TenKH = txtTenKH.text!
            
            let result = try QLPMTDatabase.getContext().fetch(request)
            let Lichkham = result[index]
            Lichkham.setValue(DatePK.date, forKey: "ngayKham")
            Lichkham.setValue(txtTenKH.text, forKey: "tenKhachHang")
            Lichkham.setValue(txtGhiChu.text, forKey: "ghiChu")
            Lichkham.setValue(rdbtnTinhTrang.isOn, forKey: "tinhTrang")
            
            try QLPMTDatabase.getContext().save()
            
        }catch{print("loi khong the luu khi sua")}
        //self.arrLichKham.remove(at: index)
        ChuyenManHinhLichKham()
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Bạn hãy nhập các trường còn trống", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
