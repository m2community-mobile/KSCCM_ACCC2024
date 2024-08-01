//
//  BoothEventViewController.swift
//  koa2019s
//
//  Created by m2comm on 13/03/2019.
//  Copyright © 2019 m2community. All rights reserved.
//

import UIKit
import FontAwesome_swift

class BoothEventViewController: BaseViewController {
    
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lig
//    }
    
    var webView : WebView!
    
    var notiLabel : UILabel!
    var howToButton : UIButton!
    var surveyButton : SurveyButtonView!
    
    var buttonBackView : UIView!
    
    var boothEventAfterView : BoothEventAfterView?
    var boothEventCompleteView : BoothEventCompleteView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subTitleLabel.text = "Booth Stamp Event"
        self.subTitleLabel.textColor = UIColor.white
        
        self.subTitleView.backgroundColor = self.naviBar.backgroundColor
        self.backButtonimageView.tintColor = UIColor.white
        
        let notiBackView = UIView(frame: CGRect(x: 0, y: self.subTitleView.frame.maxY, width: SCREEN.WIDTH, height: 50))
        self.view.addSubview(notiBackView)

        
        let reloadButton = UIButton(frame: CGRect(x: SCREEN.WIDTH - notiBackView.frame.size.height - 15, y: 0, width: notiBackView.frame.size.height, height: notiBackView.frame.size.height))
        notiBackView.addSubview(reloadButton)
        
        let reloadButtonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: reloadButton.frame.size.width * 0.5, height: reloadButton.frame.size.width * 0.5))
        reloadButtonImageView.image = UIImage(named: "icoRefresh")
        reloadButtonImageView.center = CGPoint(x: reloadButton.frame.size.width / 2, y: reloadButton.frame.size.height / 2)
        reloadButton.addSubview(reloadButtonImageView)
        
        reloadButton.addTarget(event: .touchUpInside) { (button) in
            self.webView.reloading()
            self.boothInfoUpdate()
        }
        
        // number of 앞 이미지
        let circleImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: notiBackView.frame.size.height * 0.5, height: notiBackView.frame.size.height * 0.5))
        circleImageView.image = UIImage(named: "buletTitle")
        circleImageView.center.y = notiBackView.frame.size.height / 2
        circleImageView.isUserInteractionEnabled = false
        notiBackView.addSubview(circleImageView)
        
        notiLabel = UILabel(frame: CGRect(x: circleImageView.frame.maxX + 10, y: 0, width: SCREEN.WIDTH - (circleImageView.frame.maxX + 10), height: notiBackView.frame.size.height))
        notiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        notiLabel.font = UIFont(name: NotoSansCJKkr_Bold, size: 15)
        notiLabel.center.y = notiBackView.frame.size.height / 2
        notiLabel.isUserInteractionEnabled = false
        notiLabel.text = "Number of stamps collected:"
        notiBackView.addSubview(notiLabel)
        
        buttonBackView = UIButton(frame: CGRect(x: 15, y: notiBackView.frame.maxY, width: SCREEN.WIDTH - 30, height: 55))
        self.view.addSubview(buttonBackView)
        // how to join the event 버튼
        let howToImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: buttonBackView.width, height: 0))
        howToImageView.setImageWithFrameHeight(image: UIImage(named: "howToBoothEvent"))
        buttonBackView.addSubview(howToImageView)
        buttonBackView.frame.size.height = howToImageView.height
        
                howToButton = UIButton(frame: buttonBackView.bounds)
                //        howToButton.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
                buttonBackView.addSubview(howToButton)
        
                self.howToButton.addTarget(event: .touchUpInside, buttonAction: { (button) in
                    let noticeView = BoothEvnetNoticeView(boothVC: self)
                    self.view.addSubview(noticeView)
                    //            let view1 = HowToBoothEventView(attendFunc: { (howToBoothEventView : HowToBoothEventView) in
                    //
                    //                UIView.animate(withDuration: 0.3, animations: {
                    //                    howToBoothEventView.alpha = 0
                    //                }, completion: { (fi) in
                    //                    howToBoothEventView.removeFromSuperview()
                    //                })
                    //            })
                    //
                    //            view1.alpha = 0
                    //            self.view.addSubview(view1)
                    //            UIView.animate(withDuration: 0.3, animations: {
                    //                view1.alpha = 1
                    //            })
                })
        
        
        
