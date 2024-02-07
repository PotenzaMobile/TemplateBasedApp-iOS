////
////  UIView+Extension.swift
////
////  Created by Apple on 14/03/23.
////
//


import UIKit

extension UIView {
    
    func setShadow(corner : CGFloat? = 10){
        self.layer.cornerRadius = corner ?? 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1
    }
    
    func makeBorder(corner : CGFloat? = 25, bcolor : UIColor = color.themeColor()!, width : CGFloat = 1 ){
        self.clipsToBounds = true
        self.layer.cornerRadius = corner ?? 25
        self.layer.borderWidth = width
        self.layer.borderColor = bcolor.cgColor
    }
    
    func makeRound(borderColor: UIColor = .clear, borderWidth: CGFloat? = 0.0){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth ?? 0.0
    }

    
    func setTopCorner(radius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setBottomCorner(radius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func setRightTopBottomCorner(radius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func setLeftTopBottomCorner(radius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
}

//
//import UIKit
//

//func setCornerRadiusForButton(_ button: UIButton, corners: UIRectCorner, radius: CGFloat) {
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(
//            roundedRect: button.bounds,
//            byRoundingCorners: corners,
//            cornerRadii: CGSize(width: radius, height: radius)
//        ).cgPath
//
//        button.layer.mask = maskLayer
//    }

//extension UIView {
//    
//    func setShadow(corner : CGFloat? = 10){
//        self.layer.cornerRadius = corner ?? 10
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 1
//    }
//    
//    func makeBorder(corner : CGFloat? = 25, bcolor : UIColor = color.subTitleColor()!, width : CGFloat = 1 ){
//        self.clipsToBounds = true
//        self.layer.cornerRadius = corner ?? 25
//        self.layer.borderWidth = width
//        self.layer.borderColor = bcolor.cgColor
//    }
//    
//    func makeRound(){
//        self.clipsToBounds = true
//        self.layer.cornerRadius = self.frame.size.height/2
//    }
//
//    
   
    
//    func setBottomCorner(radius : CGFloat){
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//    }
//    
//}
