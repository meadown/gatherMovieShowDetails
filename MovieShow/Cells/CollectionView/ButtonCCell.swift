//
//  ButtonCCell.swift
//  MovieShow
//
//  Created by Danyal on 10/08/2021.
//

import UIKit

class ButtonCCell: UICollectionViewCell {

    @IBOutlet weak var btnRecent: RoundFillBtn!
    @IBOutlet weak var btnOnAir: RoundFillBtn!
    @IBOutlet weak var btnPopular: RoundFillBtn!
    
    @IBOutlet weak var btnTopRated: RoundFillBtn!
    
    @IBOutlet weak var stackView: UIStackView!
    var btnPressed : ((_ tag : Int, _ isReload : Bool)->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnOnAir.btnIsSelected = true
        
    }
    func configureData(tag : Int){
        if tag == 1{
            btnRecent.btnIsSelected = true
        }else if tag == 2{
            btnOnAir.btnIsSelected = true
        }else if tag == 3{
            btnPopular.btnIsSelected = true
        }else if tag == 4{
            btnTopRated.btnIsSelected = true
        }
        
        if Constants.movieOrTV == "tv"{
            btnOnAir.setTitle("On Air", for: .normal)
            btnOnAir.setTitle("On Air", for: .selected)
        }else{
            btnOnAir.setTitle("Upcoming", for: .normal)
            btnOnAir.setTitle("Upcoming", for: .selected)
        }

    }

    @IBAction func btnPressed(_ sender: RoundFillBtn) {
        
        if sender.isSelected{
            //make call back for collection to scroll to top
//            collectionView.scrollsToTop = true
//            collectionView.setContentOffset(.zero, animated: true)
            btnPressed?(sender.tag,true)

        }else{
            btnRecent.btnIsSelected = false
            btnOnAir.btnIsSelected = false
            btnPopular.btnIsSelected = false
            btnTopRated.btnIsSelected = false
            
            sender.btnIsSelected = true
            
            btnPressed?(sender.tag,false)
            //TODO :- Add callbacks
//            selectedTag = sender.tag
//            collectionView.reloadData()
//            if tvSeasons[selectedTag].count == 0 {
//                callTVSeasonsAPis(tag: sender.tag)
//            }else{
//
//            }
            
            
        }
    }
}
