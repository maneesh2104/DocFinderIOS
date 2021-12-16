//
//  SignInVC.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/15/21.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialComponents
import Alamofire
import SCLAlertView

class SignInVC:UIViewController, UITextFieldDelegate{
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var loginBtn: MDCButton!
    
    let activityIndicator = MDCActivityIndicator()

    override func viewDidLoad() {
        userNameTF.delegate = self
        passwordTF.delegate = self
        custBtn(button: loginBtn)
        addShadow(view: cardView)
        
        activityIndicator.sizeToFit()
        activityIndicator.indicatorMode = .determinate
        activityIndicator.progress = 0.5
        activityIndicator.bringSubviewToFront(cardView)
        self.view.addSubview(activityIndicator)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        if userNameTF.text?.isEmpty ?? false{
            userNameTF.errorMessage = "Cannot be empty"
        }
        if passwordTF.text?.isEmpty ?? false{
            passwordTF.errorMessage = "Cannot be empty"
        }
        else{
            //Hit API
            let user = userNameTF.text!
            let password = passwordTF.text!
            
            let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            let h = HTTPHeader(name: "Authorization", value: "Basic \(base64Credentials)")
            activityIndicator.startAnimating()
            AF.request("https://prod.maneesh.me/v1/user/self", headers: [h]).authenticate(username: user ?? "", password: password ?? "").responseDecodable(of: signIn.self) { response in
                switch response.result{
                case .success :
                    print("Sucess")
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageVC
                    
                    self.navigationController?.pushViewController(resultViewController, animated: true)
                case .failure :
                    print("Fail")
                    SCLAlertView().showError("Invalid Credentials", subTitle: "Please check your credentials") // Error
                default:
                    print("Hi")
                }
                self.activityIndicator.stopAnimating()
                    debugPrint("Response: \(response)")
                }
            
        }
        
        
            
//            .responseString(completionHandler: { res in
//                print(res)
//            })
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        userNameTF.errorMessage = ""
        passwordTF.errorMessage = ""
            return true;
        }

    
    
}
