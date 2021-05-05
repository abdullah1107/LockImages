//
//  designation.swift
//  RoadsAndHighways
//
//  Created by AL Mustakim on 13/12/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import Foundation
struct designation: Codable {
    var message: JSONNull?
    var data: [Datum]?
    var resultState: Bool?
    var sqlError: JSONNull?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
        case resultState = "ResultState"
        case sqlError = "SqlError"
    }
}

// MARK: - Datum
struct Datum: Codable {
    var datumDescription: String?
    var compid: Int?

    enum CodingKeys: String, CodingKey {
        case datumDescription = "Description"
        case compid = "COMPID"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

