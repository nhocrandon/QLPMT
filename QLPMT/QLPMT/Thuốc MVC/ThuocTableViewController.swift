//
//  ThuocTableViewController.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/18/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData



class ThuocTableViewController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate {
    
    struct Constraint {
        static let thuoc = "Thuoc"
        static let thuocCell = "ThuocCell"
        static let themThuoc = "ThemThuoc"
        static let suaThuoc = "Sua Thuoc"
        static let dinhNghiaGiaTri = "DinhNghiaQuyDinhCell"
    }
    
    var danhSachThuoc = [Thuoc]()
    
    private var danhSachSearch = [Thuoc]()
    
    private var shouldShowSearchResults = false
    
    @IBOutlet weak var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.delegate = self
        
    
        
        let fetchRequest: NSFetchRequest<Thuoc> = Thuoc.fetchRequest()
        do {
            let newDanhSach = try QLPMTDatabase.getContext().fetch(fetchRequest)
            //            for thuoc in newDanhSach {
            //                QLPMTDatabase.getContext().delete(thuoc)
            //            }
            //            try QLPMTDatabase.getContext().save()
            danhSachThuoc = newDanhSach
        }
        catch {
            print("Error: \(error)")
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            danhSachSearch = danhSachThuoc
        } else {
            if let searchText = self.searchController.searchBar.text {
                danhSachSearch = danhSachThuoc.filter{ thuoc in
                    if searchText == String(thuoc.maThuoc) || searchText == thuoc.tenThuoc || searchText == String(describing: thuoc.donGia) || searchText == thuoc.donVi || searchText == String(thuoc.loaiThuoc) || searchText == String(thuoc.soLuongTon) {
                        return true
                    }
                    return false
                }
            }
        }
        tableView.reloadData()
    }
    @IBAction func refresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        let fetchRequest: NSFetchRequest<Thuoc> = Thuoc.fetchRequest()
        do {
            let newDanhSach = try QLPMTDatabase.getContext().fetch(fetchRequest)
            if newDanhSach.count > danhSachThuoc.count {
                danhSachThuoc.append(newDanhSach[newDanhSach.count-1])
                sender.endRefreshing()
            } else {
                sender.endRefreshing()
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setValue("Huỷ", forKey: "_cancelButtonText")
        shouldShowSearchResults = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.shouldShowSearchResults = false
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    @IBAction func unwindToThuocTVC(_ segue: UIStoryboardSegue) {}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return danhSachSearch.count
        }
        return danhSachThuoc.count
    }

    
    @IBAction func themThuoc(_ sender: UIBarButtonItem) {
        if let themThuocVC = storyboard?.instantiateViewController(withIdentifier: Constraint.themThuoc) as? ThemThuocViewController {
            self.navigationController?.pushViewController(themThuocVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constraint.thuocCell, for: indexPath) as! ThuocTableViewCell
        let request:NSFetchRequest<GiaTriMacDinh> = GiaTriMacDinh.fetchRequest()
        let result = try? QLPMTDatabase.getContext().fetch(request)
        if shouldShowSearchResults {
            cell.maThuocLabel.text = "\(danhSachSearch[indexPath.row].maThuoc)"
            cell.tenThuocLabel.text = danhSachSearch[indexPath.row].tenThuoc
            cell.donViLabel.text = "\(danhSachSearch[indexPath.row].donGia!)"
            cell.donGiaLabel.text = danhSachSearch[indexPath.row].donVi
            for i in result! {
                if i.maGiaTri == danhSachSearch[indexPath.row].loaiThuoc {
                    cell.loaiThuocLabel.text = i.giaTri
                    break
                }
            }
            cell.soLuongLabel.text = "\(danhSachSearch[indexPath.row].soLuongTon)"
        } else {
            cell.maThuocLabel.text = "\(danhSachThuoc[indexPath.row].maThuoc)"
            cell.tenThuocLabel.text = danhSachThuoc[indexPath.row].tenThuoc
            cell.donViLabel.text = "\(danhSachThuoc[indexPath.row].donGia!)"
            cell.donGiaLabel.text = danhSachThuoc[indexPath.row].donVi
            cell.soLuongLabel.text = "\(danhSachThuoc[indexPath.row].soLuongTon)"
            for i in result! {
                if i.maGiaTri == danhSachThuoc[indexPath.row].loaiThuoc {
                    cell.loaiThuocLabel.text = i.giaTri
                    break
                }
            }
        }
        
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            thuoc.remove(at: indexPath.row)
//            QLPMTDatabase.getContext().delete(thuoc[indexPath.row])
//            do {
//                try QLPMTDatabase.getContext().save()
//            } catch {
//                print("Không thể xoá")
//            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Nút sửa
        let editAction = UITableViewRowAction(style: .default, title: "Sửa", handler: { (action, indexPath) in
            let suaThuocVC = self.storyboard?.instantiateViewController(withIdentifier: Constraint.suaThuoc) as! SuaThuocViewController
            suaThuocVC.index = indexPath.row
            suaThuocVC.danhSachThuoc = self.danhSachThuoc
            self.navigationController?.pushViewController(suaThuocVC, animated: true)
        })
        editAction.backgroundColor = UIColor.blue
        
        // Nút xoá
        let deleteAction = UITableViewRowAction(style: .default, title: "Xoá", handler: { (action, indexPath) in
            QLPMTDatabase.getContext().delete(self.danhSachThuoc[indexPath.row])
            self.danhSachThuoc.remove(at: indexPath.row)
            do {
                try QLPMTDatabase.getContext().save()
            } catch {
                print("Không thể xoá")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }

    
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        
//    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
