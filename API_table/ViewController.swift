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
    @IBOutlet weak var teamNameLbl: UILabel!
    @IBOutlet weak var teamCoachLbl: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    let footballURL = "https://apiv3.apifootball.com/?action=get_teams&league_id=302&APIkey=42cd81facec04ac1a8321d9457890b72043b63281d7b83abff0673002ffbca0e"
    var footballData : [TeamElement]?
    // TeamElement형 프로퍼티를 만든다
    
    var teamNameData : String?
    var coachNameData : String?
    
    var teamChoiceData : Int? // ViewController2에서 받아온 선택한 행의 정보를 받아와서 저장하는 변수 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        playerTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        
        guard let teamData = teamChoiceData else {
            print("teamData = nil")
            return
        }// ViewController2에서 넘어온 클릭한 행의 인덱스 정보를 가진 변수를 옵셔널 바인딩함
        print("넘어온 인덱싱 정보 : \(teamData)")
        
        getData() // API를 호출하여 디코딩하는 함수 호출
        let teamNameString = self.footballData?[teamData].teamName
        let coachNameString = self.footballData?[teamData].coaches[0].coachName
        teamNameLbl.text = teamNameData ?? "팀 이름"
        teamCoachLbl.text = coachNameData ?? "감독이름"
        
        let teamImgUrl: URL! = URL(string: "https://apiv3.apifootball.com/badges/")
        let teamImageData = try! Data(contentsOf: teamImgUrl!)
        teamImg.image = UIImage(data: teamImageData)
    }
    
    func getData() {
        guard let teamData = teamChoiceData else {
            print("teamData = nil")
            return
        }// ViewController2에서 넘어온 클릭한 행의 인덱스 정보를 가진 변수를 옵셔널 바인딩함
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
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode([TeamElement].self, from: JSONdata)
                        // JSONdata인 [TeamElement]를 디코딩 하여 decodedData에 저장
                        self.footballData = decodedData    // TeamElement형 프로퍼티에 decodedData 저장
                        DispatchQueue.main.async {
                            self.playerTable.reloadData()
                        } // 메인 스레드에서 playerTable을 reloadData한다.
                        
                        guard let teamImgString = self.footballData?[teamData].teamBadge else {
                            print("getData : teamImgString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
                        guard let teamNameString = self.footballData?[teamData].teamName else {
                            print("getData : teamNameString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
                        guard let coachNameString = self.footballData?[teamData].coaches[0].coachName else {
                            print("getData : coachNameString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
                        teamNameData = teamNameString
                        coachNameData = coachNameString
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        var pCount = 10 // 기본 행의 개수를 10을 설정
        if let teamData = teamChoiceData {
            if let playerCount = footballData?[teamData].players.count {
                pCount = playerCount
            }
        }
        return pCount // 행의 개수를 플레이어 수 만큼 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        
        let plCell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        
        
        if let td = teamChoiceData { // 넘어온 인덱싱 정보를 옵셔널바인딩
            plCell.playerNameLbl.text = footballData?[td].players[indexPath.row].playerName
            plCell.playerRatingLbl.text = footballData?[td].players[indexPath.row].playerRating
            plCell.playerAgeLbl.text = footballData?[td].players[indexPath.row].playerAge
            plCell.playerNOLbl.text = footballData?[td].players[indexPath.row].playerNumber
            let playerPos = footballData?[td].players[indexPath.row].playerType.rawValue // 옵셔널을 풀기위한 상수 선언
            plCell.playerPosLbl.text = playerPos
            let imageUrlString = footballData?[td].players[indexPath.row].playerImage // imageUrlString 값에 데이터 파싱한 값을 넣는다.
            let teamImageUrlString = footballData?[td].teamBadge
            var playerImage = "https://apiv3.apifootball.com/badges/jpg"
            var teamImage = "https://apiv3.apifootball.com/badges/jpg" // 사진이 없을 때 디폴트 이미지를 없는 값으로 설정
            
            if imageUrlString != nil && imageUrlString != ""{ // 데이터의 값이 nil값이 거나 "" 이 아닐 때 , 즉 데이터 값이 존재 할 때
                playerImage = imageUrlString!// imageUrlString에 데이터를 집어넣는다
            }
            if teamImageUrlString != nil && teamImageUrlString != ""{ // 데이터의 값이 nil값이 거나 "" 이 아닐 때 , 즉 데이터 값이 존재 할 때
                teamImage = teamImageUrlString!// imageUrlString에 데이터를 집어넣는다
            }
            let imageUrl = URL(string: playerImage) // imageUrl에 playerImage의 String형 정보를 받아와 URL 데이터로 전환 시켜준다.
            let teamImageUrl = URL(string: teamImage) // imageUrl에 playerImage의 String형 정보를 받아와 URL 데이터로 전환 시켜준다.
            DispatchQueue.global().async {
                let imgData = try? Data(contentsOf: imageUrl!) //
                let teamImgData = try? Data(contentsOf: teamImageUrl!) //
                
                DispatchQueue.main.async {
                    if imgData != nil {
                        plCell.playerImg.image = UIImage(data: imgData! )
                        
                        self.teamNameLbl.text = self.teamNameData ?? "팀 이름"
                        self.teamCoachLbl.text = self.coachNameData ?? "감독이름"
                        // nil 합병 연산자로 teamNameData,coachNameData의 값이 nil일 때 기본적으로 출력될 문구 설정
                        self.teamImg.image = UIImage(data: teamImgData!)
                        // 뷰 컨트롤러에 있는 이미지, 라벨들을 다시 설정해준다.
                    }
                }
            }
        }
        return plCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행되기 직전에 자동으로 호출되는 메서드
        guard let dest = segue.destination as? PlayerWebViewController else {
            return
        }
        let playerIndexPath = playerTable.indexPathForSelectedRow!
        let playerRow = playerIndexPath.row
        guard let teamData = teamChoiceData else {
            print("teamData = nil")
            return
        }// ViewController2에서 넘어온 클릭한 행의 인덱스 정보를 가진 변수를 옵셔널 바인딩함
        dest.playerName = (footballData?[teamData].players[playerRow].playerName)!
    }
}
