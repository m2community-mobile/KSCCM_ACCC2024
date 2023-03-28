//
//  BottomSubView.swift
//  koa2019s
//
//  Created by JinGu's iMac on 2020/02/10.
//  Copyright © 2020 m2community. All rights reserved.
//

import UIKit

protocol BottomSubPopUpViewDelegate {
    func bottomSubViewButtonPressed( index : Int )
}



class BottomSubView: UIView {

    var popUpView : PopUpView!
    var closeButton : BottomSubViewCloseButton!
    var programButton : BottomIconButton!
    var bottomProgramButton : BottomIconButton?
    var flipView : UIView!
    var grayView : UIView!
    init(delegate kDelegate : BottomSubPopUpViewDelegate, programButton kProgramButton : BottomIconButton) {
        super.init(frame: SCREEN.BOUND)
        
        bottomProgramButton = kProgramButton
        
        grayView = UIView(frame: self.bounds)
        grayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.7)
        grayView.alpha = 0
        self.addSubview(grayView)
        
        let grayCloseButton = UIButton(frame: self.bounds)
        self.addSubview(grayCloseButton)
        grayCloseButton.addTarget(event: .touchUpInside) { (button) in
            self.close{}
        }
        
        
        let flipViewFrame = (appDel.window?.convert(kProgramButton.frame, from: kProgramButton.superview!))!
        flipView = UIView(frame: flipViewFrame)
        
        popUpView = PopUpView(delegate: kDelegate, flipView: self.flipView)
        popUpView.alpha = 0
        self.addSubview(popUpView)

        
        self.addSubview(flipView)
        
        self.closeButton = BottomSubViewCloseButton(frame: flipView.bounds)

        self.closeButton.actionButton.addTarget(event: .touchUpInside) { (button) in
            self.close{}
        }

