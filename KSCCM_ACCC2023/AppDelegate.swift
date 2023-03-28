//
//  AppDelegate.swift
//  icksh2021
//
//  Created by JinGu's iMac on 2021/02/22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC : MainViewController?
    var naviCon : NotRotatableNavigationController?
    
    var leftView : LeftView?
    var barCodeView : BarcodeView?
    
    var loginVC : LoginViewController?
    
    var introImages = [[String:Any]]()

    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait,.landscape]
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        WebCacheCleaner.clean()
        
        let urlString = "https://ezv.kr:4447/voting/php/banner/list.php?code=\(code)&gubun=2"
        print("introImagesUrl:\(urlString)")
        Server.postData(urlString: urlString) { (kData : Data?) in
            
            if let data = kData {
                if let kIntroImages = data.toJson() as? [[String:Any]] {
                    print("introImages:\(kIntroImages)")
                    let imageKey : String
                    if IS_NORCH {
                        imageKey = "image2"
                    }else{
                        imageKey = "image"
                    }
                    
                    self.introImages = kIntroImages
                    var count = 0
                    for i in 0..<self.introImages.count {
                        OperationQueue.main.addOperation {
                            if let imageURLString = self.introImages[i][imageKey] as? String {
                                if let imageURL = URL(string: "https://ezv.kr:4447/\(imageURLString)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
                                    if let imageData = try? Data(contentsOf: imageURL) {
                                        if let image = UIImage(data: imageData) {
                                            self.introImages[i]["imageFile"] = image
                                            count += 1
                                            if count == self.introImages.count {
                                                print("다 받음")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        FirebaseApp.configure()
        NotiCenter.shared.authorizationCheck()

        addKeyboardObserver()

        window = UIWindow(frame: UIScreen.main.bounds)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        mainVC = MainViewController()
        loginVC = LoginViewController()
        if isLogin {
            naviCon = NotRotatableNavigationController(rootViewController: mainVC!)
        }else{
            naviCon = NotRotatableNavigationController(rootViewController: loginVC!)
        }
        naviCon?.isNavigationBarHidden = true
        window?.rootViewController = naviCon
        
        window?.makeKeyAndVisible()
        
        self.leftView = LeftView()
        self.window?.addSubview(self.leftView!)
        
        var introImageViews = [UIImageView]()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            
            //모조리 다 붙여 끼워넣고
            for i in 0..<self.introImages.count {
                if let introImage = self.introImages[self.introImages.count - 1 - i]["imageFile"] as? UIImage {
                    print("\(i) 번째 이미지 - ")
                    let introImageView = UIImageView(frame: SCREEN.BOUND)
                    introImageView.image = introImage
                    introImageView.isUserInteractionEnabled = true
                    //                    introImageView.image = UIImage(named: "test\(i)")
                    self.window?.addSubview(introImageView)
//                    self.window?.insertSubview(introImageView, aboveSubview: loadingImageView)
                    introImageViews.append(introImageView)
                }
            }
            
//            UIView.animate(withDuration: 0.3, animations: {
//                loadingImageView.alpha = 0
//            }, completion: { (fi) in
//                loadingImageView.removeFromSuperview()
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
                    if let introImageView = introImageViews.first {
                        UIView.animate(withDuration: 0.3, animations: {
                            introImageView.alpha = 0
                        }, completion: { (fi) in
                            introImageView.removeFromSuperview()
                            introImageViews.removeFirst()
                        })
                    }
                })
//            })
        }
        
        sleep(2)
        
        
        
        return true
    }

    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
//        "title" : "SURGICAL+RESULT+OF+COMBINED+AURICULO-MEATOPLASTY+IN+MICROTIA"
//        "time" : "07:50-08:00"
//        "sid" : "7061"
//        "code" : "aocc2023"
        
        if let sid = url.parameters["sid"] as? String,
           let kCode = url.parameters["code"] as? String {
            let urlString = "https://ezv.kr:4447/voting/php/session/view.php?sid=\(sid)&code=\(kCode)&deviceid=\(deviceID)"
            print("urlString:\(urlString)")
            
            appDel.allDismiss {
                DispatchQueue.main.async {
                    goURL(urlString: urlString)
                }
            }
        }
        
        return true
    }
   
}

