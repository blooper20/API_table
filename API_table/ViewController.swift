//
//  ViewController.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/03.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var playerTable: UITableView! // 관심 팀의 플레이어 테이블을 playerTable로 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.dataSource = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
        playerTable.delegate = self //playerTable의 dataSorce는 이 클래스 안에서 처리한다.
       
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 섹션 관련 함수
        return 5 // 행의 개수를 5로 지정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 행 관련 함수
        let plCell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        // cell의 아이디가 "playerCell"인 것을 사용
        plCell.playerNameLbl.text = indexPath.description
        return plCell
    }
    

   

}

