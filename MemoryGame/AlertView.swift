//
//  AlertView.swift
//  MemoryGame
//
//  Created by Apps2T on 25/11/22.
//

import Foundation
import UIKit

class AlertView: UIView{
    
    static let instance = AlertView()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit(){
        image.layer.cornerRadius = 30
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 2
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType{
        case win
        case lose
    }
    
    func showAlert(title: String, message: String, alertType: AlertType){
        self.title.text = title
        self.message.text = message
        
        switch alertType {
        case .win:
            image.image = UIImage(named: "win")
        case .lose:
            image.image = UIImage(named: "lose")
        }
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
}
