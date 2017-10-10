//
//  SuaGiaTriMacDinhViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class SuaGiaTriMacDinhViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datashow.count
    }
    
    @IBOutlet weak var txtGiaTri: UITextField!
    @IBOutlet weak var lblMaGiaTriMacDinh: UILabel!
    @IBOutlet weak var pkviewDNGT: UIPickerView!
    var datashow:Array<String> = []
    var index = 0
    var valueSelected = "0"
    var arrGTMD:Array<GiaTriMacDinhObj> = []
    var arrDNQD:Array<DinhNghiaGiaTriObj> = []
    @IBAction func abtnSua(_ sender: Any) {
        if(txtGiaTri.text != ""){
            let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
            
            do{
                arrGTMD[index].GiaTri = txtGiaTri.text!
                var k:Int = 0
                for i in arrDNQD{
                    if (i.TenDinhNghia == valueSelected)
                    {
                        k = i.MaDinhNghia
                        break
                    }
                }
                
                arrGTMD[index].MaDinhNghiaGiaTri = k
                
                let result = try QLPMTDatabase.getContext().fetch(request)
                let giaTriMacDinh = result[index]
                giaTriMacDinh.setValue(arrGTMD[index].GiaTri, forKey: "giaTri")
                giaTriMacDinh.setValue(arrGTMD[index].MaDinhNghiaGiaTri, forKey: "maDinhNghiaGiaTri")
                
                try QLPMTDatabase.getContext().save()
                
            }catch{print("loi khong the luu khi sua")}
            //self.arrLichKham.remove(at: index)
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Bạn hãy nhập các trường còn trống", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func abtnXoa(_ sender: Any){
        let alert: UIAlertController = UIAlertController(title: "Cảnh báo!", message: "Bạn có muốn xoá thông tin này không?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Có", style: .destructive, handler: { (UIAlertAction) -> Void in
            var arr:Array<Any> = []
            let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
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
            self.arrGTMD.remove(at: self.index)
            self.navigationController?.popViewController(animated: true)
        }));
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: nil));
        present(alert, animated: true, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datashow[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueSelected = datashow[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        let request2:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
        request2.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request2)
            arrGTMD.removeAll()
            for i in result{
                arrGTMD.append(GiaTriMacDinhObj(object: i))
            }
            
        }catch{}
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
        request.returnsObjectsAsFaults = false
        var row:Int = 0
        var count:Int = 0
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            datashow.removeAll()
            for i in result{
                datashow.append(i.tenDinhNghia!)
                arrDNQD.append(DinhNghiaGiaTriObj(object : i))
                count = count + 1
                if i.maDinhNghia == arrGTMD[index].MaDinhNghiaGiaTri
                {
                        row = count
                }
            }
        }catch{}
        txtGiaTri.text = arrGTMD[index].GiaTri
        lblMaGiaTriMacDinh.text = String(arrGTMD[index].MaGiaTri)
        
        valueSelected = arrDNQD[0].TenDinhNghia
        pkviewDNGT.dataSource = self
        pkviewDNGT.delegate = self

        pkviewDNGT.selectRow(row-1, inComponent: 0, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
