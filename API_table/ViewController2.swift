//
//  ViewController2.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/24.
//

import UIKit

class ViewController2: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var teamTable: UITableView!
    let footballURL = "https://apiv3.apifootball.com/?action=get_teams&league_id=302&APIkey=42cd81facec04ac1a8321d9457890b72043b63281d7b83abff0673002ffbca0e"
    var footballData : [TeamElement]?
    
    var selectedTeam : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTable.rowHeight = 150
        teamTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        teamTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
//        var vC = ViewController.self
//        vC.getData()
        getData2()
        
    }
    
    func getData2() {
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
                            self.teamTable.reloadData()
                        } // 메인 스레드에서 playerTable을 reloadData한다.
                        guard let teamImgString = self.footballData?[0].teamBadge else {
                            print("getData : teamImgString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
                        guard let teamNameString = self.footballData?[0].teamName else {
                            print("getData : teamNameString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
                        guard let coachNameString = self.footballData?[0].coaches[0].coachName else {
                            print("getData : coachNameString = nil")
                            return
                        }
                        // 가드렛 문을 활용한 옵셔널 바인딩
//                        teamNameData = teamNameString
//                        coachNameData = coachNameString
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        var tCount = 20 // 기본 행의 개수를 20으로 설정
        if let playerCount = footballData?.count {
            tCount = playerCount
        }
        return tCount // 행의 개수를 footballData의 개수로 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        let teamCell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        teamCell.teamNameLbl.text = footballData?[indexPath.row].teamName
        teamCell.teamCoachLbl.text = footballData?[indexPath.row].coaches[0].coachName
        
        let teamImageUrlString = footballData?[indexPath.row].teamBadge
        var teamImage = "https://apiv3.apifootball.com/badges/jpg" // 사진이 없을 때 디폴트 이미지를 없는 값으로 설정
        if teamImageUrlString != nil && teamImageUrlString != ""{ // 데이터의 값이 nil값이 거나 "" 이 아닐 때 , 즉 데이터 값이 존재 할 때
            teamImage = teamImageUrlString!// imageUrlString에 데이터를 집어넣는다
        }
        let teamImageUrl = URL(string: teamImage) // imageUrl에 playerImage의 String형 정보를 받아와 URL 데이터로 전환 시켜준다.
        DispatchQueue.global().async {
            let teamImgData = try? Data(contentsOf: teamImageUrl!) //
            DispatchQueue.main.async {
                if teamImgData != nil {
                    teamCell.teamBadgeImg.image = UIImage(data: teamImgData! )
                }
            }
        }
        return teamCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 행을 클릭했을 때
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sendData = segue.destination as? ViewController else {
            return
        } // ViewController를 상속 받은 상수
        let teamIndexPath = teamTable.indexPathForSelectedRow // teamTable의 선택된 행의 정보를 상수 teamIndexPath에 저장
        let teamRow = teamIndexPath?.row //
        sendData.teamChoiceData = teamRow // ViewController에 teamChoiceData에 selectedTeam를 초기화
    }
}
