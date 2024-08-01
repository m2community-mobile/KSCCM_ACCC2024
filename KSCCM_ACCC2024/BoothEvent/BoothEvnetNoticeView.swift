//
//  PhotojenicAwardNoticeView.swift
//  korl2019f
//
//  Created by JinGu's iMac on 10/10/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit
import WebKit

class BoothEvnetNoticeView: UIView {
    
    var webView : WebView!
    
    init(boothVC : BoothEventViewController) {
        super.init(frame: SCREEN.BOUND)
        
        
        let attendButtonHeight : CGFloat = 50
        let attendButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT - attendButtonHeight - SAFE_AREA, width: SCREEN.WIDTH, height: attendButtonHeight + SAFE_AREA))
        attendButton.center.x = SCREEN.WIDTH / 2
        attendButton.backgroundColor = #colorLiteral(red: 0.1505553424, green: 0.5663633943, blue: 0.7254880071, alpha: 1)
        self.addSubview(attendButton)
        
        let attendButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: attendButtonHeight))
        attendButtonLabel.isUserInteractionEnabled = false
        attendButtonLabel.text = "Join the Event"
        attendButtonLabel.textColor = UIColor.white
        attendButtonLabel.textAlignment = .center
        attendButtonLabel.font = UIFont(name: Pretendard_Bold, size: attendButtonLabel.frame.size.height * 0.35)
        attendButton.addSubview(attendButtonLabel)
        attendButton.addTarget(event: .touchUpInside) { (button) in
            self.removeFromSuperview()
        }
        
        
        webView = WebView(frame: CGRect(
            x: 0,
            y: 0,
            width: SCREEN.WIDTH,
//            height: attendButton.frame.minY), urlString: "http://ezv.kr/ksccm2023/html/contents/event.html")
            height: attendButton.frame.minY), urlString: "http://ezv.kr/ksccm2024/html/sub/event.html")
        webView.motherVC = boothVC
        webView.boothEvnetNoticeView = self
        self.addSubview(webView)
        
        
        let closeButtonSize : CGFloat = SCREEN.WIDTH * 0.15
        let closeButton = ImageButton(frame: CGRect(x: SCREEN.WIDTH - closeButtonSize, y: STATUS_BAR_HEIGHT, width: closeButtonSize, height: closeButtonSize), image: UIImage(named: "btnX2"), ratio: 0.5)
        self.addSubview(closeButton)
        closeButton.addTarget(event: .touchUpInside) { (button) in
            self.removeFromSuperview()
        }
        print("closeButton.backgroundColor = UIColor.red")
        self.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
