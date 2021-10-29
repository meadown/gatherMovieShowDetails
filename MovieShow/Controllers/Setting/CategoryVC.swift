//
//  CategoryVC.swift
//  MovieShow
//
//  Created by Danyal on 20/08/2021.
//

import UIKit

class CategoryVC: BaseVC {

    @IBOutlet weak var btnMovies: RoundFillBtn!
    @IBOutlet weak var btnTvShows: RoundFillBtn!
    @IBOutlet weak var lbl: UILabel!
    var isSettings = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        print("moview :\(Constants.movieOrTV)")
        if Constants.movieOrTV == "tv"{
            btnTvShows.btnIsSelected = true
            btnMovies.btnIsSelected = false
        }else if Constants.movieOrTV == "movie"{
            btnTvShows.btnIsSelected = false
            btnMovies.btnIsSelected = true
        }
        if isSettings{
            lbl.isHidden = true
        }
        

        self.navigationItem.title = "Select Category"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        if !isSettings{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }

    @IBAction func btnPressed(_ sender: RoundFillBtn) {
        sender.btnIsSelected = true
        if sender == btnMovies{
            Constants.movieOrTV = "movie"
        }else{
            Constants.movieOrTV = "tv"
        }
        
        if !isSettings{
            let storyboardRef = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let vc  = storyboardRef.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC{
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.viewControllers = [vc]
            }
        }else{
            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
        
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
