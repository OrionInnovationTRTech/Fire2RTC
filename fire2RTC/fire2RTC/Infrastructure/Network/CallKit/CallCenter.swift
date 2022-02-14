//
//  CallCenter.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 26.01.2022.
//
import Foundation
import AVFoundation
import CallKit

class CallCenter: NSObject {

    private let controller = CXCallController()
    private let provider: CXProvider
    private var uuid = UUID()
    
    init(supportsVideo: Bool) {
        let providerConfiguration = CXProviderConfiguration(localizedName: "CallRTC")
        providerConfiguration.supportsVideo = supportsVideo
        provider = CXProvider(configuration: providerConfiguration)
    }

    func setup(_ delegate: CXProviderDelegate) {
        provider.setDelegate(delegate, queue: nil)
    }

    func startCall(_ hasVideo: Bool = false, callee : User) {
        uuid = UUID()
        let handle = CXHandle(type: .generic, value: callee.email)
        let startCallAction = CXStartCallAction(call: uuid, handle: handle)
        startCallAction.isVideo = hasVideo
        let transaction = CXTransaction(action: startCallAction)
        controller.request(transaction) { error in
            if let error = error {
                print("CXStartCallAction error: \(error.localizedDescription)")
            }
        }
    }

    func incomingCall(_ hasVideo: Bool = false, caller: User) {
        uuid = UUID()
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: caller.email)
        update.hasVideo = hasVideo
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            if let error = error {
                print("reportNewIncomingCall error: \(error.localizedDescription)")
            }
        }
    }

    func endCall() {
        let action = CXEndCallAction(call: uuid)
        let transaction = CXTransaction(action: action)
        controller.request(transaction) { error in
            if let error = error {
                print("CXEndCallAction error: \(error.localizedDescription)")
            }
        }
    }

    func connecting() {
        provider.reportOutgoingCall(with: uuid, startedConnectingAt: nil)
    }

    func connected() {
        provider.reportOutgoingCall(with: uuid, connectedAt: nil)
    }
}
