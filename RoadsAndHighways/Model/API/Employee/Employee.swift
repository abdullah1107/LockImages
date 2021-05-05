

import Foundation
struct Employee : Codable {
	let message : String?
	let data : [EmployeeData]?
	let resultState : Bool?
	let sqlError : String?

	enum CodingKeys: String, CodingKey {

		case message = "Message"
		case data = "Data"
		case resultState = "ResultState"
		case sqlError = "SqlError"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		data = try values.decodeIfPresent([EmployeeData].self, forKey: .data)
		resultState = try values.decodeIfPresent(Bool.self, forKey: .resultState)
		sqlError = try values.decodeIfPresent(String.self, forKey: .sqlError)
	}

}
