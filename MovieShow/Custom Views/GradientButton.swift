//
//  GradientButton.swift
//  MovieShow
//
//  Created by Danyal Naveed on 11/08/2021.
//

import UIKit
class GradientButton: UIButton {

    
    var arrFirstColors : [UIColor] = [.brown,.darkGray,.black,.purple,.blue,.orange]
    var arrSecondColors : [UIColor] = [.green,.yellow,.cyan,.lightGray,.magenta,.systemPink]

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let first = arrFirstColors.randomElement()!.cgColor
        let second = arrSecondColors.randomElement()!.cgColor
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [first, second]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 5
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
