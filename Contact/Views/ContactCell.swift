//
//  ContactCell.swift
//  Contact
//
//  Created by Ahmed Mohamed El-Desouky on 5/6/19.
//  Copyright © 2019 Ahmed El-Desouky. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    
    var ShowInfo: (()->())?
    
    func ConfigureCell(contact: Contact) {
        userName.text = contact.conName
        companyLbl.text = contact.conCompany
    }
    
    @IBAction func infoBtn(_ sender: Any) {
         ShowInfo?()
    }

}
