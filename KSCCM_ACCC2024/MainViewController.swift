import UIKit

class MainViewController: UIViewController {

    let bottomView = BottomView()
//    var noticeView : LatestNoticeView!
    
    var mainButtonBackView : UIView!
    var mainButtonBackView2 : UIView!
    var mainButtonBackView3 : UIView!
    
    var boothBannerView : Main_BoothBannerView!
    
    var boothEventButton : MainBoothEventButton!
    var boothEventSecondButton : BoothEventSecondButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let isOpen = appDel.leftView?.isOpen, isOpen {
            return .default
        }else{
            return .default
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.noticeView.noticeUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationController?.viewControllers.count == 2 {
            self.navigationController?.viewControllers.removeFirst()
            print("첫번째 선택 뷰컨 제거")
        }
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.2612134814, blue: 0.3129054308, alpha: 1)
        
        //        let mainBGImage = UIImage(named: "mainBG")
        //        let mainBGImageView = UIImageView(frame: self.view.bounds)
        //        mainBGImageView.setImageWithFrameHeight(image: mainBGImage)
        //        self.view.addSubview(mainBGImageView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        self.view.addSubview(statusBar)
        
        let naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: 50))
        if IS_IPHONE_SE { naviBar.frame.size.height = NAVIGATION_BAR_HEIGHT }
        self.view.addSubview(naviBar)
        
        let menuButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "menu"), ratio: 0.45)
        menuButton.addTarget(event: .touchUpInside) { (button) in
            appDel.leftView?.open(currentVC: self)
        }
        
        naviBar.addSubview(menuButton)
        
        let boothEventButtonWidth = NAVIGATION_BAR_HEIGHT * 2
        
        if IS_IPHONE_12PRO_MAX {
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth, height: boothEventButtonWidth))
        } else if IS_IPHONE_X {
            
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 10, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth - 10, height: boothEventButtonWidth - 10))
        } else if IS_IPHONE_N {
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 25, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth - 25, height: boothEventButtonWidth - 25))
        } else if IS_IPHONE_N_PLUS {
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 15, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth - 15, height: boothEventButtonWidth - 15))
        } else if IS_IPHONE_15PRO_MAX {
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 5, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth - 5, height: boothEventButtonWidth - 5))
        } else {
            boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 10, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth - 10, height: boothEventButtonWidth - 10))
        }
        
        let boothEventButtonGradientColors = [
//            #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9960784314, alpha: 1) ,
            #colorLiteral(red: 0.9644821286, green: 0.9447677732, blue: 0.4823975563, alpha: 1) ,
            #colorLiteral(red: 0.2760188878, green: 0.6350777745, blue: 0.2097142637, alpha: 1) ,
        ]
        //rgb 249 250 254
        //rgb 200 76 146
        //rgb 162 104 199
        boothEventButton.setGradientBackgroundColor(colors: boothEventButtonGradientColors) { gradientLayer in
            gradientLayer.startPoint = CGPoint.zero
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        
        
        self.view.addSubview(boothEventButton)
        boothEventButton.animatioinStart()
        boothEventButton.addTarget(event: .touchUpInside) { button in
            goBoothEvent()
        }
        
        
        
        
        if IS_IPHONE_12PRO_MAX {
//            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth, y: STATUS_BAR_HEIGHT + 10, width: boothEventButtonWidth, height: boothEventButtonWidth))
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth, y: boothEventButton.frame.maxY + 10, width: boothEventButtonWidth, height: boothEventButtonWidth))
        } else if IS_IPHONE_X {
            
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 10, y: boothEventButton.frame.maxY + 10, width: boothEventButtonWidth - 10, height: boothEventButtonWidth - 10))
        } else if IS_IPHONE_N {
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 25, y: boothEventButton.frame.maxY + 3, width: boothEventButtonWidth - 25, height: boothEventButtonWidth - 25))
        } else if IS_IPHONE_N_PLUS {
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 15, y: boothEventButton.frame.maxY + 5, width: boothEventButtonWidth - 15, height: boothEventButtonWidth - 15))
        } else if IS_IPHONE_15PRO_MAX {
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 5, y: boothEventButton.frame.maxY + 15, width: boothEventButtonWidth - 5, height: boothEventButtonWidth - 5))
        } else {
            boothEventSecondButton = BoothEventSecondButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth + 10, y: boothEventButton.frame.maxY + 10, width: boothEventButtonWidth - 10, height: boothEventButtonWidth - 10))

        }
        
        let boothSecondEventButtonGradientColors = [
//            #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9960784314, alpha: 1) ,
            #colorLiteral(red: 0.1948547065, green: 0.7559700608, blue: 0.6584917307, alpha: 1) ,
            #colorLiteral(red: 0.1599484384, green: 0.5307745337, blue: 0.9340460896, alpha: 1) ,
        ]
        //rgb 249 250 254
        //rgb 200 76 146
        //rgb 162 104 199
        boothEventSecondButton.setGradientBackgroundColor(colors: boothSecondEventButtonGradientColors) { gradientLayer in
            gradientLayer.startPoint = CGPoint.zero
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        
        
        self.view.addSubview(boothEventSecondButton)
//        boothEventSecondButton.animatioinStart()
        boothEventSecondButton.addTarget(event: .touchUpInside) { button in
//            goBoothEvent()
//            goURL(urlString: "http://ksccm.nainsmart.com")
            let url = URL(string:"http://ksccm.nainsmart.com")
            UIApplication.shared.open(url!, options: [:])
        }
        
        
        
                
        self.view.addSubview(bottomView)
        
        boothBannerView = Main_BoothBannerView(frame: CGRect(x: 0, y: SCREEN.HEIGHT - BoothBannerView.boothViewHeight - SAFE_AREA, width: SCREEN.WIDTH, height: BoothBannerView.boothViewHeight))
        self.view.addSubview(boothBannerView)

        bottomView.frame.origin.y -= BoothBannerView.boothViewHeight

        if SAFE_AREA > 0 {
            let safeAreaView = UIView(frame: CGRect(x: 0, y: boothBannerView.height, width: SCREEN.WIDTH, height: SAFE_AREA))
            safeAreaView.backgroundColor = boothBannerView.backgroundColor
            boothBannerView.addSubview(safeAreaView)
        }

        var mainButtonBackViewHeight : CGFloat = SCREEN.WIDTH
        if !IS_NORCH {
            mainButtonBackViewHeight *= 0.9
        }
        
        if IS_IPHONE_X {
            mainButtonBackView = UIView(frame: CGRect(x: 0, y: bottomView.frame.minY - mainButtonBackViewHeight, width: SCREEN.WIDTH, height: mainButtonBackViewHeight))
            self.view.addSubview(mainButtonBackView)
            
            mainButtonBackView2 = UIView(frame: mainButtonBackView.bounds)
            mainButtonBackView2.frame.size.height *= 0.9
            mainButtonBackView2.frame.size.width = mainButtonBackView2.frame.size.height
            mainButtonBackView2.center = mainButtonBackView.frame.center
            mainButtonBackView.addSubview(mainButtonBackView2)
            
            mainButtonBackView3 = UIView(frame: mainButtonBackView2.bounds)
            mainButtonBackView2.addSubview(mainButtonBackView3)
            
            let buttonWidthGap : CGFloat = 10
            let buttonHeightGap : CGFloat = 10
            let buttonWidth : CGFloat = (mainButtonBackView3.frame.size.width - (buttonWidthGap * 2)) / 3
            let buttonHeight : CGFloat = (mainButtonBackView3.frame.size.height - (buttonHeightGap * 2)) / 3
            for i in 0..<9{
                let buttonX : CGFloat = (buttonWidth + buttonWidthGap) * CGFloat(i % 3)
                let buttonY : CGFloat = (buttonHeight + buttonHeightGap) * CGFloat(i / 3)
                
                let titleString = INFO.MAIN_INFO[i][INFO.KEY.TITLE] ?? ""
                
                let button = MainButton(frame: CGRect(
                    x: buttonX,
                    y: buttonY,
                    width: buttonWidth,
                    height: buttonHeight), imageName: "icon0\(i+1)", name: titleString)
                button.addTarget(event: .touchUpInside) { (button) in
                    let infoDic = INFO.MAIN_INFO[i]
                    contentShow(dataDic: infoDic as [String:Any])
                }
                mainButtonBackView3.addSubview(button)
            }

        } else {
            mainButtonBackView = UIView(frame: CGRect(x: 0, y: bottomView.frame.minY - mainButtonBackViewHeight, width: SCREEN.WIDTH, height: mainButtonBackViewHeight))
            self.view.addSubview(mainButtonBackView)
            
            mainButtonBackView2 = UIView(frame: mainButtonBackView.bounds)
            mainButtonBackView2.frame.size.height *= 0.9
            mainButtonBackView2.frame.size.width = mainButtonBackView2.frame.size.height
            mainButtonBackView2.center = mainButtonBackView.frame.center
            mainButtonBackView.addSubview(mainButtonBackView2)
            
            mainButtonBackView3 = UIView(frame: mainButtonBackView2.bounds)
            mainButtonBackView2.addSubview(mainButtonBackView3)
            
            let buttonWidthGap : CGFloat = 10
            let buttonHeightGap : CGFloat = 10
            let buttonWidth : CGFloat = (mainButtonBackView3.frame.size.width - (buttonWidthGap * 2)) / 3
            let buttonHeight : CGFloat = (mainButtonBackView3.frame.size.height - (buttonHeightGap * 2)) / 3
            for i in 0..<9{
                let buttonX : CGFloat = (buttonWidth + buttonWidthGap) * CGFloat(i % 3)
                let buttonY : CGFloat = (buttonHeight + buttonHeightGap) * CGFloat(i / 3)
                
                let titleString = INFO.MAIN_INFO[i][INFO.KEY.TITLE] ?? ""
                
                let button = MainButton(frame: CGRect(
                    x: buttonX,
                    y: buttonY,
                    width: buttonWidth,
                    height: buttonHeight), imageName: "icon0\(i+1)", name: titleString)
                button.addTarget(event: .touchUpInside) { (button) in
                    let infoDic = INFO.MAIN_INFO[i]
                    contentShow(dataDic: infoDic as [String:Any])
                }
                mainButtonBackView3.addSubview(button)
            }
        }
        
        
        let mainTitle1Image = UIImage(named: "mainTitle1")
        let mainTitle2Image = UIImage(named: "mainTitle2")
        
        let mainTitleImageBackView = UIView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN.WIDTH, height: 0))
        mainTitleImageBackView.frame.size.height = mainButtonBackView.frame.minY - mainTitleImageBackView.frame.minY
        self.view.insertSubview(mainTitleImageBackView, at: 0)
