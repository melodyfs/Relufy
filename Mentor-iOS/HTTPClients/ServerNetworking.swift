//
//  ServerNetworking.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import KeychainSwift

let keychain = KeychainSwift()

enum Route {
    case createMentor
    case getMentor
    case updateMentor
    case createMentee
    case getMentee
    case updateMentee
    case sendMessage
    case getMatchesAll
    case getMatchesImages
    case getMessages
    case saveMessage
    case getSingleChatHistory
    case confirmMatched
    case getMenteeInfo
    case getMentorInfo
    case getMenteeImage
    case getMentorImage
   
    func path() -> String {
        
        switch self {
        case .createMentor, .updateMentor, .getMentorInfo:
            return "http://localhost:3000/mentors"
        case .getMentor:
             return "http://localhost:3000/mentors/one"
        case .createMentee, .updateMentee, .getMenteeInfo:
            return "http://localhost:3000/mentees"
        case .sendMessage:
            return "http://localhost:3000/pushers/message"
        case .getMentee:
            return "http://localhost:3000/mentees/one"
        case .getMatchesImages:
            return "http://localhost:3000/matches/get_info"
        case .getMatchesAll, .confirmMatched:
            return "http://localhost:3000/matches"
        case .getMessages, .saveMessage:
            return "http://localhost:3000/messages"
        case .getSingleChatHistory:
            return "http://localhost:3000/messages/one"
        case .getMenteeImage:
             return "http://localhost:3000/mentees/one/model"
        case .getMentorImage:
             return "http://localhost:3000/mentors/one"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createMentor, .createMentee:
            return [:]
        default:
            let headers = ["Authorization": "Token token=\(keychain.get("token")!)"]
            return headers
        }
        
    }
    
    func method() -> String {
        switch self {
        case .createMentor, .createMentee, .sendMessage, .saveMessage:
            return "POST"
        case .updateMentor, .updateMentee, .confirmMatched:
            return "PATCH"
        default:
            return "GET"
        }
    }
}


class ServerNetworking {
    
    static var shared = ServerNetworking()
    
    let session = URLSession.shared
    var statusCode = 0
    
    func getInfo(route: Route, params: [String: String], completion: @escaping (Data) -> Void) {
        let base = route.path()
        var url = URL(string: base)!
        
        url = url.appendingQueryParameters(params)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.headers()
        request.httpMethod = route.method()
        
        
        session.dataTask(with: request) { (data, res, err) in
            let httpResponse = res as? HTTPURLResponse
            if let data = data {
                self.statusCode = (httpResponse?.statusCode)!
                print(self.statusCode)
                completion(data)
                print("Networking succeeded")
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
        
    }
    
}

