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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9254901961, alpha: 1)
        
        let loginLogoImage = UIImage(named: "loginLogo")
        let loginLogoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.6, height: 0))
        loginLogoImageView.setImageWithFrameHeight(image: loginLogoImage)
        loginLogoImageView.center.x = SCREEN.WIDTH / 2
        loginLogoImageView.center.y = SCREEN.HEIGHT - SAFE_AREA - 25
        self.view.addSubview(loginLogoImageView)
        
        
        let loginBox = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 100))
        loginBox.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2784313725, blue: 0.4980392157, alpha: 1)
        self.view.addSubview(loginBox)
        
        let loginBoxLabel = UILabel(frame: CGRect(x: 0, y: 25, width: SCREEN.WIDTH - 30, height: 500))
        loginBoxLabel.center.x = SCREEN.WIDTH / 2
        loginBoxLabel.font = UIFont(name: Pretendard_SemiBold, size: 15)
        loginBoxLabel.numberOfLines = 0
        loginBoxLabel.textColor = UIColor.white
        loginBoxLabel.text = "Please login using the same ID you used to register on the KSCCM-ACCC 2023 website."
        loginBoxLabel.sizeToFit()
        loginBox.addSubview(loginBoxLabel)
        
        emailTextField = CustomTextField(frame: CGRect(x: loginBoxLabel.minX, y: loginBoxLabel.maxY + 20, width: SCREEN.WIDTH - 30, height: 45), placeholder: "ID (E-mail)", isSecureTextEntry: false)
        emailTextField?.center.x = SCREEN.WIDTH / 2
        emailTextField?.textField.delegate = self
        emailTextField?.textField.keyboardType = .emailAddress
        loginBox.addSubview(emailTextField!)
        
        let loginButton = UIButton(frame: CGRect(x: emailTextField!.minX, y: emailTextField!.maxY + 20, width: SCREEN.WIDTH - 30, height: 45))
        loginButton.center.x = SCREEN.WIDTH / 2
        loginButton.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.7215686275, blue: 0.9921568627, alpha: 1)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: Pretendard_Bold, size: loginButton.height * 0.35)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginBox.addSubview(loginButton)
        
        
        //        rgb 63 184 253
        
        loginBox.frame.size.height = loginButton.maxY + 25
        loginBox.frame.origin.y = loginLogoImageView.minY - loginBox.height - 25
        
        let loginTopImageViewBackView = UIView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN.WIDTH, height: loginBox.minY - STATUS_BAR_HEIGHT))
        self.view.addSubview(loginTopImageViewBackView)
        
        let loginTopImage = UIImage(named: "loginTop")
        let loginTopImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.8, height: 0))
        loginTopImageView.setImageWithFrameHeight(image: loginTopImage)
        loginTopImageView.center = loginTopImageViewBackView.frame.center
        loginTopImageViewBackView.addSubview(loginTopImageView)
    }
    
    var isLogin : Bool = false
    @objc func loginButtonPressed(){

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
        let urlString = "https://ezv.kr:4447/voting/php/login/ksccm2023.php"
        
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
