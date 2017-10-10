//
//  SuaDinhNghiaViewController.swift
//  QLPMT
//
//  Created by gray buster on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class SuaDinhNghiaViewController: UIViewController {
    
    var index = 0
    
    var danhSachDinhNghia = [DinhNghiaGiaTri]()

    @IBOutlet weak var tenDinhNghiaTextField: UITextField!
    @IBOutlet weak var maDinhNghiaLabel: UILabel!
    @IBOutlet weak var ghiChuTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
        do {
            let result = try QLPMTDatabase.getContext().fetch(request)
            if danhSachDinhNghia[index].maDinhNghia == result[index].maDinhNghia {
                maDinhNghiaLabel.text = "\(danhSachDinhNghia[index].maDinhNghia)"
                tenDinhNghiaTextField.text = danhSachDinhNghia[index].tenDinhNghia
                ghiChuTextField.text = danhSachDinhNghia[index].ghiChu
            }
        } catch {
            print("Lỗi!")
        }
        
        
    }

    @IBAction func suaDinhNghia(_ sender: UIButton) {
        if tenDinhNghiaTextField.text != "" && ghiChuTextField.text != "" {
            let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
            do {
                let result = try QLPMTDatabase.getContext().fetch(request)
                danhSachDinhNghia.remove(at: index)
                QLPMTDatabase.getContext().perform {
                    result[self.index].maDinhNghia = Int32((self.maDinhNghiaLabel.text)!)!
                    result[self.index].tenDinhNghia = self.tenDinhNghiaTextField.text
                    result[self.index].ghiChu = self.ghiChuTextField.text
                    
                    try? QLPMTDatabase.getContext().save()
                }
                danhSachDinhNghia.append(result[index])
                let alert = UIAlertController(title: "Thành công!", message: "Bạn đã sửa thành công", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.navigationController?.popViewController(animated: true)
            } catch {
                print(error)
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
