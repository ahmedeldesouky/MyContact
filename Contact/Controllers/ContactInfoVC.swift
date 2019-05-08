//
//  ContactInfoVC.swift
//  Contact
//
//  Created by Ahmed Mohamed El-Desouky on 5/6/19.
//  Copyright © 2019 Ahmed El-Desouky. All rights reserved.
//

import UIKit

class ContactInfoVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var homeCity: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    
    var userNamee: String?
    var phoneNum: String?
    var userHome: String?
    var userCo: String?
    var userBirt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = userNamee
        phoneNumber.text = phoneNum
        homeCity.text = userHome
        company.text = userCo
        birthdayLbl.text = userBirt
        
        setUpViwe()
    }
    
    func setUpViwe() {
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ContactInfoVC.closeTap(_recognizer:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBtn(_ sender: Any) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desViewController = mainStoryBoard.instantiateViewController(withIdentifier: "CreateContactVC") as! CreateContactVC
        desViewController.userNamee = userName.text
        desViewController.phoneNum = phoneNumber.text
        desViewController.userHome = homeCity.text
        desViewController.userCo = company.text
        desViewController.userBirt = birthdayLbl.text
        
        self.present(desViewController, animated: true, completion: nil)
    }
    
    @IBAction func colseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
