//
//  ContactAddViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactAddViewController: UIViewController, UpdateContactDetailsProtocol {

    // MARK: - Properties
    @IBOutlet weak var addContactBgView: UIView!
    @IBOutlet weak var addContactImageView: UIImageView!
    @IBOutlet weak var addContactDetailTableView: UITableView!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    //MARK: - Variable declarations
    var contactID: Int!
    let contactDetailRowHeight: CGFloat = 56
    var contactDetailProperties = ["First Name","Last Name","mobile", "email"]
    var contactDetailsDict = [String: Any]()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.setGradientBackground(view: addContactBgView)
        addContactImageView.layer.cornerRadius = (addContactImageView.frame.width/2)
        addContactImageView.clipsToBounds = true
        addContactImageView.contentMode = UIViewContentMode.scaleAspectFill
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
        
        if (!contactDetailsDict.keys.contains("first_name"))  {
            contactDetailsDict["first_name"] = ""
        }
        if (!contactDetailsDict.keys.contains("last_name"))  {
            contactDetailsDict["last_name"] = ""
        }
        if (!contactDetailsDict.keys.contains("email"))  {
            contactDetailsDict["email"] = ""
        }
        if (!contactDetailsDict.keys.contains("phone_number"))  {
            contactDetailsDict["phone_number"] = ""
        }
        if (!contactDetailsDict.keys.contains("favorite"))  {
            contactDetailsDict["favorite"] = false
        }
        
        ContactsApi.addContactDetails( headers: contactDetailsDict) { status in
            print(status)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UpdateContactDetailsProtocol method implementation
    
    /**
     func to be called to get updated field of contact detail
     - parameter: updatedData: String?, propertyTag: Int
     - returns
     */
    func didFinishEditingContactDetails(updatedData: String?, propertyTag: Int ) {
        
        if propertyTag == 0 {
            contactDetailsDict["first_name"] = updatedData ?? ""
            
        }else if propertyTag == 1 {
            contactDetailsDict["last_name"] = updatedData ?? ""
            
        }else if propertyTag == 2 {
            contactDetailsDict["phone_number"] = updatedData ?? ""
            
        }else {
            contactDetailsDict["email"] = updatedData ?? ""
        }
    }
}

extension ContactAddViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetailProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactEditTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "addContactCell") as! ContactEditTableViewCell
        
        cell.editContactPropertyNameLabel.text = contactDetailProperties[indexPath.row]
        cell.editContactPropertyInfoLabel.tag = indexPath.row
        cell.delegate = self
        
        if indexPath.row == 0 {
            cell.editContactPropertyNameLabel.textAlignment = .left
        }else if indexPath.row == 1 {
            cell.editContactPropertyNameLabel.textAlignment = .left
        }else if indexPath.row == 2 {
             cell.editContactPropertyNameLabel.textAlignment = .right
        }else {
            cell.editContactPropertyNameLabel.textAlignment = .right
        }
        
        let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
        
        lineView.backgroundColor = Utility.CustomGreyColor
        cell.contentView.addSubview(lineView)
        return cell
    }
}

extension ContactAddViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contactDetailRowHeight
    }
}

extension ContactAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imgUrl = info[UIImagePickerControllerImageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            contactDetailsDict["profile_pic"] = localPath
            
            addContactImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

