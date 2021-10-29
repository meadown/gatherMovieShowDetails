//
//  LaunchVC.swift
//  MovieShow
//
//  Created by Danyal on 29/07/2021.
//

import UIKit
import SwiftyGif

class LaunchVC: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet  var gifImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        let gif =  try! UIImage(gifName: "radial-dark.gif")
        self.gifImage.setGifImage(gif, loopCount: -1)
        gifImage.startAnimatingGif()

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if let _ = Constants.movieOrTV{
                let storyboardRef = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let vc  = storyboardRef.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC{
                    self.navigationController?.viewControllers = [vc]
                }
            }else{
                let vc = CategoryVC()
                self.navigationController?.viewControllers = [vc]

//                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
