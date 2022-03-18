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
        
        userName.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Person Name :",people.fullName ?? "-"))
        email.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Email :",people.email ?? "-"))
        jobtitle.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Job Title :",people.jobtitle ?? "-"))
        favouriteColor.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Favourite Color :",people.favouriteColor?.capitalized ?? "-"))
        
        displayImage.downloadImage(urlString: people.avatar!)
        
//     let data = try? Data(contentsOf: URL(string:people.avatar!)!)
//        DispatchQueue.main.async {
//            if let imageData = data {
//                let image = UIImage(data: imageData)
//                self.displayImage.image = image
//            }
//        }
        
    }

}
