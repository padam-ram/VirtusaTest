

import Foundation
struct People : Codable {
	let createdAt : String?
	let firstName : String?
	let avatar : String?
	let lastName : String?
	let email : String?
	let jobtitle : String?
	let favouriteColor : String?
	let id : String?
    var fullName : String?

	enum CodingKeys: String, CodingKey {

		case createdAt = "createdAt"
		case firstName = "firstName"
		case avatar = "avatar"
		case lastName = "lastName"
		case email = "email"
		case jobtitle = "jobtitle"
		case favouriteColor = "favouriteColor"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		jobtitle = try values.decodeIfPresent(String.self, forKey: .jobtitle)
		favouriteColor = try values.decodeIfPresent(String.self, forKey: .favouriteColor)
		id = try values.decodeIfPresent(String.self, forKey: .id)        
        var finalName = String()
        if self.firstName != nil  &&
            self.firstName!.count > 0 {
            finalName.append(self.firstName!)
        }
        if self.lastName != nil  &&
            self.lastName!.count > 0 {
            if finalName.count > 0 {
                finalName.append(" ")
                finalName.append(self.lastName!)
            }else{
                finalName.append(self.lastName!)
            }
        }
        self.fullName = finalName
	}

}
