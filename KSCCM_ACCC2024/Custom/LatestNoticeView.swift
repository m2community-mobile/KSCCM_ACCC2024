import UIKit

class LatestNoticeView: UIView {
    
    var iconImageView : UIImageView!
    var valueLabel : UILabel!
    var button : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let backView = UIView(frame: self.bounds)
        backView.backgroundColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.5333333333, alpha: 1)
        self.addSubview(backView)
        
        let iconImageBackView = UIView(frame: CGRect(x: 10, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        self.addSubview(iconImageBackView)
        
        iconImageView = UIImageView(frame: iconImageBackView.bounds)
        iconImageView.frame.size.width *= 0.5
        iconImageView.frame.size.height *= 0.5
        if let iconImage = UIImage(named: "icoNew") {
            iconImageView.setImageWithFrameWidth(image: iconImage)
        }
        iconImageView.center = iconImageBackView.frame.center
        iconImageBackView.addSubview(iconImageView)
        
        valueLabel = UILabel(frame: CGRect(x: iconImageBackView.frame.maxX, y: 0, width: self.frame.size.width - iconImageBackView.frame.maxX, height: self.frame.size.height))
        valueLabel.font = UIFont(name: ROBOTO_MEDIUM, size: valueLabel.frame.size.height * 0.33)
        valueLabel.textColor = UIColor.white
        valueLabel.text = ""
        self.addSubview(valueLabel)
        
        button = UIButton(frame: self.bounds)
        self.addSubview(button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func noticeUpdate(){
        print("noticeUpdate")
        let _ = Server.postData(urlString: "https://ezv.kr:4447/voting/php/bbs/get_list.php?code=\(code)") { (kData : Data?) in
            if let data = kData {
                if let dataArray = data.toJson() as? [[String:Any]] {
                    if let latestNotice = dataArray.first {
//                        print("latestNotice:\(latestNotice.showValue())")
                        if let sid = latestNotice["sid"] {
                            print("noticeUpdate success")
                            let subject = latestNotice["subject"] as? String ?? ""
                            self.valueLabel.text = subject
                            self.urlString = "\(URL_KEY.noticeView)&sid=\(sid)"
                            return
                        }
                    }
                }
            }else{
                print("noticeUpdate fail")
                self.valueLabel.text = ""
                self.urlString = nil
            }
        }
    }
    
    var urlString : String?
    @objc func buttonPressed(){
        if let urlString = urlString {
            print("buttonPressed:\(urlString)")
            goURL(urlString: urlString)
        }
    }
}
