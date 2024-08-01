import UIKit
import DropDown
class VotingViewController: UIViewController {
    
//    var bottomButtons = [UIButton]()
//
//    var mainViews = [UIView]()
//
//    var startIndex = 1
    
    
    
    var dropDown = DropDown()
    let itemList = ["Room 2 (Grand Ballroom 2)","Room 3 (Grand Ballroom 3)","Room 4 (Maple)"]
    
    var dropView: UIView!
    var btnSelectL: UIButton!
    var tfInput: UITextField!
    
    
    
    
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
        grayBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(grayBackView)
        
        
        dropView = UIView(frame: CGRect(x: 0, y: 0, width: grayBackView.width, height: 60))
//        dropView.backgroundColor = .yellow
//        dropView.layer.borderWidth = 1
        grayBackView.addSubview(dropView)
        
        btnSelectL = UIButton(frame: CGRect(x: 0, y: 0, width: dropView.width, height: 60))
        
        
        
        
        
        btnSelectL.setTitleColor(.black, for: .normal)
        btnSelectL.backgroundColor = .white
        btnSelectL.layer.borderWidth = 0.3
        btnSelectL.layer.cornerRadius = 8
        btnSelectL.addTarget(self, action: #selector(dropdownClicked(_ :)), for: .touchUpInside)
        dropView.addSubview(btnSelectL)
        
        var normalTitle = UILabel(frame: CGRect(x: 0, y: 0, width: btnSelectL.width, height: 60))
        normalTitle.text = "Please select voting room"
        normalTitle.textAlignment = .center
        btnSelectL.addSubview(normalTitle)
        
        
        
        DropDown.appearance().textColor = UIColor.lightGray
        DropDown.appearance().selectedTextColor = UIColor.black
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().backgroundColor = .white
        dropDown.dismissMode = .automatic
        
        dropDown.dataSource = itemList
        dropDown.anchorView = self.dropView
        
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        dropDown.selectionAction = { [weak self] (index, item) in
            normalTitle.text = ""
            self!.btnSelectL.titleLabel?.text = item
            self?.btnSelectL.setTitleColor(.black, for: .normal)
            self?.btnSelectL.setTitle(item, for: .normal)
        }
        
        dropDown.cancelAction = { [weak self] in
            }
    
        
        
        let subTitleLabel = UILabel(frame: CGRect(x: 0, y: dropView.frame.maxY + 10, width: grayBackView.width, height: 60))
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
            
            let votingButtonBackView = UIView(frame: CGRect(x: 0, y: CGFloat(i) * 85, width: votingButtonsBackView.width * 0.95, height: votingButtonBackViewHeight / 2))
//            let votingButtonBackView = UIView(frame: CGRect(x: 0, y: CGFloat(i) * votingButtonBackViewHeight, width: votingButtonsBackView.width * 0.95, height: votingButtonBackViewHeight / 2))
            votingButtonBackView.center.x = votingButtonsBackView.width / 2
            
//            votingButtonBackView.backgroundColor = UIColor.red.withAlphaComponent(0.1 + (CGFloat(i) * 0.1))
            votingButtonsBackView.addSubview(votingButtonBackView)
            
            let votingButton = UIButton(frame: CGRect(x: 0, y: 0, width: votingButtonBackView.width, height: votingButtonHeight / 1.3))
            votingButton.setTitle("\(i + 1)", for: .normal)
            votingButton.titleLabel?.font = UIFont(name: ROBOTO_REGULAR, size: votingButton.height * 0.3)
            votingButton.center = votingButtonBackView.frame.center
            votingButtonBackView.addSubview(votingButton)
            votingButton.setGradientBackgroundColor(colors: [#colorLiteral(red: 0.04061183333, green: 0.2401330173, blue: 0.2864151895, alpha: 1), #colorLiteral(red: 0.03921014816, green: 0.2356738448, blue: 0.282052815, alpha: 1)]) { gradientLayer in
                gradientLayer.startPoint = CGPoint.zero
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            }
            votingButton.layer.cornerRadius = votingButton.height * 0.2
            votingButton.clipsToBounds = true
            
            
            votingButton.addTarget(event: .touchUpInside) { [weak self] (button)  in
                
                
//                ["Room 2 (Grand Ballroom 2)","Room 3 (Grand Ballroom 3)","Room 4 (Maple)"]

                
                if self!.btnSelectL.titleLabel?.text == "Room 2 (Grand Ballroom 2)" {
                    
                    self?.submission(number: i+1)
                } else if self!.btnSelectL.titleLabel?.text == "Room 3 (Grand Ballroom 3)" {
                    self?.submission2(number: i+1)
                } else if self!.btnSelectL.titleLabel?.text == "Room 4 (Maple)"{
                    self?.submission3(number: i+1)
                    
                } else {
                    appDel.showAlert(title: "Notice", message: "Please select voting room.")
                    
                }
            }
            
            
        }
        
        
    }
    func submission(number:Int){
        
        let urlstring = "https://ezv.kr:4447/voting/php/voting/app/post.php?code=\(code)&val=\(number)&deviceid=\(deviceID)&room=2387"
        print("urlstring: \(urlstring)")
        
        appDel.showHud()
        Server.postData(urlString: urlstring) { (kData : Data?) in
            appDel.hideHud()
            if let data = kData,
               let dataString = data.toString() {
                
                
                
                
            print("dataString:\(dataString)")
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
    
    func submission2(number:Int){
        
        let urlstring = "https://ezv.kr:4447/voting/php/voting/app/post.php?code=\(code)&val=\(number)&deviceid=\(deviceID)&room=2388"
        print("urlstring: \(urlstring)")
        
        appDel.showHud()
        Server.postData(urlString: urlstring) { (kData : Data?) in
            appDel.hideHud()
            if let data = kData,
               let dataString = data.toString() {
                
            print("dataString:\(dataString)")
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
    func submission3(number:Int){
        
        let urlstring = "https://ezv.kr:4447/voting/php/voting/app/post.php?code=\(code)&val=\(number)&deviceid=\(deviceID)&room=2398"
        print("urlstring: \(urlstring)")
        
        appDel.showHud()
        Server.postData(urlString: urlstring) { (kData : Data?) in
            appDel.hideHud()
            if let data = kData,
               let dataString = data.toString() {
                
            print("dataString:\(dataString)")
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
    
    
    
    
    
    // View 클릭 시 Action
     @objc func dropdownClicked(_ sender: Any) {
         dropDown.show() // 아이템 팝업을 보여준다.
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        
    }
  

    
}





