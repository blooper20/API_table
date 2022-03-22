//
//  ViewController2.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/24.
//

import UIKit

class ViewController2: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var teamTable: UITableView!
//    @IBOutlet weak var teamCell: UIView!
    
    
    var selectedTeam : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        teamTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        return 5 // 행의 개수를 5로 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        let teamCell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        teamCell.teamNameLbl.text = indexPath.description
        return teamCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 행을 클릭했을 때
        selectedTeam = indexPath.row
        guard let teamIndex = selectedTeam else {
            return
        }
        print("didSelectRowAt 안에 있는 selectedTeam : \(teamIndex)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sendData = segue.destination as? ViewController else {
            return
        }
        guard let selectedTeamCell = sender as? TeamTableViewCell else {
            return
        }
//        let indexPath = tableView.indexPathForCell(selectedTeamCell)!
        sendData.teamChoiceData = selectedTeam
        print("프리페어 안에 있는 selectedTeam : \(sendData.teamChoiceData)")
    }
}
