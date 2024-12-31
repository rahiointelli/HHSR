//
//  NetworkUtilities.swift
//  EkChat
//
//  Created by Nirav Jariwala on 16/07/18.
//  Copyright © 2018 Nirav Jariwala. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreTelephony

typealias APIResponseImageVideoData = (_ data: Data, _ error: Error) -> Void

struct APIResponse {
    var error: Error?
    var result: JSON
}


class NetworkUtilities : NSObject
{
    static let shared = NetworkUtilities()
    let reachablity = NetworkReachabilityManager()
    
    
    var isConnectedToInternet: Bool {
        if let isNetworkReachable = self.reachablity?.isReachable,
            isNetworkReachable == true {
            return true
        } else {
            return false
        }
    }
    
    var cellularDataRestrictedStateUnknown = CTCellularDataRestrictedState.restrictedStateUnknown
    var cellularDataRestrictedStateRestricted = CTCellularDataRestrictedState.restricted
    
    var isCellularDataPermissionOn: Bool {
      if ((cellularDataRestrictedStateUnknown == .restrictedStateUnknown) || (cellularDataRestrictedStateRestricted == .restricted))
        {
            return false
        } else {
            return true
        }
    }
    
    override init() {
        super.init()
        self.reachablity?.startListening()
        self.reachablity?.listener = { status in
            if let isNetworkReachable = self.reachablity?.isReachable,
                isNetworkReachable == true {
                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                print("Internet Connected")
                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNamesConstant.keyInternetStatusChanged), object: nil, userInfo: nil)
//                if(AppDelegate.sharedDelegate().UserId == "")
//                {
//                }
//                else if(AppDelegate.sharedDelegate().UserIsVerified == "1")
//                {
//                    AppDelegate.sharedDelegate().updateScoreOnServer()
//                }
            } else {
                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                print("Internet Disconnected")
                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
            }
        }
    }
    
    private func validateResponse(json: [String: Any]) -> String? {
        print("JSON: \(json)") // serialized json response
        if let error = json["error"] as? String {
            return error
        } else if let success = json["statuscode"] as? NSInteger,
            success != 200 {
            if let data = json["Responsebody"] as? String,
                data != "<null>" {
                return data
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func wrongResponse(with errorMessage: String?) -> APIResponse{
        if let errorMessage = errorMessage {
            return (APIResponse.init(error: NSError.error(with: errorMessage), result: JSON.null))
        } else {
            return (APIResponse.init(error: nil, result: JSON.null))
        }
    }
    
    
    func makePOSTwithMultipartFormDataRequest(with urlString: String, fromWhere: String, parameters: Parameters?,imageParameters: Parameters?,VideoParameters: Parameters?, DocumentParameters: Parameters?,thumbImageParameters: Parameters?,ImgData : Data?, VideoData : URL?, _ completion: @escaping (APIResponse) -> Void)
    {
        if !self.isConnectedToInternet {
            
            if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
            
        }
        
        func handleCorrectResponse(with data: JSON) {
            //if let data = data["Responsebody"] as? [String: Any]
            if let data = data.dictionary!["Responsebody"]
            {
                completion(APIResponse.init(error: nil, result: JSON(data)))
            } else {
                completion(APIResponse.init(error: nil, result: data))
            }
            return
        }
        
        var headers: HTTPHeaders? = nil
        
        if(AppDelegate.sharedDelegate().RoomId.count > 0)
        {
            headers = [
            "Content-type": "multipart/form-data",
            "Authorization": CommonUtility.shared.getAPIToken()]
        }
        else
        {
            headers = [
                "Content-type": "multipart/form-data"]
        }

        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in

                    if(parameters != nil)
                    {
                        for (key, value) in parameters!
                        {
                            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                            //.data(using: String.Encoding.utf8.rawValue)!
                        }
                    }
            
                    if(ImgData != nil)
                    {
                        multipartFormData.append(ImgData!, withName: "file",fileName: "Img_\(UUID().uuidString).jpg", mimeType: "image/jpg")
                    }
                    
                    if(VideoData != nil)
                    {
                          multipartFormData.append(VideoData!, withName: "file",fileName: "Vid_\(UUID().uuidString).mov", mimeType: "video/mov")
                    }

                    var kIndx = 0
                    var thumbIndx = 0
                    if(imageParameters!.count > 0)
                    {
                        for (key, value) in imageParameters!
                        {
                            multipartFormData.append(value as! Data,withName: "file\(kIndx)",fileName: String.init(format:"%@",key),
                                                 mimeType: "image/jpg")
                            kIndx = kIndx + 1
                        }
                    }
                    
                    if(VideoParameters!.count > 0)
                    {
                        thumbIndx = kIndx
                        for (key, value) in VideoParameters!
                        {
                            multipartFormData.append(value as! URL,withName: "file\(kIndx)",fileName: String.init(format:"%@",key),
                                                 mimeType: "video/mov")
                            kIndx = kIndx + 1
                        }
                    }
            
                    if(thumbImageParameters!.count > 0)
                    {
                        for (key, value) in thumbImageParameters!
                        {
                            multipartFormData.append(value as! Data,withName: "thumbnail\(thumbIndx)",fileName: String.init(format:"%@",key),
                                                 mimeType: "image/jpg")
                            thumbIndx = thumbIndx + 1
                        }
                    }
                    
                   if(DocumentParameters!.count > 0)
                   {
                       for (key, value) in DocumentParameters!
                       {
                           let url = value as! URL
                          // let pathExtension = url.pathExtension

                        multipartFormData.append(url,withName: "file\(kIndx)",fileName: String.init(format:"%@HHSR$%@",key,url.lastPathComponent),mimeType:"application/pdf")
                        //self.mimeTypeForPath(path: url.absoluteString))
                        //mimeType:"application/pdf")
                            
                        
        //                multipartFormData.append(url,withName: "file\(kIndx)",fileName: String.init(format:"%@.pdf",key),
        //                                                     mimeType: "application/pdf")
                        
                           kIndx = kIndx + 1
                       }
                   }
                    
                }, usingThreshold: 1, to: urlString, method: .post, headers: headers) { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let json = response.result.value as? [String: Any] {
                                print("JSON: \(json)") // serialized json response
                                
                                let jsonobj = JSON(json)
                                if(response.response?.statusCode == 200)
                                {
                                    if let data = jsonobj.dictionary!["Responsebody"] {
                                        handleCorrectResponse(with: JSON(data))
                                    } else {
                                        handleCorrectResponse(with: jsonobj)
                                    }
                                }
                                else
                                {
                                    if let error = json["error"] as? String {
                                        return completion(self.wrongResponse(with: error))
                                    }
                                    else
                                    {
                                        return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                                    }
                                }
                            }else if let data = response.data {
                                let dataString = String(data: data, encoding: .utf8)
                                print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                                do {
                                    let json = try JSON.init(data:data)
                                    
                                    if(response.response?.statusCode == 200)
                                    {
                                        handleCorrectResponse(with: json)
                                    }
                                    else if((json.dictionary!["error"]) != nil)
                                    {
                                        return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                                    }
                                    else
                                    {
                                        return completion(self.wrongResponse(with: nil))
                                    }
                                    
                                } catch {
                                    print("Error while converting to json: \(error.localizedDescription)")
                                    completion(self.wrongResponse(with: error.localizedDescription))
                                }
                            } else {
                                completion(self.wrongResponse(with: nil))
                            }
                            
                            print(response.request as Any)  // original URL request
                            print(response.response as Any) // URL response
                            print(response.result.value as Any)   // result of response serialization
                            
                            print("check now")
                        }
                        break
                        
                    case .failure(let error):
                        print(error)
                        print("Error while converting to json: \(error.localizedDescription)")
                        completion(self.wrongResponse(with: error.localizedDescription))
                        break
                    }
                }
            }
    
    func makePOSTwithDataRequest(with urlString: String, parameters: Parameters?, _ completion: @escaping (APIResponse) -> Void) {
        if !self.isConnectedToInternet {
             if(!isCellularDataPermissionOn)
                      {
                          completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
                      }
                      else
                      {
                          completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
                      }
        }
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
            
        }
        
        func handleCorrectResponse(with data: JSON) {
            //if let data = data["Responsebody"] as? [String: Any]
            if let data = data.dictionary!["Responsebody"]
            {
                completion(APIResponse.init(error: nil, result: JSON(data)))
            } else {
                completion(APIResponse.init(error: nil, result: data))
            }
            return
        }
        
        let headers: HTTPHeaders? = [
            "Content-type": "application/x-www-form-urlencoded"]
            //"Authorization": Utility.getDeviceToken()]
        //        let fullURL = self.makeAPIPath(with: urlString)
        //        print("Calling POST: \(fullURL)")
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
            .responseJSON { response in
//                if (response.response?.statusCode == 401)
//                {
//                    if let data : [String:AnyObject] = response.value as? [String:AnyObject]{
//                        Utility.alertWithMessage(message: data["Message"] as! String)
//                    }
//                    Utility.hideLoader()
//                    return
//                }
                if let json = response.result.value as? [String: Any] {
                    print("JSON: \(json)") // serialized json response
                    
                    let jsonobj = JSON(json)
                    if(response.response?.statusCode == 200)
                    {
                        if let data = jsonobj.dictionary!["Responsebody"] {
                            handleCorrectResponse(with: JSON(data))
                        } else {
                            handleCorrectResponse(with: jsonobj)
                        }
                    }
                    else
                    {
                        if let error = json["error"] as? String {
                            return completion(self.wrongResponse(with: error))
                        }
                        else if let error = json["Message"] as? String {
                            return completion(self.wrongResponse(with: error))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        }
                    }
                    
                } else if let data = response.data {
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                    do {
                        let json = try JSON.init(data:data)
                        
                        if(response.response?.statusCode == 200)
                        {
                            handleCorrectResponse(with: json)
                        }
                        else if((json.dictionary!["error"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                        }
                        else if((json.dictionary!["Message"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["Message"]?.string))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: nil))
                        }
                        
                    } catch {
                        print("Error while converting to json: \(error.localizedDescription)")
                        completion(self.wrongResponse(with: error.localizedDescription))
                    }
                } else {
                    completion(self.wrongResponse(with: nil))
                }
                
                //print(response.request as Any)  // original URL request
                //print(response.response as Any) // URL response
                //print(response.result.value as Any)   // result of response serialization
                
                //print("check now")
        }
    }
    
    func makePOSTRequest(with urlString: String, parameters: Parameters?, _ completion: @escaping (APIResponse) -> Void) {
        if !self.isConnectedToInternet {
               if(!isCellularDataPermissionOn)
               {
                   completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
               }
               else
               {
                   completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
               }
        }
        
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
            
        }
        
        func handleCorrectResponse(with data: JSON) {
            //if let data = data["Responsebody"] as? [String: Any]
             if let data = data.dictionary!["Responsebody"]
            {
                completion(APIResponse.init(error: nil, result: JSON(data)))
            } else {
                completion(APIResponse.init(error: nil, result: data))
            }
            return
        }
        
        var headers: HTTPHeaders? = nil
        
        if(AppDelegate.sharedDelegate().RoomId.count > 0)
        {
            headers = [
            "Content-type": "application/json",
            "Authorization": CommonUtility.shared.getAPIToken()]
        }
        else
        {
            headers = [
                "Content-type": "application/json"]
        }
        
        