        programButton = BottomIconButton(frame: flipView.bounds, name: "PROGRAM", imageName: "footIco2")
        flipView.addSubview(programButton)
        
    }
    
    func open(){
        self.bottomProgramButton?.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { (timer) in
            UIView.transition(with: self.flipView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.programButton.removeFromSuperview()
                self.flipView.addSubview(self.closeButton)
                self.popUpView.alpha = 1
                self.grayView.alpha = 1
            }) { (fi) in
                
            }
        }
    }
    
    func close(complete:@escaping() -> Void){
        
        UIView.transition(with: self.flipView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.closeButton.removeFromSuperview()
            self.flipView.addSubview(self.programButton)
            self.popUpView.alpha = 0
            self.grayView.alpha = 0
        }) { (fi) in
            self.removeFromSuperview()
            self.bottomProgramButton?.isHidden = false
            complete()
        }
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class BottomSubViewCloseButton: UIView {
        var actionButton : UIButton!
        var imageView : UIImageView!
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1098039216, blue: 0.1333333333, alpha: 1)
            
            let imageRatio : CGFloat = 0.5
            let imageSize = min(self.frame.size.width, self.frame.size.height)
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize * imageRatio, height: imageSize * imageRatio))
            imageView.image = UIImage(named: "BottomSubViewCloseImage")
            imageView.center = self.frame.center
            self.addSubview(imageView)
            
            self.actionButton = UIButton(frame: self.bounds)
            self.addSubview(actionButton)
            
        }

        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class PopUpView: UIView {
        
        let titles = [
        "Program at a glance",
        "April 27 (Thu)",
        "April 28 (Fri)",
        "KSCCM-JSICM Joint Session",
        "Workshop",
        "Luncheon Symposium",
        ]
        
        var delegate : BottomSubPopUpViewDelegate?
        
        init(delegate kDelegate : BottomSubPopUpViewDelegate, flipView : UIView) {
            super.init(frame: SCREEN.BOUND)
            
            self.delegate = kDelegate
            
            self.frame.size.width = SCREEN.WIDTH * 0.65
            
            let innerView = UIView(frame: self.bounds)
            innerView.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2784313725, blue: 0.4980392157, alpha: 1)
            self.addSubview(innerView)
            
            var contentViewHeight : CGFloat = 40
            
            innerView.clipsToBounds = true
            innerView.layer.cornerRadius = 5
            
            for i in 0..<titles.count {
                let contentView = ContentView(
                    frame: CGRect(x: 0, y: (CGFloat(i) * contentViewHeight) + 10, width: innerView.frame.size.width, height: contentViewHeight), title: titles[i])
                contentView.actionButton.addTarget(event: .touchUpInside) { (button) in
                    self.delegate?.bottomSubViewButtonPressed(index: i)
                }
                innerView.addSubview(contentView)
            }
            
            innerView.frame.size.height = 10 + (contentViewHeight * CGFloat(titles.count)) + 10
            
            let triangleHeight : CGFloat = 15
            let triangleWidth : CGFloat = 30
            let triangleCenterX : CGFloat = (SCREEN.WIDTH / 6 / 2)
            let triangleLayer = CAShapeLayer()
            triangleLayer.lineCap = CAShapeLayerLineCap.round
            triangleLayer.lineJoin = CAShapeLayerLineJoin.round
            triangleLayer.fillColor = innerView.backgroundColor!.cgColor
            triangleLayer.lineWidth = 0
            triangleLayer.strokeColor = UIColor.clear.cgColor
//                        triangleLayer.lineDashPattern = [1,7]
            self.layer.addSublayer(triangleLayer)

            let trianglePath = UIBezierPath()
            trianglePath.move(to: CGPoint(x: triangleCenterX - (triangleWidth / 2), y: innerView.frame.size.height))
            trianglePath.addLine(to: CGPoint(x: triangleCenterX + (triangleWidth / 2), y: innerView.frame.size.height))
            trianglePath.addLine(to: CGPoint(x: triangleCenterX, y: innerView.frame.size.height + triangleHeight))
            trianglePath.addLine(to: CGPoint(x: triangleCenterX - (triangleWidth / 2), y: innerView.frame.size.height))
            triangleLayer.path = trianglePath.cgPath
            
            self.frame.size.height = innerView.frame.size.height + triangleHeight * 2
            
//            self.frame.origin.x = SCREEN.WIDTH / 6
//            self.frame.origin.y = SCREEN.HEIGHT - SAFE_AREA - 55 - self.frame.size.height
                        
            self.frame.origin.x = flipView.frame.origin.x
            self.frame.origin.y = flipView.frame.maxY - self.frame.size.height - flipView.frame.size.height
            
//            innerView.backgroundColor = UIColor.red
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        class ContentView: UIView {
            
            var actionButton : UIButton!
            
            init(frame: CGRect, title : String) {
                super.init(frame: frame)
                
                let circleView = UIView(frame: CGRect(x: 15, y: 0, width: 5, height: 5))
                circleView.backgroundColor = UIColor.white
                circleView.layer.cornerRadius = circleView.height / 2
                circleView.center.y = self.height / 2
                self.addSubview(circleView)
                
                let label = UILabel(frame: self.bounds)
                label.text = "\(title)"
                label.font = UIFont(name: Pretendard_Bold, size: 15)
                label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                label.sizeToFit()
                label.center.y = self.frame.size.height / 2
                label.frame.origin.x = circleView.maxX + 10
                self.addSubview(label)
                
                actionButton = UIButton(frame: self.bounds)
                self.addSubview(actionButton)
                
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
    }
}

extension BottomView : BottomSubPopUpViewDelegate {
    
    
    func bottomSubViewButtonPressed(index: Int) {
        
        print("BottomView : BottomSubPopUpViewDelegate:\(index)")
        
        
        self.bottomSubView?.close{
            DispatchQueue.main.async {
                switch index {
                case 0:
                    goPAG()
                    break
                case 1:
                    goURL(urlString: URL_KEY.day_1)
                    break
                case 2:
                    goURL(urlString: URL_KEY.day_2)
                    break
                case 3:
                    goURL(urlString: URL_KEY.KSCCM_JSICM_Joint_Session)
                    break
                case 4:
                    goURL(urlString: URL_KEY.Workshop)
                    break
                case 5:
                    goURL(urlString: URL_KEY.Luncheon_Symposium)
                    break
                default:
                    break
                }
            }
            
        }
        
    }
    
    
}