//        self.view.addSubview(mainTitleImageBackView)
        
        let mainTitleImageBackViewTop = UIView(frame: mainTitleImageBackView.bounds)
        mainTitleImageBackViewTop.frame.size.height *= 0.7
        mainTitleImageBackView.addSubview(mainTitleImageBackViewTop)
        
        let mainTitleImageBackViewBottom = UIView(frame: mainTitleImageBackView.bounds)
        mainTitleImageBackViewBottom.frame.origin.y = mainTitleImageBackViewTop.maxY
        mainTitleImageBackViewBottom.frame.size.height = mainTitleImageBackView.height - mainTitleImageBackViewTop.height
        mainTitleImageBackView.addSubview(mainTitleImageBackViewBottom)
        
        let mainTitle1ImageView = UIImageView(frame: mainTitleImageBackViewTop.bounds)
        mainTitle1ImageView.frame.size.width *= 0.7
        mainTitle1ImageView.frame.size.height *= 0.7
        mainTitle1ImageView.setImageWithFrameHeight(image: mainTitle1Image)
        if IS_NORCH {
            mainTitle1ImageView.frame.size.width *= 0.8
            mainTitle1ImageView.frame.size.height *= 0.8
//            mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height - 10
            mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height
        }else{
            mainTitle1ImageView.frame.size.width *= 0.7
            mainTitle1ImageView.frame.size.height *= 0.7
            mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height
            
            if IS_IPHONE_N_PLUS {
                mainTitle1ImageView.frame.size.width *= 1
                mainTitle1ImageView.frame.size.height *= 1
                mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height + 20
            }
        }
        mainTitle1ImageView.center.x = SCREEN.WIDTH / 2
        mainTitleImageBackViewTop.addSubview(mainTitle1ImageView)
        
        let mainTitle2ImageView = UIImageView(frame: mainTitleImageBackViewBottom.bounds)
        if IS_NORCH {
            mainTitle2ImageView.frame.size.width *= 0.87
            
            if IS_IPHONE_X {
                mainTitle2ImageView.frame.size.width *= 0.85
            }
            
        }else{
            mainTitle2ImageView.frame.size.width *= 0.83
        }
        mainTitle2ImageView.setImageWithFrameHeight(image: mainTitle2Image)
        if IS_NORCH {
            mainTitle2ImageView.frame.origin.y = 10
        }else{
            mainTitle2ImageView.frame.origin.y = 5
            
            if IS_IPHONE_N_PLUS {
                mainTitle2ImageView.frame.size.width *= 0.95
            } else if IS_IPHONE_N {
                mainTitle2ImageView.frame.size.width *= 0.9
                mainTitle2ImageView.frame.size.height *= 0.9
            }
        }
        mainTitle2ImageView.center.x = SCREEN.WIDTH / 2
        mainTitleImageBackViewBottom.addSubview(mainTitle2ImageView)
        
        
