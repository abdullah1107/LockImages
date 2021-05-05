
import UIKit

struct User : Codable {
    
	let name : String?
	let displayName : String?
	let officeName : String?
	let personalID : Int?
	let oFficeID : Int?
	let designation : String?
	let permanentAddress : String?
	let presentAddress : String?
	let officialMobileNo : String?
	let officialEMailID : String?
	let pernonalEmail : String?
	let personalContact : String?
    let Dst_COMPID: Int?
    

	enum CodingKeys: String, CodingKey {

		case name = "Name"
		case displayName = "DisplayName"
		case officeName = "OfficeName"
		case personalID = "PersonalID"
		case oFficeID = "OFficeID"
		case designation = "Designation"
		case permanentAddress = "PermanentAddress"
		case presentAddress = "PresentAddress"
		case officialMobileNo = "OfficialMobileNo"
		case officialEMailID = "OfficialEMailID"
		case pernonalEmail = "PernonalEmail"
		case personalContact = "PersonalContact"
        case Dst_COMPID = "Dst_COMPID"
		
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
		officeName = try values.decodeIfPresent(String.self, forKey: .officeName)
		personalID = try values.decodeIfPresent(Int.self, forKey: .personalID)
		oFficeID = try values.decodeIfPresent(Int.self, forKey: .oFficeID)
		designation = try values.decodeIfPresent(String.self, forKey: .designation)
		permanentAddress = try values.decodeIfPresent(String.self, forKey: .permanentAddress)
		presentAddress = try values.decodeIfPresent(String.self, forKey: .presentAddress)
		officialMobileNo = try values.decodeIfPresent(String.self, forKey: .officialMobileNo)
		officialEMailID = try values.decodeIfPresent(String.self, forKey: .officialEMailID)
		pernonalEmail = try values.decodeIfPresent(String.self, forKey: .pernonalEmail)
		personalContact = try values.decodeIfPresent(String.self, forKey: .personalContact)
        Dst_COMPID = try values.decodeIfPresent(Int.self, forKey: .Dst_COMPID)
		
	}

}
