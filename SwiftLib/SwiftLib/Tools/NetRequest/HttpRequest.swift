//
//  HttpRequest.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import Alamofire
class HttpRequest: NSObject {
    
    static func postRequst(url: URL, parameters: [String : Any], success: @escaping (_ json: JSON) -> Void) -> Void {
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            print("\(parameters) \n \(String(describing: response.request))")

            switch response.result {
            case .success(let suce):
                guard let value = suce as? [String : Any] else { return }
                let aJson = JSON(value)
                success(aJson)
            case .failure(let error):
                print(error)
            }

        }
        
        
    }
    
}
