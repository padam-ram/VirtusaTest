//
//  RoomsTableViewCell.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomNoLabel:UILabel!
    @IBOutlet weak var occupancyStatusLabel:UILabel!
    @IBOutlet weak var capacityLabel:UILabel!
    @IBOutlet weak var availabilityColor:UIView!
        
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
    
    func bindData(rooms:Rooms){
        
        if let roomId = rooms.id {
            roomNoLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Room # :",roomId))
        }
        
        if let status = rooms.isOccupied {
            
            if status == true {
                occupancyStatusLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Occupancy Status :","Full" ))
                availabilityColor.backgroundColor = .red
            }else{
                occupancyStatusLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Occupancy Status :","Available"))
                availabilityColor.backgroundColor = .systemGreen
            }
        }
        
        if let capacity = rooms.maxOccupancy {
        capacityLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Capacity # :",String(capacity) ))
        }
    }
    

}
