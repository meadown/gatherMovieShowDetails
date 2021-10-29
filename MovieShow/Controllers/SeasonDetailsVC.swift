//
//  SeasonDetailsVC.swift
//  MovieShow
//
//  Created by Danyal Naveed on 29/07/2021.
//

import UIKit

class SeasonDetailsVC: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lblEpName: UILabel!
    @IBOutlet weak var imgEp: UIImageView!
    @IBOutlet weak var lblRating: UILabel!

    
    var seasonsDetails : SeasonDetail? = nil
    
    var tvID : Int! = 0
    var tvName : String = ""
    var seasonID : Int! = 0
    var selectedInd : Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = tvName
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SeasonCCell", bundle: nil), forCellWithReuseIdentifier: "SeasonCCell")
        
        
        self.showIndicator()
        ApiManager.shared.getSeasonDetails(tvID : tvID ,seasonID : seasonID){ [weak self] seasonDetails , err in
            if let result = seasonDetails{
                self?.seasonsDetails = result
            }else if let error = err{
                self?.okAlert(title : "Error", message : error)
            }
            
           
            DispatchQueue.main.async {
                self?.stopIndicator()
                if let ep = self?.seasonsDetails?.episodes.first{
                    self?.changeData(episode : ep)
                }
            }
        }
    }
    
    func changeData(episode : Episode){
        self.collectionView.reloadData()
        addImage(imgStr : episode.stillPath as? String )
        self.lblEpName.text = episode.name
        self.tvContent.text = episode.overview
        self.lblRating.text = "\(episode.voteAverage ?? 0)"
        selectedInd = 0
    }
    
    func addImage(imgStr : String?){
        guard let imgPath = imgStr else {imgEp.image = nil ; return}

        let urlStr = Constants.baseImgUrl + Constants.width500Img + imgPath
        guard let url = URL(string: urlStr) else {return}
//        animeImg.alpha = 0.0
        imgEp.kf.indicatorType = .activity
        imgEp.kf.setImage(with: url, progressBlock: nil) {
            [imgEp] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
        }
//
//        if let imgurl = imgStr{
//            let urlStr = Constants.baseImgUrl + Constants.width500Img + imgurl
//            ApiManager.shared.loadImages(urlStr: urlStr) { (data, err) in
//                DispatchQueue.main.async {
//                    if let error = err{
//                    }else{
//                        self.imgEp.image = UIImage(data: data!)
//                    }
//                }
//            }
//        }else{
//            self.imgEp.image = nil
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.normalNavBar()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SeasonDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonsDetails?.episodes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCCell", for: indexPath) as! SeasonCCell
        if let season = seasonsDetails{
            cell.configureEpisodeData(episode : season.episodes[indexPath.row])

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if selectedInd != indexPath.row{
            if let item = seasonsDetails?.episodes[indexPath.row]{
                changeData(episode : item)
                selectedInd = indexPath.row
            }
        }
    }
    
}

