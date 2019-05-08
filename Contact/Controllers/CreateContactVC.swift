//
//  CreateContactVC.swift
//  Contact
//
//  Created by Ahmed Mohamed El-Desouky on 5/6/19.
//  Copyright © 2019 Ahmed El-Desouky. All rights reserved.
//

import UIKit
import CoreData

class CreateContactVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var homeTxt: UITextField!
    @IBOutlet weak var companyTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    
    var userNamee: String?
    var phoneNum: String?
    var userHome: String?
    var userCo: String?
    var userBirt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTxt.delegate = self
        phoneTxt.delegate = self
        homeTxt.delegate = self
        companyTxt.delegate = self
        birthTxt.delegate = self
        
        nameTxt.text = userNamee
        phoneTxt.text = phoneNum
        homeTxt.text = userHome
        companyTxt.text = userCo
        birthTxt.text = userBirt
        
    }

    @IBAction func createBtn(_ sender: Any) {
        if nameTxt.text != "" && phoneTxt.text != "" && homeTxt.text != "" && birthTxt.text != "" && companyTxt.text != "" {
            
            self.save { (complete) in
                if complete {
        guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
                    
                    homeVC.userNamee = self.nameTxt.text
                    homeVC.phoneNum = self.phoneTxt.text
                    homeVC.userHome = self.homeTxt.text
                    homeVC.userBirt = self.birthTxt.text
                    homeVC.userCo = self.companyTxt.text
                    
                    homeVC.modalPresentationStyle = .custom
                    present(homeVC, animated: true, completion: nil)
            }
        }
    }
}
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearName(_ sender: Any) {
        nameTxt.text = ""
    }
    
    @IBAction func clearPhone(_ sender: Any) {
        phoneTxt.text = ""
    }
    
    @IBAction func clearCity(_ sender: Any) {
        homeTxt.text = ""
    }
    
    @IBAction func clearCompany(_ sender: Any) {
        companyTxt.text = ""
    }
    
    @IBAction func clearBirth(_ sender: Any) {
        birthTxt.text = ""
    }
    
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        let contac = Contact(context: manageContext)
        
        contac.conName = nameTxt.text!
        contac.conPhone = phoneTxt.text!
        contac.conCity = homeTxt.text!
        contac.conCompany = companyTxt.text!
        contac.conBirthday = birthTxt.text!
        
        do {
            try manageContext.save()
            completion(true)
        } catch {
            debugPrint("Couldn't save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
