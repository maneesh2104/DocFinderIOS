//
//  HomePage.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/15/21.
//

import UIKit

class HomePageVC: UIViewController{
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var appoinmentView: UIImageView!
    @IBOutlet weak var SearchView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var dpView: UIImageView!
    
    override func viewDidLoad() {
        addShadow(view: appoinmentView)
        addShadow(view: SearchView)
        addShadow(view: dpView)
       addShadow(view: cardView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        SearchView.isUserInteractionEnabled = true
        SearchView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1))
        
        appoinmentView.isUserInteractionEnabled = true
        appoinmentView.addGestureRecognizer(tapGestureRecognizer1)
        
        
        
        dpView.layer.cornerRadius = dpView.bounds.height / 2
        
    }
    
    @objc
    func imageTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @objc
    func imageTapped1() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ApptsController") as! ApptsController
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
}
