//
//  AppUtility.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit
class AppUtility: NSObject {
    
    @objc class func attributeTextBuilding(stringName:String)-> NSAttributedString {
        
        let userInfo = stringName.components(separatedBy: "-")

        let splitOne    = userInfo[0]
        let splitTwo    = userInfo[1]
        
        let practiceNameAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Helvetica Neue Bold", size: IS_IPAD ? 18 : 14)]
        let providerNameLocationAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Helvetica Neue", size: IS_IPAD ? 20 : 15)]

        let partOne = NSMutableAttributedString(string: splitOne, attributes: practiceNameAttributes as [NSAttributedString.Key : Any])
        let partTwo = NSMutableAttributedString(string: splitTwo, attributes: providerNameLocationAttributes as [NSAttributedString.Key : Any])

        partOne.append(partTwo)
        
        return partOne
        
    }
    
    
    
}
