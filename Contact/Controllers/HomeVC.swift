//
//  HomeVC.swift
//  Contact
//
//  Created by Ahmed Mohamed El-Desouky on 5/6/19.
//  Copyright © 2019 Ahmed El-Desouky. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeVC: UIViewController {

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var conTable: UITableView!

    
    var userNamee: String?
    var phoneNum: String?
    var userHome: String?
    var userCo: String?
    var userBirt: String?
    
    var contacS: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conTable.delegate = self
        conTable.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        conTable.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if contacS.count >= 1 {
                conTable.isHidden = false
            } else {
                conTable.isHidden = true
            }
        }
    }
    
    @IBAction func createBtn(_ sender: Any) {
        let createVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateContactVC")
        
        self.present(createVC!, animated: true, completion: nil)
    }
    

}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell else { return UITableViewCell() }
        
        let contac = contacS[indexPath.row]
        cell.ConfigureCell(contact: contac)
        
        cell.ShowInfo = {
            let conInfoVC = ContactInfoVC()
            
            conInfoVC.userNamee = contac.conName
            conInfoVC.phoneNum = contac.conPhone
            conInfoVC.userHome = contac.conCity
            conInfoVC.userCo = contac.conCompany
            conInfoVC.userBirt = contac.conBirthday
            
            conInfoVC.modalPresentationStyle = .custom
            self.present(conInfoVC, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeContact(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            self.conTable.deleteRows(at: [indexPath], with: .automatic)
        }
        deletAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deletAction]
    }
    
}


extension HomeVC {
 
    func removeContact(atIndexPath indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(contacS[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed contact")
        } catch {
            debugPrint("Couldn't remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        do {
            contacS = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Couldn't fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
}
