//
//  TrangChuCollectionViewController.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/16/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit

fileprivate struct ReuseableCell {
    static let trangChu = "TrangChuCell"
}

class TrangChuCollectionViewController: UICollectionViewController {
    
    private var noiDung = [String]()
    
    private var tuaDe = [String]()
    
    var admin: TaiKhoan?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        noiDung = ["lich kham","thuoc","benh an","benh nhan","hoa don","don thuoc","quy dinh","dinh nghia quy dinh","tai khoan"]
        tuaDe = ["Lịch khám","Thuốc","Bệnh án","Bệnh nhân","Hoá đơn","Đơn thuốc","Quy định","Định nghĩa quy định","Tài khoản"]
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "logout" {
                if let navcon = segue.destination as? UINavigationController {
                    if let dangNhapVC = navcon.visibleViewController as? DangNhapViewController {
                        dangNhapVC.emailTextField.text = nil
                        dangNhapVC.passTextField.text = nil
                    }
                }
            }
        }
    }


    // MARK: UICollectionViewDataSource
    

    @IBAction func dangXuat(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Cảnh báo!", message: "Bạn có muốn đăng xuất hay không?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: { actions in
            return
        }))
        alert.addAction(UIAlertAction(title: "Có", style: .destructive, handler: { actions in
            self.performSegue(withIdentifier: "logout", sender: nil)
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
        }))
        present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noiDung.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseableCell.trangChu, for: indexPath) as! TrangChuCollectionViewCell
        cell.trangChuImageView.image = UIImage(named: noiDung[indexPath.row])
        cell.trangChuLabel.text = tuaDe[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: tuaDe[indexPath.row]) {
            nextViewController.title = tuaDe[indexPath.row]
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
