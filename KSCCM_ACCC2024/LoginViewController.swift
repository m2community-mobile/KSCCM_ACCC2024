import UIKit

class LoginViewController: UIViewController {
    
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let buttonNormalTitleColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
    let buttonSeletedTitleColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    var emailTextField : CustomTextField?
    
    var homeTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = #colorLiteral(red: 0.02845434099, green: 0.1907906234, blue: 0.2690033317, alpha: 1)
        
       
        
        
        
        
        let loginLogoImage = UIImage(named: "homeBottom")
        let loginLogoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.6, height: 0))
        loginLogoImageView.backgroundColor = #colorLiteral(red: 0.02845434099, green: 0.1907906234, blue: 0.2690033317, alpha: 1)
        loginLogoImageView.setImageWithFrameHeight(image: loginLogoImage)
        
        loginLogoImageView.center.x = SCREEN.WIDTH / 2
        loginLogoImageView.center.y = SCREEN.HEIGHT - SAFE_AREA - 25
        self.view.addSubview(loginLogoImageView)
        
        
        let loginBox = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 200))
        loginBox.backgroundColor = #colorLiteral(red: 0.04559290409, green: 0.3807365298, blue: 0.5083557963, alpha: 1)
        self.view.addSubview(loginBox)
        
        let loginBoxLabel = UILabel(frame: CGRect(x: 70, y: 25, width: SCREEN.WIDTH - 140, height: 500))
        loginBoxLabel.center.x = SCREEN.WIDTH / 2
        loginBoxLabel.font = UIFont(name: Pretendard_SemiBold, size: 13)
        loginBoxLabel.numberOfLines = 0
        loginBoxLabel.textAlignment = .center
        loginBoxLabel.textColor = UIColor.white
        loginBoxLabel.text = "Please login using the same ID you used to register on the KSCCM-ACCC 2024 website."
        loginBoxLabel.sizeToFit()
        loginBox.addSubview(loginBoxLabel)
        
        emailTextField = CustomTextField(frame: CGRect(x: 70, y: loginBoxLabel.maxY + 20, width: SCREEN.WIDTH - 140, height: 45), placeholder: "ID (E-mail)", isSecureTextEntry: false)
        emailTextField?.center.x = SCREEN.WIDTH / 2
        emailTextField?.textField.delegate = self
        emailTextField?.textField.keyboardType = .emailAddress
        loginBox.addSubview(emailTextField!)
        
        let loginButton = UIButton(frame: CGRect(x: 70, y: emailTextField!.maxY + 20, width: SCREEN.WIDTH - 140, height: 45))
        loginButton.center.x = SCREEN.WIDTH / 2
        loginButton.backgroundColor = #colorLiteral(red: 0.0718825236, green: 0.1986920238, blue: 0.2457453907, alpha: 1)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: Pretendard_Bold, size: loginButton.height * 0.35)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginBox.addSubview(loginButton)
        
        
        //        rgb 63 184 253
        if IS_IPHONE_N {
            loginBox.frame.size.height = loginButton.maxY + 10
        } else {
            loginBox.frame.size.height = loginButton.maxY + 25
        }
        loginBox.frame.origin.y = loginLogoImageView.minY - loginBox.height - 25
        
        let loginTopImageViewBackView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: loginBox.minY - STATUS_BAR_HEIGHT))
        self.view.addSubview(loginTopImageViewBackView)
        
        
        
        let loginTopImage = UIImage(named: "loginTop")
        var loginTopImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH , height: SCREEN.HEIGHT * 1.2))
       
        loginTopImageView.setImageWithFrameHeight(image: loginTopImage)
        loginTopImageView.center = loginTopImageViewBackView.frame.center
        loginTopImageViewBackView.addSubview(loginTopImageView)
        
        
        
        
        if IS_IPHONE_N_PLUS {
            homeTitle = UIImageView(frame: CGRect(x: 70, y: self.view.frame.size.height / 2.4, width: SCREEN.WIDTH - 140, height: 130))
        } else if IS_IPHONE_X {
            homeTitle = UIImageView(frame: CGRect(x: 70, y: self.view.frame.size.height / 2.6, width: SCREEN.WIDTH - 140, height: 120))
        } else if IS_IPHONE_N {
            homeTitle = UIImageView(frame: CGRect(x: 70, y: self.view.frame.size.height / 2.6, width: SCREEN.WIDTH - 140, height: 120))
        } else {
            homeTitle = UIImageView(frame: CGRect(x: 70, y: self.view.frame.size.height / 2.5, width: SCREEN.WIDTH - 140, height: 130))
        }