//        let fullURL = self.makeAPIPath(with: urlString)
//        print("Calling POST: \(fullURL)")
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .responseString{ response in
//
//            }
            .responseJSON { response in
                //(options: .mutableLeaves)
                if(response.error != nil)
                {
                    completion(self.wrongResponse(with: response.error?.localizedDescription))
                }
                else if let json = response.result.value as? [String: Any] {
                    print("JSON: \(json)") // serialized json response
                   
                    let jsonobj = JSON(json)
                    if(response.response?.statusCode == 200)
                    {
                        if let data = jsonobj.dictionary!["Responsebody"] {
                            handleCorrectResponse(with: JSON(data))
                        } else {
                            handleCorrectResponse(with: jsonobj)
                        }
                    }
                    else
                    {
                        if let error = json["error"] as? String {
                            return completion(self.wrongResponse(with: error))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        }
                    }
                    
                } else if let data = response.data {
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                    do {
                        let json = try JSON.init(data:data)
                        
                        if(response.response?.statusCode == 200)
                        {
                            handleCorrectResponse(with: json)
                        }
                        else if((json.dictionary!["error"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: nil))
                        }
                        
                    } catch {
                        print("Error while converting to json: \(error.localizedDescription)")
                        completion(self.wrongResponse(with: error.localizedDescription))
                    }
                } else {
                    completion(self.wrongResponse(with: nil))
                }
               // print(response.request as Any)  // original URL request
               // print(response.response as Any) // URL response
               // print(response.result.value as Any)   // result of response serialization
                print("check now")
        }
    }
    
    func makePOSTRequest1(with urlString: String, parameters: Parameters?, _ completion: @escaping (APIResponse) -> Void) {
        if !self.isConnectedToInternet {
            if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
            
        }
        
        func handleCorrectResponse(with data: JSON) {
            //if let data = data["Responsebody"] as? [String: Any]
            if let data = data.dictionary!["Responsebody"]
            {
                completion(APIResponse.init(error: nil, result: JSON(data)))
            } else {
                completion(APIResponse.init(error: nil, result: data))
            }
            return
        }
        
        var headers: HTTPHeaders? = nil
        
//        if(AppDelegate.sharedDelegate().isDeviceTokenSet)
//        {
//            headers = [
//                "Content-type": "application/json"]
//                //"Authorization": AppDelegate.sharedDelegate().AuthenticationToken]
//        }
//        else
//        {
            headers = [
                "Content-type": "application/json"]
//        }
        
        
        //        let fullURL = self.makeAPIPath(with: urlString)
        //        print("Calling POST: \(fullURL)")
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            //            .responseString{ response in
            //
            //            }
//            .responseString{ response in
//                print("here")
//            }
            .responseJSON { response in
                //(options: .mutableLeaves)
                if(response.error != nil)
                {
                    completion(self.wrongResponse(with: response.error?.localizedDescription))
                }
                else if let json = response.result.value as? [String: Any] {
                    print("JSON: \(json)") // serialized json response

                    let jsonobj = JSON(json)
                    if(response.response?.statusCode == 200)
                    {
                        if let data = jsonobj.dictionary!["Responsebody"] {
                            handleCorrectResponse(with: JSON(data))
                        } else {
                            handleCorrectResponse(with: jsonobj)
                        }
                    }
                    else
                    {
                        if let error = json["error"] as? String {
                            return completion(self.wrongResponse(with: error))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        }
                    }

                } else if let data = response.data {
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                    do {
                        let json = try JSON.init(data:data)

                        if(response.response?.statusCode == 200)
                        {
                            handleCorrectResponse(with: json)
                        }
                        else if((json.dictionary!["error"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: nil))
                        }

                    } catch {
                        print("Error while converting to json: \(error.localizedDescription)")
                        completion(self.wrongResponse(with: error.localizedDescription))
                    }
                } else {
                    completion(self.wrongResponse(with: nil))
                }
                // print(response.request as Any)  // original URL request
                // print(response.response as Any) // URL response
                // print(response.result.value as Any)   // result of response serialization
                print("check now")
        }
    }
    
    func makeGETRequest(with urlString: String, parameters: Parameters? = nil, _ completion: @escaping (APIResponse) -> Void) -> Void {
        if !self.isConnectedToInternet {
            if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
        }
        
        var headers: HTTPHeaders? = nil
        
        if(AppDelegate.sharedDelegate().RoomId.count > 0)
        {
            headers = [
            "Content-type": "application/json",
            "Authorization": CommonUtility.shared.getAPIToken()]
        }
        else
        {
            headers = [
                "Content-type": "application/json"]
        }
        
        func handleCorrectResponse(with data: JSON) {
            completion(APIResponse.init(error: nil, result: data))
            return
        }
        
//        var fullURL = ""
//        //        if  !urlString.contains(GetMapPath) {
//        //            fullURL = self.makeAPIPath(with: urlString)
//        //        } else {
//        fullURL = urlString
//        //        }
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                    let jsonobj = JSON(json)
                if(response.response?.statusCode == 200)
                {
                    if let data = jsonobj.dictionary!["Responsebody"] {
                        handleCorrectResponse(with: JSON(data))
                    } else {
                        handleCorrectResponse(with: jsonobj)
                    }
                }
                else
                {
                    if let error = json["error"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else if let error = json["Message"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))

                    }
                }
            } else if let data = response.data {
                let dataString = String(data: data, encoding: .utf8)
                print("Data: \(String(describing: dataString))") // original server data as UTF8 string

                do {
                       let json = try JSON.init(data:data)
                    
                        if(response.response?.statusCode == 200)
                        {
                             handleCorrectResponse(with: json)
                        }
                        else if((json.dictionary!["error"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                        }
                        else if((json.dictionary!["Message"]) != nil)
                        {
                            return completion(self.wrongResponse(with: json.dictionary!["Message"]?.string))
                        }
                        else
                        {
                            return completion(self.wrongResponse(with: nil))
                        }
                    
                } catch {
                    print("Error while converting to json: \(error.localizedDescription)")
                    completion(self.wrongResponse(with: error.localizedDescription))
                }
                
            } else {
                completion(self.wrongResponse(with: nil))
            }
        }
    }
    
    func makeGETRequest1(with urlString: String, parameters: Parameters? = nil, _ completion: @escaping (APIResponse) -> Void) -> Void {
        if !self.isConnectedToInternet {
            if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
        }
        
        var headers: HTTPHeaders? = [
            "Content-type":"application/json"]//,
            //"Authorization": AppDelegate.sharedDelegate().AuthenticationToken]
        
        func handleCorrectResponse(with data: JSON) {
            completion(APIResponse.init(error: nil, result: data))
            return
        }
        
        //        var fullURL = ""
        //        //        if  !urlString.contains(GetMapPath) {
        //        //            fullURL = self.makeAPIPath(with: urlString)
        //        //        } else {
        //        fullURL = urlString
        //        //        }
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                let jsonobj = JSON(json)
                if(response.response?.statusCode == 200)
                {
                    if let data = jsonobj.dictionary!["Responsebody"] {
                        handleCorrectResponse(with: JSON(data))
                    } else {
                        handleCorrectResponse(with: jsonobj)
                    }
                }
                else
                {
                    if let error = json["error"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else if let error = json["Message"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        
                    }
                }
            } else if let data = response.data {
                let dataString = String(data: data, encoding: .utf8)
                print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                
                do {
                    let json = try JSON.init(data:data)
                    
                    if(response.response?.statusCode == 200)
                    {
                        handleCorrectResponse(with: json)
                    }
                    else if((json.dictionary!["error"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                    }
                    else if((json.dictionary!["Message"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["Message"]?.string))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: nil))
                    }
                    
                } catch {
                    print("Error while converting to json: \(error.localizedDescription)")
                    completion(self.wrongResponse(with: error.localizedDescription))
                }
                
            } else {
                completion(self.wrongResponse(with: nil))
            }
        }
    }
    
    func makeGETRequestURLEncoded(with urlString: String, parameters: Parameters? = nil, _ completion: @escaping (APIResponse) -> Void) -> Void {
        if !self.isConnectedToInternet {
           if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
        }
        
        let headers: HTTPHeaders? = [
            "Content-type": "application/x-www-form-urlencoded"]
            //"Authorization": Utility.getDeviceToken()]
        
        func handleCorrectResponse(with data: JSON) {
            completion(APIResponse.init(error: nil, result: data))
            return
        }
        
        //        var fullURL = ""
        //        //        if  !urlString.contains(GetMapPath) {
        //        //            fullURL = self.makeAPIPath(with: urlString)
        //        //        } else {
        //        fullURL = urlString
        //        //        }
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                let jsonobj = JSON(json)
                if(response.response?.statusCode == 200)
                {
                    if let data = jsonobj.dictionary!["Responsebody"] {
                        handleCorrectResponse(with: JSON(data))
                    } else {
                        handleCorrectResponse(with: jsonobj)
                    }
                }
                else
                {
                    if let error = json["error"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else if let error = json["Message"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        
                    }
                }
            } else if let data = response.data {
                let dataString = String(data: data, encoding: .utf8)
                print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                
                do {
                    let json = try JSON.init(data:data)
                    
                    if(response.response?.statusCode == 200)
                    {
                        handleCorrectResponse(with: json)
                    }
                    else if((json.dictionary!["error"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                    }
                    else if((json.dictionary!["Message"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["Message"]?.string))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: nil))
                    }
                    
                } catch {
                    print("Error while converting to json: \(error.localizedDescription)")
                    completion(self.wrongResponse(with: error.localizedDescription))
                }
                
            } else {
                completion(self.wrongResponse(with: nil))
            }
        }
    }
    
    func makePUTRequest(with urlString: String, parameters: Parameters? = nil, _ completion: @escaping (APIResponse) -> Void) -> Void {
        if !self.isConnectedToInternet {
           if(!isCellularDataPermissionOn)
            {
                completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
            }
            else
            {
                completion(APIResponse.init(error: NSError.error(with: "No internet connection."), result: JSON.null))
            }
        }
        
        if urlString.isEmpty {
            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
        }
        
        var headers: HTTPHeaders? = [
            "Content-type":"application/json"]
            //"Authorization": Utility.getDeviceToken()]
        
        func handleCorrectResponse(with data: JSON) {
            completion(APIResponse.init(error: nil, result: data))
            return
        }
        
        //        var fullURL = ""
        //        //        if  !urlString.contains(GetMapPath) {
        //        //            fullURL = self.makeAPIPath(with: urlString)
        //        //        } else {
        //        fullURL = urlString
        //        //        }
        
        Alamofire.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                let jsonobj = JSON(json)
                if(response.response?.statusCode == 200)
                {
                    if let data = jsonobj.dictionary!["Responsebody"] {
                        handleCorrectResponse(with: JSON(data))
                    } else {
                        handleCorrectResponse(with: jsonobj)
                    }
                }
                else
                {
                    if let error = json["error"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else if let error = json["Message"] as? String {
                        return completion(self.wrongResponse(with: error))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: json["ExceptionMessage"] as? String))
                        
                    }
                }
            } else if let data = response.data {
                let dataString = String(data: data, encoding: .utf8)
                print("Data: \(String(describing: dataString))") // original server data as UTF8 string
                
                do {
                    let json = try JSON.init(data:data)
                    
                    if(response.response?.statusCode == 200)
                    {
                        handleCorrectResponse(with: json)
                    }
                    else if((json.dictionary!["error"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
                    }
                    else if((json.dictionary!["Message"]) != nil)
                    {
                        return completion(self.wrongResponse(with: json.dictionary!["Message"]?.string))
                    }
                    else
                    {
                        return completion(self.wrongResponse(with: nil))
                    }
                    
                } catch {
                    print("Error while converting to json: \(error.localizedDescription)")
                    completion(self.wrongResponse(with: error.localizedDescription))
                }
                
            } else {
                completion(self.wrongResponse(with: nil))
            }
        }
    }
