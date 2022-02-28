//
//  ViewController3.swift
//  API_table
//
//  Created by MacBook Air on 2022/02/25.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBAction func leagueBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goLeague", sender: self)
    }
    @IBAction func teamBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goTeam", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
