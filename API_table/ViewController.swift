//
//  ViewController.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/03.
//

import UIKit
import Foundation


// MARK: - TeamElement
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

typealias Team = [TeamElement]



class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerTable: UITableView! // 관심 팀의 플레이어 테이블을 playerTable로 선언
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerCountryLbl: UILabel!
    @IBOutlet weak var playerRatingLbl: UILabel!
    @IBOutlet weak var playerAgeLbl: UILabel!
    @IBOutlet weak var playerNOLbl: UILabel!
    @IBOutlet weak var playerPosLbl: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    
    let footballURL = "https://apiv3.apifootball.com/?action=get_teams&league_id=302&APIkey=42cd81facec04ac1a8321d9457890b72043b63281d7b83abff0673002ffbca0e"
    
    var footballData : [TeamElement]?
    // TeamElement형 프로퍼티를 만든다
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        playerTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        getData() // API를 호출하여 디코딩하는 함수 호출
        
        
    }
    //    let decoder = JSONDecoder()
    //    let product = try decoder.decode(TeamElement.self, from: )
    
    func getData() {
        if let url = URL(string: footballURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data {
                    print(JSONdata)
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    //                    print(dataString!)
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode([TeamElement].self, from: JSONdata)
                        // JSONdata인 [TeamElement]를 디코딩 하여 decodedData에 저장
                        //                        print(decodedData[0].players[0].playerName)
                        //                        print(decodedData[0].players[0].playerAge)
                        self.footballData = decodedData    // TeamElement형 프로퍼티에 decodedData 저장
                        
                        DispatchQueue.main.async {
                            self.playerTable.reloadData()
                        } // 메인 스레드에서 playerTable을 reloadData한다.
                        
//                        print(self.footballData![0].players[0].playerAge)
//                        print(self.footballData![0].players[0].playerImage)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        return 40 // 행의 개수를 5로 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        
        let plCell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        plCell.playerNameLbl.text = footballData?[0].players[indexPath.row].playerName
        plCell.playerCountryLbl.text = footballData?[0].players[indexPath.row].playerCountry
        plCell.playerRatingLbl.text = footballData?[0].players[indexPath.row].playerRating
        plCell.playerAgeLbl.text = footballData?[0].players[indexPath.row].playerAge
        plCell.playerNOLbl.text = footballData?[0].players[indexPath.row].playerNumber
        //        plCell.playerPosLbl.text = footballData?[0].players[indexPath.row].playerType
        
//        let imageUrl = URL(string: "\(footballData?[0].players[indexPath.row].playerImage)")
//        let imgData = try Data(contentsOf: imageUrl!)
//        plCell.playerImg.image = UIImage(data: imgData)
        
        plCell.playerImg.image = UIImage(named: "\(footballData?[0].players[indexPath.row].playerImage)")
        return plCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 행을 클릭했을 때
        performSegue(withIdentifier: "leagueToTeam", sender: self)
        // cell을 클릭했을 때 leagueToTeam Segue로 이동하고 보내는 값은 self로 처리한다.
    }
    
    
}
