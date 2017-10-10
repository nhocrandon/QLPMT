//
//  GiaTriMacDinhTableViewController.swift
//  QLPMT
//
//  Created by Long Quách Phi on 9/26/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit
import CoreData

class GiaTriMacDinhTableViewController: UITableViewController {

    @IBAction func abtnNavAdd(_ sender: Any) {
        let mhsua = storyboard?.instantiateViewController(withIdentifier: "ThemQuyDinh") as! ThemGiaTriMacDinhViewController
        self.navigationController?.pushViewController(mhsua, animated: true)
    }
    @IBOutlet var tbvGiaTriMacDinh: UITableView!
    var arrGTMD:Array<GiaTriMacDinhObj> = []{
        didSet {
            tbvGiaTriMacDinh.reloadData()
        }
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            if result.count > arrGTMD.count {
                arrGTMD.removeAll()
                for i in result{
                    arrGTMD.append(GiaTriMacDinhObj(object: i))
                }
                tbvGiaTriMacDinh.reloadData()
                sender.endRefreshing()
            }
            else {
                sender.endRefreshing()
            }
        }catch{}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //AddNavigationBar()
//        Timer.scheduledTimer(timeInterval: 1,
//                             target: self,
//                             selector: #selector(self.update),
//                             userInfo: nil,
//                             repeats: true)
        let request:NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "GiaTriMacDinh")
        request.returnsObjectsAsFaults = false
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrGTMD.removeAll()
            for i in result{
                arrGTMD.append(GiaTriMacDinhObj(object: i))
            }
            tbvGiaTriMacDinh.reloadData()
        }catch{}
    
        tbvGiaTriMacDinh.delegate = self
        tbvGiaTriMacDinh.dataSource = self
    }
    @objc func update() {
        let request:NSFetchRequest<GiaTriMacDinh> = NSFetchRequest(entityName: "GiaTriMacDinh")
        do{
            let result = try QLPMTDatabase.getContext().fetch(request)
            arrGTMD.removeAll()
            for i in result {
                arrGTMD.append(GiaTriMacDinhObj(object: i))
            }
            tbvGiaTriMacDinh.reloadData()
        }catch{}
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GiaTriMacDinhCell",for:indexPath) as! GiaTriMacDinhTableViewCell
        let request: NSFetchRequest<DinhNghiaGiaTri> = DinhNghiaGiaTri.fetchRequest()
        let GTMD = arrGTMD[indexPath.row]
        cell.lblGiaTri.text = GTMD.GiaTri
        
        cell.lblMaGiaTri.text = String(GTMD.MaGiaTri)
        do {
            let result = try QLPMTDatabase.getContext().fetch(request)
            for i in result {
                if GTMD.MaDinhNghiaGiaTri == i.maDinhNghia {
                    cell.lblMaDNGT.text = i.ghiChu
                }
            }
        }catch{}
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrGTMD.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mh = storyboard?.instantiateViewController(withIdentifier: "SuaQuyDinhVC") as? SuaGiaTriMacDinhViewController {
            mh.index = indexPath.row
            navigationController?.pushViewController(mh, animated: true)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
