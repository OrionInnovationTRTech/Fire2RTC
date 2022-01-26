
import UIKit
import Firebase
import PushKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    var deviceToken : String?
    var tokenTimer:Timer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        self.voipRegistration()
        
        return true
    }
    
    func voipRegistration() {
        
        let mainQueue = DispatchQueue.main
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        self.tokenTimer = Timer.scheduledTimer(timeInterval:0.3,
                                               target: self,
                                               selector: #selector(self.checkToken),
                                               userInfo: nil,
                                               repeats: true)
    }
    
    @objc func checkToken(){
        if let refreshedToken = deviceToken {
            print("retireved \(refreshedToken)")
            deviceToken = refreshedToken
        }
        else{
            print("not retireved yet")
        }
    }
}

extension AppDelegate : PKPushRegistryDelegate {
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        print(credentials.token)
        deviceToken = credentials.token.map { String(format: "%02x", $0) }.joined()
        print("pushRegistry -> deviceToken :\(deviceToken)")
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("pushRegistry:didInvalidatePushTokenForType:")
    }
    
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
    }
}

