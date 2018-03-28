//
//  ViewController.swift
//  Mentor-iOS
//
//  Created by Melody on 3/24/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import PusherSwift

class ViewController: UIViewController, PusherDelegate {
    
    var pusher: Pusher!

    override func viewDidLoad() {
        super.viewDidLoad()


        let options = PusherClientOptions(
            authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
            host: .cluster(cluster)
        )
        pusher = Pusher(
            key: key,
            options: options
        )
    
        pusher.delegate = self
        pusher.connect()
        
        let chan = pusher.subscribe("private-test-channel")

        let _ = chan.bind(eventName: "test-event", callback: { data in
            print(data)
            let _ = self.pusher.subscribe("private-test-channel")

            if let data = data as? [String : AnyObject] {
                if let testVal = data["test"] as? String {
                    print(testVal)
                }
            }
        })
        
        // triggers a client event
        chan.trigger(eventName: "client-test", data: ["test": "some value"])
        
//        let myPrivateChannel = pusher.subscribe("private-my-channel")
        
    }
    
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        // print the old and new connection states
        print("old: \(old.stringValue()) -> new: \(new.stringValue())")
    }
    
    func subscribedToChannel(name: String) {
        print("Subscribed to \(name)")
    }
    
    func debugLog(message: String) {
        print(message)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




