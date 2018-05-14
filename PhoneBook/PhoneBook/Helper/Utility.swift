//
//  Utility.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static let LightGreenColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 0.5)
    
    static let CustomGreyColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1)
    
    static let ContactImageBaseUrlString = "http://gojek-contacts-app.herokuapp.com"
    
    class func customizeBackBtnText(navigationItem: UINavigationItem) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
        backItem.title = "Contact"
        navigationItem.backBarButtonItem = backItem
    }
    
    class func setGradientBackground(view: UIView) {
        let colorTop =  UIColor.white
        let colorBottom = Utility.LightGreenColor.cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = view.bounds
        
        view.layer.insertSublayer(gradient, at: 0)
    }
}
