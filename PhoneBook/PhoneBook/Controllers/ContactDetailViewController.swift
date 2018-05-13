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
        
        ContactsApi.loadContactDetail(id: contactID!) { contactDetails in
            self.contactDetails = contactDetails
            DispatchQueue.main.async {
                self.loadContactInfo()
                self.contactDetailTableView.reloadData()
            }
        }
        setGradientBackground()
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
    
    fileprivate func loadContactInfo() {
        if let _ = contactDetails?.profilePic {
            contactImageView.image = UIImage.init(named: "placeholder_photo")
        } else {
             contactImageView.image = UIImage.init(named: "placeholder_photo")
        }
    }
    
    fileprivate func setGradientBackground() {
        let colorTop =  UIColor.white
        let colorBottom = Utility.lightGreenColor.cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = self.contactBgView.bounds
        
        self.contactBgView.layer.insertSublayer(gradient, at: 0)
    }
    
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
    
    @IBAction func callBtnTapped(_ sender: Any) {
        callOnNumber(phoneNumber: "1234567891")
    }
    
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
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        if let contactDetail = contactDetails {
            if contactDetail.favorite == false {
                contactDetail.favorite = true
                contactFavButton.setImage(UIImage.init(named: "favourite_button_selected"), for: UIControlState())
            } else {
                contactDetail.favorite = false
                contactFavButton.setImage(UIImage.init(named: "favourite_button"), for: UIControlState())
            }
        }
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        
        lineView.backgroundColor = Utility.customGreyColor
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

