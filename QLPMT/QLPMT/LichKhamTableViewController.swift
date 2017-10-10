//
//  LichKhamTableViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class LichKhamTableViewController: UITableViewController {
    @IBAction func abtnNavAdd(_ sender: Any) {
        ChuyenManHinhAdd()
    }
    @objc func longPressDelete(sender: UILongPressGestureRecognizer ,indexPath:Int){
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
                    //print(arr)
                }catch{}
                
                QLPMTDatabase.getContext().delete(arr[indexPath] as! NSManagedObject)
                
                do{
                    try QLPMTDatabase.getContext().save()
                    
                }catch{
                    print("loi khong the luu khi xoa")
                }
                self.arrLichKham.remove(at: indexPath)
                self.tbvLichKham.reloadData()
        }));
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var tbvLichKham: UITableView!
    var arrLichKham:Array<LichKhamObj> = []
    
    @objc func updateTime() {
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrLichKham.removeAll()
            for i in result{
                arrLichKham.append(LichKhamObj(object: i))
            }
            tbvLichKham.reloadData()
        }catch{}
        
        tbvLichKham.delegate = self
        tbvLichKham.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.updateTime),
                             userInfo: nil,
                             repeats: true)
        
        //AddNavigationBar()
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrLichKham.removeAll()
            for i in result{
                arrLichKham.append(LichKhamObj(object: i))
            }
            tbvLichKham.reloadData()
        }catch{}
        
        tbvLichKham.delegate = self
        tbvLichKham.dataSource = self
    }
    
    
    // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LichKhamCell",for:indexPath) as! LichKhamTableViewCell
        let lichkham = arrLichKham[indexPath.row]
        cell.lblTenKH.text = lichkham.TenKH
        cell.txtviewGhiChu.text = lichkham.GhiChu
        cell.lblNgayKham.text = lichkham.NgayKham.toString(dateFormat: "dd/MM/YYYY HH:mm")
        cell.lblTinhTrang.text = lichkham.TinhTrang.description
        let holdToDelete = UILongPressGestureRecognizer(target: self, action: #selector(LichKhamTableViewController.longPressDelete(sender:indexPath:)))

        holdToDelete.minimumPressDuration = 1.5;
        cell.addGestureRecognizer(holdToDelete);
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ChuyenManHinhEdit(Index: indexPath.row)
    }
    /*override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Nút sửa
        /*let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            self.ChuyenManHinhEdit(Index: indexPath.row)
        })
        editAction.backgroundColor = UIColor.blue
        */
        // Nút delete
        /*let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            var arr:Array<Any> = []
            let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "LichKham")
            request.returnsObjectsAsFaults = false
            do{
                let result = try QLPMTDatabase.getContext().fetch(request)
                arr.removeAll()
                for i in result{
                    arr.append(i)
                }
                print(arr)
            }catch{}
            
            QLPMTDatabase.getContext().delete(arr[indexPath.row] as! NSManagedObject)
            
            do{
                try QLPMTDatabase.getContext().save()
                
            }catch{
                print("loi khong the luu khi xoa")
            }
            self.arrLichKham.remove(at: indexPath.row)
            self.tbvLichKham.reloadData()
        })
        deleteAction.backgroundColor = UIColor.red
        */
        //return [editAction, deleteAction]
        //return [editAction]
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLichKham.count
    }
    func ChuyenManHinhEdit(Index:Int){
        if let mh0 = storyboard?.instantiateViewController(withIdentifier: "EditLichKhamVC") as? EditLichKhamViewController {
            mh0.index = Index
            navigationController?.pushViewController(mh0, animated: true)
        }
    }
    func ChuyenManHinhAdd(){
        if let mh0 = storyboard?.instantiateViewController(withIdentifier: "ThemLichKhamVC") as? ThemLichKhamViewController {
            navigationController?.pushViewController(mh0, animated: true)
        }
    }

}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
