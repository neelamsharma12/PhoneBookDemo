//
//  ContactDetailViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var contactBgView: UIView!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactFavButton: UIButton!
    @IBOutlet weak var contactDetailTableView: UITableView!
    
    //MARK: - Variable declarations
    var contactID: Int!
    let contactDetailRowHeight: CGFloat = 56
    var contactDetails: ContactDetailModel?
    var contactDetailProperties = ["mobile", "email"]
    
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactsApi.loadContactDetailById(id: contactID!) { contactDetails in
            self.contactDetails = contactDetails
            DispatchQueue.main.async {
                self.loadContactInfo()
                self.contactDetailTableView.reloadData()
            }
        }
        Utility.setGradientBackground(view: contactBgView)
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Private methods
    
    /**
     function to load the contact details information
     - parameter
     - returns
     */
    fileprivate func loadContactInfo() {
        contactImageView.layer.cornerRadius = (contactImageView.frame.width/2)
        contactImageView.clipsToBounds = true
        contactImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        if let imageUrl = contactDetails?.profilePic {
            let url: URL?
            
            if imageUrl == "/images/missing.png" {
                url = URL(string: Utility.ContactImageBaseUrlString+imageUrl)
            }else {
                url = URL(string: imageUrl)
            }
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    DispatchQueue.main.async {
                       self.contactImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }else {
            contactImageView.image = UIImage.init(named: "placeholder_photo")
        }
        loadContactName()
        loadContactFavStatus()
    }
    
    /**
     function to load contact name
     - parameter
     - returns
     */
    fileprivate func loadContactName() {
        if let firstName = contactDetails?.firstName  {
            if let lastName = contactDetails?.lastName {
                if (firstName == "" && lastName == "") {
                    contactNameLabel.text = "Not Available"
                }else if (firstName == "" && lastName != "") {
                     contactNameLabel.text = lastName
                }else if (firstName != "" && lastName == "") {
                    contactNameLabel.text = firstName
                }else {
                    contactNameLabel.text = firstName + lastName
                }
            }else {
                if firstName == "" {
                    contactNameLabel.text = "Not Available"
                } else {
                    contactNameLabel.text = firstName
                }
            }
        }else {
            contactNameLabel.text = "Not Available"
        }
    }
    
    /**
     function to load contact favourite status
     - parameter
     - returns
     */
    fileprivate func loadContactFavStatus() {
        if let contactDetail = contactDetails {
            if contactDetail.favorite == false {
                contactFavButton.setImage(UIImage.init(named: "favourite_button"), for: UIControlState())
            } else {
                contactFavButton.setImage(UIImage.init(named: "favourite_button_selected"), for: UIControlState())
            }
        }
    }
    
    /**
     function to make call on specfic number
     - parameter: phoneNumber: String
     - returns
     */
    fileprivate func callOnNumber(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }

    //MARK: - IBAction Methods
    
    /**
     IBAction to be called on tap of send message button
     - parameter: sender: Any
     - returns
     */
    @IBAction func sendMessageBtnTapped(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            if let phNumber = contactDetails?.phoneNumber {
                controller.recipients = [phNumber]
            }
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    /**
     IBAction to be called on tap of call button
     - parameter: sender: Any
     - returns
     */
    @IBAction func callBtnTapped(_ sender: Any) {
        callOnNumber(phoneNumber: "1234567891")
    }
    
    /**
     IBAction to be called on tap of send email button
     - parameter: sender: Any
     - returns
     */
    @IBAction func sendEmailBtnTapped(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["sharmaneelam262@gmail.com"])
        composeVC.setSubject("Assignment Feedback")
        composeVC.setMessageBody("Hey Neelam! Here's my feedback.", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    /**
     IBAction to be called on tap of favourite button
     - parameter: sender: Any
     - returns
     */
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        var updatedContactDetails = [String: Any]()
        
        if let contactDetail = contactDetails {
            if contactDetail.favorite == false {
                contactDetail.favorite = true
                contactFavButton.setImage(UIImage.init(named: "favourite_button_selected"), for: UIControlState())
            } else {
                contactDetail.favorite = false
                contactFavButton.setImage(UIImage.init(named: "favourite_button"), for: UIControlState())
            }
             updatedContactDetails["favorite"] = contactDetail.favorite
        }

        if updatedContactDetails.keys.count > 0 {
            ContactsApi.EditContactDetailsById(id: (contactDetails?.ID)!, headers: updatedContactDetails) { _ in
                
            }
        }
    }
    
    /**
     IBAction to be called on tap of edit button
     - parameter: sender: Any
     - returns
     */
    @IBAction func editBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "editScreenSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    /**
     function to navigate to contact edit VC
     - parameter: segue: UIStoryboardSegue, sender: Any?
     - returns
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editViewController = segue.destination as? ContactEditViewController else {
            return
        }
        if let contactDetails = contactDetails {
            editViewController.contactDetails = contactDetails
        }
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetailProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactDetailTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "contactDetailCell") as! ContactDetailTableViewCell
        
        
        if indexPath.row == 0 {
            cell.contactPropertyNameLabel.text = contactDetailProperties[0]
            if let phNumber = contactDetails?.phoneNumber {
                if phNumber == "" {
                    cell.contactPropertyInfoLabel.text = "Not Available"
                }else {
                   cell.contactPropertyInfoLabel.text = phNumber
                }
            }else {
                cell.contactPropertyInfoLabel.text = "Not Available"
            }
        } else {
            cell.contactPropertyNameLabel.text = contactDetailProperties[1]
            if let emailId = contactDetails?.email {
                if emailId == "" {
                     cell.contactPropertyInfoLabel.text = "Not Available"
                }else {
                    cell.contactPropertyInfoLabel.text = emailId
                }
            }else {
                cell.contactPropertyInfoLabel.text = "Not Available"
            }
        }
        let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
        
        lineView.backgroundColor = Utility.CustomGreyColor
        cell.contentView.addSubview(lineView)
        return cell
    }
}

extension ContactDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contactDetailRowHeight
    }
}

extension ContactDetailViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
}

extension ContactDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