//        여기 다가 베너 작업
//        var myView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//        myView.backgroundColor = .yellow
//        
//        boothBannerView.addSubview(myView)
        
        var myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: boothBannerView.frame.height))
        
        myStackView.alignment = .fill
        myStackView.distribution = .fillEqually
        myStackView.spacing = 8.0
//        myStackView.backgroundColor = .yellow
        
//        var myImage1 = UIImage(named: "http://ezv.kr/voting/upload/booth/1708841880diamond_01.png")
        var myImage1 = URL(string: "http://ezv.kr/voting/upload/booth/1708841880diamond_01.png")
        var data1 = try? Data(contentsOf: myImage1!)
//        var myImage2 = UIImage(named: "http://ezv.kr/voting/upload/booth/1708841916Platinum_01.png")
        
        var myImage2 = URL(string: "http://ezv.kr/voting/upload/booth/1708841916Platinum_01.png")
        var data2 = try? Data(contentsOf: myImage2!)
//        var myImage3 = UIImage(named: "http://ezv.kr/voting/upload/booth/1710046466Platinum_02.png")
        var myImage3 = URL(string: "http://ezv.kr/voting/upload/booth/1710046466Platinum_02.png")
        var data3 = try? Data(contentsOf: myImage3!)
        boothBannerView.addSubview(myStackView)
        
        
        var myView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: boothBannerView.frame.height))
