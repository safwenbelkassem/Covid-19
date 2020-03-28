// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let statByCountryModel = try? newJSONDecoder().decode(StatByCountryModel.self, from: jsonData)

import Foundation

// MARK: - StatByCountryModel
struct StatOfTheWorldModel: Codable {
    let totalCases, totalDeaths, totalRecovered, newCases: String
    let newDeaths, statisticTakenAt: String

    enum CodingKeys: String, CodingKey {
        case totalCases = "total_cases"
        case totalDeaths = "total_deaths"
        case totalRecovered = "total_recovered"
        case newCases = "new_cases"
        case newDeaths = "new_deaths"
        case statisticTakenAt = "statistic_taken_at"
    }
}
