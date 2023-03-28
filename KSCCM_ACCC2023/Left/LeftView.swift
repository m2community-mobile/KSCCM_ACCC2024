import UIKit
import FontAwesome_swift
import UserNotifications

var leftViewContentViewWidth : CGFloat
{
    get{
        if IS_IPHONE_N || IS_IPHONE_X{
            return SCREEN.WIDTH * 0.83
        }else if IS_IPHONE_SE {
            return SCREEN.WIDTH * 0.8
        }else{
            return SCREEN.WIDTH * 0.8
        }
    }
}
    
class LeftView: UIView {
    
    var grayView : UIView!
    var contentView : UIView!
    
    var tableView : UITableView!
    var selectedIndex = -1
    
    var settingButton : MainSettingButton!
    var votingButton : MainVotingButton!
    
    var naviBarHomeButton : UIButton!
    
    convenience init() {
        self.init(frame: SCREEN.BOUND)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        grayView = UIView(frame: SCREEN.BOUND)
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        grayView.isUserInteractionEnabled = false
        self.addSubview(grayView)
        
        //이동 대상
        contentView = UIView(frame: SCREEN.BOUND)
        contentView.backgroundColor = UIColor.clear
        contentView.isUserInteractionEnabled = true
        self.addSubview(contentView)
        
        let grayCloseButton = UIButton(frame: self.bounds)
        grayCloseButton.addTarget(event: UIControl.Event.touchUpInside) { [weak self] (button) in
            self?.close()
        }
        contentView.addSubview(grayCloseButton)
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: leftViewContentViewWidth, height: STATUS_BAR_HEIGHT))
        statusBar.backgroundColor = UIColor.clear
        contentView.addSubview(statusBar)
        
        let naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: leftViewContentViewWidth, height: 50))
        if IS_IPHONE_SE { naviBar.frame.size.height = NAVIGATION_BAR_HEIGHT }
        naviBar.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1490196078, blue: 0.3333333333, alpha: 1)
        contentView.addSubview(naviBar)
        
         /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let closeButtonImageBackView = UIView(frame: CGRect(x: leftViewContentViewWidth, y: STATUS_BAR_HEIGHT, width: SCREEN.WIDTH - leftViewContentViewWidth, height: naviBar.frame.size.height))
        closeButtonImageBackView.isUserInteractionEnabled = false
        contentView.addSubview(closeButtonImageBackView)
        
        let closeButtonImageView = UIImageView(frame: closeButtonImageBackView.bounds)
        closeButtonImageView.frame.size.width = closeButtonImageView.frame.size.height
        closeButtonImageView.frame.size.width *= 0.5
        closeButtonImageView.frame.size.height *= 0.5
        closeButtonImageView.center = closeButtonImageBackView.frame.center
        closeButtonImageView.isUserInteractionEnabled = false
        closeButtonImageView.image = UIImage(named: "btnX2")
//        closeButtonImageView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        closeButtonImageBackView.addSubview(closeButtonImageView)
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        settingButton = MainSettingButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.width, height: naviBar.frame.size.height), name: "Setting", imageName: "setting")
        settingButton.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.3843137255, blue: 0.6039215686, alpha: 1)
        settingButton.frame.origin.x = leftViewContentViewWidth - settingButton.frame.size.width
        settingButton.center.y = naviBar.frame.size.height / 2
        naviBar.addSubview(settingButton)
        
        settingButton.addTarget(event: .touchUpInside) { (button) in
            goSetting()
        }
        
        votingButton = MainVotingButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.width, height: naviBar.frame.size.height), name: "Voting", imageName: "voting")
        votingButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2823529412, blue: 0.5803921569, alpha: 1)
        votingButton.frame.origin.x = settingButton.minX - votingButton.frame.size.width - 1
        votingButton.center.y = naviBar.frame.size.height / 2
        naviBar.addSubview(votingButton)
        
        votingButton.addTarget(event: .touchUpInside) { (button) in
            goVoting()
        }
        
