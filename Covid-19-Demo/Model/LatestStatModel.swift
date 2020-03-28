//
//  Stat.swift
//  Covid-19-Demo
//
//  Created by MacBook on 3/25/20.
//  Copyright © 2020 MacBookSafwen. All rights reserved.
//

import Foundation

struct LatestStatModel: Codable {
    let country: String
    let latest_stat_by_country: [LatestStatByCountry]

   
}

// MARK: - LatestStatByCountry
struct LatestStatByCountry: Codable {
    let id, country_name, total_cases, new_cases: String
    let active_cases, total_deaths, new_deaths, total_recovered: String
    let serious_critical: String
    let region : JSONNull
    let total_cases_per1m, record_date: String

 
}
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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
