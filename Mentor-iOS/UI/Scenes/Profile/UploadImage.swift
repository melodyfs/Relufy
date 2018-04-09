//
//  UploadImage.swift
//  Grocery
//
//  Created by Melody on 11/29/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KeychainSwift

class UploadImage {
    
    static func upload(route: Route, imageData: Data) {
        let session = URLSession.shared
        let base = "https://mentor-app-server.herokuapp.com"
        let fullURL = base + route.path()
        var url = URL(string: fullURL)!
        let name = "image_file"

        Alamofire.upload(multipartFormData: { (multiPartFormData) in
            
            multiPartFormData.append(imageData, withName: name, fileName: "profile_img", mimeType: "image/png")
            
        }, usingThreshold: UInt64.init(), to: url, method: .patch, headers: route.headers(), encodingCompletion: { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                })
                
                upload.responseJSON { response in
                    print(response.description)
                }
                
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
            
        })
    }
    
}
