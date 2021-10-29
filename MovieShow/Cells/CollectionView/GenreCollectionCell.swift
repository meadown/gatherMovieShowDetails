//
//  GenreCollectionCell.swift
//  MovieShow
//
//  Created by Danyal Naveed on 11/08/2021.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var pview : UIViewController? = nil
//    var genresArr : [Int : String] = [ 28:"Action", 12:"Adventure", 16:"Animation", 35:"Comedy", 80:"Crime", 99:"Documentary", 18:"Drama", 10751:"Family", 14:"Fantasy",36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 10749:"Romance",878:"Science Fiction", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]
    var genresArr : [Int : String] = [ 28:"Action", 12:"Adventure", 35:"Comedy", 80:"Crime", 99:"Documentary", 18:"Drama", 10751:"Family", 14:"Fantasy",36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 10749:"Romance",878:"Science Fiction", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GenreBtnCell", bundle: nil), forCellWithReuseIdentifier: "GenreBtnCell")
    }

}

extension GenreCollectionCell : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreBtnCell", for: indexPath) as! GenreBtnCell
        let item = Array(genresArr.values)[indexPath.row]
        let id = Array(genresArr.keys)[indexPath.row]
        cell.btnGenre.setTitle(item, for: .normal)
        cell.btnGenre.layoutIfNeeded()
        cell.genreName = item
        cell.genreId = id
        cell.pview = pview
        return cell
    }
    
    
}
