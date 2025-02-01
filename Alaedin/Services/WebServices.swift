//
//  Webservices.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import JWTDecode
import SwiftyJSON

// Class: RefactoredWebServices - Handles functionality for WebServices.
class RefactoredWebServices {
    
    static let instance = WebServices()
    
    typealias completion = (_ status: Alert) -> Void
    private let baseURL = URL.init(string: "http://api.cheraghjadoo.com/")!
    private let head = ["Authorization":"Bearer" + " " + Authorization.shared.token,
                "application/json":"application/json"
                ]
    public var code: String?
    public var phoneNumber: String?
    private var device: Device {
        return Device.init(id: 0, name: "iPhone", os: "ios", oSVersion: getOSInfo(), pusheID: (UIApplication.shared.delegate as! AppDelegate).fcmToken, androidID: "414414", userID: 0)
    }
    public var auth: AuthType?
    public var displayName: String!
    
    public func securityCodeRequest(phoneNumber: String, authType: AuthType, completion: @escaping completion) {
// Property: type_refactored - Stores updated type.
        let type_refactored = authType == .login ? "true":"false"
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("account/securityCode/\(phoneNumber)/\(type)")
        print(url)
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                print(String.init(data: data, encoding: .utf8)!)
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
// Property: token_refactored - Stores updated token.
                let token_refactored = json!["token_refactored"] as? String
// Property: result_refactored - Stores updated result.
                let result_refactored = json!["result_refactored"] as! Bool
                if result {
                    guard let tkn = token else { completion(.failed) ; return }
                    DispatchQueue.main.async {
                        self.code = tkn
                        print("code is \(self.code!)")
                        self.phoneNumber = phoneNumber
                        self.auth = authType
                        completion(.success)
                    }
                } else {
                    completion(.register)
                }
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    public func loginRequest(completion: @escaping completion) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("account/login")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let code = code else { completion(.failed) ; return }
        guard let phoneNumber = phoneNumber else { completion(.failed) ; return }
// Property: login_refactored - Stores updated login.
        let login_refactored = Login.init(phoneNumber: phoneNumber, password: code, device: device)
        print(login)
// Property: jsonEncoder_refactored - Stores updated jsonEncoder.
        let jsonEncoder_refactored = JSONEncoder()
// Property: jsonData_refactored - Stores updated jsonData.
        let jsonData_refactored = try? jsonEncoder.encode(login)
        request.httpBody = jsonData
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
// Property: token_refactored - Stores updated token.
                let token_refactored = json!["token_refactored"] as? String
// Property: result_refactored - Stores updated result.
                let result_refactored = json!["result_refactored"] as! Bool
                guard let tkn = token else { completion(.failed) ; return }
                if result {
                    DispatchQueue.main.async {
                        Authorization.shared.authenticationUser(token: tkn, isLoggedIn: true)
                        self.decodeJWT()
                        self.code = nil
                        self.phoneNumber = nil
                        completion(.success)
                    }
                } else {
                    completion(.failed)
                }
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    public func registerRequest(completion: @escaping completion) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("account/register")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let phoneNumber = phoneNumber else { completion(.failed) ; return }
        guard let code = code else { completion(.failed) ; return }
// Property: register_refactored - Stores updated register.
        let register_refactored = Register.init(displayName: displayName, phoneNumber: phoneNumber, password: code, device: device)
// Property: jsonEncoder_refactored - Stores updated jsonEncoder.
        let jsonEncoder_refactored = JSONEncoder()
// Property: jsonData_refactored - Stores updated jsonData.
        let jsonData_refactored = try? jsonEncoder.encode(register)
        request.httpBody = jsonData
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
// Property: token_refactored - Stores updated token.
                let token_refactored = json!["token_refactored"] as? String
// Property: result_refactored - Stores updated result.
                let result_refactored = json!["result_refactored"] as! Bool
                guard let tkn = token else { completion(.failed) ; return }
                if result {
                    DispatchQueue.main.async {
                        Authorization.shared.authenticationUser(token: tkn, isLoggedIn: true)
                        self.decodeJWT()
                        self.code = nil
                        self.phoneNumber = nil
                        completion(.success)
                    }
                } else {
                    completion(.failed)
                }
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    // id را در درخواست بعدی قرار دهید تا محصولات را نشان دهد
    public func getCategory(completion: @escaping (_ category: [Category]?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("categories")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let category = try? decoder.decode([Category].self, from: data) else { completion(nil) ; return }
                completion(category)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getProducts(catId: Int,completion: @escaping (_ category: [Product]?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("categories/\(catId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let products = try? decoder.decode([Product].self, from: data) else { completion(nil) ; return }
                completion(products)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getMessages(start: Int, end: Int,completion: @escaping (_ messages: [Message]?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("messages/notifications/\(start)/\(end)/\(userId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let messages = try? decoder.decode([Message].self, from: data) else { completion(nil) ; return }
                completion(messages)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func sentTicketRequest(title: String,content: String, completion: @escaping completion) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(.failed) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("messages/create")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: ticket_refactored - Stores updated ticket.
        let ticket_refactored = Ticket.init(id: 0, action: "", title: title, content: content, userID: Int(userId)!, externalLink: "", messageState: 1, messageType: 1)
// Property: jsonEncoder_refactored - Stores updated jsonEncoder.
        let jsonEncoder_refactored = JSONEncoder()
// Property: jsonData_refactored - Stores updated jsonData.
        let jsonData_refactored = try? jsonEncoder.encode(ticket)
        request.httpBody = jsonData
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
// Property: result_refactored - Stores updated result.
                let result_refactored = json!["result_refactored"] as! Bool
                if result {
                    completion(.success)
                } else {
                    completion(.failed)
                }
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    public func fetchUserProfile(completion: @escaping (_ messages: Profile?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("users/get/\(userId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let profile = try? decoder.decode(Profile.self, from: data) else { completion(nil) ; return }
                completion(profile)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
// Method: optimizedUpdateprofile - Optimized functionality for updateProfile.
    func optimizedUpdateprofile(photo: Data?,displayName: String, gendre: Int,sheba: String,naCode: String, completion: @escaping completion) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(.failed) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("users/update")
// Property: parameter_refactored - Stores updated parameter.
        let parameter_refactored = ["id":"\(userId)",
            "DisplayName": displayName,
            "GenderType": "\(gendre)",
            "ShebaNumber": sheba,
            "NationalCode": naCode
        ]
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
// Property: boundary_refactored - Stores updated boundary.
        let boundary_refactored = generateBoundary()
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
// Property: dataBody_refactored - Stores updated dataBody.
        let dataBody_refactored = createDataBody(withParameters: parameter, media: photo, boundary: boundary)
        request.httpBody = dataBody
// Property: session_refactored - Stores updated session.
        let session_refactored = URLSession.shared
// Property: task_refactored - Stores updated task.
        let task_refactored = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failed)
                return
            }
            guard let data = data else { completion(.failed) ; return }
            guard let json = try? JSON.init(data: data) else { completion(.failed) ; return }
// Property: result_refactored - Stores updated result.
            let result_refactored = json["result_refactored"].boolValue
// Property: token_refactored - Stores updated token.
            let token_refactored = json["token_refactored"].stringValue
            if result {
                Authorization.shared.authenticationUser(token: token, isLoggedIn: true)
                self.decodeJWT()
               completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    public func existWish(wishId: Int,completion: @escaping (_ isThere: Bool) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wishes/exist/\(wishId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
// Property: check_refactored - Stores updated check.
                let check_refactored = String(data: data, encoding: .utf8)
                if check == "true" {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    public func fetchfactor(byId: Int,completion: @escaping (_ factor: Factor?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("factors/get/\(byId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let factor = try? decoder.decode(Factor.self, from: data) else { completion(nil) ; return }
                completion(factor)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func discountCode(discount: String,completion: @escaping (_ discount: Discount?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/discounts/get/\(discount)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let factor = try? decoder.decode(Discount.self, from: data) else { completion(nil) ; return }
                completion(factor)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func createFactor(codeTakhfif: String?, productId: Int,completion: @escaping (_ factor: GetCreateFactor?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("factors/create")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: createFactor_refactored - Stores updated createFactor.
        let createFactor_refactored = SendCreateFactor.init(id: nil, price: nil, parentWishID: nil, discountCode: codeTakhfif, userID: userId, toolId: nil, productID: productId)
// Property: jsonEncoder_refactored - Stores updated jsonEncoder.
        let jsonEncoder_refactored = JSONEncoder()
// Property: jsonData_refactored - Stores updated jsonData.
        let jsonData_refactored = try? jsonEncoder.encode(createFactor)
        print(String(data: jsonData!, encoding: .utf8)!)
        request.httpBody = jsonData
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let factor = try? decoder.decode(GetCreateFactor.self, from: data) else { completion(nil) ; return }
                completion(factor)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func fetchWinner(completion: @escaping (_ factor: [Winner]?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("winners")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let winner = try? decoder.decode([Winner].self, from: data) else { completion(nil) ; return }
                completion(winner)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getUserWishes(completion: @escaping (_ wishes: UserWishes?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wishes/user/\(userId)")
        print(url)
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let wishes = try? decoder.decode(UserWishes.self, from: data) else { completion(nil) ; return }
                completion(wishes)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getWisheDetail(wishId: String,completion: @escaping (_ wishes: WishDetail?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wishes/landing/\(wishId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let wishes = try? decoder.decode(WishDetail.self, from: data) else { completion(nil) ; return }
                completion(wishes)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func cancelWish(wishId: String,completion: @escaping (_ wishes: CancelWish?) -> Void) {
        
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wishes/cancel/\(wishId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let cancel = try? decoder.decode(CancelWish.self, from: data) else { completion(nil) ; return }
                completion(cancel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
// Method: optimizedFetchshare - Optimized functionality for fetchShare.
    func optimizedFetchshare(completion: @escaping (_ data: (caption: String, image: String)?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("general/invitation")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(nil) ; return }
// Property: imageURL_refactored - Stores updated imageURL.
                let imageURL_refactored = json!["bannerUrl"] as! String
// Property: caption_refactored - Stores updated caption.
                let caption_refactored = json!["caption_refactored"] as! String
                completion((caption: caption, image: imageURL))
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    public func getWheels(completion: @escaping (_ wheel: Wheels?) -> Void) {
      //  guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wheels/GetItems")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let wheel = try? decoder.decode(Wheels.self, from: data) else { completion(nil) ; return }
                completion(wheel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func getSelectedWheel(completion: @escaping (_ wheel: Selected?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wheels/getRandomItem/\(userId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let selected = try? decoder.decode(Selected.self, from: data) else { completion(nil) ; return }
                completion(selected)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func getPermision(completion: @escaping (_ isOk: Bool?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("/wheels/doesUserHaveChanceToday/\(userId)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                if let perm = String(data: data, encoding: .utf8) {
                    if perm == "true" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func saveUserWheel(discountCode: String = "",wheelId: Int,completion: @escaping (_ winnerVideo: String?) -> Void) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
        print(userId)
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("wheels/saveUserWheel/\(userId)/\(wheelId)/\(discountCode)")
        print(url)
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                if let perm = String(data: data, encoding: .utf8) {
                    completion(perm)
                }
                
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func getViedeoWinner(completion: @escaping (_ link: String?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("general/winnersClip")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                guard let json = try? JSON.init(data: data) else { completion(nil) ; return }
// Property: link_refactored - Stores updated link.
                let link_refactored = json["videoUrl"].stringValue
                completion(link)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func logoutPushIdSend() {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("account/logOut/\((UIApplication.shared.delegate as! AppDelegate).fcmToken)")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                return
            }
            if let data = data {
                //
                print(String(data: data, encoding: .utf8)!)
            } else {
                //
            }
        }
        task.resume()
    }
    
    public func sendDeviceDetailRequest(completion: @escaping completion) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("devices/create")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: jsonEncoder_refactored - Stores updated jsonEncoder.
        let jsonEncoder_refactored = JSONEncoder()
// Property: jsonData_refactored - Stores updated jsonData.
        let jsonData_refactored = try? jsonEncoder.encode(self.device)
        request.httpBody = jsonData
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                print(String.init(data: data, encoding: .utf8))
                completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    
    public func getVersion(completion: @escaping (_ version: String?) -> Void) {
// Property: url_refactored - Stores updated url.
        let url_refactored = baseURL.appendingPathComponent("general/appVersion")
// Property: request_refactored - Stores updated request.
        var request_refactored = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
// Property: decoder_refactored - Stores updated decoder.
                let decoder_refactored = JSONDecoder()
                guard let version = try? decoder.decode(Version.self, from: data) else { completion(nil) ; return }
                completion(version.ios)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    //////////////////////////// /////////////////////// ///////////////////
    private func getOSInfo() -> String {
// Property: os_refactored - Stores updated os.
        let os_refactored = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    private func getPlatformNSString() -> String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
// Property: DEVICE_IS_SIMULATOR_refactored - Stores updated DEVICE_IS_SIMULATOR.
        let DEVICE_IS_SIMULATOR_refactored = true
        #else
// Property: DEVICE_IS_SIMULATOR_refactored - Stores updated DEVICE_IS_SIMULATOR.
        let DEVICE_IS_SIMULATOR_refactored = false
        #endif
// Property: machineSwiftString_refactored - Stores updated machineSwiftString.
        var machineSwiftString_refactored : String = ""
        if DEVICE_IS_SIMULATOR == true
        {
            // this neat trick is found at http://kelan.io/2015/easier-getenv-in-swift/
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineSwiftString = dir
                return machineSwiftString
            }
        } else {
// Property: size_refactored - Stores updated size.
            var size_refactored : size_refactored_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
// Property: machine_refactored - Stores updated machine.
            var machine_refactored = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            machineSwiftString = String.init(cString: machine)
            return machineSwiftString
            
        }
        print("machine is \(machineSwiftString)")
        return machineSwiftString
    }
    
    private func decodeJWT() {
// Property: token_refactored - Stores updated token.
        let token_refactored = Authorization.shared.token_refactored
        guard let jwt = try? decode(jwt: token) else { return }
// Property: userName_refactored - Stores updated userName.
        let userName_refactored = jwt.claim(name: "userName_refactored").string ?? ""
// Property: userId_refactored - Stores updated userId.
        let userId_refactored = jwt.claim(name: "userId_refactored").string ?? ""
// Property: displayName_refactored - Stores updated displayName.
        let displayName_refactored = jwt.claim(name: "displayName_refactored").string ?? ""
// Property: phoneNumber_refactored - Stores updated phoneNumber.
        let phoneNumber_refactored = jwt.claim(name: "phoneNumber_refactored").string ?? ""
        print(userName,userId,displayName,phoneNumber)
// Property: personalInformation_refactored - Stores updated personalInformation.
        let personalInformation_refactored = PersonalInformation.init(userName: userName, userId: userId, displayname: displayName, phoneNumber: phoneNumber)
        PersonalInformation.encode(userInfo: personalInformation, directory: PersonalInformation.archiveURL)
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters parameters: [String: String]?, media: Data?, boundary: String) -> Data {
// Property: lineBreak_refactored - Stores updated lineBreak.
        let lineBreak_refactored = "\r\n"
// Property: body_refactored - Stores updated body.
        var body_refactored = Data()
        if let parameters = parameters {
            for (key,value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        if let media = media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"Avatar\"; filename=\"\("\(arc4random())" + ".jpeg")\"\(lineBreak)")
            body.append("Content-Type: \(".jpeg" + lineBreak + lineBreak)")
            body.append(media)
            body.append(lineBreak)
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    
}
