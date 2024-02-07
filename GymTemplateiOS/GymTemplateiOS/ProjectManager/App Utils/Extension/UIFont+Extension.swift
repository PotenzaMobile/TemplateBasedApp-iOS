//
//  Font+Extension.swift
//
//  Created by Apple on 13/03/23.
//

import UIKit


typealias MainFont = AppFont.Nunito

enum AppFont {
    enum Nunito: String {
        
        case regular = "SFProText-Regular"
        case medium = "SFProText-Medium"
        case bold = "SFProText-Bold"
        case semiBold = "SFProText-Semibold"
        case thin = "SFProDisplay-Black"
        
    }
}

extension UIFont {
    class func customFont(font : MainFont, size: CGFloat) -> UIFont {
        let fontName: String
        
        switch font {
        case .regular:
            fontName = "SFProText-Regular"
        case .medium:
            fontName = "SFProText-Medium"
        case .bold:
            fontName = "SFProText-Bold"
        case .semiBold:
            fontName = "SFProText-Semibold"
        case .thin:
            fontName = "SFProDisplay-Black"
        }
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
