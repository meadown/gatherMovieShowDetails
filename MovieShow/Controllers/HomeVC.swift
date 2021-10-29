//
//  HomeVC.swift
//  MovieShow
//
//  Created by Danyal on 12/07/2021.
//

import UIKit
import GoogleMobileAds
import Kingfisher
import ScalingCarousel

enum TVCategory : Int{
    case Recent = 1
    case onAir = 2
    case Popular = 3
    case TopRated = 4
}

class HomeVC: BaseVC {

    @IBOutlet weak var btn1: RoundFillBtn!
    @IBOutlet weak var btn2: RoundFillBtn!
    @IBOutlet weak var btn3: RoundFillBtn!
    @IBOutlet weak var btn4: RoundFillBtn!
    
    @IBOutlet weak var scalingCollectionView: ScalingCarouselView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tvSeasonsRecent : [TvMainResult] = []
    var tvSeasonsOnAir : [TvMainResult] = []
    var tvSeasonsPopular : [TvMainResult] = []
    var tvSeasonsTopRated : [TvMainResult] = []
    
    var tvSeasons : [[TvMainResult]] = [[],[],[],[],[]]
    
    var urlArr : [String] = ["",Constants.recentUrl,Constants.onAirUrl,Constants.popularUrl,Constants.topRatedUrl]
    var currentTotalPages : Array<(key: Int,value:Int)> = [(key:0,value:0),(key:0,value:0),(key:0,value:0),(key:0,value:0),(key:0,value:0)]
    var selectedTag = 2
//    let indicator = UIActivityIndicatorView()
    var isApiLoading = [false,true,false,false,false]

    var bannerView: GADBannerView!
//    var extraCells : Int = 3
    var isShowFoooter : Bool = false {
        didSet{
            if self.tvSeasons[selectedTag].count > 0 {
                
                
                if !isShowFoooter{
                    collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionFooter , at: [3,0])?.size = CGSize(width: collectionView.frame.width, height: 0)
                    
                }else{
                    collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionFooter , at: [3,0])?.size = CGSize(width: collectionView.frame.width, height: 50)
                }
            }
        }
    }
    
    var movieOrTv : String? = nil//Constants.movieOrTV ?? "tv"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        
        collectionView.register(UINib(nibName: "AnimeCell", bundle: nil), forCellWithReuseIdentifier: "AnimeCell")
