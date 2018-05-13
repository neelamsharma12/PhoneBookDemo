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
    
    class func customizeBackBtnText(navigationItem: UINavigationItem) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
        navigationItem.backBarButtonItem = backItem
    }
}
