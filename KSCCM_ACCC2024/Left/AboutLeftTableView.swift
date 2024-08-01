import UIKit
import FontAwesome_swift

@objc protocol LeftTableViewHeaderDelegate {
    @objc optional func leftTableViewHeader(_ leftTableViewHeader: LeftTableViewHeader, didSelectHeader index: Int)
}

class LeftTableViewHeader: UITableViewHeaderFooterView {
    
    static var height : CGFloat {
        get {
            if IS_IPHONE_SE {
                return 50
            }else{
                return 60
            }
        }
    }
    
    var delegate : LeftTableViewHeaderDelegate?
    
    var titleLabel : UILabel!
    var titleImageView : UIImageView!
    
    var arrowImageView : UIImageView!
    var underBar : UIView!
    
    var index = 0
    
//    var isHighlighted : Bool = false {
//        willSet(newIsHighlighted) {
//            self.contentView.backgroundColor = newIsHighlighted ? #colorLiteral(red: 0.168627451, green: 0.3882352941, blue: 0.7215686275, alpha: 1) : UIColor.white
//        }
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let myHeight = LeftTableViewHeader.height
        
        self.frame.size = CGSize(width: leftViewContentViewWidth, height: myHeight)
        
        let arrowImageBackView = UIView(frame: CGRect(x: leftViewContentViewWidth - myHeight, y: 0, width: myHeight, height: myHeight))
        //        plusImageBackView.backgroundColor = UIColor.red
        self.addSubview(arrowImageBackView)
        
        arrowImageView = UIImageView(frame: arrowImageBackView.bounds)
        arrowImageView.frame.size.width *= 0.5
        arrowImageView.frame.size.height *= 0.5
        arrowImageView.center = arrowImageBackView.frame.center
        arrowImageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.angleDown, style: FontAwesomeStyle.solid, textColor:  #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), size: arrowImageView.frame.size)
        arrowImageBackView.addSubview(arrowImageView)
        
//        titleImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: LeftTableViewHeader.height * 0.65, height: LeftTableViewHeader.height * 0.65))
        titleImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: LeftTableViewHeader.height * 0.35, height: LeftTableViewHeader.height * 0.35))
        titleImageView.center.y = LeftTableViewHeader.height * 0.5
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.isUserInteractionEnabled = false
        self.addSubview(titleImageView)
        
        titleLabel = UILabel(frame: CGRect(
            x: titleImageView.frame.maxX + 10,
            y: 0,
            width: arrowImageBackView.frame.minX - 10 - (titleImageView.frame.maxX + 15),
            //            width: 100,
            height: self.frame.size.height))
        titleLabel.font = UIFont(name: OpenSans_SemiBold, size: titleLabel.frame.size.height * 0.25)
        titleLabel.isUserInteractionEnabled = false
        titleLabel.textColor =  #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        
        underBar = UIView(frame: CGRect(x: 15, y: LeftTableViewHeader.height - 0.5, width: self.frame.size.width - 30, height: 0.5))
        underBar.backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.4705882353, blue: 0.6705882353, alpha: 1)
        self.addSubview(underBar)
        
        let button = UIButton(frame: self.bounds)
        button.addTarget(event: .touchUpInside) { [weak self] (button) in
            if let self = self {
                self.delegate?.leftTableViewHeader?(self, didSelectHeader: self.index)
            }
        }
        self.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class LeftTableViewCell: UITableViewCell {
    
    static let height : CGFloat = 40
//    static var height : CGFloat {
//        get {
//            if IS_IPHONE_SE {
//                return 40
//            }else{
//                return 45
//            }
//        }
//    }
    var titleLabel : UILabel!
    
//    override var isSelected: Bool {
//        willSet(newIsSelected) {
//            if newIsSelected {
//                titleLabel.textColor = #colorLiteral(red: 0.1529411765, green: 0.6549019608, blue: 0.9176470588, alpha: 1)
//            }else{
//                titleLabel.textColor = #colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.3882352941, alpha: 1)
//            }
//
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
        
        let myHeight = LeftTableViewCell.height
        self.frame.size = CGSize(width: leftViewContentViewWidth, height: myHeight)
        
        titleLabel = UILabel(frame: CGRect(x: 40, y: 0, width: leftViewContentViewWidth - 32, height: myHeight))
        titleLabel.font = UIFont(name: OpenSans_Regular, size: myHeight * 0.4)
        titleLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
