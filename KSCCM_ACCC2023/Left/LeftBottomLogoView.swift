//
//  LeftBottomLogoView.swift
//  icksh2021
//
//  Created by JinGu's iMac on 2021/03/29.
//

import UIKit

class LeftBottomLogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2392156863, blue: 0.4588235294, alpha: 1)
        
        let supportedByLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width * 0.9, height: 50))
        supportedByLabel.font = UIFont(name: ROBOTO_BOLD, size: LeftTableViewHeader.height * 0.3 * 0.95)
        supportedByLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        supportedByLabel.text = "Supported By"
        supportedByLabel.sizeToFit()
        supportedByLabel.frame.size.width = self.frame.size.width * 0.85
        supportedByLabel.frame.size.height += 30
        supportedByLabel.center.x = self.frame.size.width / 2
        self.addSubview(supportedByLabel)
        
//        let logoImageViewCenterGapWidth : CGFloat = supportedByLabel.frame.origin.x
        let logoImageViewCenterGapWidth : CGFloat = 0
        
        let logoImageViewWidth = (supportedByLabel.width - logoImageViewCenterGapWidth) / 2
        
        let logoImageView1 = UIImageView(frame: CGRect(
                                            x: supportedByLabel.frame.origin.x,
                                            y: supportedByLabel.maxY,
                                            width: logoImageViewWidth,
                                            height: 0))
        logoImageView1.setImageWithFrameHeight(image: UIImage(named: "LeftLogo1"))
        self.addSubview(logoImageView1)
        
        let logoImageView2 = UIImageView(frame: CGRect(
                                            x: logoImageView1.maxX + logoImageViewCenterGapWidth,
                                            y: supportedByLabel.maxY,
                                            width: logoImageViewWidth,
                                            height: 0))
        logoImageView2.setImageWithFrameHeight(image: UIImage(named: "LeftLogo2"))
        self.addSubview(logoImageView2)
        
        if SAFE_AREA == 0 {
            self.frame.size.height = logoImageView2.maxY + supportedByLabel.frame.origin.x
        }else{
            self.frame.size.height = logoImageView2.maxY
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
