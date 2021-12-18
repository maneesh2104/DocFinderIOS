//
//  BookApptVC.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/17/21.
//

import UIKit
import MaterialComponents
import SkyFloatingLabelTextField
import Alamofire
import SCLAlertView

class BookApptVC: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var dr_name = ""
    var speacilat = ""
    var address = ""
    
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var specslabel: UILabel!
    @IBOutlet weak var docImage: UIImageView!
    @IBOutlet weak var bookBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = dr_name
        addressLabel.text = address
        specslabel.text = speacilat
        
        
        self.textField.datePicker(target: self,
                                          doneAction: #selector(doneAction),
                                          cancelAction: #selector(cancelAction),
                                          datePickerMode: .dateAndTime)
        addShadow(view: cardView)
        custBtn(button: bookBtn)
    }
    
    @objc
        func cancelAction() {
            self.textField.resignFirstResponder()
        }

        @objc
        func doneAction() {
            if let datePickerView = self.textField.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd "
                let dateString = dateFormatter.string(from: datePickerView.date)
                self.textField.text = dateString
                
                print(datePickerView.date)
                print(dateString)
                
                self.textField.resignFirstResponder()
            }
        }
    
    @IBAction func bookPressed(_ sender: Any) {
        if validateTF(tf: textField, type: ""){
            //Hit API
            let parameters: [String: String] = [
                "doc_name": dr_name,
                "apt_time": textField.text ?? ""
  
            ]
            let user = users[0].username
            let password = users[0].password
            let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            let h = HTTPHeader(name: "Authorization", value: "Basic \(base64Credentials)")
            AF.request("https://prod.maneesh.me/v1/appoinment/",method: .post, parameters: parameters, headers: [h]).authenticate(username: user ?? "", password: password ?? "").responseDecodable(of: apptAPI.self) { response in
                switch response.result{
                case .success :
                    print("Sucess")
                    SCLAlertView().showSuccess("Appoinment Booked", subTitle: "Please be on time!")
                case .failure :
                    print("Fail")
                    SCLAlertView().showError("Invalid Details", subTitle: "Please check your datails!") // Error
                default:
                    print("-------------")
                }
                    debugPrint("Response: \(response)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}
