
import UIKit
import Firebase
import PushKit
import WebRTC

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    let callManager = CallManager()
    var providerDelegate: ProviderDelegate!
    var deviceToken : String?
    var tokenTimer:Timer!
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        self.voipRegistration()
        providerDelegate = ProviderDelegate(callManager: callManager)
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
        
        defer {
            completion()
        }
        
        guard type == .voIP,
              
              let callerName = payload.dictionaryPayload["calleeName"] as? String,
              let sdp = payload.dictionaryPayload["sdp"] as? RTCSessionDescription,
              let handle = payload.dictionaryPayload["callerName"] as? String
                
        else {
            return
        }
        settingRemoteSdp(sdp: sdp) {
            self.displayIncomingCall(name: handle,callerName: callerName )
        }
    }
    
    func displayIncomingCall(name: String ,callerName: String) {
        providerDelegate?.incomingCall(handle: name, hasVideo: false, callerName: callerName)
    }
    func settingRemoteSdp(sdp : RTCSessionDescription, handler: @escaping () -> Void) {
        callManager.webRTCClient.set(remoteSdp: sdp) { error in
            print(error)
        }
    }
}

