//
//  DangNhapViewController.swift
//  QLPMT
//
//  Created by Khanh Hoang on 9/16/17.
//  Copyright © 2017 Khanh Hoang. All rights reserved.
//

import UIKit



class DangNhapViewController: UIViewController,UITextFieldDelegate {
    
  
    private struct Constraints {
        static let adminEmail = "admin@gmail.com"
        static let adminName = "Yêu"
        static let adminPass = "123456"
        static let login = "Dang Nhap"
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        spinner.startAnimating()
        return true
    }
    
  
    @IBOutlet weak var emailTextField: DesignableUITextField!
    
    @IBOutlet weak var passTextField: DesignableUITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func dangNhap(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passTextField.text
        
        UserDefaults.standard.set(emailTextField.text, forKey: "email")
        UserDefaults.standard.set(passTextField.text, forKey: "password")
        UserDefaults.standard.synchronize()
        
        let emailStored = UserDefaults.standard.string(forKey: "email")
        let passwordStored = UserDefaults.standard.string(forKey: "password")
        
        //Kiểm tra email 
        if email == emailStored {
            if password == passwordStored {
                performSegue(withIdentifier: Constraints.login, sender: nil)
            }
        } else {
            displayAlertMessage(with: "Đăng nhập không thành công", and: "Hãy nhập lại email hoặc password")
        }
        
    }
    
    
    private let admin = TaiKhoan.init(email: Constraints.adminEmail, name: Constraints.adminName, password: Constraints.adminPass)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passTextField.delegate = self
        emailTextField.becomeFirstResponder()
        spinner.stopAnimating()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        spinner.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        let emailStored = UserDefaults.standard.string(forKey: "email")
        let passwordStored = UserDefaults.standard.string(forKey: "password")
        if emailStored == admin.email && passwordStored == admin.password {
            performSegue(withIdentifier: Constraints.login, sender: dangNhap)
        }
        
    }
    
    @IBAction func unwindToDangNhap(segue: UIStoryboardSegue) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        self.emailTextField.text = nil
        self.passTextField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passTextField.becomeFirstResponder()
        } else if textField == passTextField {
            if emailTextField.text == admin.email && passTextField.text == admin.password {
                performSegue(withIdentifier: Constraints.login, sender: dangNhap)
            } else {
                displayAlertMessage(with: "Đăng nhập không thành công", and: "Hãy nhập lại email hoặc password")
                textField.becomeFirstResponder()
            }
        }
        return true
    }
    
    private func displayAlertMessage(with title: String,and errorMessage: String ) {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { actions in
            return
        }))
        present(alert, animated: true, completion: nil)
    }

    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constraints.login {
            if emailTextField.text == admin.email && passTextField.text == admin.password {
                return true
            }
                displayAlertMessage(with: "Đăng nhập không thành công", and: "Hãy nhập lại email hoặc password")
        }
        return false
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == Constraints.login {
                if let navcon = segue.destination as? UINavigationController {
                    if let trangChuVC = navcon.visibleViewController as? TrangChuCollectionViewController {
                        trangChuVC.title = "Trang chủ"
                        UserDefaults.standard.set(emailTextField.text, forKey: "email")
                        UserDefaults.standard.set(passTextField.text, forKey: "password")
                        UserDefaults.standard.synchronize()
                        trangChuVC.admin = self.admin
                    }
                }
            }
        }
    }

}
