//
//  ApptsController.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/17/21.
//

//
//  DocResultsTableViewController.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/17/21.
//

import UIKit
import Alamofire
import SCLAlertView

class ApptsController: UITableViewController {
    
    var appoinments = [Appoinment]()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
        activityIndicator.startAnimating()
        let user = users[0].username
        let password = users[0].password
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let h = HTTPHeader(name: "Authorization", value: "Basic \(base64Credentials)")
        AF.request("https://prod.maneesh.me/v1/appoinment/", method: .get, headers: [h]).responseDecodable(of: GetApptsAPI.self) { response in
            switch response.result{
                case .success(let docRes) :
                    print("Sucess")
                    self.appoinments = docRes.appts
                    self.tableView.reloadData()
                case .failure :
                    print("Fail")
                    SCLAlertView().showError("Invalid Credentials", subTitle: "Please check your credentials")
                default:
                    print("Hi")
            }
            self.activityIndicator.stopAnimating()
            debugPrint("Response: \(response)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appoinments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: "cell")

//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = appoinments[indexPath.row].doc_name
        cell.detailTextLabel?.text = appoinments[indexPath.row].apt_time
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "BookApptVC") as! BookApptVC
//        resultViewController.dr_name = doctors[indexPath.row].name.components(separatedBy: ", ")[0]
//        resultViewController.speacilat = doctors[indexPath.row].name.components(separatedBy: ", ")[1]
//        resultViewController.address = doctors[indexPath.row].address
//        
//        
//        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    

}


