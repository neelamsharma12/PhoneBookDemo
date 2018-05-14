//
//  ContactEditViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController, UpdateContactDetailsProtocol {

    // MARK: - Properties
    @IBOutlet weak var editContactBgView: UIView!
    @IBOutlet weak var editContactImageView: UIImageView!
    @IBOutlet weak var editContactDetailTableView: UITableView!
    @IBOutlet weak var uploadImageButton: UIButton!
    var contactDetailProperties = ["First Name","Last Name","mobile", "email"]
    
    //MARK: - Variable declarations
    var contactDetails: ContactDetailModel!
    var updatedContactDict: [String: Any]?
    let contactDetailRowHeight: CGFloat = 56
    var contactDetailsDict = [String: Any]()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        editContactImageView.layer.cornerRadius = (editContactImageView.frame.width/2)
        editContactImageView.clipsToBounds = true
        editContactImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        editContactDetailTableView.tableFooterView = UIView()
        Utility.setGradientBackground(view: editContactBgView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBAction Methods
    
    /**
     IBAction to be called on tap of upload image button
     - parameter: sender: Any
     - returns
     */
    @IBAction func uploadImageBtnTapped(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    /**
     IBAction to be called on tap of cancel button
     - parameter: sender: Any
     - returns
     */
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     IBAction to be called on tap of done button
     - parameter: sender: Any
     - returns
     */
    @IBAction func doneBtnTapped(_ sender: Any) {
        var updatedContactDetails: [String: Any]!
    
        if let updatedContactData = self.updatedContactDict {
            updatedContactDetails = updatedContactData
        }
        if updatedContactDetails != nil {
            ContactsApi.EditContactDetailsById(id: contactDetails.ID!, headers: updatedContactDetails) { updatedContactDetails in
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UpdateContactDetailsProtocol method implementation
    
    /**
     func to be called to get updated field of contact detail
     - parameter: updatedData: String?, propertyTag: Int
     - returns
     */
    func didFinishEditingContactDetails(updatedData: String?, propertyTag: Int) {
        
        if propertyTag == 0 {
            contactDetailsDict["first_name"] = updatedData ?? ""
            
        }else if propertyTag == 1 {
            contactDetailsDict["last_name"] = updatedData ?? ""
           
        }else if propertyTag == 2 {
            contactDetailsDict["phone_number"] = updatedData ?? ""
           
        }else {
            contactDetailsDict["email"] = updatedData ?? ""
        }
        updatedContactDict = contactDetailsDict
    }
   
}

extension ContactEditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetailProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactEditTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "contactEditCell") as! ContactEditTableViewCell
        
        cell.editContactPropertyNameLabel.text = contactDetailProperties[indexPath.row]
        cell.editContactPropertyInfoLabel.tag = indexPath.row
        cell.delegate = self
        
        if indexPath.row == 0 {
            if let firstName =  contactDetails.firstName {
                cell.editContactPropertyInfoLabel.text = firstName
            }
            cell.editContactPropertyNameLabel.textAlignment = .left
        }else if indexPath.row == 1 {
            if let lastName =  contactDetails.lastName {
                cell.editContactPropertyInfoLabel.text = lastName
            }
            cell.editContactPropertyNameLabel.textAlignment = .left
        }else if indexPath.row == 2 {
            if let phNumber =  contactDetails.phoneNumber {
                cell.editContactPropertyInfoLabel.text = phNumber
            }
            cell.editContactPropertyNameLabel.textAlignment = .right
        }else {
            if let emailId =  contactDetails.email {
                cell.editContactPropertyInfoLabel.text = emailId
            }
            cell.editContactPropertyNameLabel.textAlignment = .right
        }
       
        let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
        
        lineView.backgroundColor = Utility.CustomGreyColor
        cell.contentView.addSubview(lineView)
        return cell
    }
}

extension ContactEditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contactDetailRowHeight
    }
}

extension ContactEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        editContactImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

}
