//
//  Utils.swift
//  SwiftMasterProject
//
//  Created by Apple on 27/12/23.
//

//import SwiftyJSON
//import Toaster
import UIKit


typealias commonHandler = (() -> ())

enum UserDefaultsKeys : String {
    case UserId
}
class Utils {
    
    //MARK: - Alert
    
    /// Function Purpose: To Show simple alert with two buttons and completion handlers
    /// Parameters:
    /// vc: Pass the current viewcontroller on which the alert is to be present
    /// title: Enter the title of the Alert
    /// msg: Enter the message to be displayed
    /// actionTitle: Enter the title of the action button
    /// cancelHandler: Completeion handler for cancel button click
    class func showAlert(vc : UIViewController, title : String, msg : String, actionTitle : String,  handler : @escaping commonHandler, cancelHandler :  @escaping (() -> Void) = {}) {
        
        let alert = UIAlertController(title: title, message: msg , preferredStyle: .alert)
        let cancelaction = UIAlertAction(title: "Cancel", style: .cancel) {
            action in cancelHandler()
        }
        let yesaction: UIAlertAction = UIAlertAction(title: actionTitle,  style: .destructive) {  action in
            handler()
        }
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.customFont(font: .bold, size: 18), NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes as [NSAttributedString.Key : Any])
        let messageAttributes = [NSAttributedString.Key.font: UIFont.customFont(font: .regular, size: 15), NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: msg, attributes: messageAttributes as [NSAttributedString.Key : Any])
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.addAction(cancelaction)
        alert.addAction(yesaction)
        vc.present(alert, animated: true, completion: nil)
    }
//================================================================================================================================================================
    
    /// Function Purpose: To Show simple alert with just an OK button
    /// Parameters:
    /// vc: Pass the current viewcontroller on which the alert is to be present
    /// title: Enter the title of the Alert
    /// message: Enter the message to be displayed
    class  func showOkAlert(vc : UIViewController, title : String , message : String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
            let cancelaction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(cancelaction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
