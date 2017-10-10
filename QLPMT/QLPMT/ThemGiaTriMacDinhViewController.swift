//
//  ThemGiaTriMacDinhViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class ThemGiaTriMacDinhViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datashow.count
    }
    

    @IBOutlet weak var txtGiaTri: UITextField!
    @IBOutlet weak var lblMaGiaTri: UILabel!
    @IBOutlet weak var pkviewDNGT: UIPickerView!
    
    var datashow = [DinhNghiaGiaTri]()
    var arrDNQD:Array<DinhNghiaGiaTriObj> = []
    var valueSelected: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            datashow = result
            for i in result{
                arrDNQD.append(DinhNghiaGiaTriObj(object: i))
            }
        }catch{}
        
    
        
        
        
        let request2:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
        request2.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request2)
            lblMaGiaTri.text = String(result.count + 1)
        }catch{}
        txtGiaTri.delegate = self
        pkviewDNGT.dataSource = self
        pkviewDNGT.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtGiaTri {
            textField.resignFirstResponder()
        }
        return true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datashow[row].ghiChu
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueSelected = datashow[row].ghiChu
    }
    
    @IBAction func abtnThem(_ sender: Any) {
        if txtGiaTri.text != "" && lblMaGiaTri.text != "" {
            let giaTriMacDinh : GiaTriMacDinh = NSEntityDescription.insertNewObject(forEntityName: "GiaTriMacDinh", into: QLPMTDatabase.getContext()) as! GiaTriMacDinh
            let request:NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
            var k:Int32 = 0
            
            do {
                let result = try QLPMTDatabase.getContext().fetch(request)
                for i in result{
                    if valueSelected != nil {
                        if (i.ghiChu == valueSelected) {
                            k = i.maDinhNghia
                        }
                    }
                }
                do {
                    giaTriMacDinh.giaTri = self.txtGiaTri.text
                    giaTriMacDinh.maGiaTri = Int32((self.lblMaGiaTri.text!))!
                    giaTriMacDinh.maDinhNghiaGiaTri = k
                    try QLPMTDatabase.getContext().save()
                } catch {
                    print(error)
                }
                self.navigationController?.popViewController(animated: true)
            } catch {}
        } else {
            let alert = UIAlertController(title: "Cảnh báo!", message: "Bạn phải điền vào tất cả những trường trên?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                return
            }))
            present(alert, animated: true, completion: nil)
        }
    }

}
