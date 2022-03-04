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
    init(from decoder: Decoder) throws {
           // 1 - container 생성
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           // 2 - 일반적인 디코딩
           teamKey = try container.decode(String.self, forKey: .teamKey)
           teamName = try container.decode(String.self, forKey: .teamName)
           teamBadge = try container.decode(String.self, forKey: .teamBadge)
           // players = try container.decode(String.self, forKey: .players)
           // coaches = try container.decode(String.self, forKey: .coaches )
           // let players = try container.self([Player].self, from: data)
       }
}

// MARK: - Coach
struct Coach: Codable {
    let coachName, coachCountry, coachAge: String
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
    
    
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int
    let playerID: String
    let playerImage: String
    let playerName, playerNumber, playerCountry: String
    let playerType: PlayerType
    let playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String
    let playerRedCards: String
    let playerInjured: PlayerInjured
    let playerSubstituteOut, playerSubstitutesOnBench, playerAssists, playerIsCaptain: String
    let playerShotsTotal, playerGoalsConceded, playerFoulsCommitted, playerTackles: String
    let playerBlocks, playerCrossesTotal, playerInterceptions, playerClearances: String
    let playerDispossesed, playerSaves, playerInsideBoxSaves, playerDuelsTotal: String
    let playerDuelsWon, playerDribbleAttempts, playerDribbleSucc, playerPenComm: String
    let playerPenWon, playerPenScored, playerPenMissed, playerPasses: String
    let playerPassesAccuracy, playerKeyPasses, playerWoordworks, playerRating: String
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerID = "player_id"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerInjured = "player_injured"
        case playerSubstituteOut = "player_substitute_out"
        case playerSubstitutesOnBench = "player_substitutes_on_bench"
        case playerAssists = "player_assists"
        case playerIsCaptain = "player_is_captain"
        case playerShotsTotal = "player_shots_total"
        case playerGoalsConceded = "player_goals_conceded"
        case playerFoulsCommitted = "player_fouls_committed"
        case playerTackles = "player_tackles"
        case playerBlocks = "player_blocks"
        case playerCrossesTotal = "player_crosses_total"
        case playerInterceptions = "player_interceptions"
        case playerClearances = "player_clearances"
        case playerDispossesed = "player_dispossesed"
        case playerSaves = "player_saves"
        case playerInsideBoxSaves = "player_inside_box_saves"
        case playerDuelsTotal = "player_duels_total"
        case playerDuelsWon = "player_duels_won"
        case playerDribbleAttempts = "player_dribble_attempts"
        case playerDribbleSucc = "player_dribble_succ"
        case playerPenComm = "player_pen_comm"
        case playerPenWon = "player_pen_won"
        case playerPenScored = "player_pen_scored"
        case playerPenMissed = "player_pen_missed"
        case playerPasses = "player_passes"
        case playerPassesAccuracy = "player_passes_accuracy"
        case playerKeyPasses = "player_key_passes"
        case playerWoordworks = "player_woordworks"
        case playerRating = "player_rating"
    }
}

enum PlayerInjured: String, Codable {
    case no = "No"
    case yes = "Yes"
}

enum PlayerType: String, Codable {
    case defenders = "Defenders"
    case forwards = "Forwards"
    case goalkeepers = "Goalkeepers"
    case midfielders = "Midfielders"
}

