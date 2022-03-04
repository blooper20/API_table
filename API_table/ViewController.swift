//
//  ViewController.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/03.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var playerTable: UITableView! // 관심 팀의 플레이어 테이블을 playerTable로 선언
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerCountryLbl: UILabel!
    @IBOutlet weak var playerRatingLbl: UILabel!
    @IBOutlet weak var playerAgeLbl: UILabel!
    @IBOutlet weak var playerBackNumberLbl: UILabel!
    @IBOutlet weak var playerPositionLbl: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        playerTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        API()
        
    }

    let player:[String] = ["playerImage","playerName","playerNumber","playerCountry","playerAge","playerRating","playerType"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        
        return self.player.count // 행의 개수를 5로 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        
        let plCell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        plCell.playerNameLbl.text = TeamElement.CodingKeys.teamName.stringValue
        return plCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 행을 클릭했을 때
        performSegue(withIdentifier: "leagueToTeam", sender: self)
        // cell을 클릭했을 때 leagueToTeam Segue로 이동하고 보내는 값은 self로 처리한다.
    }


}