//        myView1.backgroundColor = .yellow
        myView1.image = UIImage(data: data1!)
        var myView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: boothBannerView.frame.height))
//        myView2.backgroundColor = .blue
        myView2.image = UIImage(data: data2!)
        var myView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: boothBannerView.frame.height))
//        myView3.backgroundColor = .black
        myView3.image = UIImage(data: data3!)
        myStackView.addArrangedSubview(myView1)
        myStackView.addArrangedSubview(myView2)
        myStackView.addArrangedSubview(myView3)
        
        
        let tapImageViewRecognizer
                   = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                  //이미지뷰가 상호작용할 수 있게 설정
        myView1.isUserInteractionEnabled = true
                  //이미지뷰에 제스처인식기 연결
        myView1.addGestureRecognizer(tapImageViewRecognizer)
        
        
        let tapImageViewRecognizer2
                   = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
                  //이미지뷰가 상호작용할 수 있게 설정
        myView2.isUserInteractionEnabled = true
                  //이미지뷰에 제스처인식기 연결
        myView2.addGestureRecognizer(tapImageViewRecognizer2)
        
        let tapImageViewRecognizer3
                   = UITapGestureRecognizer(target: self, action: #selector(imageTapped3(tapGestureRecognizer:)))
                  //이미지뷰가 상호작용할 수 있게 설정
        myView3.isUserInteractionEnabled = true
                  //이미지뷰에 제스처인식기 연결
        myView3.addGestureRecognizer(tapImageViewRecognizer3)
        
//        myStackView.addArrangedSubview(myImage1)
//        myStackView.addArrangedSubview(myImage2)
//        myStackView.addArrangedSubview(myImage3)
        
        
//        self.boothUpdate()
        
//        self.view.uiCheck()
        
        if IS_TEST {
            self.testFunc()
        }
        
//        self.view.uiCheck()
//        mainButtonBackView2.backgroundColor = UIColor.red
    }

    
    func testFunc(){
        let bottomHeight = appDel.window?.safeAreaInsets.bottom ?? 1000
        print("bottomHeight:\(bottomHeight)")
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
       {
//           print("do something.")
           if let url = URL(string: "https://www.pfizer.co.kr/") {    UIApplication.shared.open(url, options: [:])}
           
       }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
       {
//           print("do something.")
           if let url = URL(string: "https://www.aitrics.com/") {    UIApplication.shared.open(url, options: [:])}
           
       }
    
    @objc func imageTapped3(tapGestureRecognizer: UITapGestureRecognizer)
       {
//           print("do something.")
           if let url = URL(string: "https://www.vuno.co/") {    UIApplication.shared.open(url, options: [:])}
           
       }

}



