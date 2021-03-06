//
//  ContactsListViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit
import CoreData

class ContactsListViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var contactsListTableView: UITableView!
    
    //MARK: - Variable declarations
     var contacts = [Contact]()
     var contactsWithSections = [[Contact]]()
     let contactRowHeight: CGFloat = 65
     var selectedContactID: Int?
     var letterIndex = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
     let collation = UILocalizedIndexedCollation.current()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do {
            let contactsList = try PersistenceService.context.fetch(fetchRequest)
            self.contacts = contactsList

            if (self.contacts.count == 0) {
                ContactsApi.loadContacts() { contacts in
                
                    self.contacts = contacts
                    if (self.contacts.count > 0) {
                        self.contactsWithSections = self.collation.partitionObjects(array: self.contacts, collationStringSelector: #selector(getter: Contact.firstName)) as! [[Contact]]
                        DispatchQueue.main.async {
                            self.contactsListTableView.reloadData()
                        }
                    }
                }
            } else {
                contactsWithSections = collation.partitionObjects(array: self.contacts, collationStringSelector: #selector(getter: Contact.firstName)) as! [[Contact]]
                 self.contactsListTableView.reloadData()
            }
        } catch {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    /**
     function to navigate to contact detail VC
     - parameter: segue: UIStoryboardSegue, sender: Any?
     - returns
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? ContactDetailViewController else {
            return
        }
        if let id = selectedContactID {
            detailViewController.contactID = id
        }
        Utility.customizeBackBtnText(navigationItem: navigationItem)
     }
}

extension ContactsListViewController: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letterIndex
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return contactsWithSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collation.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return contactsWithSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactTableViewCell
        
        let contact = contactsWithSections[indexPath.section][indexPath.row]
       
        if contacts.count > 0 {
            if let firstName = contact.firstName, let lastName =  contact.lastName {
                 cell.contactNameLabel.text = firstName + lastName
            }
            cell.contactFavButton.isHidden = (contact.favorite == 1) ? false : true
            
            let url: URL?
            
             cell.contactImageView.layer.cornerRadius = (cell.contactImageView.frame.width/2)
             cell.contactImageView.clipsToBounds = true
             cell.contactImageView.contentMode = UIViewContentMode.scaleAspectFill
            
            if let imageUrl = contact.profilePic {
                if imageUrl == "/images/missing.png" {
                    url = URL(string: Utility.ContactImageBaseUrlString+imageUrl)
                }else {
                    url = URL(string: imageUrl)
                }
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    if let imageData = data {
                         DispatchQueue.main.async {
                            cell.contactImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }else {
                cell.contactImageView.image = UIImage.init(named: "placeholder_photo")
            }
            let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
            
            lineView.backgroundColor = Utility.CustomGreyColor
            cell.contentView.addSubview(lineView)
        }
        return cell
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contactRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if contacts.count > 0 {
            selectedContactID = Int(contacts[indexPath.row].id)
        }
        
        performSegue(withIdentifier: "contactDetailSegue", sender: self)
    }
}