//        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: 1.5, height: naviBar.height))
//        separatorView.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.3843137255, blue: 0.6039215686, alpha: 1)
//        separatorView.center.x = votingButton.maxX
//        naviBar.addSubview(separatorView)
        
        
        let homeButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "home"), ratio: 0.5)
        homeButton.addTarget(event: .touchUpInside) { [weak self] (button) in
            self?.goHome()
        }
        naviBar.addSubview(homeButton)
        
        let homeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: naviBar.frame.size.height * 0.85))
        homeLabel.isUserInteractionEnabled = false
        homeLabel.text = "Home"
        homeLabel.textColor = UIColor.white
        homeLabel.font = UIFont(name: Pretendard_SemiBold, size: homeLabel.frame.size.height * 0.3)
        homeLabel.sizeToFit()
        homeLabel.frame.origin.x = homeButton.frame.maxX
        homeLabel.center.y = naviBar.frame.size.height / 2
        naviBar.addSubview(homeLabel)
        

        naviBarHomeButton = UIButton(frame: CGRect(x: 0, y: 0, width: votingButton.frame.minX, height: naviBar.frame.size.height))
        naviBarHomeButton.addTarget(event: .touchUpInside) { [weak self] (button) in
            self?.goHome()
        }
        naviBar.addSubview(naviBarHomeButton)
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
//        let leftBottomLogoView = LeftBottomLogoView(frame: CGRect(x: 0, y: 0, width: leftViewContentViewWidth, height: 0))
//        leftBottomLogoView.frame.origin.y = SCREEN.HEIGHT - SAFE_AREA - leftBottomLogoView.frame.size.height
//        contentView.addSubview(leftBottomLogoView)
        
        if SAFE_AREA > 0 {
            let safeAreaView = UIView(frame: CGRect(x: 0, y: SCREEN.HEIGHT - SAFE_AREA, width: leftViewContentViewWidth, height: SAFE_AREA))
            safeAreaView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            contentView.addSubview(safeAreaView)
        }
        
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
//        tableView = UITableView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: leftViewContentViewWidth, height: SCREEN.HEIGHT - naviBar.frame.maxY))
        tableView = UITableView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: leftViewContentViewWidth, height: SCREEN.HEIGHT - SAFE_AREA - naviBar.frame.maxY))
        tableView.register(LeftTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "LeftTableViewHeader")
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: "LeftTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.addSubview(tableView)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        self.isHidden = true
        self.contentView.frame.origin.x = -SCREEN.WIDTH
        self.grayView.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentVC : UIViewController?
    var isOpen = false
    func open(currentVC kCurrentVC : UIViewController? = nil) {
        
//        self.loginCheck()
        
        self.currentVC = kCurrentVC
        self.isOpen = true
        self.currentVC?.setNeedsStatusBarAppearanceUpdate()
        
        appDel.window?.endEditing(true)
        
        self.isHidden = false
        self.grayView.alpha = 0
        
        UIView.animate(withDuration: 0.4, animations: {
            self.grayView.alpha = 1
            self.contentView.frame.origin.x = 0
            
        }) { (fi : Bool) in
            self.currentVC?.setNeedsStatusBarAppearanceUpdate()
        }
        
//        adView.adUpdate { (count : Int) in
//            self.adView.adViewAnimationStart()
//        }
    }
    
    @objc func close(){
        
        self.isOpen = false
        self.currentVC = appDel.naviCon?.viewControllers.last //?/
        
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.frame.origin.x = -SCREEN.WIDTH
            self.grayView.alpha = 0
            self.currentVC?.setNeedsStatusBarAppearanceUpdate()
        }) { (fi : Bool) in
            self.isHidden = true
//            self.adView.adViewAnimationStop()
            
        }
    }
    
    func goHome(){
        appDel.naviCon?.popToRootViewController(animated: false)
        self.close()
    }
    ////
    
    func loginCheck(){
//        if isLogin{
//            logoutButton.isHidden = false
//            naviBarHomeButton.frame.size.width = logoutButton.frame.minX
//
//            loginButton.isHidden = true
//            favoriteButton.isHidden = false
//        }else{
//            logoutButton.isHidden = true
//            naviBarHomeButton.frame.size.width = leftViewContentViewWidth
//
//            loginButton.isHidden = false
//            favoriteButton.isHidden = true
//        }
    }
    
}

