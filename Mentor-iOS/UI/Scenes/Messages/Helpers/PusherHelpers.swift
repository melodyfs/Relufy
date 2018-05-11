//
//  PusherHelpers.swift
//  Mentor-iOS
//
//  Created by Melody on 3/27/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import PusherSwift

class AuthRequestBuilder: AuthRequestBuilderProtocol {
    func requestFor(socketID: String, channelName: String) -> URLRequest? {
//        let base = URL(string: "http://localhost:3000/pushers")
        let base = URL(string: "https://mentor-app-server.herokuapp.com/pushers")
        var request = URLRequest(url: base!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization": "Token token=\(token)"]
        request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: String.Encoding.utf8)
        return request
    }
}

 //MARK: - Publish events from server

//        let options = PusherClientOptions(
//            host: .cluster(cluster)
//        )
//
//        pusher = Pusher(key: key, options: options)
//        let myChannel = pusher.subscribe("my-channel")

//        let _ = myChannel.bind(eventName: "my-event", callback: { (data: Any?) -> Void in
//            if let data = data as? [String : AnyObject] {
//                if let message = data["message"] as? String {
//                    print(message)
//                }
//            }
//        })
