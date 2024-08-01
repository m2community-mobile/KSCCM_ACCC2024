import UIKit
import FontAwesome_swift

class MainBoothEventButton : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = #colorLiteral(red: 0.7027865052, green: 0.7947098017, blue: 0.1979543865, alpha: 1)
        
        let name = "Booth Stamp\nEvent"
        let imageName = "mainBoothEventButtonImage"
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width * 0.35, height: 0))
        iconImageView.setImageWithFrameHeight(image: UIImage(named: imageName))
        iconImageView.center.x = self.frame.size.width / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: iconImageView.frame.maxY + 5, width: self.frame.size.width, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: OpenSans_Regular, size: self.frame.size.height * 0.13)
        nameLabel.sizeToFit()
        nameLabel.center.x = self.frame.size.width / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.height = nameLabel.frame.maxY
        innerView.center.y = self.frame.size.height / 2
        
        self.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.topLeft,.bottomLeft])
    }
    
    func animatioinStart(){
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            DispatchQueue.main.async {
                self.iconImageView.isHidden.toggle()
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

