//
//  BottomView.swift
//  icksh2020
//
//  Created by JinGu's iMac on 2020/01/07.
//  Copyright © 2020 JinGu's iMac. All rights reserved.
//

import UIKit

var BottomViewInnerViewSizeHeight : CGFloat {
    if IS_IPHONE_SE {
        return 45
    }else{
        return 55
    }
}

class BottomView: UIView {
    var bottomSubView : BottomSubView?
    init() {
        print("bottomview init")
        super.init(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (BottomViewInnerViewSizeHeight + SAFE_AREA), width: SCREEN.WIDTH, height: BottomViewInnerViewSizeHeight + SAFE_AREA))
        self.backgroundColor = #colorLiteral(red: 0.05882352941, green: 0.07058823529, blue: 0.09411764706, alpha: 1)
        
        self.clipsToBounds = true
        
        let innerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: BottomViewInnerViewSizeHeight))
        innerView.backgroundColor = UIColor.clear
        self.addSubview(innerView)
        
        if IS_NORCH {
            let safeView = UIView(frame: CGRect(x: 0, y: innerView.frame.maxY, width: self.frame.size.width, height: SAFE_AREA))
            safeView.backgroundColor = UIColor.clear
            self.addSubview(safeView)
        }
        
        let buttonCount = 5
        let buttonWidth : CGFloat = SCREEN.WIDTH / CGFloat(buttonCount)
        let buttonHeight : CGFloat = BottomViewInnerViewSizeHeight
        let buttonNames = ["HOME","PROGRAM","NOW","SEARCH","FAVORITE"]
        for i in 0..<buttonCount{
            
            let bottomButton = BottomIconButton(frame: CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: buttonHeight), name: buttonNames[i], imageName: "footIco\(i+1)")
            innerView.addSubview(bottomButton)
            
            bottomButton.addTarget(event: .touchUpInside) { (button) in
                switch i {
                case 0:
                    appDel.naviCon?.popToRootViewController(animated: true)
                    break
                case 1:
//                    goPAG()//popAnimation: false, pushAnimation: false)
                    self.bottomSubView = BottomSubView(delegate: self , programButton: bottomButton)
                    appDel.window?.addSubview(self.bottomSubView!)
                    self.bottomSubView?.open()
                    break
                case 2:
                    goURL(urlString: URL_KEY.now)//, popAnimation: false, pushAnimation: false)
//                    goURL(urlString: URL_KEY.noticeList)
                    break
                case 3:
                    goURL(urlString: URL_KEY.search)//, popAnimation: false, pushAnimation: false)
                    break
                case 4:
                    goURL(urlString: URL_KEY.mySchedule)//, popAnimation: false, pushAnimation: false)
                    break
                default:
                    break
                }
            }
        }
        
        
//        let separaterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0.5))
//        separaterView.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
//        self.addSubview(separaterView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton: UIButton {
    
    //    override var isHighlighted: Bool {
    //        willSet(newIsHighlighted) {
    //            if newIsHighlighted {
    //                self.buttonImageView.tintColor = #colorLiteral(red: 0, green: 0.4705882353, blue: 1, alpha: 1)
    //            }else{
    //                self.buttonImageView.tintColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5529411765, alpha: 1)
    //            }
    //        }
    //    }
    
    var buttonImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonImageView = UIImageView(frame: self.bounds)
        buttonImageView.isUserInteractionEnabled = false
        //        self.buttonImageView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(buttonImageView)
    }
    
    func setButtonImageView(image : UIImage?) {
        
        if let image = image {
            let imageRatio : CGFloat = 0.5
            buttonImageView.frame.size.height = self.frame.size.height * imageRatio
            buttonImageView.setImageWithFrameWidth(image: image)
        }
        buttonImageView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BottomIconButton: UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: self.bounds)
        iconImageView.frame.size.height *= 0.4
        iconImageView.frame.size.width *= 0.4
        //iconImageView.backgroundColor = UIColor.random
        innerView.addSubview(iconImageView)
        
        if let iconImage = UIImage(named: imageName) {
            iconImageView.setImageWithFrameWidth(image: iconImage)
        }
        iconImageView.center.x = innerView.frame.center.x
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: iconImageView.frame.maxY, width: self.frame.size.width * 2, height: 50))
        nameLabel.frame.size.height = 0
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: OpenSans_SemiBold, size: 11)
        nameLabel.numberOfLines = 0
        innerView.addSubview(nameLabel)
        
        nameLabel.frame.origin.y = iconImageView.frame.maxY + 5
        nameLabel.center.x = innerView.frame.size.width / 2
        nameLabel.text = name
        //        if !name.contains("\n") {
        //            nameLabel.text = "\(name)\n"
        //        }
        nameLabel.sizeToFit()
        nameLabel.text = name
        nameLabel.center.x = self.frame.size.width / 2
        
        innerView.frame.size.height = nameLabel.frame.maxY
        innerView.center.y = self.frame.size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
