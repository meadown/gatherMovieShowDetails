//
//  SettingVC.swift
//  MovieShow
//
//  Created by Danyal on 13/07/2021.
//

import UIKit
import StoreKit
import MessageUI
import GoogleMobileAds


class SettingVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var arrName = ["Category","Rate this app", "Feedback", "Share this app", "About"]
    var images = [UIImage(named: "Catergory Icon"),UIImage(named: "Rate Icon"),UIImage(named: "Feedback Icon"),UIImage(named: "Share Icon"),UIImage(named: "About Icon")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
//        tableView.register(UINib(nibName: "BannerAddTCell", bundle: nil), forCellReuseIdentifier: "BannerAddTCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.layer.masksToBounds = true
//        self.tableView
        
        self.tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tableView.layer.cornerRadius = 18
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.normalNavBar()
        self.tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        AdsManager.shared.presentAd(vc: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func shareApp(){
        // text to share
            let text = "This is awesome app share with your friends https://apps.apple.com/us/app/id1582792226"
            
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    func feedbackEmail(){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["contact@movcy.xyz"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
          } else {
            // show failure alert
            print("cannot open email")
          }
    }

}

extension SettingVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        }else{
            return arrName.count
//        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return kGADAdSizeBanner.size.height+30
//        }else{
            return UITableView.automaticDimension
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerAddTCell") as! BannerAddTCell
//            cell.parentVC = self
//            cell.loadAd()
//            return cell
//
//        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            cell.imgView.image = images[indexPath.row]
            cell.lblName.text = arrName[indexPath.row]

        if indexPath.row == 0 {
            cell.lblDetail.text = Constants.movieOrTV?.uppercased()
            cell.lblDetail.isHidden = false
        }else{
            cell.lblDetail.isHidden = true

        }
            return cell

//        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.section==1{
        if indexPath.row == 0 {
            //Open Category Screen
            let vc = CategoryVC()
            vc.isSettings = true
//            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(vc, animated: true)
//                .present(vc, animated: true, completion: nil)
            
            

        }
           else if indexPath.row == 1 {
                //Open Rating popup
                SKStoreReviewController.requestReview()

            }else if indexPath.row == 2 {
                //Open Feedback Email
               feedbackEmail()
            }
            else if indexPath.row == 3 {
                //Share app
                shareApp()
            }
            else if indexPath.row == 4 {
                //About
                let vc = AboutVC()
                self.navigationController?.pushViewController(vc, animated: true)

                
            }
//        }
       
    }
    
    
}

extension SettingVC : MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print("error :\(error?.localizedDescription)")
        switch result{
        
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        controller.dismiss(animated: true)
    }
}


