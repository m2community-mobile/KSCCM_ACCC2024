//
//  BoothEventCompleteView.swift
//  koa2019s
//
//  Created by JinGu-MacBookPro on 12/03/2019.
//  Copyright © 2019 m2community. All rights reserved.
//

import UIKit
import FontAwesome_swift

class BoothEventCompleteView: UIView {

    var enterTheWinButton : UIButton?
    var enterTheWinButtonPressedFunc : (()->())?
    init() {
        super.init(frame: SCREEN.BOUND)
        
        self.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2392156863, blue: 0.5450980392, alpha: 1)
        
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 25, width: SCREEN.WIDTH, height: 100))
        label1.text = "YOU COLLECTED ALL THE STAMPS!"
        label1.font = UIFont(name: Pretendard_Bold, size: 20)
        label1.textColor = #colorLiteral(red: 0.7764705882, green: 1, blue: 0.3490196078, alpha: 1)
        label1.textAlignment = .center
        label1.sizeToFit()
        label1.center.x = SCREEN.WIDTH / 2
        self.addSubview(label1)
        
        let backView1 = UIView(frame: CGRect(x: 0, y: label1.frame.maxY + 25, width: 1000, height: 1000))
        self.addSubview(backView1)
        
        let boothBoxImage = UIImage(named: "boothBox")
        let boothBoxImageView = UIImageView(frame: CGRect(x: 40, y: 20, width: 45, height: 0))
        boothBoxImageView.setImageWithFrameHeight(image: boothBoxImage)
        backView1.addSubview(boothBoxImageView)
        
        let boothBoxLabel = UILabel(frame: CGRect(x: boothBoxImageView.maxX + 15, y: 0, width: 1000, height: 1000))
        boothBoxLabel.text = "Enter to Win"
        boothBoxLabel.font = UIFont(name: Pretendard_Bold, size: 25)
        boothBoxLabel.textColor = UIColor.white
        boothBoxLabel.sizeToFit()
        backView1.addSubview(boothBoxLabel)
        
        backView1.frame.size.height = boothBoxImageView.maxY + 20
        boothBoxLabel.center.y = backView1.frame.size.height / 2
        backView1.frame.size.width = boothBoxLabel.maxX + 40
        backView1.center.x = self.width / 2
        backView1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1058823529, blue: 0.2784313725, alpha: 1)
        backView1.layer.borderColor = UIColor.white.cgColor
        backView1.layer.borderWidth = 3
        //rgb 24 27 71
        
        enterTheWinButton = UIButton(frame: backView1.bounds)
        enterTheWinButton?.addTarget(self, action: #selector(enterTheWinButtonPressed), for: .touchUpInside)
        backView1.addSubview(enterTheWinButton!)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: backView1.maxY + 20, width: 1000, height: 1000))
        label2.numberOfLines = 0
        label2.text = """
        Lucky Draw winners will be announced at
        the Closing Ceremony
        (April 15 (Sat), 13:20 I Room B).
        """
        label2.textColor = #colorLiteral(red: 0.9921568627, green: 1, blue: 0.3921568627, alpha: 1)
        label2.textAlignment = .center
        label2.sizeToFit()
        label2.center.x = self.width / 2
        self.addSubview(label2)
        
        self.frame.size.height = label2.frame.maxY + 10 + SAFE_AREA
        
        let boothEventCompleteViewTopRightImage = UIImage(named: "BoothEventCompleteViewTopRight")
        let boothEventCompleteViewTopRightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.17, height: 0))
        boothEventCompleteViewTopRightImageView.setImageWithFrameHeight(image: boothEventCompleteViewTopRightImage)
        boothEventCompleteViewTopRightImageView.frame.origin.x = SCREEN.WIDTH - boothEventCompleteViewTopRightImageView.width
        self.insertSubview(boothEventCompleteViewTopRightImageView, at: 0)
        
        let boothEventCompleteViewBottomLeftImage = UIImage(named: "boothEventCompleteViewBottomLeft")
        let boothEventCompleteVieBottomLeftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.2, height: 0))
        boothEventCompleteVieBottomLeftImageView.setImageWithFrameHeight(image: boothEventCompleteViewBottomLeftImage)
        boothEventCompleteVieBottomLeftImageView.frame.origin.y = self.height - boothEventCompleteVieBottomLeftImageView.height
        self.insertSubview(boothEventCompleteVieBottomLeftImageView, at: 0)
        
//        backView1.backgroundColor = UIColor.red.withAlphaComponent(0.5)
//        boothBoxImageView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
//        boothBoxLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        
        return
        
