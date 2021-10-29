//
//  AnimeDetailTVC.swift
//  MovieShow
//
//  Created by Danyal on 18/07/2021.
//

import UIKit
import GoogleMobileAds
import AVKit



enum CellType{
    case Summary
    case InformationHeader
    case InformationRows
    case Ads
    case Characters
    case Seasons
}
class AnimeDetailTVC: UITableViewController {
    
    
    @IBOutlet weak var headingView: HeaderView!
    
    private lazy var needsLayoutHandler: (() -> Void) = {
        [weak self] in
        self?.tableView.performBatchUpdates({
            self?.tableView.setNeedsLayout()
        }, completion: nil)
    }
    
//    var infoArr = ["First Air Date","Last Air Date", "Next Air Date", "Episode Duration","Airing Status" ,"Total Episodes","Popularity", "Rating"]
    
    var animeID : Int!
    var tvDetails : TVDetails!
    
    var topPadding : CGFloat!
    var navHeight : CGFloat!
    var headerHeight : CGFloat!
    var tabBarHeight : CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingView.indicator.startAnimating()
        headingView.parentVC = self
       
        ApiManager.shared.getTvDetails(id: animeID) { (details, err) in
            
            DispatchQueue.main.async {
                
                self.headingView.indicator.stopAnimating()
                
                if let error = err{
                    self.headingView.lblTitle.text = error
                    
                }else{
                    self.tvDetails = details
                    self.navigationItem.title = ""//self.tvDetails.name

                    self.headingView.videos = self.tvDetails.videos.results // Crash here
                    if details?.name.lowercased() == self.tvDetails.originalName.lowercased(){
                        self.headingView.lblSubTitle.text = self.tvDetails.tagline
                    }else{
                        self.headingView.lblSubTitle.text = self.tvDetails.originalName

                    }
                    self.headingView.lblTitle.text = details!.name
                    self.headingView.btnFvrt.tag = self.tvDetails.id
                    
                    self.headingView.btnFvrt.addTarget(self, action: #selector(self.btnFvrtPressed(_:)), for: .touchUpInside)
                    if let imgPath = self.tvDetails.backdropPath{
                        self.headingView.imgUrlStr = imgPath
                    }
                    
                    if CoreDataManager.shared.isFavourite(id : self.tvDetails.id){
                        self.headingView.btnFvrt.isSelected = true
                    }else{
                        self.headingView.btnFvrt.isSelected = false
                    }
                
                    
                    
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
        
        tableView.register(UINib(nibName: "TvSummaryTCell", bundle: nil), forCellReuseIdentifier: "TvSummaryTCell")
        tableView.register(UINib(nibName: "CastTCell", bundle: nil), forCellReuseIdentifier: "CastTCell")
        tableView.register(UINib(nibName: "InfoTCell", bundle: nil), forCellReuseIdentifier: "InfoTCell")
        tableView.register(UINib(nibName: "HeadingTCell", bundle: nil), forCellReuseIdentifier: "HeadingTCell")
        tableView.register(UINib(nibName: "SeasonsTCell", bundle: nil), forCellReuseIdentifier: "SeasonsTCell")
//        tableView.register(UINib(nibName: "BannerAddTCell", bundle: nil), forCellReuseIdentifier: "BannerAddTCell")

    }
    
    @objc func btnFvrtPressed(_ sender : UIButton){
        if sender.isSelected{
            CoreDataManager.shared.removeFavourite(id: sender.tag)
        }
        else{
            let fvrtTV = FavouriteTVModel(id: tvDetails.id, name: tvDetails.name, rating: tvDetails.voteAverage, imagePath: tvDetails.posterPath)
            CoreDataManager.shared.addFavourite(fvrtTV: fvrtTV)
            
        }
        sender.isSelected = !sender.isSelected
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        tableView.tableFooterView = UIView()
        headingView.onNeededLayout = needsLayoutHandler
        self.navigationController?.transparentNavBar()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.normalNavBar()
    }
    
    
    func initialize(){
        let window = UIApplication.shared.keyWindow
        topPadding = window?.safeAreaInsets.top  ?? 0.0//55
        navHeight = self.navigationController?.navigationBar.frame.height ?? 0.0 //44
        headerHeight  = tableView.tableHeaderView?.frame.height ?? 0.0 //222
        tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight + 10, right: 0)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        AdsManager.shared.presentAd(vc: self)

        initialize()

    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        adjustNavigationBarStyle()

        if scrollView.contentOffset.y < 0 {
            headingView.headingScrollExpansion = scrollView.contentOffset.y
        } else {
            headingView.headingScrollExpansion = 0
        }
        
      
        let heightDiff = headerHeight - topPadding - navHeight
        
        UIView.animate(withDuration: 0.3) {
            if scrollView.contentOffset.y >= heightDiff{
//                self.navigationController?.normalNavBar()
                self.view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                self.view.layer.cornerRadius = 18
            }else{
//                self.navigationController?.transparentNavBar()
    //            self.view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                self.view.layer.cornerRadius = 0
            }
            self.view.layoutIfNeeded()
        }
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if tvDetails == nil{
            return 0
        }else{
            //Summary //Heading //Introduction //Cast //Seasons
            if Constants.movieOrTV == "tv"{
                return 1 + 1 + 1 + 1 + 1

            }else{
                //Summary //Heading //Introduction //Cast
                return 1 + 1 + 1 + 1
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return 1 + 1 + tvDetails.informationArr.count + 1
        if section == 2{
            return tvDetails.informationArr.count
        }else{
            return 1
        }
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TvSummaryTCell", for: indexPath) as! TvSummaryTCell
            cell.configureData(summary: tvDetails.overview)
            cell.onLayoutChange = needsLayoutHandler
            cell.tvHeightChanged = {[unowned self] height in
                self.tableView.reloadSections([0], with: .fade)
            }
            return cell
            

        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadingTCell", for: indexPath) as! HeadingTCell
            cell.lblHeading.text = "Information"
            return cell

        }
        else if indexPath.section == 2{//tvDetails.informationArr.count+2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTCell", for: indexPath) as! InfoTCell
            //            var item = Array(tvDetails.informationArr)
            //            item.sort(by: {$0.key < $1.key})
             let item = tvDetails.informationArr//{
                cell.configureData(heading: item[indexPath.row].key, name: item[indexPath.row].value)

//            }
            
            return cell
            
        
//        } else if indexPath.section == 3{//if indexPath.row > tvDetails.informationArr.count{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerAddTCell", for: indexPath) as! BannerAddTCell
//            cell.parentVC = self
//            cell.loadAd()
//            return cell

        }else if indexPath.section == 3{
            print("index path cast :\(indexPath.section)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTCell", for: indexPath) as! CastTCell
            cell.configuredata(cast: tvDetails.credits.cast)
            cell.parentVc = self

            return cell

        }else if indexPath.section == 4{
            print("index path cast :\(indexPath.section)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonsTCell", for: indexPath) as! SeasonsTCell
            cell.seasons = tvDetails.seasons
            cell.tvID = tvDetails.id
            cell.tvName = tvDetails.name
            cell.parentVc = self
            return cell
        }
        

        
        

        // Configure the cell...

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 44
//        }else if indexPath.row == 3 {
//            return kGADAdSizeBanner.size.height+30
        }else{
            return UITableView.automaticDimension
        }
        
        

    }




}

extension AnimeDetailTVC : AVPlayerViewControllerDelegate{
    
}

