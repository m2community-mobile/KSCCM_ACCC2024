import UIKit

class VotingViewController: UIViewController {
    
//    var bottomButtons = [UIButton]()
//
//    var mainViews = [UIView]()
//
//    var startIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    
        let titleLabel = UILabel(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT * 1.5))
        titleLabel.textColor = UIColor.black
        titleLabel.text = "Voting"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: ROBOTO_BOLD, size: 35)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        let closeButton = ImageButton(frame: CGRect(x: SCREEN.WIDTH - titleLabel.height, y: STATUS_BAR_HEIGHT, width: titleLabel.height, height: titleLabel.height), image: UIImage(named: "icoClose"), ratio: 0.35)
        self.view.addSubview(closeButton)
        closeButton.addTarget(event: .touchUpInside) { button in
            self.dismiss(animated: true)
        }
        
        let grayBackView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 15, width: SCREEN.WIDTH * 0.9, height: 0))
        grayBackView.frame.size.height = SCREEN.HEIGHT - SAFE_AREA - grayBackView.frame.minY
        grayBackView.center.x = SCREEN.WIDTH / 2
        grayBackView.backgroundColor = #colorLiteral(red: 0.9404773116, green: 0.940477252, blue: 0.9404773116, alpha: 1)
        self.view.addSubview(grayBackView)
        
        let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: grayBackView.width, height: 60))
        subTitleLabel.text = "Select the Answer"
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont(name: ROBOTO_LIGHT, size: 25)
        subTitleLabel.textColor = UIColor.black
        grayBackView.addSubview(subTitleLabel)
        
        let votingButtonsBackView = UIView(frame: CGRect(x: 0, y: subTitleLabel.maxY, width: grayBackView.width, height: grayBackView.height - subTitleLabel.maxY))
//        votingButtonsBackView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        votingButtonsBackView.center.x = grayBackView.width / 2
        grayBackView.addSubview(votingButtonsBackView)
        
        let votingButtonBackViewHeight : CGFloat = votingButtonsBackView.height / 5
        let votingButtonHeight : CGFloat = votingButtonBackViewHeight * 0.75
        
        for i in 0..<5 {
            let votingButtonBackView = UIView(frame: CGRect(x: 0, y: CGFloat(i) * votingButtonBackViewHeight, width: votingButtonsBackView.width * 0.95, height: votingButtonBackViewHeight))
            votingButtonBackView.center.x = votingButtonsBackView.width / 2
//            votingButtonBackView.backgroundColor = UIColor.red.withAlphaComponent(0.1 + (CGFloat(i) * 0.1))
            votingButtonsBackView.addSubview(votingButtonBackView)
            
            let votingButton = UIButton(frame: CGRect(x: 0, y: 0, width: votingButtonBackView.width, height: votingButtonHeight))
            votingButton.setTitle("\(i + 1)", for: .normal)
            votingButton.titleLabel?.font = UIFont(name: ROBOTO_REGULAR, size: votingButton.height * 0.3)
            votingButton.center = votingButtonBackView.frame.center
            votingButtonBackView.addSubview(votingButton)
            votingButton.setGradientBackgroundColor(colors: [#colorLiteral(red: 0.1870094836, green: 0.2588235294, blue: 0.4431372549, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]) { gradientLayer in
                gradientLayer.startPoint = CGPoint.zero
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            }
            votingButton.layer.cornerRadius = votingButton.height * 0.2
            votingButton.clipsToBounds = true
            
            votingButton.addTarget(event: .touchUpInside) { [weak self] (button)  in
                self?.submission(number: i+1)
            }
        }
    }
    func submission(number:Int){
        
        let urlstring = "https://ezv.kr:4447/voting/php/voting/app/post.php?code=\(code)&val=\(number)&deviceid=\(deviceID)"
        
        appDel.showHud()
        Server.postData(urlString: urlstring) { (kData : Data?) in
            appDel.hideHud()
            if let data = kData,
               let dataString = data.toString() {
                if dataString == "1" {
                    appDel.showAlert(title: "Notice", message: "Your vote has been submitted.")
                }else if dataString == "2" {
                    appDel.showAlert(title: "Notice", message: "Votes have been corrected.")
                }else{
                    appDel.showAlert(title: "Notice", message: "There is currently no vote in progress.")
                }
            }
        }
        
        
        
        
        
    }
    
}





