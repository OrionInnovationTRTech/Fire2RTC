//
//  CallViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit
import Firebase

class CallViewController: UIViewController {
    
    @IBOutlet weak var callerNameTextField: UITextField!
    @IBOutlet weak var endCallButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    private var callViewModel : CallViewModel!
    var callManager: CallManager!
    
    required init?(coder: NSCoder, callViewModel: CallViewModel) {
        self.callViewModel = callViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        endCallButton.isHidden = true
        callerNameTextField.text = callViewModel.name
        callManager = AppDelegate.shared.callManager
        super.viewDidLoad()
    }
    
    
    @IBAction func callPressed(_ sender: UIButton) {
        endCallButton.isHidden = false
        callButton.isHidden = true
        guard let currentUsername = Auth.auth().currentUser?.email else {return}
        callManager.startCall(handle: callViewModel.name, videoEnabled: true, callerName: currentUsername)
    }
    
    @IBAction func endCallPressed(_ sender: UIButton) {
        
        if let i = self.callManager.calls.firstIndex(where: { $0.handle == callerNameTextField.text}) {
            let obj = self.callManager.calls[i]
            
            callManager.end(call: obj)
            endCallButton.isHidden = true
            callButton.isHidden = false
        }
    }
}