//        let reloadButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        reloadButtonLabel.text = "Refresh"
//        reloadButtonLabel.textColor = UIColor.white
//        reloadButtonLabel.backgroundColor = #colorLiteral(red: 0.2546537817, green: 0.3155307472, blue: 0.4873780608, alpha: 1)
//        reloadButtonLabel.font = UIFont(name: Pretendard_Regular, size: 15)
//        reloadButtonLabel.textAlignment = .center
//        reloadButtonLabel.sizeToFit()
//        reloadButtonLabel.frame.size.width += 30
//        reloadButtonLabel.frame.size.height += 20
//        reloadButtonLabel.frame.origin.x = notiBackView.width - reloadButtonLabel.frame.width - 15
//        reloadButtonLabel.center.y = notiBackView.height / 2
//        reloadButtonLabel.layer.cornerRadius = 3
//        reloadButtonLabel.clipsToBounds = true
//        notiBackView.addSubview(reloadButtonLabel)
//        
//        let reloadButton = UIButton(frame: reloadButtonLabel.frame)
//        notiBackView.addSubview(reloadButton)
//        
//        //        let circleImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: notiBackView.frame.size.height * 0.5, height: notiBackView.frame.size.height * 0.5))
//        //        circleImageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.genderless, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.3333333333, green: 0.5568627451, blue: 0.8352941176, alpha: 1), size: circleImageView.frame.size)
//        //        circleImageView.center.y = notiBackView.frame.size.height / 2
//        //        circleImageView.isUserInteractionEnabled = false
//        //        notiBackView.addSubview(circleImageView)
//        
//        notiLabel = UILabel(frame: CGRect(x: 15, y: 0, width: reloadButtonLabel.frame.minX - 15 - 10, height: notiBackView.frame.size.height))
//        notiLabel.textColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
//        notiLabel.font = UIFont(name: Pretendard_Medium, size: 15)
//        notiLabel.center.y = notiBackView.frame.size.height / 2
//        notiLabel.isUserInteractionEnabled = false
//        notiLabel.text = "◈ Number of stamps collected: 1"
//        
//        notiBackView.addSubview(notiLabel)
//        
//        buttonBackView = UIView(frame: CGRect(x: 0, y: notiBackView.frame.maxY, width: SCREEN.WIDTH - 30, height: 55))
//        buttonBackView.center.x = SCREEN.WIDTH / 2
//        buttonBackView.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.1843137255, blue: 0.3529411765, alpha: 1)
//        self.view.addSubview(buttonBackView)
//        
//        let buttonBackInnerView = UIView(frame: buttonBackView.bounds)
//        buttonBackView.addSubview(buttonBackInnerView)
//        
//        let circleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: buttonBackInnerView.height * 0.5, height: buttonBackInnerView.height * 0.5))
//        circleLabel.layer.cornerRadius = circleLabel.height / 2
//        circleLabel.backgroundColor = UIColor.white
//        circleLabel.text = "!"
//        circleLabel.textAlignment = .center
//        circleLabel.textColor = buttonBackView.backgroundColor
//        circleLabel.center.y = buttonBackInnerView.height / 2
//        circleLabel.clipsToBounds = true
//        circleLabel.font = UIFont(name: Pretendard_Medium, size: circleLabel.height * 0.5)
//        buttonBackInnerView.addSubview(circleLabel)
//        
//        let buttonBackInnerLabel = UILabel(frame: buttonBackInnerView.bounds)
//        buttonBackInnerLabel.text = "How to join the event?"
//        buttonBackInnerLabel.font = UIFont(name: Pretendard_SemiBold, size: buttonBackInnerLabel.height * 0.35)
//        buttonBackInnerLabel.textColor = UIColor.white
//        buttonBackInnerLabel.sizeToFit()
//        buttonBackInnerLabel.frame.origin.x = circleLabel.maxX + 10
//        buttonBackInnerLabel.center.y = buttonBackInnerView.height / 2
//        buttonBackInnerView.addSubview(buttonBackInnerLabel)
//        
//        buttonBackInnerView.frame.size.width = buttonBackInnerLabel.maxX
//        buttonBackInnerView.center.x = buttonBackView.width / 2
//        
//        howToButton = UIButton(frame: buttonBackView.bounds)
//        //        howToButton.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
//        buttonBackView.addSubview(howToButton)
//        
//        self.howToButton.addTarget(event: .touchUpInside, buttonAction: { (button) in
//            let noticeView = BoothEvnetNoticeView(boothVC: self)
//            self.view.addSubview(noticeView)
//            //            let view1 = HowToBoothEventView(attendFunc: { (howToBoothEventView : HowToBoothEventView) in
//            //
//            //                UIView.animate(withDuration: 0.3, animations: {
//            //                    howToBoothEventView.alpha = 0
//            //                }, completion: { (fi) in
//            //                    howToBoothEventView.removeFromSuperview()
//            //                })
//            //            })
//            //
//            //            view1.alpha = 0
//            //            self.view.addSubview(view1)
//            //            UIView.animate(withDuration: 0.3, animations: {
//            //                view1.alpha = 1
//            //            })
//        })
        
        
        
        
        
        
        //?/
        
        //        surveyButton = SurveyButtonView(frame: CGRect(x: howToButton.frame.maxX + 15, y: 0, width: (SCREEN.WIDTH - 30 - 15) / 2, height: 50), iconImageName: FontAwesome.voteYea, name: "설문조사 참여")
        //        surveyButton.center.y = buttonBackView.frame.size.height / 2
        //        buttonBackView.addSubview(surveyButton)
        //        surveyButton.addTarget(event: .touchUpInside) { (button) in
        //            goURL(urlString: URL_KEY.Survey)
        //        }
        
        let scannerButton = ScannerButton()
        scannerButton.frame.origin.y = SCREEN.HEIGHT - scannerButton.frame.size.height
        self.view.addSubview(scannerButton)
        
        //        let scannerButtonHeight : CGFloat = 50
        //        let scannerButtonGap : CGFloat = 15
        //        let scannerButtonBackView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: scannerButtonHeight + scannerButtonGap + SAFE_AREA))
        //        scannerButtonBackView.frame.origin.y = SCREEN.HEIGHT - scannerButtonBackView.frame.size.height
        //        self.view.addSubview(scannerButtonBackView)
        //
        //        let scannerButtonBackView2 = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: scannerButtonHeight + scannerButtonGap))
        //        scannerButtonBackView.addSubview(scannerButtonBackView2)
        //
        //        var scannerButtonFrame = scannerButtonBackView2.bounds
        //        scannerButtonFrame.size.width -= scannerButtonGap
        //        scannerButtonFrame.size.height -= scannerButtonGap
        //
        //        let scannerButton = IconButton(frame: scannerButtonFrame, name: "SCANNER", imageName: "barcode")
        //        scannerButton.center = scannerButtonBackView2.frame.center
        //        if IS_IPHONE_SE {
        //            scannerButton.nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 18)
        //        }
        //        scannerButton.nameLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.3882352941, blue: 0.8274509804, alpha: 1)
        //        scannerButton.layer.borderWidth = 0.5
        //        scannerButton.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.3882352941, blue: 0.8274509804, alpha: 1)
        //        scannerButtonBackView2.addSubview(scannerButton)
        scannerButton.addTarget(event: .touchUpInside) { (button) in
            
            let qrCodeReaderVC = QRCodeReaderViewController()
            qrCodeReaderVC.boothEventVC = self
            qrCodeReaderVC.modalPresentationStyle = .fullScreen
            self.present(qrCodeReaderVC, animated: true, completion: {
                
            })
            
        }
        
        //scannerRight
        //        let scannerRightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: scannerButton.frame.size.height * 0.3))
        //        scannerRightImageView.setImageWithFrameWidth(image: UIImage(named: "scannerRight"))
        //        scannerRightImageView.frame.origin.x = scannerButton.frame.size.width - (scannerRightImageView.frame.size.width * 2)
        //        scannerRightImageView.center.y = scannerButton.frame.size.height / 2
        //        scannerRightImageView.isUserInteractionEnabled = false
        //        scannerButton.addSubview(scannerRightImageView)
        print("boothEvent:\(boothEvent)")
        webView = WebView(frame: CGRect(
            x: 0,
            y: buttonBackView.frame.maxY + 10,
            width: SCREEN.WIDTH,
            height: scannerButton.frame.minY - (buttonBackView.frame.maxY + 10)), urlString: boothEvent)
        webView.motherVC = self
        
        self.view.addSubview(webView)
        
        
