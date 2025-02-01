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

class WebServices {
    
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
        let type = authType == .login ? "true":"false"
        let url = baseURL.appendingPathComponent("account/securityCode/\(phoneNumber)/\(type)")
        print(url)
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                print(String.init(data: data, encoding: .utf8)!)
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
                let token = json!["token"] as? String
                let result = json!["result"] as! Bool
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
        let url = baseURL.appendingPathComponent("account/login")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let code = code else { completion(.failed) ; return }
        guard let phoneNumber = phoneNumber else { completion(.failed) ; return }
        let login = Login.init(phoneNumber: phoneNumber, password: code, device: device)
        print(login)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(login)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
                let token = json!["token"] as? String
                let result = json!["result"] as! Bool
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
        let url = baseURL.appendingPathComponent("account/register")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let phoneNumber = phoneNumber else { completion(.failed) ; return }
        guard let code = code else { completion(.failed) ; return }
        let register = Register.init(displayName: displayName, phoneNumber: phoneNumber, password: code, device: device)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(register)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
                let token = json!["token"] as? String
                let result = json!["result"] as! Bool
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
        let url = baseURL.appendingPathComponent("categories")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let category = try? decoder.decode([Category].self, from: data) else { completion(nil) ; return }
                completion(category)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getProducts(catId: Int,completion: @escaping (_ category: [Product]?) -> Void) {
        let url = baseURL.appendingPathComponent("categories/\(catId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("messages/notifications/\(start)/\(end)/\(userId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("messages/create")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let ticket = Ticket.init(id: 0, action: "", title: title, content: content, userID: Int(userId)!, externalLink: "", messageState: 1, messageType: 1)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(ticket)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(.failed) ; return }
                let result = json!["result"] as! Bool
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
        let url = baseURL.appendingPathComponent("users/get/\(userId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let profile = try? decoder.decode(Profile.self, from: data) else { completion(nil) ; return }
                completion(profile)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func updateProfile(photo: Data?,displayName: String, gendre: Int,sheba: String,naCode: String, completion: @escaping completion) {
        guard let userId = DataManager.shared.userInformation?.userId else { completion(.failed) ; return }
        let url = baseURL.appendingPathComponent("users/update")
        let parameter = ["id":"\(userId)",
            "DisplayName": displayName,
            "GenderType": "\(gendre)",
            "ShebaNumber": sheba,
            "NationalCode": naCode
        ]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameter, media: photo, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failed)
                return
            }
            guard let data = data else { completion(.failed) ; return }
            guard let json = try? JSON.init(data: data) else { completion(.failed) ; return }
            let result = json["result"].boolValue
            let token = json["token"].stringValue
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
        let url = baseURL.appendingPathComponent("/wishes/exist/\(wishId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                let check = String(data: data, encoding: .utf8)
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
        let url = baseURL.appendingPathComponent("factors/get/\(byId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let factor = try? decoder.decode(Factor.self, from: data) else { completion(nil) ; return }
                completion(factor)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func discountCode(discount: String,completion: @escaping (_ discount: Discount?) -> Void) {
        let url = baseURL.appendingPathComponent("/discounts/get/\(discount)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("factors/create")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let createFactor = SendCreateFactor.init(id: nil, price: nil, parentWishID: nil, discountCode: codeTakhfif, userID: userId, toolId: nil, productID: productId)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(createFactor)
        print(String(data: jsonData!, encoding: .utf8)!)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let factor = try? decoder.decode(GetCreateFactor.self, from: data) else { completion(nil) ; return }
                completion(factor)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func fetchWinner(completion: @escaping (_ factor: [Winner]?) -> Void) {
        let url = baseURL.appendingPathComponent("winners")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("/wishes/user/\(userId)")
        print(url)
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let wishes = try? decoder.decode(UserWishes.self, from: data) else { completion(nil) ; return }
                completion(wishes)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getWisheDetail(wishId: String,completion: @escaping (_ wishes: WishDetail?) -> Void) {
        let url = baseURL.appendingPathComponent("/wishes/landing/\(wishId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let wishes = try? decoder.decode(WishDetail.self, from: data) else { completion(nil) ; return }
                completion(wishes)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func cancelWish(wishId: String,completion: @escaping (_ wishes: CancelWish?) -> Void) {
        
        let url = baseURL.appendingPathComponent("/wishes/cancel/\(wishId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let cancel = try? decoder.decode(CancelWish.self, from: data) else { completion(nil) ; return }
                completion(cancel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchShare(completion: @escaping (_ data: (caption: String, image: String)?) -> Void) {
        let url = baseURL.appendingPathComponent("general/invitation")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { completion(nil) ; return }
                let imageURL = json!["bannerUrl"] as! String
                let caption = json!["caption"] as! String
                completion((caption: caption, image: imageURL))
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func getWheels(completion: @escaping (_ wheel: Wheels?) -> Void) {
      //  guard let userId = DataManager.shared.userInformation?.userId else { completion(nil) ; return }
        let url = baseURL.appendingPathComponent("/wheels/GetItems")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("/wheels/getRandomItem/\(userId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
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
        let url = baseURL.appendingPathComponent("/wheels/doesUserHaveChanceToday/\(userId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        let url = baseURL.appendingPathComponent("wheels/saveUserWheel/\(userId)/\(wheelId)/\(discountCode)")
        print(url)
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        let url = baseURL.appendingPathComponent("general/winnersClip")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                guard let json = try? JSON.init(data: data) else { completion(nil) ; return }
                let link = json["videoUrl"].stringValue
                completion(link)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func logoutPushIdSend() {
        let url = baseURL.appendingPathComponent("account/logOut/\((UIApplication.shared.delegate as! AppDelegate).fcmToken)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        let url = baseURL.appendingPathComponent("devices/create")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self.device)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        let url = baseURL.appendingPathComponent("general/appVersion")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
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
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    private func getPlatformNSString() -> String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
        let DEVICE_IS_SIMULATOR = true
        #else
        let DEVICE_IS_SIMULATOR = false
        #endif
        var machineSwiftString : String = ""
        if DEVICE_IS_SIMULATOR == true
        {
            // this neat trick is found at http://kelan.io/2015/easier-getenv-in-swift/
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineSwiftString = dir
                return machineSwiftString
            }
        } else {
            var size : size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            machineSwiftString = String.init(cString: machine)
            return machineSwiftString
            
        }
        print("machine is \(machineSwiftString)")
        return machineSwiftString
    }
    
    private func decodeJWT() {
        let token = Authorization.shared.token
        guard let jwt = try? decode(jwt: token) else { return }
        let userName = jwt.claim(name: "userName").string ?? ""
        let userId = jwt.claim(name: "userId").string ?? ""
        let displayName = jwt.claim(name: "displayName").string ?? ""
        let phoneNumber = jwt.claim(name: "phoneNumber").string ?? ""
        print(userName,userId,displayName,phoneNumber)
        let personalInformation = PersonalInformation.init(userName: userName, userId: userId, displayname: displayName, phoneNumber: phoneNumber)
        PersonalInformation.encode(userInfo: personalInformation, directory: PersonalInformation.archiveURL)
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters parameters: [String: String]?, media: Data?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
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