extension MainViewController {
    func boothUpdate(){
        self.loadBoothArray { (imageDataArray : [[String : Any]]) in
            if imageDataArray.count == 0 { return }
            
            self.boothBannerView.boothUpdate(imageDataArray: imageDataArray)
        }
    }
    
    func loadBoothArray(complete:@escaping(_ imageDataArray : [[String:Any]])->Void){
        
        let urlString = "https://ezv.kr:4447/voting/php/booth/get_list.php?code=\(code)"
        
        Server.postData(urlString: urlString) { (kData:Data?) in
            if let data = kData {
                if let imageDataArray = data.toJson() as? [[String:Any]] {
                    print("mainTopImageUpdate \(imageDataArray.count) dataDic:\(imageDataArray)")
                    
                    let minCount = min(imageDataArray.count, 8)
                    var newArray = [[String:Any]]()
                    (0..<minCount).forEach{
                        newArray.append(imageDataArray[$0])
                    }
                    print("mainTopImageUpdate after \(newArray.count) dataDic:\(newArray)")
                    complete(newArray)
                    
                    
//                    if imageDataArray.count < 5 {
//                        complete(imageDataArray + imageDataArray)
//                    }else{
//                        complete(imageDataArray)
//                    }
                    return
                }
            }
        }
    }
}


class MainButton: UIButton {

    var innerView : UIView!
    var backImageView : UIImageView!
    var iconImageView : UIImageView!
    var nameLabel : UILabel!

