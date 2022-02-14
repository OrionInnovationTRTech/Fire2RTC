//
//  Request.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 26.01.2022.
//

import Foundation

struct Request {
    
    let url : String
    let sdp : Data
    let header : String
    let body : [String: Any]
    
    init (url: String, sdp:Data, header : String, body : [String: Any]) {
        self.url = url
        self.sdp = sdp
        self.header = header
        self.body = body
    }
}
