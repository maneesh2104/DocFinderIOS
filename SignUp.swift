//
//  SignUp.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/15/21.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialComponents
import Alamofire
import SCLAlertView
import NotificationCenter

class SignUpVC: UIViewController{
    
    @IBOutlet weak var loginBtn: MDCButton!
    @IBOutlet weak var lastnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cardView: UIView!
    

    @IBAction func btnClicked(_ sender: Any) {
        var flag = false
        flag = validateTF(tf: firstNameTF, type: "")
        flag = validateTF(tf: lastnameTF, type: "")
        flag = validateTF(tf: usernameTF, type: "")
        flag = validateTF(tf: passwordTF, type: "")
        
        if flag{
            hitApi()
        }
        else{
            SCLAlertView().showError("Validation Error", subTitle: "Please check your deatils")
        }
    }
    
    override func viewDidLoad() {
        addShadow(view: cardView)
        custBtn(button: loginBtn)
        
        lastnameTF.delegate = self
        usernameTF.delegate = self
        passwordTF.delegate = self
        firstNameTF.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);

    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func showLogin(sender: NSNotification) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    

    
    func hitApi(){
        
        let parameters: [String: String] = [
            "username": usernameTF.text ?? "",
            "password": passwordTF.text ?? "",
            "first_name": firstNameTF.text ?? "",
            "last_name": lastnameTF.text ?? ""
        ]
        AF.request("https://prod.maneesh.me/v1/user/", method: .post, parameters: parameters).responseDecodable(of: signUpApi.self) { response in
            switch response.result{
            case .success :
                print("Sucess")
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("Login Now", target:self, selector: #selector(self.showLogin))
                alertView.showSuccess("Successfully registered", subTitle: "Please Verify your email before loging in")
            case .failure :
                print("Fail")
                SCLAlertView().showError("Invalid Details", subTitle: "Please check your deatils") // Error
            default:
                print("-------------")
            }
                debugPrint("Response: \(response)")
        }
    }
}

extension UIViewController{
    func validateTF(tf: SkyFloatingLabelTextField, type:String) -> Bool {
        
        var flag = true
        if tf.text?.isEmpty ?? false{
            tf.errorMessage = "Cannot be empty"
            flag = false
        }
        return flag
    }
}

extension SignUpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        usernameTF.errorMessage = ""
        passwordTF.errorMessage = ""
        firstNameTF.errorMessage = ""
        lastnameTF.errorMessage = ""
        return true;
    }
}