//        let grayView = UIView(frame: SCREEN.BOUND)
//        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        grayView.isUserInteractionEnabled = false
//        self.addSubview(grayView)
//
//        let closeButton1 = UIButton(frame: SCREEN.BOUND)
//        self.addSubview(closeButton1)
//        closeButton1.addTarget(event: .touchUpInside) { (button) in
//            self.removeFromSuperview()
//        }
//
//        let innerView = UIView(frame: SCREEN.BOUND)
//        innerView.isUserInteractionEnabled = false
//        self.addSubview(innerView)
//
//        let closeButton = UIButton(frame: CGRect(x: SCREEN.WIDTH - 50 - 20, y: STATUS_BAR_HEIGHT + (NAVIGATION_BAR_HEIGHT * 0.5), width: 50, height: 50))
//        self.addSubview(closeButton)
//        closeButton.addTarget(event: .touchUpInside) { (button) in
//            self.removeFromSuperview()
//        }
//
//        let closeButtonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        closeButtonImageView.center = closeButton.frame.center
//        closeButtonImageView.image = UIImage(named: "btnClose")
//        closeButtonImageView.isUserInteractionEnabled = false
//        closeButton.addSubview(closeButtonImageView)
//
//        let gaps : (CGFloat,CGFloat,CGFloat,CGFloat) = {
//           return (40,40,40,40)
//        }()
//
//
//        let giftimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.3, height: SCREEN.WIDTH * 0.3))
//        giftimageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.gift, style: FontAwesomeStyle.solid, textColor: UIColor.white, size: giftimageView.frame.size)
//        giftimageView.center.x = SCREEN.WIDTH / 2
////        giftimageView.center.y = SCREEN.HEIGHT * 0.2
//        innerView.addSubview(giftimageView)
//
//        let label1 = UILabel(frame: CGRect(x: 0, y: giftimageView.frame.maxY + gaps.0, width: SCREEN.WIDTH, height: 100))
//        label1.text = "Booth Event 참여완료"
//        label1.textAlignment = .center
//        label1.textColor = UIColor.white
//        label1.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 25)
//        label1.sizeToFit()
//        label1.center.x = SCREEN.WIDTH / 2
////        label1.center.y = SCREEN.HEIGHT * 0.305
//        innerView.addSubview(label1)
//
//        let label2 = UILabel(frame: CGRect(x: 0, y: label1.frame.maxY + gaps.1, width: SCREEN.WIDTH, height: 100))
//        label2.textAlignment = .center
//        label2.numberOfLines = 0
//        innerView.addSubview(label2)
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 5
//        paragraphStyle.alignment = .center
//
//        //?/
//        var fontSize : CGFloat = 20
//        if IS_IPHONE_SE {
//            fontSize = 16
//        }
//        let attInfos : [(String,[NSAttributedString.Key:NSObject])] = [
//            ("축하합니다 !\nBooth Event 이벤트 참여완료 하셨습니다.\n",[
//                NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: fontSize)!
//                ,NSAttributedString.Key.foregroundColor:UIColor.white
//                 ,NSAttributedString.Key.paragraphStyle:paragraphStyle]),
//            ("‘선물 증정 대상’",[
//                NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF, size: fontSize)!
//                ,NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.8509803922, green: 0.9960784314, blue: 0.1725490196, alpha: 1)
//                ,NSAttributedString.Key.paragraphStyle:paragraphStyle]),
//            (" 입니다.",[
//                NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: fontSize)!
//                ,NSAttributedString.Key.foregroundColor:UIColor.white
//                ,NSAttributedString.Key.paragraphStyle:paragraphStyle]),
//
//        ]
//        let attText = NSMutableAttributedString(stringsInfos: attInfos)
//        label2.attributedText = attText
//        label2.sizeToFit()
//        label2.center.x = SCREEN.WIDTH / 2
////        label2.center.y = SCREEN.HEIGHT * 0.43
//
//        ///
//        let qrCodeImageView = UIImageView(frame: CGRect(x: 0, y: label2.frame.maxY + gaps.2, width: SCREEN.WIDTH * 0.75, height: 0))
//        qrCodeImageView.frame.size.height = qrCodeImageView.frame.size.width * 9 / 21
//        qrCodeImageView.image = UIImage.makeQRCodeImage(type: UIImage.CodeType.barCode, code: barCode, size: qrCodeImageView.frame.size)
//        qrCodeImageView.center.x = SCREEN.WIDTH / 2
////        qrCodeImageView.center.y = SCREEN.HEIGHT * 0.66
//        innerView.addSubview(qrCodeImageView)
//
//        ///
//
//        let label3 = UILabel(frame: CGRect(x: 0, y: qrCodeImageView.frame.maxY + gaps.3, width: SCREEN.WIDTH, height: 100))
//        label3.textAlignment = .center
//        label3.numberOfLines = 0
//        innerView.addSubview(label3)
//
//
//
//        let attInfos2 : [(String,[NSAttributedString.Key:NSObject])] = [
//            ("행사장 선물 수령 장소에서\n",[
//                NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: fontSize)!
//                ,NSAttributedString.Key.foregroundColor:UIColor.white
//                ,NSAttributedString.Key.paragraphStyle:paragraphStyle]),
//            ("직원에게 바코드를 보여주세요",[
//                NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: fontSize)!
//                ,NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.8509803922, green: 0.9960784314, blue: 0.1725490196, alpha: 1)
//                ,NSAttributedString.Key.paragraphStyle:paragraphStyle])
//            ]
//        let attText2 = NSMutableAttributedString(stringsInfos: attInfos2)
//        label3.attributedText = attText2
//        label3.sizeToFit()
//        label3.center.x = SCREEN.WIDTH / 2
////        label3.center.y = SCREEN.HEIGHT * 0.85
//
//        innerView.frame.size.height = label3.frame.maxY
//        innerView.center.y = SCREEN.HEIGHT / 2

    }
    
    @objc func enterTheWinButtonPressed(){
        print("enterTheWinButtonPressed")
        
        self.enterTheWinButtonPressedFunc?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
