//
//  ThemDinhNghiaViewController.swift
//  QLPMT
//
//  Created by gray buster on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class ThemDinhNghiaViewController: UIViewController {

    @IBOutlet weak var ghiChuTextField: UITextField!
    @IBOutlet weak var tenDinhNghiaTextField: UITextField!
    @IBAction func themDinhNghia(_ sender: UIButton) {
        if ghiChuTextField.text != "" && tenDinhNghiaTextField.text != "" {
            let dinhNghiaQuyDinh: DinhNghiaGiaTri = NSEntityDescription.insertNewObject(forEntityName: "DinhNghiaGiaTri", into: QLPMTDatabase.getContext()) as! DinhNghiaGiaTri
            let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
            do {
                let result = try QLPMTDatabase.getContext().fetch(request)
                QLPMTDatabase.persistentContainer.performBackgroundTask{ [weak self] context in
                    dinhNghiaQuyDinh.maDinhNghia = Int32(result.count + 1)
                    dinhNghiaQuyDinh.tenDinhNghia = self?.tenDinhNghiaTextField?.text
                    dinhNghiaQuyDinh.ghiChu = self?.ghiChuTextField?.text
                    try? context.save()
                } 
                let alert = UIAlertController(title: "Thành công", message: "Bạn đã thêm thành công!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { actions in
                    self.navigationController?.popViewController(animated: true)
                }))
                present(alert, animated: true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        tenDinhNghiaTextField.becomeFirstResponder()
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
