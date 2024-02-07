//
//  ThemeTitleLabel.swift
//  GymTemplateiOS
//
//  Created by Potenza on 07/02/24.
//

import Foundation
import UIKit

class ThemeTitleLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sharedInit()
    }
    
    
    /// Function Purpose is to set the UI of the label in the entire application
    /// Parameters:
    /// sTitle -> Enter the title of the label (Optional)
    /// bgColor -> The background color of the label. By default white color is set
    /// txColor -> The text color of the label
    /// fontSize, fontStyle -> Font size and style of the label title
    func sharedInit(sTitle: String = "", bgColor: UIColor? = .white, txColor: UIColor? = color.themeColor(), fontSize : CGFloat = 20.0, fontStyle: MainFont = .bold) {
        
        if sTitle != "" {
            self.text = sTitle
        }
        self.backgroundColor = bgColor
        self.textColor = txColor
        self.font = UIFont.customFont(font: fontStyle, size: fontSize)
        self.layoutIfNeeded()
    }
}