    init(frame: CGRect, imageName : String, name : String) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12
        
//        let lineLayer = CAShapeLayer()
//        lineLayer.lineCap = CAShapeLayerLineCap.round
//        lineLayer.lineJoin = CAShapeLayerLineJoin.bevel
//        lineLayer.fillColor = UIColor.white.cgColor
//        lineLayer.lineWidth = 0
//        lineLayer.strokeColor = UIColor.clear.cgColor
//        
//        self.layer.addSublayer(lineLayer)

//        let smallRadius : CGFloat = self.width * 0.1
//        let largeRadius : CGFloat = self.width * 0.3
//
//        let leftTopCenterPoint = CGPoint(x: smallRadius, y: smallRadius)
//        let leftTopPoint1 = CGPoint(x: 0, y: smallRadius)
////        let leftTopPoint2 = CGPoint(x: smallRadius, y: 0)
//
//        let rightTopCenterPoint = CGPoint(x: self.width - smallRadius, y: smallRadius)
//        let rightTopPoint1 = CGPoint(x: self.width - smallRadius, y: 0)
////        let rightTopPoint2 = CGPoint(x: self.width, y: smallRadius)
//        
//        let rightBottomCenterPoint = CGPoint(x: self.width - largeRadius, y: self.height - largeRadius)
//        let rightBottomPoint1 = CGPoint(x: self.width, y: self.height - largeRadius)
////        let rightBottomPoint2 = CGPoint(x: self.width - largeRadius, y: self.height)
//
//        let leftBottomCenterPoint = CGPoint(x: smallRadius, y: self.height - smallRadius)
//        let leftBottomPoint1 = CGPoint(x: smallRadius, y: self.height)
////        let leftBottomPoint2 = CGPoint(x: 0, y: self.height - smallRadius)
//        
//        let startAngle0 = 2 * CGFloat.pi * (0 / 360)
//        let startAngle90 = 2 * CGFloat.pi * (90 / 360)
//        let startAngle180 = 2 * CGFloat.pi * (180 / 360)
//        let startAngle270 = 2 * CGFloat.pi * (270 / 360)
//        
//        let roundPath = UIBezierPath()
//        roundPath.move(to: leftTopPoint1)
//        roundPath.addArc(withCenter: leftTopCenterPoint, radius: smallRadius, startAngle: startAngle180, endAngle: startAngle270, clockwise: true)
//        
//        roundPath.addLine(to: rightTopPoint1)
//        roundPath.addArc(withCenter: rightTopCenterPoint, radius: smallRadius, startAngle: startAngle270, endAngle: startAngle0, clockwise: true)
//        
//        roundPath.addLine(to: rightBottomPoint1)
//        roundPath.addArc(withCenter: rightBottomCenterPoint, radius: largeRadius, startAngle: startAngle0, endAngle: startAngle90, clockwise: true)
//        
//        roundPath.addLine(to: leftBottomPoint1)
//        roundPath.addArc(withCenter: leftBottomCenterPoint, radius: smallRadius, startAngle: startAngle90, endAngle: startAngle180, clockwise: true)
//        
//        roundPath.addLine(to: leftTopPoint1)
//        roundPath.close()
//
//        lineLayer.path = roundPath.cgPath
        
        
        backImageView = UIImageView(frame: self.bounds)
        backImageView.isUserInteractionEnabled = false
        self.addSubview(backImageView)
        
        innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)

        let iconImageViewRatio : CGFloat = 0.4
        iconImageView  = UIImageView(frame: innerView.bounds)
        iconImageView.frame.size.width *= iconImageViewRatio
        iconImageView.frame.size.height *= iconImageViewRatio
        innerView.addSubview(iconImageView)

        if let iconImage = UIImage(named: imageName) {
            iconImageView.setImageWithFrameWidth(image: iconImage)
            
        }
        iconImageView.center.x = innerView.frame.center.x
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: iconImageView.frame.maxY, width: self.frame.size.width * 2, height: 50))
        nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.textAlignment = .center
        if IS_NORCH {
            nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.3)
            
            if IS_IPHONE_X {
                nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.25)
            }
        }else{
            nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.25)
        }
        nameLabel.numberOfLines = 2
        innerView.addSubview(nameLabel)

        if IS_NORCH {
            nameLabel.frame.origin.y = iconImageView.frame.maxY + 5
        }else{
            nameLabel.frame.origin.y = iconImageView.frame.maxY + 5
        }
        nameLabel.center.x = innerView.frame.size.width / 2
        nameLabel.text = name
        if !name.contains("\n") {
            nameLabel.text = "\(name)\n"
        }
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
