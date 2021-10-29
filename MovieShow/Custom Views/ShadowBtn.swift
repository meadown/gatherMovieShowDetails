//
//  ShadowBtn.swift
//  MovieShow
//
//  Created by Danyal Naveed on 12/08/2021.
//

import Foundation
import UIKit

@IBDesignable class ShadowBtn : UIButton{
    
    @IBInspectable var isCircular : Bool = false{
        didSet{
            refreshCorner()
        }
        
    }
    
 override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        
        refreshCorner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
    }
    
    
    
    func refreshCorner(){
//        layer.shadowColor = UIColor.white.cgColor
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 35
//        layer.shadowOpacity = 0.5
//        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.masksToBounds = false
        if isCircular{
            layer.cornerRadius = frame.height/2
        }
    }
}