//        reloadButton.addTarget(event: .touchUpInside) { (button) in
//            self.webView.reloading()
//            self.boothInfoUpdate()
//        }
        
        
        
        self.boothInfoUpdate()
        
        
        //        let boothEventCompleteView = BoothEventCompleteView(barCode: "asdf")
        //        boothEventCompleteView.frame.origin.y = SCREEN.HEIGHT - boothEventCompleteView.height
        //        self.view.addSubview(boothEventCompleteView)
        
        
        //        let boothEventAfterView = BoothEventAfterView()
        //        boothEventAfterView.frame.origin.y = SCREEN.HEIGHT - boothEventAfterView.height
        //        self.view.addSubview(boothEventAfterView)
        
    }
    
    func didDismissBarCodeView() {
        print("didDismissBarCodeView")
        //        self.webView.reloading()
        //        self.boothInfoUpdate ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.reloading()
        self.boothInfoUpdate ()
    }
    
    var isFirst = true
    
    var IS_APPLY_EVENT = "IS_APPLY_EVENT"
    var isApplyEvent : Bool {
        get {
            return userD.bool(forKey: IS_APPLY_EVENT)
        }
        set(value) {
            userD.set(value, forKey: IS_APPLY_EVENT)
            userD.synchronize()
        }
    }
    
    func boothInfoUpdate(){
        let urlString = "https://ezv.kr:4447/voting/php/booth/get_event_cnt.php?code=\(code)&regist_sid=\(regist_sid)"
        print("boothInfoUpdate:\(urlString)")
        Server.postData(urlString: urlString) { (kData : Data?) in
            if let data = kData {
                
                if let dataDic = data.toJson() as? [String:Any] {
                    print("boothInfoUpdate dataDic:\(dataDic)")
                    var cnt = 0
                    
                    let eventYN = dataDic["eventYN"] as? String ?? "N"
                    
                    if let stringValue = dataDic["cnt"] as? String {
                        if let intValue = Int(stringValue, radix: 10) {
                            cnt = intValue
                        }
                    }else if let intValue = dataDic["cnt"] as? Int {
                        cnt = intValue
                    }
                    var gift = 0
                    if let stringValue = dataDic["gift"] as? String {
                        if let intValue = Int(stringValue, radix: 10) {
                            gift = intValue
                        }
                    }else if let intValue = dataDic["gift"] as? Int {
                        gift = intValue
                    }
                    
                    print("cnt : \(cnt)") // 총 부스참여 갯수
                    
                    DispatchQueue.main.async{
                        self.notiLabel.text = "Number of stamps collected: \(cnt)"
                        if eventYN == "Y" {
                            if self.isApplyEvent {
                                self.boothEventAfterView?.removeFromSuperview()
                                self.boothEventAfterView = BoothEventAfterView()
                                self.boothEventAfterView?.frame.origin.y = SCREEN.HEIGHT - self.boothEventAfterView!.height
                                self.view.addSubview(self.boothEventAfterView!)
                            }else{
                                self.boothEventCompleteView?.removeFromSuperview()
                                self.boothEventCompleteView = BoothEventCompleteView()
                                self.boothEventCompleteView!.frame.origin.y = SCREEN.HEIGHT - self.boothEventCompleteView!.height
                                self.view.addSubview(self.boothEventCompleteView!)
                                self.boothEventCompleteView?.enterTheWinButtonPressedFunc = {
                                    
                                    let alertcon = UIAlertController(title: "", message: "Thank you for joining the event!", preferredStyle: .alert)
                                    alertcon.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                                        self.isApplyEvent = true
                                        
                                        self.boothEventCompleteView?.removeFromSuperview()
                                        self.boothEventAfterView?.removeFromSuperview()
                                        self.boothEventAfterView = BoothEventAfterView()
                                        self.boothEventAfterView?.frame.origin.y = SCREEN.HEIGHT - self.boothEventAfterView!.height
                                        self.view.addSubview(self.boothEventAfterView!)
                                    }))
                                    self.present(alertcon, animated: true)
                                    
                                }
                            }
                          }
                        }
                        
                        if cnt == 0 && self.isFirst {
                            self.isFirst = false
                            let noticeView = BoothEvnetNoticeView(boothVC: self)
                            self.view.addSubview(noticeView)
                            //                            let view1 = HowToBoothEventView(attendFunc: { (eventView : HowToBoothEventView) in
                            //                                eventView.removeFromSuperview()
                            //                            })
                            //                            self.view.addSubview(view1)
                        }
                    }
                }
            }
        }
}
    

