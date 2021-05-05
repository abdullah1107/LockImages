//
//  ChiefModel.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 14/12/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import Foundation
struct GetChiefModel: Codable {
    var message: String?
    var data: [GetChiefModelDatum]?
    var resultState: Bool?
    var sqlError: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
        case resultState = "ResultState"
        case sqlError = "SqlError"
    }
}

// MARK: - Datum
struct GetChiefModelDatum: Codable {
    var name, displayName, officeName: String?
    var personalID, oFficeID: Int?
    var designation, permanentAddress, presentAddress, officialMobileNo: String?
    var officialEMailID, pernonalEmail, personalContact, dateofBirth: String?
    var dateOfConfirmation, dateOfDptExam: String?
    var dateOfEncadrement: JSONNull?
    var dateOfEntryToGazettedPost: String?
    var dstCOMPID: Int?
    var drivingLicenseNo: JSONNull?
    var firstNameBangla, firstNameBangla1, lastName, nickName: String?
    var father, mother, empID, gender: String?
    var maritalStatus: String?
    var gazetted: Bool?
    var religion, eMailID, dateOfEntryToGazettedPost1, userName: String?
    var editor: String?
    var isRHDEmployee: Bool?
    var isFreedomFighter: JSONNull?
    var nationalID: String?
    var passportNo: JSONNull?
    var tin: String?

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
        case dstCOMPID = "Dst_COMPID"
        case drivingLicenseNo = "DrivingLicenseNo"
        case firstNameBangla = "FirstName_Bangla"
        case firstNameBangla1 = "FirstName_Bangla1"
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
        case tin = "TIN"
    }
}
