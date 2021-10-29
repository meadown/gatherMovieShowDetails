//
//  shadowView.swift
//  MovieShow
//
//  Created by Danyal Naveed on 12/08/2021.
//

import UIKit
class ShadowView:UIView {
    
    //    @IBInspectable var cornerRadius: CGFloat = 2
    
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 3
    var shadowColor: UIColor? = UIColor.white
    var shadowOpacity: Float = 0.3
//
//    @IBInspectable var shadowOffsetHeight: Int = 3
//    @IBInspectable var shadowColor: UIColor? = UIColor.black
//    @IBInspectable var shadowOpacity: Float = 0.5
//
    override func layoutSubviews() {
//        layer.cornerRadius = 8
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        layer.shadowPath = shadowPath.cgPath
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowColor = UIColor.white.cgColor
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 3
//        layer.shadowOpacity = 0.5
        
        
    }
    
}