//        homeTitle = UIImageView(frame: CGRect(x: 70, y: self.view.frame.size.height / 2.4, width: SCREEN.WIDTH - 140, height: 200))
        
        self.view.addSubview(homeTitle)
        
        let hometitleIMage = UIImage(named: "homeTitle")
        
        homeTitle.image = hometitleIMage
        
        var myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 50))
        if IS_IPHONE_12PRO_MAX {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 90))
        } else if IS_IPHONE_12PRO {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 100))
        } else if IS_IPHONE_15PRO {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 100))
        } else if IS_IPHONE_15PRO_MAX {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 110))
        } else if IS_IPHONE_N_PLUS {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 60))
        } else {
            myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 80))
        }
        
        
        
        myView.backgroundColor = #colorLiteral(red: 0.04780871421, green: 0.2622846067, blue: 0.3123528957, alpha: 1)
        self.view.addSubview(myView)
    }
    
    var isLogin : Bool = false
    @objc func loginButtonPressed(){

//        let mainVC = MainViewController()
//        self.navigationController?.pushViewController(mainVC, animated: true)
        
        if isLogin { return }
        isLogin = true
        
        guard let email = emailTextField?.textField.text else {
            isLogin = false
            return
        }
        
        if email.isEmpty || email.replacingOccurrences(of: " ", with: "") == "" {
            isLogin = false
            appDel.showAlert(title: "Notice", message: "The password you entered is incorrect. Please try again.")
            return
        }
        
//        if email == "m2" {
//            userD.set("0", forKey: USER_SID)
//            userD.synchronize()
//
//            DispatchQueue.main.async {
//                let mainVC = MainViewController()
//                self.navigationController?.pushViewController(mainVC, animated: true)
//            }
//        }
//        return
        let urlString = "https://ezv.kr:4447/voting/php/login/ksccm2024.php"
        

//                let urlString = "https://ezv.kr:4447/voting/php/login/ksccm2023.php"
    

        
        let sendData = [
            "deviceid":deviceID,
            "code":code,
            "email":email,
            "device":"IOS"
        ]
        
        
        Server.postData(urlString: urlString, method: .post, otherInfo: sendData, completion: { (kData : Data?) in
            self.isLogin = false
            if let data = kData {
                if let dataString = data.toString() {
                    print("dataString:\(dataString)")
                }
                if let dataDic = data.toJson() as? [String:Any] {
                    if let rows = dataDic["rows"] as? String {
                        if rows == "Y"{
                            var regist_sid_value = ""
                            if let registsid = dataDic["regist_sid"] as? Int {
                                print("regist_sid Int:\(registsid)")
                                regist_sid_value = "\(registsid)"
                            }
                            if let registsid = dataDic["regist_sid"] as? String {
                                print("regist_sid String:\(registsid)")
                                regist_sid_value = registsid
                            }
                            if !regist_sid_value.isEmpty {
                                userD.set(regist_sid_value, forKey: REGIST_SID)
                                userD.synchronize()
                                
                                DispatchQueue.main.async {
                                    let mainVC = MainViewController()
                                    self.navigationController?.pushViewController(mainVC, animated: true)
                                }
                                return
                            }
                            
                        }
                        
                        if rows == "N" {
                            DispatchQueue.main.async {
                                appDel.showAlert(title: "Notice", message: "The password you entered is incorrect. Please try again.")
                            }
                            return
                        }else{
                            
                        }
                    }
                }
            }
        })
    }
                        

    class CustomTextField: UIButton {
        
        var motherVC : UIViewController?
        
        var textField : UITextField!
        
        private override init(frame: CGRect) {
            super.init(frame:frame)
        }
        
        convenience init(frame : CGRect, placeholder : String = "", isSecureTextEntry : Bool = false) {
            self.init(frame: frame)
            
            
            self.backgroundColor = UIColor.white
            self.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1).cgColor
            self.layer.borderWidth = 0.5
            
            let textFontSize : CGFloat = self.frame.size.height * 0.35
//            rgb 184 183 183
            textField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - 30, height: self.frame.size.height))
            textField.center.x = self.frame.size.width / 2
            textField.font = UIFont(name: Pretendard_SemiBold, size: textFontSize)
            textField.textColor = #colorLiteral(red: 0.4392156863, green: 0.4549019608, blue: 0.5294117647, alpha: 1)
            textField.textAlignment = .natural
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.addDoneCancelToolbar()
            textField.isSecureTextEntry = isSecureTextEntry
            
            let idTextFieldAttributedPlaceholder : [NSAttributedString.Key : NSObject] = [
                .font : UIFont(name: Pretendard_SemiBold, size: textFontSize)!,
                .foregroundColor : #colorLiteral(red: 0.4392156863, green: 0.4549019608, blue: 0.5294117647, alpha: 1)
            ]
            textField.attributedPlaceholder = NSMutableAttributedString(stringsInfos: [(placeholder,idTextFieldAttributedPlaceholder)])
            
            self.addSubview(textField)
            
            self.addTarget(event: .touchUpInside) { (button) in self.textField.becomeFirstResponder() }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    

}
