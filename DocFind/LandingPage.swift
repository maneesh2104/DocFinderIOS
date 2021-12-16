//
//  LandingPage.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/13/21.
//

import UIKit
import MaterialComponents

class LandingPageVC: UIViewController{
   
    @IBOutlet weak var SignInBtn: MDCButton!
    @IBOutlet weak var SignUpBtn: MDCButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        icon.image = UIImage.init(named: "logo")
        addShadow(view: cardView)
        addShadow(view: SignUpBtn)
        addShadow(view: SignInBtn)
        custBtn(button: SignInBtn)
        custBtn(button: SignUpBtn)
//        addShadow(view: icon)
        
    }
}

extension UIViewController{
    func custBtn(button: MDCButton){
        button.backgroundColor = .systemGray
        button.tintColor = .white
    }
    
    func addShadow(view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
    }
}
