//
//  UIViewController+Extension.swift
//
//  Created by Apple on 14/03/23.
//

import UIKit
//import SideMenu

extension UIViewController{
    
    var topVC: UIViewController? {
          return self.topVC(currentViewController: self)
      }

      private func topVC(currentViewController: UIViewController) -> UIViewController {
          if let tabBarController = currentViewController as? UITabBarController,
              let selectedViewController = tabBarController.selectedViewController {
              return self.topVC(currentViewController: selectedViewController)
          } else if let navigationController = currentViewController as? UINavigationController,
              let visibleViewController = navigationController.visibleViewController {
              return self.topVC(currentViewController: visibleViewController)
         } else if let presentedViewController = currentViewController.presentedViewController {
              return self.topVC(currentViewController: presentedViewController)
         } else {
              return currentViewController
          }
      }

    
    func moveToNext(vc: UIViewController){
        navigationController?.pushViewController(vc, animated: true)
    }

    func pop(){
        navigationController?.popViewController(animated: true)
    }
    
    open override func awakeAfter(using coder: NSCoder) -> Any? {
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
        } // This will help us to remove text
        return super.awakeAfter(using: coder)
    }
    
    class func topViewController(controller: UIViewController? =
                                 UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController{
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func setBackground(view:UIView){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
}


class BaseViewController : UIViewController, UIGestureRecognizerDelegate{
    
    var vSpinner : UIView?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
    }
    
    @objc func btnBackClick(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 
    //MARK: -  loader
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        ai.style = .large
        ai.layer.cornerRadius = 5
        ai.backgroundColor = UIColor.white
        ai.color = color.themeColor()
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async { [self] in
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
