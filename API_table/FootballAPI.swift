//
//  FootBallAPI.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/28.
//
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

func API() {
    let semaphore = DispatchSemaphore (value: 0)
    let Key = "42cd81facec04ac1a8321d9457890b72043b63281d7b83abff0673002ffbca0e"
    var request = URLRequest(url: URL(string: "https://apiv3.apifootball.com/?action=get_teams&league_id=302&APIkey=\(Key)")!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
        }
        print(String(data: data, encoding: .utf8)!)
        semaphore.signal()
    }
    task.resume()
    semaphore.wait()
}

struct TeamElement: Codable {
    let teamKey, teamName: String
    let teamBadge: String
    let players: [Player]
    let coaches: [Coach]
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamBadge = "team_badge"
        case players, coaches
    }
//    init(from decoder: Decoder) throws {
//        do {
//            // 1 - container 생성
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            // 2 - 일반적인 디코딩
//            teamKey = try container.decode(String.self, forKey: .teamKey)
//            teamName = try container.decode(String.self, forKey: .teamName)
//            teamBadge = try container.decode(String.self, forKey: .teamBadge)
//            players = try container.decode(Array.self, forKey: .players)
//            coaches = try container.decode(Array.self, forKey: .coaches )
//        } catch{
//            print(error)
//        }
//    }
}

// MARK: - Coach
struct Coach: Codable {
    let coachName: String
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // 1 - container 생성
//        coachName = try container.decode(String.self, forKey: .coachName)
//        // 2 - 일반적인 디코딩
//    }
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int
    let playerID: String
    let playerImage: String
    let playerName, playerNumber, playerCountry: String
    let playerType: PlayerType
    let playerAge : String
    let playerIsCaptain: String
    let playerRating: String
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerID = "player_id"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerIsCaptain = "player_is_captain"
        case playerRating = "player_rating"
    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // 1 - container 생성
//        playerKey = try container.decode(Int.self, forKey: .playerKey)
//        playerID = try container.decode(String.self, forKey: .playerID)
//        playerImage = try container.decode(String.self, forKey: .playerImage)
//        playerName = try container.decode(String.self, forKey: .playerName)
//        playerNumber = try container.decode(String.self, forKey: .playerNumber)
//        playerCountry = try container.decode(String.self, forKey: .playerCountry)
//        //playerType = try container.decode(PlayerType.self), forKey: .playerType)
//        //self.player = PlayerType(rawValue: playerType)
//        playerAge = try container.decode(String.self, forKey: .playerAge)
//        playerIsCaptain = try container.decode(String.self, forKey: .playerIsCaptain)
//        playerRating = try container.decode(String.self, forKey: .playerRating)
//        // playerType = try container.decode(String.self, forKey: .playerType)
//        // 2 - 일반적인 디코딩
//    }
    
    enum PlayerType: String, Codable {
        case defenders = "Defenders"
        case forwards = "Forwards"
        case goalkeepers = "Goalkeepers"
        case midfielders = "Midfielders"
    }
    //    init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: PlayerType.self)
    //         1 - container 생성
    //        defenders = try container.decode(String.self, forKey: .defenders)
    //        forwards = try container.decode(String.self, forKey: .forwards)
    //        goalkeepers = try container.decode(String.self, forKey: .goalkeepers)
    //        midfielders = try container.decode(String.self, forKey: .midfielders)
    //          2 - 일반적인 디코딩
    //    }
}
