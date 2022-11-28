//
//  HomeViewController.swift
//  MemoryGame
//
//  Created by Apps2T on 28/11/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if let totalScore = UserDefaults.standard.integer(forKey: "Score") as Int?
        {
            score.text = "Score : \(totalScore)"
        }else{
            UserDefaults.standard.set(0, forKey: "Score")
        }
    }
    
    @IBOutlet weak var score: UILabel!
    
    @IBAction func easy(_ sender: Any) {
        UserDefaults.standard.set("easy", forKey: "Level")
    }
    
    @IBAction func medium(_ sender: Any) {
        UserDefaults.standard.set("medium", forKey: "Level")
    }
    
    @IBAction func hard(_ sender: Any) {
        UserDefaults.standard.set("hard", forKey: "Level")
    }
}

