import UIKit
import FontAwesome_swift

let mainColor = #colorLiteral(red: 0.009689426981, green: 0.2586796284, blue: 0.3077326417, alpha: 1)

class BaseViewController: UIViewController {

    var naviBar : UIView!
    
    var subTitleString = ""
    
    var subTitleView : UIView!
    var subTitleLabel : UILabel!
    
    var backButton : UIButton!
    
    var backButtonimageView : UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let isOpen = appDel.leftView?.isOpen, isOpen {
            return .lightContent
        }else{
            return .lightContent
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        statusBar.backgroundColor = mainColor
        self.view.addSubview(statusBar)
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
        naviBar.backgroundColor = mainColor
        self.view.addSubview(naviBar)
        
        let menuButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), ratio: 0.45)
        menuButton.buttonImageView.tintColor = UIColor.white
        menuButton.addTarget(event: .touchUpInside) { (button) in
            appDel.leftView?.open(currentVC: self)
        }
        
        naviBar.addSubview(menuButton)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - (menuButton.frame.size.width * 2), height: naviBar.frame.size.height))
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.text = "KSCCM-ACCC 2024"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: Pretendard_Bold, size: 17.5)
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: Pretendard_Bold, size: 15)
        }
        titleLabel.textAlignment = .center
        naviBar.addSubview(titleLabel)
        
        let homeButton = UIButton(frame: titleLabel.frame)
        homeButton.addTarget(event: .touchUpInside) { (button) in
            appDel.naviCon?.popToRootViewController(animated: true)
        }
        naviBar.addSubview(homeButton)
        
        
        subTitleView = UIView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: 40))
        subTitleView.backgroundColor = #colorLiteral(red: 0.1015554443, green: 0.5125484467, blue: 0.5941668153, alpha: 1)
        self.view.addSubview(subTitleView)
        
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: subTitleView.frame.size.height, height: subTitleView.frame.size.height))
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        subTitleView.addSubview(backButton)
        
        backButtonimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: subTitleView.frame.size.height * 0.5, height: subTitleView.frame.size.height * 0.5))
        backButtonimageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.arrowLeft, style: .solid, textColor: UIColor.white, size: backButtonimageView.frame.size).withRenderingMode(.alwaysTemplate)
        
        backButtonimageView.center.x = backButton.frame.size.width / 2
        backButtonimageView.tintColor = UIColor.white
        backButtonimageView.isUserInteractionEnabled = false
        backButtonimageView.center = CGPoint(x: backButton.frame.size.width / 2, y: backButton.frame.size.height / 2)
        backButton.addSubview(backButtonimageView)
        
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - (backButton.frame.size.width * 2), height: subTitleView.frame.size.height))
        subTitleLabel.center.x = SCREEN.WIDTH / 2
        subTitleLabel.text = subTitleString
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)
        subTitleLabel.textAlignment = .center
        subTitleView.addSubview(subTitleLabel)
        
        let underBar = UIView(frame: CGRect(x: 0, y: subTitleView.frame.maxY, width: SCREEN.WIDTH, height: 0.5))
        underBar.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1).withAlphaComponent(0.5)
        self.view.addSubview(underBar)
        
        let underBar2 = UIView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: 0.5))
        underBar2.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1).withAlphaComponent(0.5)
        self.view.addSubview(underBar2)
        
    }
    
    @objc func backButtonPressed(){
        appDel.naviCon?.popViewController(animated: true)
    }
    
}
