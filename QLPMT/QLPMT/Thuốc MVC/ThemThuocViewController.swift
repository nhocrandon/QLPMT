//
//  ThemThuocViewController.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/19/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class ThemThuocViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {

    
    
    
    @IBOutlet weak var soLuongTonTextField: UITextField!
    @IBOutlet weak var donViTextField: UITextField!
    @IBOutlet weak var donGiaTextField: UITextField!
    @IBOutlet weak var loaiThuocTextField: UITextField!
    @IBOutlet weak var loaiThuocPicker: UIPickerView!
    @IBOutlet weak var tenThuocTextField: UITextField!
    
    
    private var danhSachData = [String]()
    
//    var danhSach = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tenThuocTextField.becomeFirstResponder()
        loaiThuocTextField.delegate = self
        tenThuocTextField.delegate = self
        donViTextField.delegate = self
        donGiaTextField.delegate = self
        soLuongTonTextField.delegate = self
        loaiThuocPicker.delegate = self
        loaiThuocPicker.dataSource = self
        let request:NSFetchRequest<GiaTriMacDinh> = GiaTriMacDinh.fetchRequest()
        do {
            let result = try QLPMTDatabase.getContext().fetch(request)
            for i in result {
                if i.maDinhNghiaGiaTri == 2 {
                    danhSachData.append(i.giaTri!)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return danhSachData[row]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tenThuocTextField {
            donGiaTextField.becomeFirstResponder()
        }
        else if textField == donGiaTextField {
            donViTextField.becomeFirstResponder()
        }
        else if textField == donViTextField {
            soLuongTonTextField.becomeFirstResponder()
        }
        else if textField == soLuongTonTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return danhSachData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loaiThuocTextField.text = danhSachData[row]
        loaiThuocPicker.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loaiThuocTextField {
            loaiThuocPicker.isHidden = false
            textField.endEditing(true)
        }
    }

    @IBAction func themThuoc(_ sender: UIButton) {

        if tenThuocTextField.text != "" && donViTextField.text != "" && donGiaTextField.text != "" && loaiThuocTextField.text != "" && soLuongTonTextField.text != "" {
            let thuoc: Thuoc = NSEntityDescription.insertNewObject(forEntityName: ThuocTableViewController.Constraint.thuoc, into: QLPMTDatabase.getContext()) as! Thuoc
            let request: NSFetchRequest<Thuoc> = Thuoc.fetchRequest()
            let quyDinhRequest:NSFetchRequest<GiaTriMacDinh> = GiaTriMacDinh.fetchRequest()
            do  {
                let searchResults = try QLPMTDatabase.getContext().fetch(request)
                let fetchResults = try QLPMTDatabase.getContext().fetch(quyDinhRequest)
                thuoc.maThuoc = Int32(searchResults.count)
                thuoc.tenThuoc = tenThuocTextField.text

                thuoc.donVi = donViTextField.text
                thuoc.donGia = NSDecimalNumber(string: donGiaTextField.text)
                thuoc.soLuongTon = Int32((soLuongTonTextField?.text)!)!
                for i in 0..<fetchResults.count {
                    if loaiThuocTextField.text == fetchResults[i].giaTri {
                        thuoc.loaiThuoc = fetchResults[i].maGiaTri
                        thuoc.giaTriLoaiThuoc?.maGiaTri = fetchResults[i].maGiaTri
                        break
                    }
                }
                if let thuocTableVC = storyboard?.instantiateViewController(withIdentifier: "Thuốc") as? ThuocTableViewController {
                    thuocTableVC.danhSachThuoc.append(thuoc)
                    thuocTableVC.tableView.reloadData()
                }
                try QLPMTDatabase.getContext().save()
                let alert = UIAlertController(title: "Thành công", message: "Bạn đã thêm thành công!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                    self.navigationController?.popViewController(animated: true)
                }))
                present(alert, animated: true, completion: nil)
                
            } catch {
                print("Error: \(error)")
            }
        } else {
            let alert = UIAlertController(title: "Cảnh báo!", message: "Bạn phải điền vào tất cả những trường trên?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                return
            }))
            present(alert, animated: true, completion: nil)
        }
        
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
