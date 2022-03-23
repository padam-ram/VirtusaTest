//
//  PeopleTableViewCell.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var jobtitle:UILabel!
    @IBOutlet weak var favouriteColor:UILabel!
    @IBOutlet weak var displayImage:UIImageView!
    
    class var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(people:People){
        
        var finalName = String()
        
        if people.firstName != nil  && people.firstName!.count > 0 {
            finalName.append(people.firstName!)
        }
        if people.lastName != nil  && people.lastName!.count > 0 {
        if finalName.count > 0 {
            finalName.append(" ")
            finalName.append(people.lastName!)
        }else{
             finalName.append(people.lastName!)
           }
        }
        
        userName.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Person Name :",finalName))
        
        if let emailId = people.email {
            email.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Email :",emailId))
        }
        
        if let jobTitle = people.jobtitle {
            jobtitle.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Job Title :",jobTitle))
        }
        
        if let favColor = people.favouriteColor {
            favouriteColor.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Favourite Color :",favColor.capitalized))
        }
        
        if let personimg = people.avatar {
            displayImage.downloadImage(urlString: personimg)
        }
        
        
        
        
        
    }

}
