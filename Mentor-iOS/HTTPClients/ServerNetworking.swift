//
//  ServerNetworking.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

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
    
   
    func path() -> String {
        
        switch self {
        case .createMentor, .getMentor, .updateMentor:
            return "http://localhost:3000/mentors"
        case .createMentee, .updateMentee:
            return "http://localhost:3000/mentees"
        case .sendMessage:
            return "http://localhost:3000/pushers/message"
        // TODO: Remove this after testing
        case .getMentee:
            return "http://localhost:3000/mentees/all"
        case .getMatchesImages:
            return "http://localhost:3000/matches/get_info"
        case .getMatchesAll:
            return "http://localhost:3000/matches"
        case .getMessages, .saveMessage:
            return "http://localhost:3000/messages"
        case .getSingleChatHistory:
            return "http://localhost:3000/messages/one"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createMentor, .createMentee:
            return [:]
        default:
            let headers = ["Authorization": "Token token=e99edf19d5c8225109736af67c94b310"]
            return headers
        }
        
    }
    
    
    func body(data: Encodable?) -> Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .sendMessage:
            return nil
        default:
            guard let model = data as? User else {return nil}
            let result = try? encoder.encode(model)
            return result
        }
    }
    
    func method() -> String {
        switch self {
        case .createMentor, .createMentee, .sendMessage, .saveMessage:
            return "POST"
        case .updateMentor, .updateMentee:
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
    
    func fetch(route: Route, data: Encodable?, completion: @escaping (Data) -> Void) {
        let base = route.path()
        var url = URL(string: base)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.headers()
        request.httpBody = route.body(data: data)
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

