//
//  Constants.swift
//  SwiftMasterProject
//
//  Created by Apple on 28/12/23.
//

import Foundation


let color = R.color
let storyboard = R.storyboard
//let image = R.image

//MARK: -  API url configuration
struct Domain {
    static let dev = "https://dummyjson.com/auth/"
 
}

extension Domain {
    static func baseUrl() -> String {
        return "\(Domain.dev)"
    }
}

struct APIConstants {
    static let kSuccess = "success"
    static let kError = "error"
}

struct UrlConstant {
    static func apiurl(_ apiEndPoint : APIEndpoint) -> String{
        return "\(String(describing: Domain.baseUrl()))\(apiEndPoint.rawValue)"
    }
    static let forgotpassword = "https://{host}/api/Authentication/"
}

enum APIEndpoint : String {
    case login = "login"
    case forgotPassword = "https://{host}/api/Authentication/SecureForgotPassword?"
    case register = "Register"
}
enum APIName : String {
    
    case login
    case forgotPassword
    case register
    
}

struct APIParamKeys {
    static let kUserName = "username"
    static let kPassword = "password"
    static let kEmailAddress = "EmailAddress"
 
    
}
