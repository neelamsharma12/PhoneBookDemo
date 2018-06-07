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
    
    static let LightGreyHeaderViewColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    
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
    
    class func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dateFormatter.string(from: NSDate() as Date)
        return dateString
    }
}

extension UILocalizedIndexedCollation {
    
    func partitionObjects(array:[AnyObject], collationStringSelector:Selector) -> [AnyObject] {
        var unsortedSections = [[AnyObject]]()
        //1. Create a array to hold the data for each section
        for _ in self.sectionTitles {
            unsortedSections.append([]) //appending an empty array
        }
        //2. put each objects into a section
        for item in array {
            let index:Int = self.section(for: item, collationStringSelector:collationStringSelector)
            unsortedSections[index].append(item)
        }
        //3. sort the array of each sections
        var sections = [AnyObject]()
        for index in 0 ..< unsortedSections.count {
            sections.append(self.sortedArray(from: unsortedSections[index], collationStringSelector: collationStringSelector) as AnyObject)
        }
        return sections
    }
}

