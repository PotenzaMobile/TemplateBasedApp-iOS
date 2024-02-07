////
////  UITextField+Extension.swift
////
////  Created by Apple on 14/03/23.
////
//
import UIKit



extension UITextField {
    
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setAttributeText(  placeHolderString : String) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray as Any ,
            NSAttributedString.Key.font : UIFont.customFont(font: .regular, size: 14)
        ] as [NSAttributedString.Key : Any]
        return NSAttributedString(string:placeHolderString, attributes:attributes)
    }

    func setInputViewDatePicker(target: Any, selector: Selector, isDate: Bool) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))

        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }

        datePicker.datePickerMode = isDate ? .date : .time

        datePicker.maximumDate = Date() // This sets the maximum date to today

        self.inputView = datePicker

        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        toolBar.barTintColor = color.themeColor()

        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        cancel.tintColor = .white
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        barButton.tintColor = .white

        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }

    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
