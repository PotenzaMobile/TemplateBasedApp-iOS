////
////  UIButton+Extension.swift
////
////  Created by Apple on 14/03/23.
////
//
//import UIKit
//
//extension UIButton{
//
//    
//    func setPrimaryButton(){
//        self.backgroundColor = color.primaryColor()
//        self.layer.cornerRadius = self.frame.size.height/2
//        self.titleLabel?.font = UIFont.customFont(font: .medium, size: 16)
//        self.setTitleColor(color.secondaryColor(), for: .normal)
//    }
//    
//    func setSecondaryButton(){
//        self.backgroundColor = .clear
//        self.titleLabel?.font = UIFont.customFont(font: .semiBold, size: 15)
//        self.setTitleColor(color.primaryColor(), for: .normal)
//    }
//    
//    func setBorderButton(){
//        self.backgroundColor = .clear
//        self.layer.cornerRadius = self.frame.size.height/2
//        self.titleLabel?.font = UIFont.customFont(font: .medium, size: 16)
//        self.setTitleColor(color.primaryColor(), for: .normal)
//        self.layer.borderWidth = 2
//        self.layer.borderColor = color.primaryColor()?.cgColor
//    }
//    
//}
