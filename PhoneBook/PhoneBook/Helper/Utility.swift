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
    
    static let lightGreenColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 0.5)
    
    static let customGreyColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1)
    
    class func customizeBackBtnText(navigationItem: UINavigationItem) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
        backItem.title = "Contact"
        navigationItem.backBarButtonItem = backItem
    }
}
