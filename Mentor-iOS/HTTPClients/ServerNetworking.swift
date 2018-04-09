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
    case createMatches
   
    func path() -> String {
        
        switch self {
        case .createMentor, .updateMentor, .getMentorInfo:
            return "/mentors"
        case .getMentor:
             return "/one"
        case .createMentee, .updateMentee, .getMenteeInfo:
            return "/mentees"
        case .sendMessage:
            return "/pushers/message"
        case .getMentee:
            return "/mentees/one"
        case .getMatchesImages:
            return "/matches/get_info"
        case .getMatchesAll, .confirmMatched, .createMatches:
            return "/matches"
        case .getMessages, .saveMessage:
            return "/messages"
        case .getSingleChatHistory:
            return "/messages/one"
        case .getMenteeImage:
             return "/mentees/one/model"
        case .getMentorImage:
             return "/mentors/one/model"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createMentor, .createMentee, .getMentee, .getMentor:
            return [:]
        default:
            let headers = ["Authorization": "Token token=\(keychain.get("token")!)"]
            return headers
        }
        
    }
    
    func method() -> String {
        switch self {
        case .createMentor, .createMentee, .sendMessage, .saveMessage, .createMatches:
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
        let base = "https://mentor-app-server.herokuapp.com"
        let base2 = "http://localhost:3000"
        let fullURL = base + route.path()
        var url = URL(string: fullURL)!
        
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

