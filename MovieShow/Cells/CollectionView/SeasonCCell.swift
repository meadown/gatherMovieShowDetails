//
//  SeasonCCell.swift
//  MovieShow
//
//  Created by Danyal on 26/07/2021.
//

import UIKit
import AVFoundation

class SeasonCCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblSeasonName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(season : Season){
        lblSeasonName.text = season.name
        print("season image path :\(season.posterPath)")
//        guard let imgPath = season.posterPath else {img.image = nil ; return}
//
//        let urlStr = Constants.baseImgUrl + Constants.width200Img + imgPath
//        guard let url = URL(string: urlStr) else {return}
////        animeImg.alpha = 0.0
//        img.kf.indicatorType = .activity
//        img.kf.setImage(with: url, progressBlock: nil) {
//            [img] _ in UIView.animate(withDuration: 0.2) {
////                animeImg?.alpha = 1.0
//            }
//        }
        
        addImage(imgStr: season.posterPath)
    }
    
    func addImage(imgStr : String?){
        guard let imgPath = imgStr else {img.image = nil ; return}

        let urlStr = Constants.baseImgUrl + Constants.width200Img + imgPath
        guard let url = URL(string: urlStr) else {return}
//        animeImg.alpha = 0.0
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url, progressBlock: nil) {
            [img] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
        }
    }
    
    func configureEpisodeData(episode : Episode){
        addImage(imgStr: episode.stillPath as? String)
        lblSeasonName.text = episode.name

    }
    
    func setVideoData(video : VideoResult){
        lblSeasonName.text = video.name
        self.contentView.backgroundColor = .clear
        img.backgroundColor = .clear
        lblSeasonName.textColor = .white

        let urlStr = "https://img.youtube.com/vi/\(video.key!)/0.jpg"
        guard let url = URL(string: urlStr) else {return}
//        animeImg.alpha = 0.0
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url, progressBlock: nil) {
            [img] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
        }
        
//        let url = URL(string: urlStr)
//
//            if let thumbnailImage = getThumbnailImage(forUrl: url!) {
//                img.image = thumbnailImage
//            }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }

}
