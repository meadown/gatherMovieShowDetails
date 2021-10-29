//
//  VideoVC.swift
//  MovieShow
//
//  Created by Danyal Naveed on 27/07/2021.
//

import UIKit
import youtube_ios_player_helper

class VideoVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var videos : [VideoResult] = []
    var tempVideos: [VideoResult] = []
    var videoKey : String!
    var urlStr : String = ""//{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        webView.load(NSURLRequest(url: NSURL(string: urlStr)! as URL) as URLRequest)
        
//        ytPlayer.load(withVideoId: videoKey)
//        ytPlayer.removeWebView()
        ytPlayer.delegate = self
        indicator.startAnimating()
        ytPlayer.backgroundColor = .black
//        ytPlayer.webView?.backgroundColor = .black

        ytPlayer.load(withVideoId: videoKey, playerVars: ["playInline" : 1])

//        ytPlayer.webView?.backgroundColor = .black

        
        collectionView.register(UINib(nibName: "SeasonCCell", bundle: nil), forCellWithReuseIdentifier: "SeasonCCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self

        

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnDismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension VideoVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCCell", for: indexPath) as! SeasonCCell
        let video = videos[indexPath.row]
        cell.setVideoData(video : video)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        indicator.startAnimating()
        indicator.isHidden = false
        if videoKey != video.key{
            videoKey = video.key
            ytPlayer.load(withVideoId: videoKey)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: collectionView.frame.height-20)
    }


}

extension VideoVC : YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        indicator.stopAnimating()
        indicator.isHidden = true

    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        indicator.stopAnimating()
        indicator.isHidden = true

        okAlert2(title: "Error", message: error.rawValue.description)
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        .clear
    }
    
}
