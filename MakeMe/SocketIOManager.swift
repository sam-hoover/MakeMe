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
        
        socket.on("authenticate-confirmation") { data in
            print(data.0)
            print(data.1)
        }
        
        socket.on("register-confirmation") { data in
            print(data.0)
        }
        
        socket.on("update-list") { data in
            // i will get back the lists unique ID number for reference
        }
    }
    
    func authenticate(number: String, pass: String) {
        socket.emit("authenticate", number, pass)
    }
    
    func register(name: String, number: String, pass: String) {
        socket.emit("register", name, number, pass)
    }
    
    func createReminderList(name: String, number: String, to: String) {
        socket.emit("create-list", name, number, to)
    }
    
    func createReminder(name: String, number: String, listID: String, alarm: Int) {
        socket.emit("create-reminder", name, number, listID, alarm)
    }
}
