//
//  ImgCCell.swift
//  MovieShow
//
//  Created by Danyal on 08/08/2021.
//

import UIKit
import ScalingCarousel

class ImgCCell: UICollectionViewCell {

//    @IBOutlet weak var heightConstr: NSLayoutConstraint!
    
//    @IBOutlet weak var widthConstr: NSLayoutConstraint!
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btnWidthConstr: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    var isSmall : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func configureData(tv : TvMainResult){
        
        let imgPath : String!
        if let poster = tv.posterPath{
            imgPath = poster
        }else if let poster = tv.backdropPath{
            imgPath = poster
        }else{
            imgPath = ""
            self.img.image = nil ; return
        }
        
        let urlStr = Constants.baseImgUrl + Constants.width200Img + imgPath

    
        let url = URL(string: urlStr)
//        animeImg.alpha = 0.0
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url!, progressBlock: nil) {
            [img] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
        }
    }
    
    func configureDataPerson(imgPath : String?){
        
        if let _ = imgPath{
        }else{
            self.img.image = nil ; return
        }
        
        let urlStr = Constants.baseImgUrl + Constants.width200Img + imgPath!

    
        let url = URL(string: urlStr)
//        animeImg.alpha = 0.0
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url!, progressBlock: nil) {
            [img] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
        }
    }

}