//    func makeGETRequestForDownloadImage(with urlString: String, parameters: Parameters? = nil, _ completion: @escaping (APIResponse) -> Void) -> Void {
//
//        if !self.isConnectedToInternet {
//            completion(APIResponse.init(error: NSError.error(with: ErrorMsg.keyTurnOnAppCellularData), result: JSON.null))
//        }
//
//        if urlString.isEmpty {
//            completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
//        }
//
//        func handleCorrectResponse(with data: JSON) {
//            completion(APIResponse.init(error: nil, result: data))
//            return
//        }
//        Alamofire.request(urlString).responseData { (response) in
//            if let data = response.data {
//                let dataString = String(data: data, encoding: .utf8)
//                print("Data: \(String(describing: dataString))") // original server data as UTF8 string
//
//                do {
//                    let json = try JSON.init(data:data)
//
//                    if(response.response?.statusCode == 200)
//                    {
//                        handleCorrectResponse(with: json)
//                    }
//                    else if((json.dictionary!["error"]) != nil)
//                    {
//                        return completion(self.wrongResponse(with: json.dictionary!["error"]?.string))
//                    }
//                    else
//                    {
//                        return completion(self.wrongResponse(with: nil))
//                    }
//
//                } catch {
//                    print("Error while converting to json: \(error.localizedDescription)")
//                    completion(self.wrongResponse(with: error.localizedDescription))
//                }
//
//            } else {
//                completion(self.wrongResponse(with: nil))
//            }
//        }
//
//    }
    
    func makeGETRequestForDownloadImage(with urlString: String, completionHandler:@escaping (Data?, Error?)->()) ->() {
        
        if !self.isConnectedToInternet {
            if(!isCellularDataPermissionOn)
            {
                completionHandler(nil,NSError.error(with: ErrorMsg.keyTurnOnAppCellularData))
            }
            else
            {
                completionHandler(nil,NSError.error(with: "No internet connection."))
            }
        }
        if urlString.isEmpty {
            //completion(APIResponse.init(error: NSError.error(with: "request is invalid!"), result: JSON.null))
            completionHandler(nil,NSError.error(with: "request is invalid!"))

        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url  = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            print()
            
            if let dataImageVideo = data
            {
                if (response as! HTTPURLResponse).statusCode == 200
                {
                    completionHandler(dataImageVideo,nil)
                }
                else
                {
                    completionHandler(nil,error!)
                }
            }
            else
            {
                completionHandler(nil,error!)
            }
        })
        task.resume()
    }
}
