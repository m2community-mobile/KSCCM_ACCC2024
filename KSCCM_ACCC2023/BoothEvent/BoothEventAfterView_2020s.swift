//
//  BoothEventAfterView.swift
//  koa2019s
//
//  Created by m2comm on 14/03/2019.
//  Copyright © 2019 m2community. All rights reserved.
//

import UIKit
import FontAwesome_swift


class BoothEventAfterView: UIView {

    var signDate = 0
    
    var label3 : UILabel!
    
    init() {
        super.init(frame: SCREEN.BOUND)
        
        self.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.5450980392, alpha: 1)

        let boothEventCompleteViewImage1Image = UIImage(named: "BoothEventCompleteViewImage1")
        let boothEventCompleteViewImage1ImageView = UIImageView(frame: CGRect(x: 0, y: 20, width: SCREEN.WIDTH * 0.3, height: 0))
        boothEventCompleteViewImage1ImageView.setImageWithFrameHeight(image: boothEventCompleteViewImage1Image)
        boothEventCompleteViewImage1ImageView.frame.origin.x = (SCREEN.WIDTH / 2) - (boothEventCompleteViewImage1ImageView.width * 0.75)
        self.addSubview(boothEventCompleteViewImage1ImageView)
        
//        Thank you for joining the event!
        let label1 = UILabel(frame: CGRect(x: 0, y: boothEventCompleteViewImage1ImageView.maxY, width: SCREEN.WIDTH, height: 100))
        label1.text = "Thank you for joining the event!"
        label1.font = UIFont(name: Pretendard_Bold, size: 20)
        label1.textColor = #colorLiteral(red: 0.3490196078, green: 0.9607843137, blue: 1, alpha: 1)
        label1.textAlignment = .center
        label1.sizeToFit()
        label1.center.x = SCREEN.WIDTH / 2
        self.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: label1.maxY + 20, width: 1000, height: 1000))
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
        
        self.frame.size.height = label2.maxY + 20 + SAFE_AREA
        
//        self.signDate = 0
//
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
//
//        let giftimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.3, height: SCREEN.WIDTH * 0.3))
//        giftimageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.gift, style: FontAwesomeStyle.solid, textColor: UIColor.white, size: giftimageView.frame.size)
//        giftimageView.center.x = SCREEN.WIDTH / 2
//        giftimageView.center.y = SCREEN.HEIGHT * 0.2
//        innerView.addSubview(giftimageView)
//
//        let label1 = UILabel(frame: CGRect(x: 0, y: giftimageView.frame.maxY + 20, width: SCREEN.WIDTH, height: 100))
//        label1.text = "선물 교환 완료"
//        label1.textAlignment = .center
//        label1.textColor = UIColor.white
//        label1.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 25)
//        label1.sizeToFit()
//        label1.center.x = SCREEN.WIDTH / 2
//        label1.center.y = SCREEN.HEIGHT * 0.3
//        innerView.addSubview(label1)
//
//        let label2 = UILabel(frame: CGRect(x: 0, y: label1.frame.maxY + 20, width: SCREEN.WIDTH, height: 100))
//        label2.numberOfLines = 0
//        label2.textAlignment = .center
//        label2.textColor = UIColor.white
//
//        let originText = "감사합니다.\n선물교환이 완료되었습니다."
//        let attText = NSMutableAttributedString(string: originText)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 15
//        paragraphStyle.alignment = .center
//        attText.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle,
//                               NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF, size: 20)!], range: NSMakeRange(0, originText.count))
//        label2.attributedText = attText
//        label2.sizeToFit()
//        label2.center.x = SCREEN.WIDTH / 2
//        label2.center.y = SCREEN.HEIGHT * 0.40
//        innerView.addSubview(label2)
//
//
//
//        label3 = UILabel(frame: CGRect(x: 0, y: label2.frame.maxY + 50, width: SCREEN.WIDTH, height: 100))
//        label3.text = "04월18일(목) 13시34분 교환 완료"
//        label3.numberOfLines = 0
//        label3.textAlignment = .center
//        label3.textColor = UIColor.white
//        label3.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 20)
//        label3.sizeToFit()
//        label3.center.x = SCREEN.WIDTH / 2
//        label3.center.y = SCREEN.HEIGHT * 0.56
//        innerView.addSubview(label3)
//
//        //교환완료
//        let buttonView = UIButton(frame: CGRect(x: 0, y: label3.frame.maxY + 30, width: SCREEN.WIDTH * 0.85, height: 60))
//        buttonView.setTitle("교환완료", for: .normal)
//        buttonView.titleLabel?.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 25)
//        buttonView.backgroundColor = #colorLiteral(red: 0.8, green: 0.06274509804, blue: 0.3568627451, alpha: 1)
//        buttonView.center.x = SCREEN.WIDTH / 2
//        buttonView.center.y = SCREEN.HEIGHT * 0.6627
//        innerView.addSubview(buttonView)
//
////        innerView.frame.size.height = buttonView.frame.maxY
////        innerView.center.y = SCREEN.HEIGHT / 2
//
//        self.timeUpdate()
    }
    
//    func timeUpdate(){
//        let time = Date(timeIntervalSince1970: TimeInterval(self.signDate))
//        let timeString = DateCenter.shared.dateToStringWithFormat(formatString: "MM월dd일(E) hh시mm분 교환 완료", date: time)
//        self.label3.text = timeString
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
