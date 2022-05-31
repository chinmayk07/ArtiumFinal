//
//  LoginViewController.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 30/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var lblGuestLogin: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblGuestLogin.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.proceedToApp(_:))))
        lblGuestLogin.isUserInteractionEnabled = true
    }
    
    @objc func proceedToApp(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController)!
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
        
    }

    @IBAction func btnLogin(_ sender: Any) {
        
//        viewmodel.ValidateUser(username: username.text!, password: password.text!)
//
//        if username.text != "" && password.text != "" {
//
//            if username.text == "test" && password.text == "test" {
//                print("LOGIN_SUCCUSSFULL")
//            }
//            else {
//                showAlert()
//            }
//        }
//        else {
//           showAlert()
//        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Please enter valid details", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }


}
