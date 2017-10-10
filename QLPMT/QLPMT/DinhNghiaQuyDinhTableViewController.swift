//
//  DinhNghiaQuyDinhTableViewController.swift
//  QLPMT
//
//  Created by gray buster on 9/25/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class DinhNghiaQuyDinhTableViewController: UITableViewController,UISearchBarDelegate,UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            danhSachSearch = danhSachDinhNghia
        } else {
            if let searchText = self.searchController.searchBar.text {
                danhSachSearch = danhSachDinhNghia.filter{ dinhNghia in
                    if (dinhNghia.tenDinhNghia?.lowercased().contains(searchText.lowercased()))! || searchText == String(dinhNghia.maDinhNghia) || searchText == dinhNghia.ghiChu {
                        return true
                    }
                    return false
                }
            }
        }
        self.tableView.reloadData()
    }
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//        tableView.reloadData()
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setValue("Huỷ", forKey: "_cancelButtonText")
        shouldShowSearchResults = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//    }
    
    var danhSachDinhNghia = [DinhNghiaGiaTri]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    private var shouldShowSearchResults = false
    
    private var danhSachSearch = [DinhNghiaGiaTri]()
    
    private let maDinhNghia:[Int32] = [1,2,3,4,5]
    
    private let tenDinhNghia = ["KH","LT","Q","DGK","DGTK"]
    
    private let ghiChu = ["Loại khách hàng","Loại thuốc","Quyền","Đơn giá khám","Đơn giá tái khám"]
    

    var searchController: UISearchController!
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        self.refreshControl?.beginRefreshing()
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
        do {
            let newDanhSachDinhNghiaGiaTri = try QLPMTDatabase.getContext().fetch(request)
            if newDanhSachDinhNghiaGiaTri.count > danhSachDinhNghia.count {
                danhSachDinhNghia = newDanhSachDinhNghiaGiaTri
                self.refreshControl?.endRefreshing()
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Tìm kiếm"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false

        
        
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
//        for i in 0..<maDinhNghia.count {
//            let dinhNghiaGiaTri = NSEntityDescription.insertNewObject(forEntityName: "DinhNghiaGiaTri", into: QLPMTDatabase.getContext()) as! DinhNghiaGiaTri
//            dinhNghiaGiaTri.maDinhNghia = maDinhNghia[i]
//            dinhNghiaGiaTri.tenDinhNghia = tenDinhNghia[i]
//            dinhNghiaGiaTri.ghiChu = ghiChu[i]
//            danhSachDinhNghia.append(dinhNghiaGiaTri)
//            try? QLPMTDatabase.getContext().save()
//        }
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        do {
            let newDanhSachDinhNghiaGiaTri = try QLPMTDatabase.getContext().fetch(request)
            if newDanhSachDinhNghiaGiaTri.count > danhSachDinhNghia.count {
                danhSachDinhNghia = newDanhSachDinhNghiaGiaTri
            }
        }
        catch {
            print("Error: \(error)")
        }
        
        
    }

    @IBAction func themDinhNghiaQuyDinh(_ sender: UIBarButtonItem) {
        if let themDinhNghiaVC = storyboard?.instantiateViewController(withIdentifier: "Them Dinh Nghia") {
            self.navigationController?.pushViewController(themDinhNghiaVC, animated: true)
        }
    }
  
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return danhSachSearch.count
        } else {
            return danhSachDinhNghia.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ThuocTableViewController.Constraint.dinhNghiaGiaTri, for: indexPath)
        if let dinhNghiaGiaTriCell = cell as? DinhNghiaQuyDinhTableViewCell {
            if shouldShowSearchResults {
                dinhNghiaGiaTriCell.dinhNghiaGiaTri = danhSachSearch[indexPath.row]
            } else {
                dinhNghiaGiaTriCell.dinhNghiaGiaTri = danhSachDinhNghia[indexPath.row]
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Nút sửa
        let editAction = UITableViewRowAction(style: .default, title: "Sửa", handler: { (action, indexPath) in
            let suaDinhNghiaVC = self.storyboard?.instantiateViewController(withIdentifier: "Sua Dinh Nghia") as! SuaDinhNghiaViewController
            suaDinhNghiaVC.index = indexPath.row
            suaDinhNghiaVC.danhSachDinhNghia = self.danhSachDinhNghia
            self.navigationController?.pushViewController(suaDinhNghiaVC, animated: true)
        })
        editAction.backgroundColor = UIColor.blue
        
        // Nút xoá
        let deleteAction = UITableViewRowAction(style: .default, title: "Xoá", handler: { (action, indexPath) in
            QLPMTDatabase.getContext().delete(self.danhSachDinhNghia[indexPath.row])
            self.danhSachDinhNghia.remove(at: indexPath.row)
            try? QLPMTDatabase.getContext().save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
