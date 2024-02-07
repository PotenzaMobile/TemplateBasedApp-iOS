//
//  ErrorConstants.swift
//  GymTemplateiOS
//
//  Created by Potenza on 07/02/24.
//

import Foundation

class ErrorMessages {

    struct APIFailureErrors {
        static let kStatusFailed = "Status Failed"
        static let kInvalidAccessToken = "Invalid Access Token"
        static let kUserDoesNotExist = "User Does Not Exist"
        static let kresponseTimeOut = "Response TimeOut.Please try after sometime."
    }
    
    struct NetworkIssueErrors{
        static let kNoInternet = "You are not connected to a stable internet connection.Please try again later"
    }
}

class SuccessMessages {
    
    struct AuthenticationMessages {
        static let kLoginSuccess = "Login Successfully!"
        static let kRegistrationSuccess = "You are registered successfully!"
    }
}
