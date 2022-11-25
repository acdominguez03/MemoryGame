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
    private var finalImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomImage.layer.cornerRadius = 20
        
        let randomNumber = Int.random(in: 0...3)
        self.randomImage.image = self.images[randomNumber]
        self.finalImages.append(self.images[randomNumber])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let randomNumber = Int.random(in: 0...3)
            UIView.transition(with: self.randomImage,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.randomImage.image = self.images[randomNumber]
            }, completion: nil)
            self.finalImages.append(self.images[randomNumber])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let randomNumber = Int.random(in: 0...3)
            UIView.transition(with: self.randomImage,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.randomImage.image = self.images[randomNumber]
            }, completion: nil)
            self.finalImages.append(self.images[randomNumber])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let randomNumber = Int.random(in: 0...3)
            UIView.transition(with: self.randomImage,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.randomImage.image = self.images[randomNumber]
            }, completion: nil)
            self.finalImages.append(self.images[randomNumber])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinishLevelEasy") as? GameLevelEasy
            vc?.images = self.finalImages
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
}
