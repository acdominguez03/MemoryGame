//
//  EasyMode.swift
//  MemoryGame
//
//  Created by Apps2T on 18/11/22.
//

import Foundation
import UIKit


class EasyModeController: UIViewController{
    
    
    @IBOutlet weak var randomImage: UIImageView!
    
    private let images = [#imageLiteral(resourceName: "delfin"), #imageLiteral(resourceName: "julian"), #imageLiteral(resourceName: "juanlu"), #imageLiteral(resourceName: "daniel")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomImage.layer.cornerRadius = 20
        
        
        self.randomImage.image = self.images[Int.random(in: 0...3)]
           
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.randomImage,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: {
                                        self.randomImage.image = self.images[Int.random(in: 0...3)]
                    }, completion: nil)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.transition(with: self.randomImage,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: {
                                        self.randomImage.image = self.images[Int.random(in: 0...3)]
                    }, completion: nil)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            UIView.transition(with: self.randomImage,
                                        duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: {
                                        self.randomImage.image = self.images[Int.random(in: 0...3)]
                    }, completion: nil)
            
        }
        
        
    }
    
    
}
