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
        
        roomNoLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Room # :",rooms.id ?? "-"))
        
        if rooms.isOccupied == true {
            occupancyStatusLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Occupancy Status :","Full" ))
            availabilityColor.backgroundColor = .red
        }else{
            occupancyStatusLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Occupancy Status :","Available"))
            availabilityColor.backgroundColor = .systemGreen
        }
        
        capacityLabel.attributedText = AppUtility.attributeTextBuilding(stringName: String(format:"%@ - %@","Capacity # :",String(rooms.maxOccupancy!) ))
        
    }
    

}
