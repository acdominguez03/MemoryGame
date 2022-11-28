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
        
        if let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int?
        {
            punctuation.text = "Punctuation : \(totalPunctuation)"
        }else{
            UserDefaults.standard.set(0, forKey: "Punctuation")
        }
    }
    
    @IBOutlet weak var punctuation: UILabel!
    
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

