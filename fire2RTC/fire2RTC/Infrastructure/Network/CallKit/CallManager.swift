//
//  CallManager.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 28.01.2022.
//

import Foundation
import CallKit
import WebRTC

class CallManager {
    
    private let callController = CXCallController()
    let webRTCClient = WebRTCClient()
    let firebaseFunction = FirebaseFunction()
    
    private(set) var calls: [Call] = []
    
    func callWithUUID(uuid: UUID) -> Call? {
        guard let index = calls.firstIndex(where: { $0.uuid == uuid }) else {
            return nil
        }
        return calls[index]
    }
    
    func add(call: Call) {
        calls.append(call)

    }
    
    func remove(call: Call) {
        guard let index = calls.firstIndex(where: { $0 === call }) else { return }
        calls.remove(at: index)
    }
    
    func removeAllCalls() {
        calls.removeAll()
    }
    
    func end(call : Call) {
        let endCallAction = CXEndCallAction(call: call.uuid)
        let transaction = CXTransaction(action: endCallAction)
        requestTransaction(transaction)
        self.webRTCClient.closePeerConnection()
        self.webRTCClient.createPeerConnection()
    }
    
    func startCall(handle: String, videoEnabled: Bool, callerName : String) {
        let handler = CXHandle(type: .phoneNumber, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handler)
        startCallAction.isVideo = videoEnabled
        let transaction = CXTransaction(action: startCallAction)
        requestTransaction(transaction)
        self.webRTCClient.offer { sdp in
            self.firebaseFunction.sendSdpRequest(sdp: sdp, callee: handle, callerName: callerName)
        }
    }
    
    private func requestTransaction(_ transaction: CXTransaction) {
        callController.request(transaction) { error in
            if let error = error {
                print("Error requesting transaction: \(error)")
            } else {
                print("Requested transaction successfully")
            }
        }
    }
}
