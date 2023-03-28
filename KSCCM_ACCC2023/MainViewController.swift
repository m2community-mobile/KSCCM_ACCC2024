import UIKit

class MainViewController: UIViewController {

    let bottomView = BottomView()
//    var noticeView : LatestNoticeView!
    
    var mainButtonBackView : UIView!
    var mainButtonBackView2 : UIView!
    var mainButtonBackView3 : UIView!
    
    var boothBannerView : Main_BoothBannerView!
    
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

        self.view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        
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
        let boothEventButton = MainBoothEventButton(frame: CGRect(x: SCREEN.WIDTH - boothEventButtonWidth, y: STATUS_BAR_HEIGHT, width: boothEventButtonWidth, height: boothEventButtonWidth))
        let boothEventButtonGradientColors = [
//            #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9960784314, alpha: 1) ,
            #colorLiteral(red: 0.7843137255, green: 0.2980392157, blue: 0.5725490196, alpha: 1) ,
            #colorLiteral(red: 0.6352941176, green: 0.4078431373, blue: 0.7803921569, alpha: 1) ,
        ]
        //rgb 249 250 254
        //rgb 200 76 146
        //rgb 162 104 199
        boothEventButton.setGradientBackgroundColor(colors: boothEventButtonGradientColors) { gradientLayer in
            gradientLayer.startPoint = CGPoint.zero
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        self.view.addSubview(boothEventButton)
        boothEventButton.animatioinStart()
        boothEventButton.addTarget(event: .touchUpInside) { button in
            goBoothEvent()
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
        mainTitle1ImageView.frame.size.width *= 0.5
        mainTitle1ImageView.setImageWithFrameHeight(image: mainTitle1Image)
        if IS_NORCH {
            mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height - 10
        }else{
            mainTitle1ImageView.frame.origin.y = mainTitleImageBackViewTop.height - mainTitle1ImageView.height - 5
        }
        mainTitle1ImageView.center.x = SCREEN.WIDTH / 2
        mainTitleImageBackViewTop.addSubview(mainTitle1ImageView)
        
        let mainTitle2ImageView = UIImageView(frame: mainTitleImageBackViewBottom.bounds)
        if IS_NORCH {
            mainTitle2ImageView.frame.size.width *= 0.87
        }else{
            mainTitle2ImageView.frame.size.width *= 0.83
        }
        mainTitle2ImageView.setImageWithFrameHeight(image: mainTitle2Image)
        if IS_NORCH {
            mainTitle2ImageView.frame.origin.y = 10
        }else{
            mainTitle2ImageView.frame.origin.y = 5
        }
        mainTitle2ImageView.center.x = SCREEN.WIDTH / 2
        mainTitleImageBackViewBottom.addSubview(mainTitle2ImageView)
        
        self.boothUpdate()
        
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

        self.backgroundColor = UIColor.clear
        
        let lineLayer = CAShapeLayer()
        lineLayer.lineCap = CAShapeLayerLineCap.round
        lineLayer.lineJoin = CAShapeLayerLineJoin.bevel
        lineLayer.fillColor = UIColor.white.cgColor
        lineLayer.lineWidth = 0
        lineLayer.strokeColor = UIColor.clear.cgColor
        self.layer.addSublayer(lineLayer)

        let smallRadius : CGFloat = self.width * 0.1
        let largeRadius : CGFloat = self.width * 0.3

        let leftTopCenterPoint = CGPoint(x: smallRadius, y: smallRadius)
        let leftTopPoint1 = CGPoint(x: 0, y: smallRadius)
//        let leftTopPoint2 = CGPoint(x: smallRadius, y: 0)

        let rightTopCenterPoint = CGPoint(x: self.width - smallRadius, y: smallRadius)
        let rightTopPoint1 = CGPoint(x: self.width - smallRadius, y: 0)
//        let rightTopPoint2 = CGPoint(x: self.width, y: smallRadius)
        
        let rightBottomCenterPoint = CGPoint(x: self.width - largeRadius, y: self.height - largeRadius)
        let rightBottomPoint1 = CGPoint(x: self.width, y: self.height - largeRadius)
//        let rightBottomPoint2 = CGPoint(x: self.width - largeRadius, y: self.height)
        
        let leftBottomCenterPoint = CGPoint(x: smallRadius, y: self.height - smallRadius)
        let leftBottomPoint1 = CGPoint(x: smallRadius, y: self.height)
//        let leftBottomPoint2 = CGPoint(x: 0, y: self.height - smallRadius)
        
        let startAngle0 = 2 * CGFloat.pi * (0 / 360)
        let startAngle90 = 2 * CGFloat.pi * (90 / 360)
        let startAngle180 = 2 * CGFloat.pi * (180 / 360)
        let startAngle270 = 2 * CGFloat.pi * (270 / 360)
        
        let roundPath = UIBezierPath()
        roundPath.move(to: leftTopPoint1)
        roundPath.addArc(withCenter: leftTopCenterPoint, radius: smallRadius, startAngle: startAngle180, endAngle: startAngle270, clockwise: true)
        
        roundPath.addLine(to: rightTopPoint1)
        roundPath.addArc(withCenter: rightTopCenterPoint, radius: smallRadius, startAngle: startAngle270, endAngle: startAngle0, clockwise: true)
        
        roundPath.addLine(to: rightBottomPoint1)
        roundPath.addArc(withCenter: rightBottomCenterPoint, radius: largeRadius, startAngle: startAngle0, endAngle: startAngle90, clockwise: true)
        
        roundPath.addLine(to: leftBottomPoint1)
        roundPath.addArc(withCenter: leftBottomCenterPoint, radius: smallRadius, startAngle: startAngle90, endAngle: startAngle180, clockwise: true)
        
        roundPath.addLine(to: leftTopPoint1)
        roundPath.close()

        lineLayer.path = roundPath.cgPath
        
        
        backImageView = UIImageView(frame: self.bounds)
        backImageView.isUserInteractionEnabled = false
        self.addSubview(backImageView)
        
        innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)

        let iconImageViewRatio : CGFloat = 0.3
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
        }else{
            nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.25)
        }
        nameLabel.numberOfLines = 2
        innerView.addSubview(nameLabel)

        if IS_NORCH {
            nameLabel.frame.origin.y = iconImageView.frame.maxY + 10
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