//        collectionView.register(UINib(nibName: "BannerAddCellCV", bundle: nil), forCellWithReuseIdentifier: "BannerAddCellCV")
        collectionView.register(UINib(nibName: "ButtonCCell", bundle: nil), forCellWithReuseIdentifier: "ButtonCCell")
        collectionView.register(UINib(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionCell")
        collectionView.register(UINib(nibName: "CarousalCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "CarousalCollectionVCell")

        collectionView.register(UINib(nibName: "LoadingView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingView")
        
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.collectionView.layer.cornerRadius = 18
        self.collectionView.layer.masksToBounds = false


        collectionView.delegate = self
        collectionView.dataSource = self
        
        if Constants.movieOrTV == "movie"{
            urlArr = ["",Constants.recentMovieUrl,Constants.onAirMovieUrl,Constants.popularUrl,Constants.topRatedUrl]
            
        }else{
       
        }
        
        callTVSeasonsAPis(tag: selectedTag)
        
        AdsManager.shared.requestIDFA()
        
       // loadCarousalData()

    }


    func loadCarousalData(){
        
        
        ApiManager.shared.getTvShowsList(urlStr: urlArr[1], tag: 1){ tvMain, tag, err in
            DispatchQueue.main.async {
                self.tvSeasonsRecent = tvMain?.results ?? []
                self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.normalNavBar()
        if tvSeasonsRecent.count == 0{
           loadCarousalData()
        }
//        AdsManager.shared.presentAd(vc: self)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        

        AdsManager.shared.presentAd(vc: self)
        
        if let _ = movieOrTv{
            if movieOrTv != Constants.movieOrTV{
                print("dubara chalo sub : local :\(movieOrTv), user defaults :\(Constants.movieOrTV)")
                defaultAll()
                movieOrTv = Constants.movieOrTV
            }
        }else{
            movieOrTv = Constants.movieOrTV
            print("khali hai :\(movieOrTv)")
        }
        
//        collectionView.reloadData()

    }
    
    func defaultAll(){
         tvSeasonsRecent  = []
         tvSeasonsOnAir = []
         tvSeasonsPopular  = []
         tvSeasonsTopRated  = []
        
         tvSeasons  = [[],[],[],[],[]]
        
         currentTotalPages = [(key:0,value:0),(key:0,value:0),(key:0,value:0),(key:0,value:0),(key:0,value:0)]
         selectedTag = 2
         isApiLoading = [false,true,false,false,false]
        
        if Constants.movieOrTV == "movie"{
            urlArr = ["",Constants.recentMovieUrl,Constants.onAirMovieUrl,Constants.popularUrl,Constants.topRatedUrl]
            
        }else{
            urlArr = ["",Constants.recentUrl,Constants.onAirUrl,Constants.popularUrl,Constants.topRatedUrl]
        }
        
        collectionView.reloadData()
        
        loadCarousalData()
        callTVSeasonsAPis(tag: selectedTag)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnCategorySelected(_ sender: RoundFillBtn) {
        
        
        if sender.isSelected{
            collectionView.scrollsToTop = true
            collectionView.setContentOffset(.zero, animated: true)


        }else{
            btn1.btnIsSelected = false
            btn2.btnIsSelected = false
            btn3.btnIsSelected = false
            btn4.btnIsSelected = false
            
            sender.btnIsSelected = true
            selectedTag = sender.tag
            collectionView.reloadData()
            if tvSeasons[selectedTag].count == 0 {
                callTVSeasonsAPis(tag: sender.tag)
            }else{
//                collectionView.scrollsToTop = true
//                collectionView.setContentOffset(.zero, animated: false)
//                collectionView.scrollToItem(at: [0,0], at: .top, animated: false)


            }
            
            
        }
        
    }
    
    func reloadCollectionData(tag : Int){
//        if tag == 1{
//            tvSeasons = tvSeasonsRecent
//        }else if tag == 2 {
//            tvSeasons = tvSeasonsOnAir
//        }else if tag == 3 {
//            tvSeasons = tvSeasonsPopular
//        }else{
//            tvSeasons = tvSeasonsTopRated
//        }
        self.collectionView.reloadData()
    }
    
    func callTVSeasonsAPis(tag : Int, isCallAPi : Bool = true, isUserInteraction : Bool = true){
       isApiLoading[selectedTag] = true
//        if tag == 1{
////            tvSeasons = tvSeasonsRecent
//            urlStr = Constants.recentUrl
//        }else if tag == 2 {
////            tvSeasons = tvSeasonsOnAir
//            urlStr = Constants.onAirUrl
//        }else if tag == 3 {
////            tvSeasons = tvSeasonsPopular
//            urlStr = Constants.popularUrl
//        }else{
//            tvSeasons = tvSeasonsTopRated
//            urlStr = Constants.topRatedUrl
//        }
//        if (tvSeasons[selectedTag].count == 0) && isCallAPi {
        self.view.isUserInteractionEnabled = isUserInteraction
//        if isUserInteraction{
//            indicator.startAnimating()
//        }else{
            isShowFoooter = true
//        }
        collectionView.reloadSections([3])
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            var url = urlArr[selectedTag]
            let currentPage = currentTotalPages[selectedTag].key + 1
//             pages[selectedTag] += 1
            currentTotalPages[selectedTag].key = currentPage
        
        if currentPage != 0{
            url += "&page=\(currentPage)"

        }
        print("url : \(url)")
        ApiManager.shared.getTvShowsList(urlStr: url, tag: selectedTag) {[unowned self] (rc, tag, err) in
            
            self.isApiLoading[self.selectedTag] = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
            
            self.isShowFoooter = self.isApiLoading[self.selectedTag]
            
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                if let result = rc{
                    self.currentTotalPages[self.selectedTag].key = rc?.page ?? 0
                    self.currentTotalPages[self.selectedTag].value = rc?.totalPages ?? 0
                    self.tvSeasons[tag].append(contentsOf:  rc?.results ?? [])
                }else if let error = err{
                    self.okAlert(title : "Error", message : error)
                }
                self.collectionView.layoutIfNeeded()
                self.collectionView.reloadData()
            }
                
//            }
            
        }
//        }else{
//            self.collectionView.reloadData()
//            print("Data already hai")
//        }
        
    }
}


extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if tvSeasons[selectedTag].count > 2 {
//            return 2 + 1
//        }else{
//            return tvSeasons[selectedTag].count + 1
//        }

//        return tvSeasons[selectedTag].count + extraCells
        
        if section == 3 {
            return tvSeasons[selectedTag].count
        }else{
            return 1
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("indexPath first time mai:\(indexPath)")

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarousalCollectionVCell", for: indexPath) as! CarousalCollectionVCell
//            cell.stackView.isHidden = true
            cell.recentArr = tvSeasonsRecent
            print("collectionview :\(cell.collectionView)")
            cell.pview = self
            
            cell.configureData()
            return cell

        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as! GenreCollectionCell
            cell.pview = self
            return cell
            
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCCell", for: indexPath) as! ButtonCCell
//            cell.stackView.isHidden = false
            cell.configureData(tag: selectedTag)
            cell.btnPressed = {[unowned self]  tag , isrelaod in
                if isrelaod{
                    collectionView.scrollsToTop = true
                    collectionView.setContentOffset(.zero, animated: true)
                }else{
                    selectedTag = tag
                    
                    if tvSeasons[selectedTag].count == 0 {
                        callTVSeasonsAPis(tag: tag)
                    }else{
                        collectionView.reloadSections([3])
                    }
                }
            }
           
            return cell

//        }else if indexPath.row == 3 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerAddCellCV", for: indexPath) as! BannerAddCellCV
//            cell.parentVC = self
//            cell.loadAd()
//            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
//            let item = tvSeasons[selectedTag][indexPath.row-extraCells]
            let item = tvSeasons[selectedTag][indexPath.row]
            cell.configureDate(tv: item)
            return cell

        }


    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-30
        if indexPath.section == 0{
            return CGSize(width: width, height: width/3 * 2)

        }else if indexPath.section == 1{
            return CGSize(width: width, height: 60)

        }else if indexPath.section == 2{
            return CGSize(width: width, height: 60)
//        }else if indexPath.row == 3{
//            return CGSize(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height+30)
        }
        else{
            let numberInOneRow : CGFloat = 2
            let width = (width-10*numberInOneRow)/numberInOneRow
            return CGSize(width: width, height: width*1.6 + 80)
        }

    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath
//        if (indexPath.row > (extraCells-1)) && tvSeasons[selectedTag].count > 0 && indexPath.row <= tvSeasons[selectedTag].count {
        if (indexPath.section == 3) && tvSeasons[selectedTag].count > 0 && indexPath.row <= tvSeasons[selectedTag].count {
            let item = tvSeasons[selectedTag][indexPath.row]
            let vc = AnimeDetailTVC()
            vc.animeID = item.id
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
//
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("indexPath:\(indexPath)")

//        if (indexPath.row > (extraCells-1)){
            if (indexPath.section == 3){

            if indexPath.row == tvSeasons[selectedTag].count-1 && currentTotalPages[selectedTag].key < currentTotalPages[selectedTag].value {//&& tvSeasons[selectedTag].count > 0{  //numberofitem count
                self.callTVSeasonsAPis(tag: selectedTag,isUserInteraction: false)
                
                print("ktni dafa chalega")
            }else{
                print("kuch nhi")
            }
            
        }
//        if indexPath.row > 0 && tvSeasons[selectedTag].count > 0 && indexPath.row <= tvSeasons[selectedTag].count {
//            if let urlStr = tvSeasons[selectedTag][indexPath.row - 1].posterPath{
//                let url = URL(string: Constants.baseImgUrl + Constants.width200Img  + urlStr)!
//                ImageDownloadManager.shared.downloadImage(url : url, indexPath: indexPath, selectedTag: selectedTag) { (image, url, indexPath,selectedtag, error) in
//                    if let indexPathNew = indexPath {
//                        if self.selectedTag == selectedtag{
//                            DispatchQueue.main.async {
//                                if let getCell = collectionView.cellForItem(at: indexPathNew) {
//                                    (getCell as? AnimeCell)!.animeImg.image = image
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//        }
    }

//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
        func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            /* Reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
            if isApiLoading[selectedTag] {return}
//            if indexPath.row > 0 && tvSeasons[selectedTag].count > 0 && indexPath.row <= tvSeasons[selectedTag].count {
//
//                if let urlStr = tvSeasons[selectedTag][indexPath.row - 1].posterPath{
//                    let url = URL(string: Constants.baseImgUrl + Constants.width200Img + urlStr)!
//                    ImageDownloadManager.shared.slowDownImageDownloadTaskfor(url: url)
//                }
//
//            }
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
                case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingView", for: indexPath) as! LoadingView
//                    footer.backgroundColor = .brown
            //                footer = SomeView
            footer.indicator.startAnimating()
            return footer

        default:
            print("anything")
            return UICollectionReusableView()
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if section == 3 {
//            if isApiLoading[selectedTag] {
//
//                return CGSize(width: collectionView.frame.width, height: 50)
//            }else{
//                return CGSize(width: collectionView.frame.width, height: 0)
//            }
//        }else{
//            return
//        }
//
        if isApiLoading[selectedTag] && section == 3 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }else{
            return CGSize(width: collectionView.frame.width, height: 0)
        }
        
    }

}

