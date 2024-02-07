//
//  APIHelper.swift
//  TutumNetUI
//
//  Created by Apple on 18/05/23.
//

import Alamofire
import Foundation
import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

class APIHelper{
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    static let sharedInstance = APIHelper()
    init(responseHandler: ResponseHandler = ResponseHandler()) {
        self.responseHandler = responseHandler
    }
    
    private let responseHandler: ResponseHandler
    
    private var commonHeaders: HTTPHeaders {
        
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization" : "Basic YzNCdmNuUnNhV1psYzNWalkyVnpjdzpjM0J2Y25Sc2FXWmxjM1ZqWTJWemMwQmhjR2xoWTJObGMzTQ=="
        ]
    }
    
    func base64EncodedCredentials(username: String, password: String) -> String {
        let credentials = "\(username):\(password)"
        if let data = credentials.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
    
    func request<T: Codable>(modelType: T.Type, apiurl : String, param : [String:Any]? = nil, methodType : HTTPMethod = .post, completion: @escaping ResultHandler<T>){
        guard let url = URL(string: apiurl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url, method: methodType, parameters: param, encoding: URLEncoding.default, headers: commonHeaders).responseData{ (response:DataResponse)  in
            print("response - \(response)")
            
            switch(response.result) {
            case .success(let data):
                if let stringValue = String(data: data, encoding: .utf8) {
                    print("Response String: \(stringValue)")
                }
                
                self.responseHandler.parseResonseDecode(data: data,
                                                        modelType: modelType,
                                                        completionHandler: { response in
                    switch response {
                    case .success(let mainResponse):
                        completion(.success(mainResponse))
                    case .failure(let error):
                        completion(.failure(error))
                        print("api Failure :::\(error)")
                    }
                })
                break
            case .failure(let error):
                !Connectivity.isConnectedToInternet() ? completion(.failure(.network(error))) :
                completion(.failure(.invalidResponse))
                print("api Failure :::\(error)")
                break
            }
        }
    }
    
    //MARK: - Set Image Multipart from data
    func requestImg<T: Codable>(modelType: T.Type, apiURL: String, parameters: [String: Any]?, methodType: HTTPMethod = .post,image: UIImage?,  // Add this parameter for image upload
                                imageParameterName: String?,  // Add the name of the parameter for the image
                                completion: @escaping ResultHandler<T>
    ) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image?.jpegData(compressionQuality: 0.5), let imageParamName = imageParameterName {
                multipartFormData.append(imageData, withName: imageParamName, fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters ?? [:] {
                if let stringValue = value as? String {
                    multipartFormData.append(stringValue.data(using: .utf8) ?? Data(), withName: key)
                }
            }
        }, to: url, method: methodType, headers: commonHeaders)
        .responseData { response in
            switch response.result {
            case .success(let data):
                if let stringValue = String(data: data, encoding: .utf8) {
                    print("Response String: \(stringValue)")
                }
                
                self.responseHandler.parseResonseDecode(data: data, modelType: modelType) { response in
                    switch response {
                    case .success(let mainResponse):
                        completion(.success(mainResponse))
                    case .failure(let error):
                        completion(.failure(error))
                        print("API Failure: \(error)")
                    }
                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    completion(.failure(.network(error)))
                } else {
                    completion(.failure(.invalidResponse))
                }
                print("API Failure: \(error)")
            }
        }
    }
    
    func requestrawdata<T: Codable>(
        modelType: T.Type,
        apiurl: String,
        rawParams: Data, // Pass raw data as a parameter
        methodType: HTTPMethod = .post,
        completion: @escaping ResultHandler<T>
    ) {
        guard let url = URL(string: apiurl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.upload(rawParams, to: url, method: methodType, headers: commonHeaders)
            .response { response in
                print("response - \(response)")
                
                switch response.result {
                case .success(let data):
                    if let stringValue = String(data: data!, encoding: .utf8) {
                        print("Response String: \(stringValue)")
                    }
                    
                    self.responseHandler.parseResonseDecode(data: data!, modelType: modelType) { response in
                        switch response {
                        case .success(let mainResponse):
                            completion(.success(mainResponse))
                        case .failure(let error):
                            completion(.failure(error))
                            print("api Failure: \(error)")
                        }
                    }
                case .failure(let error):
                    !Connectivity.isConnectedToInternet() ? completion(.failure(.network(error))) :
                    completion(.failure(.invalidResponse))
                    print("api Failure: \(error)")
                }
            }
    }
}


class ResponseHandler {
    
    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    ) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        }catch {
            completionHandler(.failure(.decoding(error)))
        }
    }
}

//class ResponseHandlerr {
//
//    func presentData<T: Decodable>(modelType: T.Type) {
//        let data = try JSONDecoder.decode(modelType, from: Data) {
//            print(Data)
//            //api calling
//            //Notes:- User using get methods calling
//
//            //            completionHandler(.failure)
//        }
//    }
//}