extension LeftView : UITableViewDelegate, UITableViewDataSource, LeftTableViewHeaderDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedIndex == section {
            
            let subDic = INFO.INFOS[section]
            if let subMenues = subDic[INFO.KEY.SUB_MENU] as? [[String:Any]] {
                return subMenues.count
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return INFO.INFOS.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LeftTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return LeftTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return LeftTableViewHeader.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LeftTableViewHeader.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftTableViewCell", for: indexPath) as! LeftTableViewCell
        
        let subDic = INFO.INFOS[indexPath.section]
        if let subMenues = subDic[INFO.KEY.SUB_MENU] as? [[String:Any]] {
            let subMenu = subMenues[indexPath.row]
            if let subMenuTitleString = subMenu[INFO.KEY.TITLE] as? String {
                cell.titleLabel.text = "- \(subMenuTitleString)"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeftTableViewHeader") as! LeftTableViewHeader
        
        headerView.index = section
        headerView.delegate = self
        let subDic = INFO.INFOS[section]
        if let headerTitleString = subDic[INFO.KEY.TITLE] as? String {
            headerView.titleLabel.text = headerTitleString
        }
        
        if let _ = subDic[INFO.KEY.SUB_MENU] as? [[String:Any]] {
            headerView.arrowImageView.isHidden = false
            headerView.arrowImageView.image = (section == self.selectedIndex) ? UIImage.fontAwesomeIcon(name: FontAwesome.angleUp, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), size: headerView.arrowImageView.frame.size) : UIImage.fontAwesomeIcon(name: FontAwesome.angleDown, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), size: headerView.arrowImageView.frame.size)
            headerView.underBar.isHidden = (section == self.selectedIndex)
        }else{
            headerView.arrowImageView.isHidden = true
        }
        
        
        let titmeImageName = String(format: "lefticon%02d", section)
        headerView.titleImageView.image = UIImage(named: titmeImageName)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeftTableViewCell
        cell.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeftTableViewCell
        cell.isSelected = true
        
        let dataDic = INFO.INFOS[indexPath.section]
        let rowArray = dataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
        if rowArray.count > indexPath.row {
            contentShow(dataDic: rowArray[indexPath.row])
            return
        }
    }
    
