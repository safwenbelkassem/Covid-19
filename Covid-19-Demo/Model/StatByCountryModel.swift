// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let statByCountryModel = try? newJSONDecoder().decode(StatByCountryModel.self, from: jsonData)

import Foundation

struct StatByCountryModel: Codable {
    let country: Country
    let statByCountry: [StatByCountry]

    enum CodingKeys: String, CodingKey {
        case country
        case statByCountry = "stat_by_country"
    }
}

enum Country: String, Codable {
    case tunisia = "Tunisia"
}

// MARK: - StatByCountry
struct StatByCountry: Codable {
    let id: String
    let countryName: Country
    let totalCases, newCases, activeCases, totalDeaths: String
    let newDeaths, totalRecovered, seriousCritical: String
    let region: JSONNull?
    let totalCasesPer1M, recordDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case countryName = "country_name"
        case totalCases = "total_cases"
        case newCases = "new_cases"
        case activeCases = "active_cases"
        case totalDeaths = "total_deaths"
        case newDeaths = "new_deaths"
        case totalRecovered = "total_recovered"
        case seriousCritical = "serious_critical"
        case region
        case totalCasesPer1M = "total_cases_per1m"
        case recordDate = "record_date"
    }
}
