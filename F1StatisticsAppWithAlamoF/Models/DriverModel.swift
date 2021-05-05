//
//  DriverModel.swift
//  F1StatisticsAppWithAlamoF
//
//  Created by Mac on 04.05.2021.
//


// MARK: - Welcome
struct Welcome: Codable {
    let mrData: MRData?

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct MRData: Codable {
    let xmlns: String?
    let series: String?
    let url: String?
    let limit, offset, total: String?
    let standingsTable: StandingsTable?

    enum CodingKeys: String, CodingKey {
        case xmlns, series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct StandingsTable: Codable {
    let season: String?
    let standingsLists: [StandingsList]?

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct StandingsList: Codable {
    let season, round: String?
    let driverStandings: [DriverStanding]?

    enum CodingKeys: String, CodingKey {
        case season, round
        case driverStandings = "DriverStandings"
    }
}

// MARK: - DriverStanding
struct DriverStanding: Codable {
    let position, positionText, points, wins: String?
    let driver: Driver?
    let constructors: [Constructor]?

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorID: String?
    let url: String?
    let name, nationality: String?

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url, name, nationality
    }
}

// MARK: - Driver
struct Driver: Codable {
    let driverID: String?
    let permanentNumber: String?
    let code: String?
    let url: String?
    let givenName, familyName, dateOfBirth, nationality: String?

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }
}
