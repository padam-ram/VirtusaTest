//
//  Constant.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import Foundation
import UIKit


let kBaseURL   = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
let kPeople    = "people"
let kRooms     = "rooms"

let appColor = UIColor(rgb: 0xC40202)

let IS_IPAD = (UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiom.pad) ? true : false
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone ? true : false
