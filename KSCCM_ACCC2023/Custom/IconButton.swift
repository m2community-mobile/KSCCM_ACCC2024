import UIKit
import FontAwesome_swift

class IconButton : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, fontAwesome : FontAwesome, fontAwesomeStyle : FontAwesomeStyle = .solid) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.5, height: self.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: fontAwesome, style: FontAwesomeStyle.solid, textColor: UIColor.white, size: iconImageView.frame.size)
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 20)
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        innerView.center.x = self.frame.size.width / 2
    }
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height * 0.5))
        iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
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

class IconButton2 : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, fontAwesome : FontAwesome, fontAwesomeStyle : FontAwesomeStyle = .solid) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.5, height: self.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: fontAwesome, style: FontAwesomeStyle.solid, textColor: UIColor.white, size: iconImageView.frame.size)
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 20)
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        innerView.center.x = self.frame.size.width / 2
    }
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height * 0.5))
        iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
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


class IconButtonWithBottom : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, fontAwesome : FontAwesome, fontAwesomeStyle : FontAwesomeStyle = .solid) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        innerView.frame.size.height = 50
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: innerView.frame.size.height * 0.5, height: innerView.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: fontAwesome, style: fontAwesomeStyle, textColor: UIColor.white, size: iconImageView.frame.size)
        iconImageView.center.y = innerView.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: innerView.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 20)
        nameLabel.sizeToFit()
        nameLabel.center.y = innerView.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ImageButton: UIButton {
    
    var buttonImageView : UIImageView!
    var ratio : CGFloat = 0
    
    init(frame : CGRect, image : UIImage?, ratio kRatio: CGFloat) {
        super.init(frame: frame)
        
        self.ratio = kRatio
        
        buttonImageView = UIImageView(frame: self.bounds)
        buttonImageView.isUserInteractionEnabled = false
        buttonImageView.frame.size.width *= ratio
        buttonImageView.frame.size.height *= ratio

        if let image = image {
            if image.size.width > image.size.height {
                buttonImageView.setImageWithFrameHeight(image: image)
            }else{
                buttonImageView.setImageWithFrameWidth(image: image)
            }
        }
        buttonImageView.center = self.frame.center

        self.addSubview(buttonImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
