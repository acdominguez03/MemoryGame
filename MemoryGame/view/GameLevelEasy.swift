//
//  GameLevelEasy.swift
//  MemoryGame
//
//  Created by Ismael Cordón Domínguez on 23/11/22.
//

import UIKit
import SCLAlertView

class GameLevelEasy: UIViewController{
    
    var images: [UIImage] = []
    var correctValues = [UIImage]()
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        images.shuffle()
        
        //CollectionView-1 drag and drop configuration
        self.collectionView1.dragInteractionEnabled = true
        self.collectionView1.dragDelegate = self
        self.collectionView1.dropDelegate = self
        self.collectionView1.reorderingCadence = .fast
        
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView === self.collectionView1
                {
                    self.images.remove(at: sourceIndexPath.row)
                    self.images.insert(item.dragItem.localObject as! UIImage, at: dIndexPath.row)
                }
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }
    
    
    
    @IBAction func checkOrder(_ sender: Any) {
        if(images == correctValues){
            SCLAlertView().showSuccess("You win", subTitle: "Congratulations you guess all the images").setDismissBlock {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Main") as? HomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            if let level = UserDefaults.standard.string(forKey: "Level")
            {
                if level == "easy", let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int? {
                    UserDefaults.standard.set(totalPunctuation + 50, forKey: "Punctuation")
                } else if level == "medium", let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int? {
                    UserDefaults.standard.set(totalPunctuation + 100, forKey: "Punctuation")
                } else if level == "hard", let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int? {
                    UserDefaults.standard.set(totalPunctuation + 200, forKey: "Punctuation")
                }
            }
        }else{
            SCLAlertView().showError("You lose", subTitle: "Sorry you are so bad").setDismissBlock {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Main") as? HomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            if let level = UserDefaults.standard.string(forKey: "Level")
            {
                if level == "easy", let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int? {
                    UserDefaults.standard.set(totalPunctuation - 200, forKey: "Punctuation")
                } else if level == "medium", let totalPunctuation = UserDefaults.standard.integer(forKey: "Punctuation") as Int? {
                    UserDefaults.standard.set(totalPunctuation - 10, forKey: "Punctuation")
                }
            }
        }
    }
}

extension GameLevelEasy : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.images.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.teacherPhoto.image = images[indexPath.row]
        cell.teacherPhoto.layer.cornerRadius = 20
        return cell
    }
}

extension GameLevelEasy : UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let item = self.images[indexPath.row]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem]
    {
        let item = self.images[indexPath.row]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        if collectionView == collectionView1
        {
            let previewParameters = UIDragPreviewParameters()
            previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 120, height: 120))
            return previewParameters
        }
        return nil
    }
}

extension GameLevelEasy : UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView === self.collectionView1
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
        else
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of table view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
            
        case .copy:
            break
            
        default:
            return
        }
    }
}
