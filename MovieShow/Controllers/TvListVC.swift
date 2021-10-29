//
//  TvListVC.swift
//  MovieShow
//
//  Created by Danyal Naveed on 11/08/2021.
//

import UIKit
import GoogleMobileAds

class TvListVC: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var genreId : Int = 0
    var genreName : String = ""
    var tvSeasons : [TvMainResult] = []
    var currentTotalPages = (key:0,value:0)
    var url : String = ""
    var movieOrTv : String? = nil
    var isShowFoooter : Bool = false {
        didSet{
            if self.collectionView.visibleCells.count > 0 {
                
                
                if !isShowFoooter{
                    collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionFooter , at: [0,0])?.size = .zero
                    
                }else{
                    collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionFooter , at: [0,0])?.size = CGSize(width: collectionView.frame.width, height: 50)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = genreName
        collectionView.register(UINib(nibName: "AnimeCell", bundle: nil), forCellWithReuseIdentifier: "AnimeCell")
//        collectionView.register(UINib(nibName: "BannerAddCellCV", bundle: nil), forCellWithReuseIdentifier: "BannerAddCellCV")
        collectionView.register(UINib(nibName: "LoadingView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingView")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.layer.masksToBounds = false
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.collectionView.layer.cornerRadius = 18
        
        
        url = Constants.discoverTvUrl
        url = url.replacingOccurrences(of: Constants.genreID, with: "\(genreId)")
        callTVSeasonsAPis(url: &url)
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = movieOrTv{
            if movieOrTv != Constants.movieOrTV{
                print("dubara chalo sub : local :\(movieOrTv), user defaults :\(Constants.movieOrTV)")
                movieOrTv = Constants.movieOrTV
                
                 tvSeasons  = []
                 currentTotalPages = (key:0,value:0)
                collectionView.reloadData()
                url = Constants.discoverTvUrl
                url = url.replacingOccurrences(of: Constants.genreID, with: "\(genreId)")
                callTVSeasonsAPis(url: &url)
            }
        }else{
            movieOrTv = Constants.movieOrTV
            print("khali hai :\(movieOrTv)")
        }
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

    func callTVSeasonsAPis( url : inout String, isUserInteraction : Bool = true, isClear : Bool = true){
//        url = url.replacingOccurrences(of: Constants.genreID, with: "\(genreID)")
//        if (tvSeasons[selectedTag].count == 0) && isCallAPi {
        self.view.isUserInteractionEnabled = isUserInteraction
//        if isUserInteraction{
//            indicator.startAnimating()
//        }else{
            isShowFoooter = true
//        }
        
        if isClear{
            currentTotalPages.key = 0
            currentTotalPages.value = 0
            tvSeasons.removeAll()
            collectionView.reloadData()
        }
        
            let currentPage = currentTotalPages.key + 1
//             pages[selectedTag] += 1
            currentTotalPages.key = currentPage
        
//        if currentPage != 0{
            url += "&page=\(currentPage)"
//        }
            print("url : \(url)")
            ApiManager.shared.getTvShowsList(urlStr: url, tag: 1) { (rc, tag, err) in
                
                self.isShowFoooter = false
                
                if let result = rc{
                    self.currentTotalPages.key = rc?.page ?? 0
                    self.currentTotalPages.value = rc?.totalPages ?? 0
                    self.tvSeasons.append(contentsOf:  rc?.results ?? [])
                }else if let error = err{
                    self.okAlert2(title : "Error", message : error)
                }
                
               
                DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled = true
                    self.collectionView.reloadData()
                    AdsManager.shared.presentAd(vc: self)
                }
            }
//        }else{
//            self.collectionView.reloadData()
//            print("Data already hai")
//        }
        
    }
    
}

extension TvListVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tvSeasons.count //+ 1
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("indexPath first time mai:\(indexPath)")

//        if indexPath.row == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerAddCellCV", for: indexPath) as! BannerAddCellCV
//            cell.parentVC = self
//            cell.loadAd()
//            return cell
//
//        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
            let item = tvSeasons[indexPath.row]
            cell.configureDate(tv: item)
            return cell

//        }
        
        
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0{
//            return CGSize(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height+30)
//
//        }else{
            let numberInOneRow : CGFloat = 2
            let width = (self.collectionView.frame.width-10*numberInOneRow-30)/numberInOneRow
            return CGSize(width: width, height: width*1.6 + 80)
//        }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = tvSeasons[indexPath.row]
        let vc = AnimeDetailTVC()
        vc.animeID = item.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("indexPath:\(indexPath)")
        print("seasons count : \(tvSeasons.count)\ncurrent page : \(currentTotalPages.key)\n TotalPages : \(currentTotalPages.value)\n")
        if indexPath.row == tvSeasons.count-1 && currentTotalPages.key < currentTotalPages.value {//&& tvSeasons[selectedTag].count > 0{  //numberofitem count
            self.callTVSeasonsAPis(url : &url,isUserInteraction: false, isClear: false)
            print("ktni dafa chalega")
        }else{
            print("kuch nhi")
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
                case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingView", for: indexPath) as! LoadingView
            
            //                footer = SomeView
            footer.indicator.startAnimating()
            return footer
            
        default:
            print("anything")
            return UICollectionReusableView()
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isShowFoooter {
            return CGSize(width: collectionView.frame.width, height: 50)
        }else{
            return .zero//CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
}

