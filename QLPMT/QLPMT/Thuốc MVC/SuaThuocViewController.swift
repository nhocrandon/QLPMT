//
//  SuaThuocViewController.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/20/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class SuaThuocViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return danhSachData.count
    }
    private var danhSachData = [String]()
    
    @IBOutlet weak var soLuongTonTextField: UITextField!
    @IBOutlet weak var donViTextField: UITextField!
    @IBOutlet weak var donGiaTextField: UITextField!
    @IBOutlet weak var loaiThuocTextField: UITextField!
    @IBOutlet weak var tenThuocTextField: UITextField!
    @IBOutlet weak var maThuocLabel: UILabel!
    @IBOutlet weak var loaiThuocPicker: UIPickerView!
    var index = 0 {
        didSet {
            print(index)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loaiThuocTextField.text = danhSachData[row]
        loaiThuocPicker.isHidden = true
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return danhSachData[row]
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loaiThuocTextField {
            loaiThuocPicker.isHidden = false
            textField.endEditing(true)
        }
    }
    
    var danhSachThuoc = [Thuoc]() {
        didSet {
            print(self.danhSachThuoc.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thuocRequest: NSFetchRequest<Thuoc> = Thuoc.fetchRequest()
        let giaTriRequest: NSFetchRequest<GiaTriMacDinh> = GiaTriMacDinh.fetchRequest()
        do {
            let thuocResult = try QLPMTDatabase.getContext().fetch(thuocRequest)
            let danhSachGiaTri = try QLPMTDatabase.getContext().fetch(giaTriRequest)
            for giaTri in danhSachGiaTri {
                if giaTri.maDinhNghiaGiaTri == 2 {
                    danhSachData.append(giaTri.giaTri!)
                }
            }
            if danhSachThuoc[index].maThuoc == thuocResult[index].maThuoc {
                maThuocLabel.text = "\(danhSachThuoc[index].maThuoc)"
                donViTextField.text = danhSachThuoc[index].donVi
                donGiaTextField.text = "\(danhSachThuoc[index].donGia ?? 0)"
                tenThuocTextField.text = danhSachThuoc[index].tenThuoc
                soLuongTonTextField.text = "\(danhSachThuoc[index].soLuongTon)"
                for giaTri in danhSachGiaTri {
                    if danhSachThuoc[index].loaiThuoc == giaTri.maGiaTri {
                        loaiThuocTextField.text = giaTri.giaTri
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }

    @IBAction func suaThuoc(_ sender: UIButton) {
        if soLuongTonTextField.text != "" && donGiaTextField.text != "" && donViTextField.text != "" && loaiThuocTextField.text != "" && tenThuocTextField.text != "" {
            let fetchThuoc: NSFetchRequest<Thuoc> = Thuoc.fetchRequest()
            let fetchGiaTri: NSFetchRequest<GiaTriMacDinh> = GiaTriMacDinh.fetchRequest()
            self.danhSachThuoc.removeAll()
            do {
                let fetchResult = try QLPMTDatabase.getContext().fetch(fetchThuoc)
                let danhSachGiaTri = try QLPMTDatabase.getContext().fetch(fetchGiaTri)
                fetchResult[self.index].maThuoc = Int32(self.maThuocLabel.text!)!
                fetchResult[self.index].tenThuoc = self.tenThuocTextField.text
                fetchResult[self.index].donVi = self.donViTextField.text
                fetchResult[self.index].donGia = NSDecimalNumber(string: self.donGiaTextField.text)
                fetchResult[self.index].soLuongTon = Int32(self.soLuongTonTextField.text!)!
                for giaTri in danhSachGiaTri {
                    if self.loaiThuocTextField.text == giaTri.giaTri {
                        fetchResult[self.index].loaiThuoc = giaTri.maGiaTri
                        fetchResult[self.index].giaTriLoaiThuoc?.maGiaTri = giaTri.maGiaTri
                        break
                    }
                }
                
                do {
                    try QLPMTDatabase.getContext().save()
                    self.danhSachThuoc.append(fetchResult[self.index])
                    let alert = UIAlertController(title: "Thành công!", message: "Bạn đã sửa thành công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } catch {
                    print("Lỗi khi sửa!")
                }
                
            } catch {
                print("Lỗi!")
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
