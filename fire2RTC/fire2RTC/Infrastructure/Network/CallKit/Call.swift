//
//  Call.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 28.01.2022.
//

import Foundation
import CallKit


enum CallState {
    case connecting
    case active
    case held
    case ended
}

enum ConnectedState {
    case pending
    case complete
}

class Call {
    let uuid: UUID
    let handle: String
    
    var state: CallState = .ended {
        didSet {
            stateChanged?()
        }
    }
    
    var connectedState: ConnectedState = .pending {
        didSet {
            connectedStateChanged?()
        }
    }
    
    var stateChanged: (() -> Void)?
    var connectedStateChanged: (() -> Void)?
    
    init(uuid: UUID, handle: String) {
        self.uuid = uuid
        self.handle = handle
    }
    
    func answer() {
        state = .active
    }
    
    func end() {
        state = .ended
    }
}
