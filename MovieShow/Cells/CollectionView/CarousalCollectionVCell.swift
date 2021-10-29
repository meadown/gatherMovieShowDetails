//
//  CarousalCollectionVCell.swift
//  MovieShow
//
//  Created by Danyal on 11/08/2021.
//

import UIKit
import ScalingCarousel

class CarousalCollectionVCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var recentArr : [TvMainResult] = []
    var cellSmall = true
    var pview : UIViewController?
    var bigSizeRow = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "ImgCCell", bundle: nil), forCellWithReuseIdentifier: "ImgCCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout.invalidateLayout()

        let lay = SnappingCollectionViewLayout()
        lay.scrollDirection = .horizontal
        lay.minimumInteritemSpacing = 0
        lay.estimatedItemSize = .zero
        collectionView.collectionViewLayout = lay

    }
    
    func configureData(){
        collectionView.layoutIfNeeded()
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
       collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        print("collection view size :\(collectionView.frame.size)")
    }

}


//MARK: - Collection View
extension CarousalCollectionVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recent count :\(recentArr.count)")
        return recentArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCCell", for: indexPath) as! ImgCCell
        let item = recentArr[indexPath.row]
        let visibleCells = collectionView.indexPathsForVisibleItems
        print("-------")
        print("visible cells index cellForItemAt: \(visibleCells)")
        print("index path cellForItemAt: \(indexPath)")
        print("-------")
        
        
        cell.contentView.layer.masksToBounds = false
        UIView.animate(withDuration: 0.3) {
            if  indexPath.row == 1{
                cell.contentView.alpha = 1
                cell.transform = CGAffineTransform(scaleX:1.35, y: 1.4)
            }else{

                cell.transform = CGAffineTransform(scaleX: 0.83, y: 0.8)
                cell.contentView.alpha = 0.5
            }
            cell.img.layoutIfNeeded()
            cell.layoutIfNeeded()
    
        }

        cell.configureData(tv : item)



        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let visibleCells = collectionView.indexPathsForVisibleItems.count
        print("-------")
        print("visible cells count sizeForItemAt: \(visibleCells)")
        print("indexPath sizeForItemAt: \(indexPath)")
        print("-------")
        
        collectionView.layoutIfNeeded()
        let height = collectionView.frame.height
        let width = (collectionView.frame.width-20)/3
//        let width = (collectionView.frame.width)/3

        return CGSize(width: width, height: height)
//        return CGSize(width: width, height: width * 1.7)
      
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let item = recentArr[indexPath.row]
       let vc = AnimeDetailTVC()
       vc.animeID = item.id
       pview?.navigationController?.pushViewController(vc, animated: true)
   }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Also, this is where we scale our cells
        
        let indexPAthVisibleCells = collectionView.indexPathsForVisibleItems.sorted()
        let visibleCells = collectionView.visibleCells
        
        var i = 0
        for indexPath in indexPAthVisibleCells {//collectionView.visibleCells {
            i += 1
        if let tempCell = collectionView.cellForItem(at: indexPath) as? ImgCCell {
                
                UIView.animate(withDuration: 0.3) {
                    if i == 2{

                        tempCell.transform = CGAffineTransform(scaleX:1.35, y: 1.35)
                        tempCell.contentView.alpha = 1
//                        tempCell.contentView.backgroundColor = .blue
                    }else{

                        tempCell.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
                        tempCell.contentView.alpha = 0.5
//                        tempCell.contentView.backgroundColor = .systemPink
                    }
                    tempCell.img.layoutIfNeeded()
                    tempCell.layoutIfNeeded()
            
                }
            }
        }
        print("-------")
        print("visible cells indexPath scrollViewDidScroll: \(indexPAthVisibleCells)")
        print("visible cells count scrollViewDidScroll : \(visibleCells.count)")
        print("-------")
    }
}


class SnappingCollectionViewLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        scrollDirection = .horizontal
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })

//        print("currentItemIdx :\(currentItemIdx)")
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    
}

class SnapCenterLayout: UICollectionViewFlowLayout {
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    scrollDirection = .horizontal
    
    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)

    let itemSpace = itemSize.width + minimumInteritemSpacing
    var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)

    // Skip to the next cell, if there is residual scrolling velocity left.
    // This helps to prevent glitches
    let vX = velocity.x
    if vX > 0 {
      currentItemIdx += 1
    } else if vX < 0 {
      currentItemIdx -= 1
    }

    
//    let cell = self.visibleCells[i] as! ImgCCell
//    let cellWidth = cell.bounds.size.width
//    let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
//
//    // Now calculate closest cell
//    let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
//    if distance < closestDistance {
//        closestDistance = distance
//        closestCellIndex = self.indexPath(for: cell)!.row
//    }
    print("currentItemIdx :\(currentItemIdx)")
    let nearestPageOffset = currentItemIdx * itemSpace
    return CGPoint(x: nearestPageOffset, y: parent.y)
  }
}

