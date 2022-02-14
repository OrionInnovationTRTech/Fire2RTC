//
//  FirebaseFunction.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 26.01.2022.
//

import Foundation
import WebRTC
import Firebase

class FirebaseFunction {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func sendSdpRequest (sdp rtcSdp: RTCSessionDescription, callee : String, callerName: String){
        
        guard let sdpDataMessage = try? self.encoder.encode(SessionDescription(from: rtcSdp)) else {return}
        
        let requestFunction = Request(url: "https://us-central1-callrtc-afe85.cloudfunctions.net/callRequest?callee=\(callee)",sdp: sdpDataMessage, header: callee, body: ["callerName": callerName, "sdp": sdpDataMessage, "calleeName": callee])
        
        let urlString = requestFunction.url
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestFunction.body, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
}

