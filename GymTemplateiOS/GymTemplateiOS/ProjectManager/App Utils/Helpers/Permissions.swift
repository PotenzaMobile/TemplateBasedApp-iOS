//
//  Permissions.swift
//  SwiftMasterProject
//
//  Created by Apple on 27/12/23.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class Permissions {
    
    //MARK: - Declarations
    var locationManager: CLLocationManager!
   
    
    /// Function Purpose: To Show alert that will be navigated to the phone's setting
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    /// title: Enter the title of the Alert
    func showAlert(aViewcontoller : UIViewController , title : String ) {
        let alert : UIAlertController = UIAlertController(title: "" , message: title, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { UIAlertAction in
            self.checkCameraPermission(aViewcontoller: aViewcontoller )
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) { UIAlertAction in
            self.checkGalleryPermission(aViewcontoller: aViewcontoller )
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { UIAlertAction in
            aViewcontoller.dismiss(animated: true, completion: nil)
        }
    
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        if let popoverController = alert.popoverPresentationController {
               popoverController.sourceView = aViewcontoller.view
               popoverController.sourceRect = CGRect(x: aViewcontoller.view.bounds.midX, y: aViewcontoller.view.bounds.midY, width: 0, height: 0)
               popoverController.permittedArrowDirections = []
           }

           aViewcontoller.present(alert, animated: true, completion: nil)
    }
    
    /// Function Purpose: To Show alert that will be navigated to the phone's setting
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    func checkCameraPermission(aViewcontoller : UIViewController) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
            case .denied : print("denied status")
                allowPermissionforCamera(aViewcontoller: aViewcontoller)
                break
            case .authorized : print("sucess")
                self.openCamera(aViewcontoller: aViewcontoller )
                break
            case .restricted : print("user dont allowed")
                break
            case .notDetermined : AVCaptureDevice.requestAccess(for: .video) { [self](success) in
                if success {
                    print("permission granted")
                    self.openCamera(aViewcontoller: aViewcontoller )
                }
                else{
                    print("permission not granted")
                }
            }
                break
            @unknown default:
                break
        }
    }
    
    /// Function Purpose: To Show alert with settings button to navigate user to settings screen
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    func allowPermissionforCamera( aViewcontoller : UIViewController) {
        Utils.showAlert(vc: aViewcontoller, title: "Error", msg: "Camera permission is denied", actionTitle: "Setting", handler: {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
            }
        })
    }
    
    /// Function Purpose: To Show alert with settings button to navigate user to settings screen
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    func checkGalleryPermission(aViewcontoller : UIViewController) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
            case .denied : print("denied status")
            Utils.showAlert(vc: aViewcontoller, title: "Error", msg: "Photo library status is denied", actionTitle: "Setting", handler: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                }
            })
                break
            case .authorized : print("success")
                self.openGallary(aViewcontoller: aViewcontoller)
                break
            case .restricted :  print("user dont allowed")
                break
            case .notDetermined : PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if (newStatus == PHAuthorizationStatus.authorized) {
                        print("permission granted")
                        self.openGallary(aViewcontoller: aViewcontoller )
                    }
                    else {
                        print("permission not granted")
                    }
                })
                break
        case .limited:
            print("limited")
        @unknown default:
            break
        }
    }

    /// Function Purpose: To open iPhone's default camera
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    func openCamera(aViewcontoller: UIViewController) {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = aViewcontoller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true

                if UIDevice.current.userInterfaceIdiom == .pad {
                    // For iPad, use a UIPopoverController
                    let popoverController = UIPopoverController(contentViewController: imagePicker)
                    popoverController.present(from: CGRect.zero, in: aViewcontoller.view, permittedArrowDirections: .any, animated: true)
                } else {
                    // For iPhone, present normally
                    aViewcontoller.present(imagePicker, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "No Camera", message: "Camera not Available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    self.openGallary(aViewcontoller: aViewcontoller)
                }))
                aViewcontoller.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /// Function Purpose: To open photo gallery
    /// Parameters:
    /// aViewcontoller -> Pass the current viewcontroller on which the alert is to be present
    func openGallary(aViewcontoller : UIViewController ) {
        DispatchQueue.main.async {
         if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
             let imagePicker = UIImagePickerController()
                    imagePicker.delegate = aViewcontoller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                     imagePicker.sourceType = .photoLibrary
                     imagePicker.allowsEditing = true
                     aViewcontoller.present(imagePicker, animated: true, completion: nil)
             }
        }
    }
    
    //MARK: - Location Access
    func checkLocationPermission(aViewcontoller: UIViewController) {
            locationManager = CLLocationManager()
            locationManager.delegate = aViewcontoller as? CLLocationManagerDelegate

            let authStatus = CLLocationManager.authorizationStatus()
            switch authStatus {
            case .denied, .restricted:
                Utils.showAlert(vc: aViewcontoller, title: "Error", msg: "Location permission is denied", actionTitle: "Settings", handler: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                    }
                })
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
    
    //MARK: - FileManager Delegate
      func openDocumentPicker(aViewcontoller: UIViewController) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = aViewcontoller  as? UIDocumentPickerDelegate
        documentPicker.allowsMultipleSelection = false
        aViewcontoller.present(documentPicker, animated: true, completion: nil)
    }
}
