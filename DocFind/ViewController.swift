//
//  ViewController.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/13/21.
//

import UIKit
 import paper_onboarding
import MaterialComponents


class ViewController: UIViewController {
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage.init(named: "doc")!,
                               title: "Find nearby Doctors",
                               description: "Your next doctor is just a few taps away",
                               pageIcon:  UIImage.init(named: "doc")!,
                               color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
        OnboardingItemInfo(informationImage:  UIImage.init(named: "cal")!,
                               title: "Schedule appoinments",
                               description: "Skip the que by booking in advance",
                               pageIcon:  UIImage.init(named: "doc")!,
                               color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
         OnboardingItemInfo(informationImage: UIImage.init(named: "chat")!,
                               title: "Chat",
                               description: "Message the doctor for ",
                               pageIcon:  UIImage.init(named: "doc")!,
                               color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
          let constraint = NSLayoutConstraint(item: onboarding,
                                              attribute: attribute,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: attribute,
                                              multiplier: 1,
                                              constant: 0)
          view.addConstraint(constraint)
        }
        print(UIScreen.main.bounds.width)
        let skip = MDCButton(frame: CGRect(x: UIScreen.main.bounds.width - 90, y: 100, width: 100, height: 40))
        skip.backgroundColor = .clear
        skip.setTitle("Skip", for: .normal)
        skip.setTitleColor(.white, for: .normal)
        skip.addTarget(self, action: #selector(skipClicked), for: .touchUpInside)
        view.addSubview(skip)
    }
    
    @objc
    func skipClicked() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "LandingPageVC") as! LandingPageVC
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
        print("Skip")
    }
}

extension ViewController:PaperOnboardingDelegate{
    
}

extension ViewController:PaperOnboardingDataSource{
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
         return items[index]
     }

     func onboardingItemsCount() -> Int {
         return 3
     }
}

