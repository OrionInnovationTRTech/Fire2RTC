
import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        let storyboard =  UIStoryboard(name: "RegisterViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as RegisterViewController? else { return  }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let storyboard =  UIStoryboard(name: "LoginViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as LoginViewController? else { return  }
        navigationController?.pushViewController(vc, animated: true)
    }
}