class BoothButtonView: UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, iconImageName kIconImageName : FontAwesome, name kName : String) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.5568627451, blue: 0.8352941176, alpha: 1)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.5, height: self.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: kIconImageName, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), size: iconImageView.frame.size)
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 5, y: 0, width: 1000, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = kName
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: 15)
        if IS_IPHONE_SE {
            nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: 12)
        }
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SurveyButtonView: UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, iconImageName kIconImageName : FontAwesome, name kName : String) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.6431372549, blue: 0.5294117647, alpha: 1)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.5, height: self.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: kIconImageName, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), size: iconImageView.frame.size)
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 5, y: 0, width: 1000, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = kName
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: 15)
        if IS_IPHONE_SE {
            nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: 12)
        }
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ScannerButton : UIButton {
    
    init(){
        super.init(frame: SCREEN.BOUND)
        
        let innerView = UIView(frame: SCREEN.BOUND)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        innerView.backgroundColor = #colorLiteral(red: 0.09646994621, green: 0.163752377, blue: 0.2646248043, alpha: 1)
        
        let scanLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.75, height: 100))
        scanLabel.font = UIFont(name: NotoSansCJKkr_Medium, size: SCREEN.WIDTH * 0.04)
        scanLabel.textAlignment = .center
        scanLabel.text = "Please scan the barcode of each booth"
        scanLabel.sizeToFit()
        scanLabel.center.x = SCREEN.WIDTH / 2
        scanLabel.frame.origin.y = 15
        scanLabel.isUserInteractionEnabled = false
        scanLabel.textColor = UIColor.white
        innerView.addSubview(scanLabel)
        
        let scanImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.65, height: 0))
        scanImageView.setImageWithFrameHeight(image: UIImage(named: "icoScan"))
        scanImageView.isUserInteractionEnabled = false
        scanImageView.center.x = SCREEN.WIDTH / 2
        scanImageView.frame.origin.y = scanLabel.frame.maxY + 15
        innerView.addSubview(scanImageView)
        
        innerView.frame.size.height = scanImageView.maxY + 10 + SAFE_AREA
        innerView.setCornerRadius(cornerRadius: SCREEN.WIDTH * 0.075, byRoundingCorners: [.topRight,.topLeft])
        innerView.isUserInteractionEnabled = false
        innerView.setShadow()
        self.frame.size.height = innerView.maxY
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//class ScannerButton: UIButton {
//    
//    
//    init() {
//        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0))
//        
//        self.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.4039215686, blue: 0.568627451, alpha: 1)
//        //        rgb 88 103 145
//        
//        let innerView1 = UIView(frame:self.bounds)
//        innerView1.isUserInteractionEnabled = false
//        self.addSubview(innerView1)
//        
//        let noticeLabel1 = UILabel(frame: CGRect(x: 0, y: 10, width: self.frame.size.width, height: 100))
//        noticeLabel1.text = "Please scan the barcode of each booth"
//        noticeLabel1.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        noticeLabel1.font = UIFont(name: Pretendard_Regular, size: 12)
//        noticeLabel1.sizeToFit()
//        noticeLabel1.center.x = SCREEN.WIDTH / 2
//        noticeLabel1.frame.size.height += 15
//        innerView1.addSubview(noticeLabel1)
//        
//        let innerView2 = UIView(frame: self.bounds)
//        innerView2.frame.origin.y = noticeLabel1.frame.maxY
//        innerView2.isUserInteractionEnabled = false
//        innerView1.addSubview(innerView2)
//        
//        let noticeLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 100))
//        noticeLabel2.text = "SCANNER"
//        noticeLabel2.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        noticeLabel2.font = UIFont(name: Pretendard_Bold, size: 20)
//        noticeLabel2.sizeToFit()
//        noticeLabel2.center.y = innerView2.frame.size.height / 2
//        noticeLabel2.frame.size.height += 20
//        innerView2.addSubview(noticeLabel2)
//        
//        let iconImageView = UIImageView(frame: CGRect(x: noticeLabel2.frame.maxX + 10, y: 0, width: 22, height: 16))
//        iconImageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.arrowRight, style: .solid, textColor: UIColor.white, size: iconImageView.frame.size)
//        innerView2.addSubview(iconImageView)
//        innerView2.frame.size.height = iconImageView.frame.size.height
//        
//        innerView2.frame.size.width = iconImageView.frame.maxX
//        innerView2.frame.size.height = iconImageView.frame.size.height
//        innerView2.center.x = innerView1.frame.size.width / 2
//        
//        noticeLabel2.center.y = innerView2.frame.size.height / 2
//        iconImageView.center.y = innerView2.frame.size.height / 2
//        
//        innerView1.frame.size.height = innerView2.frame.maxY + 10
//        
//        self.frame.size.height = innerView1.frame.size.height + 10 + SAFE_AREA
//        
//        //        self.layer.borderWidth = 2
//        //        self.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.3882352941, blue: 0.8274509804, alpha: 1).cgColor
//        
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