    func headrSeletedUpdate(){
        
        if self.selectedIndex != -1 {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: self.selectedIndex), at: UITableView.ScrollPosition.middle, animated: true)
        }
        
        for i in 0..<INFO.INFOS.count{
            if let headerView = self.tableView.headerView(forSection: i) as? LeftTableViewHeader {
                headerView.underBar.isHidden = (i == self.selectedIndex)
                let subDic = INFO.INFOS[i]
                if let _ = subDic[INFO.KEY.SUB_MENU] as? [[String:Any]] {
                    headerView.arrowImageView.isHidden = false
                    headerView.arrowImageView.image = (i == self.selectedIndex) ? UIImage.fontAwesomeIcon(name: FontAwesome.angleUp, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), size: headerView.arrowImageView.frame.size) : UIImage.fontAwesomeIcon(name: FontAwesome.angleDown, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), size: headerView.arrowImageView.frame.size)
                }else{
                    headerView.arrowImageView.isHidden = true
                }
            }
        }
    }
    
    func leftTableViewHeader(_ leftTableViewHeader: LeftTableViewHeader, didSelectHeader index: Int) {
        
        let headerDataDic = INFO.INFOS[index]
        let headerRowArray = headerDataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
        if headerRowArray.count == 0 {
            contentShow(dataDic: headerDataDic)
            return
        }
        
        if self.selectedIndex == -1 {
            self.selectedIndex = index
            
            var indexPaths = [IndexPath]()
            
            let dataDic = INFO.INFOS[self.selectedIndex]
            let rowArray = dataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
            for i in 0..<rowArray.count{
                indexPaths.append(IndexPath(row: i, section: self.selectedIndex))
            }
            
            if indexPaths.count > 0{
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: UITableView.RowAnimation.fade)
                self.tableView.endUpdates()
                
            }
            
        }else if self.selectedIndex == index{
            
            self.selectedIndex = -1
            
            var indexPaths = [IndexPath]()
            
            let dataDic = INFO.INFOS[index]
            let rowArray = dataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
            
            for i in 0..<rowArray.count{
                indexPaths.append(IndexPath(row: i, section: index))
            }
            
            if indexPaths.count > 0{
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: indexPaths, with: UITableView.RowAnimation.fade)
                self.tableView.endUpdates()
                
            }
        }else{
            
            var beforeIndexPaths = [IndexPath]()
            let beforeDataDic = INFO.INFOS[self.selectedIndex]
            let beforeRowArray = beforeDataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
            for i in 0..<beforeRowArray.count{
                beforeIndexPaths.append(IndexPath(row: i, section: self.selectedIndex))
            }
            
            self.selectedIndex = index
            var afterIndexPaths = [IndexPath]()
            let afterDataDic = INFO.INFOS[self.selectedIndex]
            let afterRowArray = afterDataDic[INFO.KEY.SUB_MENU] as? [[String:Any]] ?? [[String:Any]]()
            
            for i in 0..<afterRowArray.count{
                afterIndexPaths.append(IndexPath(row: i, section: self.selectedIndex))
            }
            
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: beforeIndexPaths, with: UITableView.RowAnimation.fade)
            self.tableView.insertRows(at: afterIndexPaths, with: UITableView.RowAnimation.fade)
            self.tableView.endUpdates()
            
        }
        
        self.headrSeletedUpdate()
    }
    
    
}

//extension LeftView : LeftSubTitleViewDelegate {
//    func leftSubTitleViewButtonPressed(index: Int) {
//        print("leftSubTitleViewButtonPressed : \(index)")
//        
//        if index == 0 {
//            
//            return
//        }
//        if index == 1 {
//            
//            return
//        }
//        if index == 2 {
//            
//            return
//        }
//    }
//}


class LeftViewHomeButton : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 20, y: 0, width: 0, height: self.frame.size.height * 0.4))
        iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 20, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 17)
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX
        //        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class SettingButton : LeftBottomButton {}

class LoginButton : LeftBottomButton { }

class FavoriteButton : LeftBottomButton {}

class LeftBottomButton: UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0.4666666667, blue: 0.7529411765, alpha: 1)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.4, height: self.frame.size.height * 0.4))
        if let image = UIImage(named: imageName) {
            iconImageView.setImageWithFrameWidth(image: image)
        }
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
//        iconImageView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: ROBOTO_LIGHT, size: 15)
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



class LogoutButton: UIButton {
    
    var nameLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        nameLabel.text = "로그아웃"
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.2, blue: 0.568627451, alpha: 1)
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 13)
        nameLabel.sizeToFit()
        nameLabel.frame.size.width += 30
        nameLabel.frame.size.height += 15
        nameLabel.layer.cornerRadius = nameLabel.frame.size.height / 2
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.white.cgColor
        self.addSubview(nameLabel)
        
        self.frame.size.width = nameLabel.frame.size.width + 20
        
        nameLabel.center = self.frame.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainVotingButton : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 10, y: 0, width: 0, height: self.frame.size.height * 0.5))
        iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.3 * 0.85)
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX + 10
        self.frame.size.width = innerView.frame.size.width
//        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MainSettingButton : UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 10, y: 0, width: 0, height: self.frame.size.height * 0.5))
        iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Pretendard_SemiBold, size: nameLabel.frame.size.height * 0.3 * 0.85)
        nameLabel.sizeToFit()
        nameLabel.center.y = self.frame.size.height / 2
        nameLabel.isUserInteractionEnabled = false
        innerView.addSubview(nameLabel)
        
        innerView.frame.size.width = nameLabel.frame.maxX + 10
        self.frame.size.width = innerView.frame.size.width
//        innerView.center.x = self.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
