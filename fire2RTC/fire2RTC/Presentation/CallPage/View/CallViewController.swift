//
//  CallViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class CallViewController: UIViewController {

    @IBOutlet weak var callerNameTextField: UITextField!
    @IBOutlet weak var endCallButton: UIButton!
    private var callViewModel : CallViewModel!
    
    required init?(coder: NSCoder, callViewModel: CallViewModel) {
        self.callViewModel = callViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        endCallButton.isHidden = true
        callerNameTextField.text = callViewModel?.name
        super.viewDidLoad()

    }
}
