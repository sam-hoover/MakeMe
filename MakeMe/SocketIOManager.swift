//
//  SocketIOManager.swift
//  MakeMe
//
//  Created by Vox on 4/23/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    static let instance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://caseyearl.com:4000")!/*, options: [.Log(true)]*/ )
    
    override init() {
        super.init()
        addHandlers()
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func addHandlers() {
        socket.on("confirmation") { data in
            print("connection confirmed")
            print(data.0)
        }
    }
    
    func authenticate(number: String, pass: String) {
        socket.emit("authenticate", number, pass)
    }
}
