/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ChefDataDetails : Codable {
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
	let dateofBirth : String?
	let dateOfConfirmation : String?
	let dateOfDptExam : String?
	let dateOfEncadrement : String?
	let dateOfEntryToGazettedPost : String?
	let dst_COMPID : Int?
	let drivingLicenseNo : String?
	let firstName_Bangla : String?
	let firstName_Bangla1 : String?
	let lastName : String?
	let nickName : String?
	let father : String?
	let mother : String?
	let empID : String?
	let gender : String?
	let maritalStatus : String?
	let gazetted : Bool?
	let religion : String?
	let eMailID : String?
	let dateOfEntryToGazettedPost1 : String?
	let userName : String?
	let editor : String?
	let isRHDEmployee : Bool?
	let isFreedomFighter : String?
	let nationalID : String?
	let passportNo : String?
	let tIN : String?

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
		case dateofBirth = "DateofBirth"
		case dateOfConfirmation = "DateOfConfirmation"
		case dateOfDptExam = "DateOfDptExam"
		case dateOfEncadrement = "DateOfEncadrement"
		case dateOfEntryToGazettedPost = "DateOfEntryToGazettedPost"
		case dst_COMPID = "Dst_COMPID"
		case drivingLicenseNo = "DrivingLicenseNo"
		case firstName_Bangla = "FirstName_Bangla"
		case firstName_Bangla1 = "FirstName_Bangla1"
		case lastName = "LastName"
		case nickName = "NickName"
		case father = "Father"
		case mother = "Mother"
		case empID = "EmpID"
		case gender = "Gender"
		case maritalStatus = "MaritalStatus"
		case gazetted = "Gazetted"
		case religion = "Religion"
		case eMailID = "EMailID"
		case dateOfEntryToGazettedPost1 = "DateOfEntryToGazettedPost1"
		case userName = "UserName"
		case editor = "Editor"
		case isRHDEmployee = "IsRHDEmployee"
		case isFreedomFighter = "IsFreedomFighter"
		case nationalID = "NationalID"
		case passportNo = "PassportNo"
		case tIN = "TIN"
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
		dateofBirth = try values.decodeIfPresent(String.self, forKey: .dateofBirth)
		dateOfConfirmation = try values.decodeIfPresent(String.self, forKey: .dateOfConfirmation)
		dateOfDptExam = try values.decodeIfPresent(String.self, forKey: .dateOfDptExam)
		dateOfEncadrement = try values.decodeIfPresent(String.self, forKey: .dateOfEncadrement)
		dateOfEntryToGazettedPost = try values.decodeIfPresent(String.self, forKey: .dateOfEntryToGazettedPost)
		dst_COMPID = try values.decodeIfPresent(Int.self, forKey: .dst_COMPID)
		drivingLicenseNo = try values.decodeIfPresent(String.self, forKey: .drivingLicenseNo)
		firstName_Bangla = try values.decodeIfPresent(String.self, forKey: .firstName_Bangla)
		firstName_Bangla1 = try values.decodeIfPresent(String.self, forKey: .firstName_Bangla1)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		nickName = try values.decodeIfPresent(String.self, forKey: .nickName)
		father = try values.decodeIfPresent(String.self, forKey: .father)
		mother = try values.decodeIfPresent(String.self, forKey: .mother)
		empID = try values.decodeIfPresent(String.self, forKey: .empID)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		maritalStatus = try values.decodeIfPresent(String.self, forKey: .maritalStatus)
		gazetted = try values.decodeIfPresent(Bool.self, forKey: .gazetted)
		religion = try values.decodeIfPresent(String.self, forKey: .religion)
		eMailID = try values.decodeIfPresent(String.self, forKey: .eMailID)
		dateOfEntryToGazettedPost1 = try values.decodeIfPresent(String.self, forKey: .dateOfEntryToGazettedPost1)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		editor = try values.decodeIfPresent(String.self, forKey: .editor)
		isRHDEmployee = try values.decodeIfPresent(Bool.self, forKey: .isRHDEmployee)
		isFreedomFighter = try values.decodeIfPresent(String.self, forKey: .isFreedomFighter)
		nationalID = try values.decodeIfPresent(String.self, forKey: .nationalID)
		passportNo = try values.decodeIfPresent(String.self, forKey: .passportNo)
		tIN = try values.decodeIfPresent(String.self, forKey: .tIN)
	}

}
