//
//  ThemeButton.swift
//  GymTemplateiOS
//
//  Created by Potenza on 07/02/24.
//

import Foundation
import UIKit

class ThemeButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sharedInit()
    }
    
    
    /// Function Purpose is to set the UI of the button in the entire application
    /// Parameters: 
    /// sTitle -> Enter the title of the button (Optional)
    /// bgColor -> The background color of the button. By default white color is set
    /// txColor -> The text color of the button
    /// fontSize, fontStyle -> Font size and style of the button title
    /// cornerradius,borderWidht -> corner radius and width of border
    /// withOnlyBorder -> Set the boolean value to true if the button has no background color just the border.
    
    func sharedInit(sTitle: String = "", bgColor: UIColor? = .white, txColor: UIColor? = color.themeColor(), fontSize : CGFloat = 20.0, fontStyle: MainFont = .bold, cornerradius: CGFloat = 22.0, borderWidht: CGFloat = 1.0,withOnlyBorder:Bool = false) {
        
        if sTitle != "" {
            self.setTitle(sTitle, for: .normal)
        }
        if withOnlyBorder {
            self.backgroundColor = .clear
            self.setTitleColor(color.themeColor(), for: .normal)
            self.layer.borderWidth = 2.0
            self.layer.borderColor = color.themeColor()?.cgColor
            self.layer.cornerRadius =  22.0
            self.clipsToBounds = true
            self.titleLabel?.font = UIFont.customFont(font: fontStyle, size: fontSize)
            self.layoutIfNeeded()
        } else {
            self.backgroundColor = bgColor
            self.setTitleColor(txColor, for: .normal)
            self.layer.cornerRadius = cornerradius
            self.layer.borderWidth = borderWidht
            self.layer.borderColor = UIColor.clear.cgColor
            self.clipsToBounds = true
            self.titleLabel?.font = UIFont.customFont(font: fontStyle, size: fontSize)
            self.layoutIfNeeded()
        }
    }
}
