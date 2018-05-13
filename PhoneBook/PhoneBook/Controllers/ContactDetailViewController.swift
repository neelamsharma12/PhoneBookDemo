//
//  ContactDetailViewController.swift
//  PhoneBook
//
//  Created by Neelam on 12/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var contactBgView: UIView!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
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
        let colorBottom = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0).cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.contactBgView.bounds
        
        self.contactBgView.layer.insertSublayer(gradient, at: 0)
    }

    //MARK: - IBAction Methods
    @IBAction func sendMessageBtnTapped(_ sender: Any) {
    }
    
    @IBAction func callBtnTapped(_ sender: Any) {
    }
    
    @IBAction func sendEmailBtnTapped(_ sender: Any) {
    }
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactDetailTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "contactDetailCell") as! ContactDetailTableViewCell
        
        if let contactDetails  = contactDetails {
            
            if indexPath.row == 0 {
                cell.contactPropertyNameLabel.text = contactDetailProperties[0]
                cell.contactPropertyInfoLabel.text = contactDetails.phoneNumber
                
            } else if indexPath.row == 1 {
                cell.contactPropertyNameLabel.text = contactDetailProperties[1]
                cell.contactPropertyInfoLabel.text = contactDetails.email
                
            }
            let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.size.height - 1.0, width: cell.contentView.frame.size.width - 20, height: 1))
            
            lineView.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1)
            cell.contentView.addSubview(lineView)
        }
        return cell
    }
}

extension ContactDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contactDetailRowHeight
    }
}

