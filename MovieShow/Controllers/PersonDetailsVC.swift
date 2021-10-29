//
//  PersonDetailsVC.swift
//  MovieShow
//
//  Created by Danyal on 22/08/2021.
//

import UIKit

class PersonDetailsVC: BaseVC {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var biographyTV: UITextView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    var personDetails : PersonDetail? = nil
    var personId : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ImgCCell", bundle: nil), forCellWithReuseIdentifier: "ImgCCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        showIndicator()
        ApiManager.shared.getPersonDetails(personID: personId) { (personDet, err) in
            DispatchQueue.main.async {
                if let error = err{
                    self.okAlert(title: "Error", message: error)
                }else{
                    self.stopIndicator()
                    self.personDetails = personDet
                    
                    self.lblName.text = self.personDetails?.name ?? ""
                    self.lblName.layoutIfNeeded()
                    self.lblDob.text = self.personDetails?.birthday ?? ""
                    self.biographyTV.text = self.personDetails?.biography ?? ""

                    self.addImage(imgPath: self.personDetails?.profilePath)
                    if (personDet?.images.images.count ?? 0) > 1{
                        self.imageView.isHidden = false
                        self.collectionView.reloadData()
                    }else{
                        self.imageView.isHidden = true
                    }
                }
                
            }
        }
    }

    
    func addImage(imgPath : String?){
        
        if let _ = imgPath{
        }else{
            self.imgPerson.image = nil ; return
        }
        
        let urlStr = Constants.baseImgUrl + Constants.width200Img + imgPath!

    
        let url = URL(string: urlStr)
//        animeImg.alpha = 0.0
        imgPerson.kf.indicatorType = .activity
        imgPerson.kf.setImage(with: url!, progressBlock: nil) {
            [imgPerson] _ in UIView.animate(withDuration: 0.2) {
//                animeImg?.alpha = 1.0
            }
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
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PersonDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personDetails?.images.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCCell", for: indexPath) as! ImgCCell
        if let imgPath = personDetails?.images.images[indexPath.row].filePath{
            cell.configureDataPerson(imgPath : imgPath)

        }else{
            cell.configureDataPerson(imgPath : nil)

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: height*0.66, height: height)
    }
    
    
}
