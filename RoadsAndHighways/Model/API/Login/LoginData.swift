
import UIKit

struct LoginData : Codable {
    
	let token : String?
	let user : [User]?

	enum CodingKeys: String, CodingKey {

		case token = "Token"
		case user = "User"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		user = try values.decodeIfPresent([User].self, forKey: .user)
	}
}
