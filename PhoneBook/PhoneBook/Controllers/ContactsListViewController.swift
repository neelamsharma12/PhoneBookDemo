//
//  ContactsListViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var contactsListTableView: UITableView!
    
    //MARK: - Variable declarations
     var contacts: [ContactModel]? = nil
     let contactRowHeight: CGFloat = 65
     var selectedContactID: Int?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactsApi.loadContacts() { contacts in
            self.contacts = contacts
            DispatchQueue.main.async {
               self.contactsListTableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: - Navigation
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = contacts else {
            return 0
        }
        return contacts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactTableViewCell
       
        if let contactList  = contacts {
            if let firstName = contactList[indexPath.row].firstName, let lastName =  contactList[indexPath.row].lastName {
                 cell.contactNameLabel.text = firstName + lastName
            }
            if let fav = contactList[indexPath.row].favorite {
                cell.contactFavButton.isHidden = fav == 1 ? false : true
            }
            if let imageUrl = contactList[indexPath.row].profilePic {
                cell.contactImageView.image = UIImage.init(named: "placeholder_photo")
                    //UIImage.init(named: imageUrl)
            }
            let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
            
            lineView.backgroundColor = Utility.customGreyColor
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
        
        if let contactList  = contacts {
            selectedContactID = contactList[indexPath.row].ID
        }
        
        performSegue(withIdentifier: "contactDetail", sender: self)
    }
}

