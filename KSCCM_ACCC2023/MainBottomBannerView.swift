//
//  LeftViewBoothBanner.swift
//  koa2019s
//
//  Created by JinGu's iMac on 2020/08/11.
//  Copyright © 2020 m2community. All rights reserved.
//

import UIKit

class Main_BoothBannerView : BoothBannerView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 0
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BoothBannerView : UIView {
    
    static var boothViewHeight : CGFloat {
        get{
            if IS_IPHONE_SE {
                return 45
            }
            return 55
//            if IS_IPHONE_SE {
//                return 65
//            }
//            return 85
        }
    }
    
    var scrollView : UIScrollView!
    var advertiseViews = [AdvertiseView]()
    var boothTimer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
//        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(white: 210/255, alpha: 1).cgColor
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: self.frame.size.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        self.addSubview(scrollView)
        
//        self.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func boothUpdate(imageDataArray : [[String : Any]]){
        
        if imageDataArray.count == 0 { return }
        
        //첫번째 이미지를 불러와 이미지 비율을 본다
        self.loadFirstImageRatio(imageDataArray: imageDataArray) { (ratio : CGFloat) in
            //이미지 비율을 이용해 광고뷰 붙이기
            self.setBoothView(imageDataArray: imageDataArray, imageRatio: ratio)
            
            print("animation Start and loadImages")
            
            //시간값이 낮아지면 속도는 빨라진다 (반비례)
//            self.boothTimer?.invalidate()
//            self.boothTimer = Timer(timeInterval: 0.001, target: self, selector: #selector(self.animationUpdate), userInfo: nil, repeats: true)
//            RunLoop.main.add(self.boothTimer!, forMode: RunLoop.Mode.common)
            
            //각 광고뷰에 이미지 로딩하여 붙이기
            self.loadBoothImages(imageDataArray: imageDataArray) {
                print("All Booth Image Load ========")
                print("self.advertiseViews.count:\(self.advertiseViews.count)")
                let minCount = min(self.advertiseViews.count, 3)
                if minCount >= 1 {
                    self.advertiseViews[0].center.x = (SCREEN.WIDTH / 6) * 1
                }
                if minCount >= 2 {
                    self.advertiseViews[1].center.x = (SCREEN.WIDTH / 6) * 3
                }
                if minCount >= 3 {
                    self.advertiseViews[2].center.x = (SCREEN.WIDTH / 6) * 5
                }
            }
        }
        
    }
    
    
    
    func loadImage(index : Int, imageUrlString : String, complete:@escaping(_ success : Bool) -> Void) {
        Server.postData(urlString: imageUrlString,method: .get) { (kData : Data?) in
            if let data = kData {
                if let image = UIImage.sd_animatedGIF(with: data) {
                    if index < self.advertiseViews.count {
                        let advertiseView = self.advertiseViews[index]
                        DispatchQueue.main.async {
                            advertiseView.settingImage(image: image)
                        }
                        complete(true)
                        return
                    }
                }
            }
            print("load fail index :\(index) urlString : \(imageUrlString)")
            complete(false)
        }
    }
    
    func loadBoothImages(imageDataArray : [[String:Any]], complete:@escaping() -> Void){
        
        var count = imageDataArray.count
        
        for i in 0..<imageDataArray.count {
            let imageDic = imageDataArray[i]
            
            if let imageFileURL = imageDic["image"] as? String {
                //                let urlString = "\(imageFileURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
                let urlString = "\(imageFileURL)"
                print("ad imageURL:\(urlString)")
                
                OperationQueue.main.addOperation {
                    self.loadImage(index: i, imageUrlString: urlString) { (success : Bool) in
                        count -= 1
                        if count == 0 {
                            complete()
                        }
                    }
                }
            }
        }
    }
    
    func setBoothView(imageDataArray : [[String:Any]], imageRatio : CGFloat){
        DispatchQueue.main.async {
            var maxX : CGFloat = 0
            for i in 0..<imageDataArray.count {
                let advertiseViewHeight = BoothBannerView.boothViewHeight * 0.8
                let advertiseView = AdvertiseView(frame: CGRect(x: maxX, y: 0, width: 0, height: advertiseViewHeight))
                advertiseView.frame.size.width = advertiseView.frame.size.height * imageRatio
//                if IS_IPHONE_SE {
//                    advertiseView.frame.size.height = 60
//                }
                advertiseView.center.y = self.scrollView.frame.size.height / 2
                self.scrollView.addSubview(advertiseView)
                self.advertiseViews.append(advertiseView)
                if let linkurl = imageDataArray[i]["linkurl"] as? String,
                   let url = URL(string: linkurl)
                {
                    advertiseView.addTarget(event: .touchUpInside) { _ in
                        UIApplication.shared.open(url)
                    }
                }
                
                if maxX == 0 {
                    advertiseView.frame.origin.x = SCREEN.WIDTH
                }
                maxX = advertiseView.frame.maxX + 10
                
            }
        }
    }
    
    func loadFirstImageRatio(imageDataArray : [[String:Any]], complete:@escaping(_ ratio : CGFloat)->Void) {
        
        if let firstImageDic = imageDataArray.first {
            if let imageFileURL = firstImageDic["image"] as? String {
//                let urlString = "\(imageFileURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
                let urlString = imageFileURL
                print("first ad imageURL:\(urlString)")
                
                Server.postData(urlString: urlString, method: .get) { (kData : Data?) in
                    if let data = kData {
                        if let image = UIImage.sd_animatedGIF(with: data) {
                            let ratio = image.size.width / image.size.height
                            complete(ratio)
                            return
                        }
                    }
                    complete(0)
                }
            }
        }
        
        
    }
   
    @objc func animationUpdate(){
        
            for advertiseView in self.advertiseViews {
                //좌표변화가 크면 속도가 빨라진다 (비례)
                
//                var nextX = advertiseView.frame.origin.x - 0.1
                var nextX = advertiseView.frame.origin.x - 0.08
                
//                advertiseView.frame.origin.x -= 0.1
                
                if advertiseView.frame.maxX <= 0 {
                    var lastView = self.advertiseViews[0]
                    for advertiseView2 in self.advertiseViews {
                        if lastView.frame.origin.x < advertiseView2.frame.origin.x {
                            lastView = advertiseView2
                        }
                    }
                    nextX = lastView.frame.maxX + 10
                }
                DispatchQueue.main.async {
                advertiseView.frame.origin.x = nextX
            }
        }
    }
    
    
}



class AdvertiseView: UIButton {
    
    var adImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adImageView = UIImageView(frame: self.bounds)
        adImageView.isUserInteractionEnabled = false
        self.addSubview(adImageView)
        
//        self.layer.borderColor = UIColor(white: 210/255, alpha: 1).cgColor
//        self.layer.borderWidth = 0.5
    }
    
    func settingImage(image : UIImage){
        adImageView.setImageWithFrameWidth(image: image)
        self.frame.size = adImageView.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
