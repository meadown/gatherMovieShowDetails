//
//  GenreBtnCell.swift
//  MovieShow
//
//  Created by Danyal Naveed on 11/08/2021.
//

import UIKit

class GenreBtnCell: UICollectionViewCell {

    @IBOutlet weak var btnGenre: UIButton!
    var pview : UIViewController?
    var genreName : String  = ""
    var genreId  : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnGenrePressed(_ sender: UIButton) {
        if let tempVC = pview{
            let vc = TvListVC()
            vc.genreName = genreName
            vc.genreId = genreId
            tempVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
