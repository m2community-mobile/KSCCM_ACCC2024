//
//  HowToBoothEventView.swift
//  koa2019s
//
//  Created by JinGu-MacBookPro on 12/03/2019.
//  Copyright © 2019 m2community. All rights reserved.
//

import UIKit
import FontAwesome_swift

class HowToBoothEventView: UIView {

    init(attendFunc : @escaping( _ howToBoothEventView : HowToBoothEventView)->Void ) {
        super.init(frame: SCREEN.BOUND)
        
        let bgImageView = UIImageView(frame: self.bounds)
        if IS_NORCH {
            bgImageView.setImageWithFrameHeight(image: UIImage(named: "howToEvent_Max"))
        }else{
            bgImageView.setImageWithFrameHeight(image: UIImage(named: "howToEvent_Plus"))
        }
        self.addSubview(bgImageView)
        
        let closeButtonSize : CGFloat = SCREEN.WIDTH * 0.15
        let closeButton = ImageButton(frame: CGRect(x: SCREEN.WIDTH - closeButtonSize, y: STATUS_BAR_HEIGHT, width: closeButtonSize, height: closeButtonSize), image: UIImage(named: "btnX2"), ratio: 0.5)
        self.addSubview(closeButton)
        closeButton.addTarget(event: .touchUpInside) { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: { (fi) in
                self.removeFromSuperview()
            })
        }
        
        let attendButtonHeight : CGFloat = 50
        let attendButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - 30, height: attendButtonHeight))
        if IS_NORCH {
            attendButton.frame.origin.y = SCREEN.HEIGHT - attendButtonHeight - SAFE_AREA
        }else{
            attendButton.frame.origin.y = SCREEN.HEIGHT - attendButtonHeight - 15
        }
        attendButton.center.x = SCREEN.WIDTH / 2
        attendButton.backgroundColor = UIColor.white
        attendButton.setTitleColor(#colorLiteral(red: 0.1529411765, green: 0.2039215686, blue: 0.4039215686, alpha: 1), for: UIControl.State.normal)
        self.addSubview(attendButton)
        
        attendButton.setTitle("참여하기", for: .normal)
        attendButton.titleLabel?.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: attendButton.frame.size.height * 0.35)
        attendButton.addTarget(event: .touchUpInside) { (button) in
            attendFunc(self)
        }

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


class BottomButtonWithSafeArea : UIButton {
    init(imageName : String?, name : String, backgroundColor kBackgroundColor : UIColor) {
        super.init(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (50 + SAFE_AREA), width: SCREEN.WIDTH, height: 50 + SAFE_AREA))
        
        self.backgroundColor = kBackgroundColor
        
        let iconView = IconView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 50), iconImageName: imageName, name: name)
        self.addSubview(iconView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class IconView: UIView {
        
        var iconImageView : UIImageView!
        var nameLabel : UILabel!
        
        init(frame: CGRect, iconImageName kIconImageName : String?, name kName : String) {
            super.init(frame: frame)
            
            self.isUserInteractionEnabled = false
            
            let innerView = UIView(frame: self.bounds)
            self.addSubview(innerView)
            
            iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height * 0.5))
            if let iconImageName = kIconImageName, let iconImage = UIImage(named: iconImageName) {
                iconImageView.setImageWithFrameWidth(image: iconImage)
            }else{
                iconImageView.frame.size = CGSize.zero
            }
            iconImageView.center.y = self.frame.size.height / 2
            iconImageView.isUserInteractionEnabled = false
            innerView.addSubview(iconImageView)
            
            nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
            nameLabel.numberOfLines = 0
            nameLabel.textAlignment = .center
            nameLabel.text = kName
            nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 20)
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
}
