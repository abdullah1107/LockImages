
import Foundation
struct CategoryData : Codable {
	let cOMPID : Int?
	let name : String?
	let name_Bangla : String?

	enum CodingKeys: String, CodingKey {

		case cOMPID = "COMPID"
		case name = "Name"
		case name_Bangla = "Name_Bangla"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cOMPID = try values.decodeIfPresent(Int.self, forKey: .cOMPID)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		name_Bangla = try values.decodeIfPresent(String.self, forKey: .name_Bangla)
	}

}
