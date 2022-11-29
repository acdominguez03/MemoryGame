//
//  EasyMode.swift
//  MemoryGame
//
//  Created by Apps2T on 18/11/22.
//

import Foundation
import UIKit

class ImagesViewController: UIViewController{
    
    @IBOutlet weak var randomImage: UIImageView!
    
    private let images:[UIImage] = [#imageLiteral(resourceName: "daniel"), #imageLiteral(resourceName: "julian"), #imageLiteral(resourceName: "delfin"), #imageLiteral(resourceName: "juanlu"), #imageLiteral(resourceName: "david"), #imageLiteral(resourceName: "jessica"), #imageLiteral(resourceName: "eva"), #imageLiteral(resourceName: "fol")]
    private var finalImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomImage.layer.cornerRadius = 20
        
        let randomNumber = self.getRandonImage(images: self.images)
        self.randomImage.image = self.images[randomNumber]
        self.finalImages.append(self.images[randomNumber])
        
        
        if let level = UserDefaults.standard.string(forKey: "Level")
        {
            if level == "easy" {
                changeImage(time: 0.5)
                changeImage(time: 1.25)
                changeImage(time: 2)
                
                navigateToFinal(time: 2.5)
            } else if level == "medium" {
                changeImage(time: 0.5)
                changeImage(time: 1)
                changeImage(time: 1.5)
                changeImage(time: 2)
                changeImage(time: 2.5)
                
                navigateToFinal(time: 3)
            } else if level == "hard" {
                changeImage(time: 0.4)
                changeImage(time: 0.8)
                changeImage(time: 1.2)
                changeImage(time: 1.6)
                changeImage(time: 2)
                changeImage(time: 2.4)
                changeImage(time: 2.8)
                
                navigateToFinal(time: 3.2)
            }
        }
         
    }
    
    private func changeImage(time: TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            let randomNumber = self.getRandonImage(images: self.images)
            UIView.transition(with: self.randomImage,
                              duration: 0.25,
                              options: .transitionCurlUp,
                              animations: {
                self.randomImage.image = self.images[randomNumber]
            }, completion: nil)
            self.finalImages.append(self.images[randomNumber])
        }
    }
    
    private func getRandonImage(images: [UIImage]) -> Int{
        return Int.random(in: 0...images.count - 1)
    }
    
    private func navigateToFinal(time: TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinishLevelEasy") as? GameViewController
            vc?.images = self.finalImages
            vc?.correctValues = self.finalImages
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    

}
