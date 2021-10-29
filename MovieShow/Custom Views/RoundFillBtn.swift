//
//  RoundFillBtn.swift
//  MovieShow
//
//  Created by Danyal on 14/07/2021.
//

import UIKit

@IBDesignable class RoundFillBtn: UIButton {

    @IBInspectable var btnIsSelected : Bool = false{
        didSet{
            reloadBtn()
        }
    }
    
    @IBInspectable var selectedBkg : UIColor = UIColor(named: "Primary")!
//    {
//        didSet{
//
//        }
//    }
    
    @IBInspectable var unSelectedBkg: UIColor = .black
//    {
//        didSet{
//
//        }
//    }
    
    @IBInspectable var selectedTextClr : UIColor = .white
    @IBInspectable var unSelectedTextClr : UIColor = .white
    @IBInspectable var cornerRad: CGFloat = 10{
        didSet{
            self.layer.cornerRadius = cornerRad
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
       
        
      
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    func commonInit(){
        self.setTitleColor(selectedTextClr, for: .selected)
        self.setTitleColor(unSelectedTextClr, for: .normal)
        self.backgroundColor = unSelectedBkg
        self.tintColor = .clear
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = cornerRad
    }
    
    func reloadBtn(){
        self.isSelected = btnIsSelected
        if isSelected{
            self.backgroundColor = selectedBkg
        }else{
            self.backgroundColor = unSelectedBkg

        }
    }

}
