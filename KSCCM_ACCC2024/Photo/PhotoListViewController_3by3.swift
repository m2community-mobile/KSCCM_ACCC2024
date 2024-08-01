import UIKit
import SDWebImage
import FontAwesome_swift

import Photos

struct PHOTO_LIST_INFO {
    struct KEY {
        static let TITLE = "TITLE"
        static let URL = "URL"
        static let TAB = "TAB"
    }
    
    static let INFO = [
//        [
//            KEY.TITLE : "04.24 (ㅉㄷㅇ)",
//            KEY.TAB : "537"
//        ],
        
//        [
//            KEY.TITLE : "04.24 (Wed)",
//                    KEY.TAB : "-1"
//                ],
        
        
        [
            KEY.TITLE : "04.25 (Thu)",
            KEY.TAB : "538"
        ],
        [
            KEY.TITLE : "04.26 (Fri)",
            KEY.TAB : "539"
        ],
//        [
//            KEY.TITLE : "04.15(Sat)",
//            KEY.TAB : "423"
//        ],
    ]
    
}

class PhotoListViewController: BaseViewController {
    
    var dataArray = [[String:Any]]()
    var imageCollectionView : UICollectionView!
    
    let addNewImageButtonHeight : CGFloat = 50
    var addNewImageButton : UIButton!
    
    var segBackView : UIView!
    
//    var mainBottomViewBackView : UIView!
    let bottomView = BottomView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let collectionViewLayout = PhotoCollectionViewLayout()
    
    var photoListSelectButtons = [PhotoListSelectButton]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoMenuListUpdate(index: self.currentIndex)
//        photoMenuListUpdate(index: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subTitleLabel.text = "Photo Gallery"
        
        self.subTitleView.backgroundColor = #colorLiteral(red: 0.07529277354, green: 0.3476974964, blue: 0.4083291888, alpha: 1)
        self.subTitleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButtonimageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.arrowLeft, style: .solid, textColor: UIColor.white, size: backButtonimageView.frame.size)
        
        segBackView = UIView(frame: CGRect(x: 0, y: subTitleView.frame.maxY, width: SCREEN.WIDTH, height: 50))
//        segBackView.frame.size.height = 0
        segBackView.clipsToBounds = true
        self.view.addSubview(segBackView)

        let photoListSelectButtonWidth : CGFloat = SCREEN.WIDTH / CGFloat(PHOTO_LIST_INFO.INFO.count)
        for i in 0..<PHOTO_LIST_INFO.INFO.count{
            let photoListSelectButton = PhotoListSelectButton(frame: CGRect(x: CGFloat(i) * photoListSelectButtonWidth, y: 0, width: photoListSelectButtonWidth, height: segBackView.frame.size.height), name: PHOTO_LIST_INFO.INFO[i][PHOTO_LIST_INFO.KEY.TITLE]!)
            segBackView.addSubview(photoListSelectButton)
            
            photoListSelectButtons.append(photoListSelectButton)
            
            photoListSelectButton.addTarget(self, action: #selector(photoListSelectButtonPressed(button:)), for: .touchUpInside)
        }
        
        let segUnderView0 = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0.5))
        segUnderView0.backgroundColor = #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1).withAlphaComponent(0.5)
        self.subTitleView.addSubview(segUnderView0)
        
        let segUnderView1 = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0.5))
        segUnderView1.backgroundColor = #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1).withAlphaComponent(0.5)
        segBackView.addSubview(segUnderView1)
        
        let segUnderView2 = UIView(frame: CGRect(x: 0, y: segBackView.frame.maxY, width: SCREEN.WIDTH, height: 0.5))
        segUnderView2.backgroundColor = #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1)
        self.view.addSubview(segUnderView2)
        
        imageCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: segUnderView2.frame.maxY,
                width: SCREEN.WIDTH,
                height: bottomView.frame.minY - segUnderView2.frame.maxY),
            collectionViewLayout: collectionViewLayout)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        imageCollectionView.bounces = false
        imageCollectionView.showsVerticalScrollIndicator = false
        imageCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(imageCollectionView)
        
        addNewImageButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT, width: SCREEN.WIDTH, height: addNewImageButtonHeight))
        addNewImageButton.backgroundColor = mainColor
        self.view.addSubview(addNewImageButton)
        
        self.view.addSubview(bottomView)
        
        let addNewImageButtonView = AddNewImageButtonBackView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: addNewImageButtonHeight), name: "Add Photo")
        addNewImageButton.addSubview(addNewImageButtonView)
        
        addNewImageButton.addTarget(event: .touchUpInside) { (button) in
            print("addNewImage")
            
            
            let imageSelectAlertCon = UIAlertController(title: "Please select an upload method.", message: nil, preferredStyle: .actionSheet)
            imageSelectAlertCon.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (action) in
                print("Camera")
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (grant : Bool) in
                    if grant {
                        let imagePickerController = UIImagePickerController()
                        imagePickerController.sourceType = .camera
                        imagePickerController.showsCameraControls = true
                        imagePickerController.delegate = self
                        imagePickerController.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.present(imagePickerController, animated: true) { }
                        }
                    }else{
                        DispatchQueue.main.async {
                            appDel.showAlert(title: "Notice", message: "You cannot access the camera.\nSettings > Privacy > Camera > \(APP_NAME) App")
                        }
                    }
                })
                
            }))
            imageSelectAlertCon.addAction(UIAlertAction(title: "Album", style: UIAlertAction.Style.default, handler: { (action) in
                print("Album")
                
                PHPhotoLibrary.requestAuthorization({ (state : PHAuthorizationStatus) in
                    if state == .authorized {
                        let imagePickerController = UIImagePickerController()
                        imagePickerController.sourceType = .photoLibrary
                        imagePickerController.delegate = self
                        imagePickerController.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.present(imagePickerController, animated: true) { }
                        }
                    }else{
                        DispatchQueue.main.async {
                            appDel.showAlert(title: "Notice", message: "You cannot access the album.\nSettings > Privacy > album > \(APP_NAME) App")

                        }
                    }
                })
                
                
                
            }))
            imageSelectAlertCon.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                print("Cancel")
            }))
            self.present(imageSelectAlertCon, animated: true, completion: {
                
            })
            
        }
        
        photoListSelectButtonPressed(button: self.photoListSelectButtons[0])
//        currentDayUpdate()
    }
    
    func currentDayUpdate(){
        //오늘날짜로 업데이트
        let _ = Server.postData(urlString: "https://ezv.kr:4447/voting/php/session/get_set.php?code=\(code)", otherInfo: [:]) {[weak self] (kData : Data?) in
            guard let self = self else { return }
            
            if let data = kData {
                if let dataDic = data.toJson() as? [String:Any] {
                    print("PAGView dataDic:\(dataDic)")
                    
                    //오늘날짜로 업데이트
                    
                    if let currentTab = dataDic["tab"] as? String {
                        print("currentTab:\(currentTab)")
                        
                        if let todayIndex = PHOTO_LIST_INFO.INFO.firstIndex(where: { photoListInfoDic in
                            if let tab = photoListInfoDic[PHOTO_LIST_INFO.KEY.TAB] {
                                print("PHOTO_LIST_INFO.INFO Tab :\(tab)")
                                return tab == currentTab
                            }
                            return false
                        }) {
                            print("찾은 인덱스:\(todayIndex)")
                            DispatchQueue.main.async {
                                self.photoListSelectButtonPressed(button: self.photoListSelectButtons[todayIndex])
                            }
                        }
                        
                        
                        
                        
                    }
                }
            }
        }
    }
    
    var currentIndex = 0
    let taps = ["-1"]
    func photoMenuListUpdate( index : Int? ){
        print("photoMenuListUpdate:\(String(describing: index))")
        var urlString = "https://ezv.kr:4447/voting/php/photo/get_photo.php?deviceid=\(deviceID)&code=\(code)"
        if let kIndex = index,
           kIndex < PHOTO_LIST_INFO.INFO.count {
            let tab = PHOTO_LIST_INFO.INFO[kIndex][PHOTO_LIST_INFO.KEY.TAB] ?? ""
            currentIndex = kIndex
            urlString = urlString + "&tab=\(tab)"
        }
        
        print("urlString:\(urlString)")
        let _ = Server.postData(urlString: urlString, otherInfo: [:]){ [weak self] (kData : Data?) in
            guard let self = self else { return }
            if let data = kData {
                if let array = data.toJson() as? [[String:Any]] {
                    print("array:\(array)")
                    self.dataArray = array
                    self.collectionViewLayout.numberOfitem = self.dataArray.count
                    self.imageCollectionView.reloadData()
                    
                }
                else{
                    print("데이터 없음")
                    self.dataArray = [[String:Any]]()
                    self.collectionViewLayout.numberOfitem = self.dataArray.count
                    self.imageCollectionView.reloadData()
                }
            }
            
        }
    }
    
    @objc func photoListSelectButtonPressed( button : PhotoListSelectButton ){
        
        var index = 0
        for i in 0..<self.photoListSelectButtons.count {
            let photoListSelectButton = self.photoListSelectButtons[i]
            photoListSelectButton.isSelected = (photoListSelectButton == button)
            
            if photoListSelectButton == button {
                photoMenuListUpdate(index: i)
                index = i
            }
        }

        UIView.animate(withDuration: 0.3, animations: {
            if index == 10 {
                
//                self.addNewImageButton.frame.origin.y = SCREEN.HEIGHT - self.addNewImageButton.frame.size.height
//                self.imageCollectionView.frame.size.height = self.addNewImageButton.frame.origin.y - self.segBackView.frame.maxY
                
                self.addNewImageButton.frame.origin.y = self.bottomView.frame.minY - self.addNewImageButton.frame.size.height
                self.imageCollectionView.frame.size.height = self.addNewImageButton.frame.origin.y - self.segBackView.frame.maxY
                
            }else{
//                self.addNewImageButton.frame.origin.y = SCREEN.HEIGHT
//                self.imageCollectionView.frame.size.height = SCREEN.HEIGHT - self.segBackView.frame.maxY
                
                self.addNewImageButton.frame.origin.y = self.bottomView.frame.minY
                self.imageCollectionView.frame.size.height = self.bottomView.frame.minY - self.segBackView.frame.maxY
            }
        }) { (fi) in

        }
        
        
    }
    
}



extension PhotoListViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let getImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let resizedImage = getImage.resizeForWeb() {
                guard let imageData = resizedImage.pngData() else { return print("make png fail") }
                let imageString = imageData.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
                
                let _ = Server.postData(urlString: "https://ezv.kr:4447/voting/php/photo/photo_upload.php", otherInfo: ["img":imageString,"code":code,"deviceid":deviceID]) { (kData : Data?) in
                    if let data = kData {
                        print("sendPhoto : \(String(describing: data.toString()))")
                        self.photoMenuListUpdate(index: self.currentIndex)
                    }
                }
                
            }
            
        }
        

        
        picker.dismiss(animated: true) { }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true) { }
    }
}

extension PhotoListViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoCollectionViewCellDelegate {
    
    //PhotoCollectionViewCellDelegate
    func photoCollectionViewCelldidHeartButtonSelected(index: Int) {
        print("\(index) selected")
       
        if index >= self.dataArray.count { return }
        
        var dataDic = self.dataArray[index]
            
        var nextValue = 0
        
        guard let sid = dataDic["sid"] as? String else { return print("sid is nil") }
        guard let myfav = dataDic["myfav"] as? String else { return print("myfav is nil")}
        
        guard let myfavValue = Int(myfav, radix: 10) else { return print("10진수 변환 실패") }
        if myfavValue == 0 { nextValue = 1}
        if myfavValue == 1 { nextValue = 0}
        
        let urlString = "https://ezv.kr:4447/voting/php/photo/set_favor.php?sid=\(sid)&deviceid=\(deviceID)&val=\(nextValue)"
//        print("set urlString \(urlString)")
        let _ = Server.postData(urlString: urlString, otherInfo: [:]) { (kData : Data?) in
            if let data = kData {
                if let afterCnt = data.toString() {
                    dataDic["cnt"] = afterCnt
                    dataDic["myfav"] = myfavValue == 1 ? "0":"1"
                    self.dataArray[index] = dataDic
                    self.imageCollectionView.reloadData()
                }
//                self.photoMenuListUpdate(index: self.currentIndex)
            }
        }
        
    }
    
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewLayout.numberOfitem
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.index = indexPath.row
        cell.delegate = self
        
        if let cnt = dataArray[indexPath.row]["cnt"] as? String {
            if let cnt_Int = Int(cnt, radix: 10) {
                cell.numberOfLike = cnt_Int
            }
        }
        
        if let fileURL = dataArray[indexPath.row]["url"] as? String {
            OperationQueue.main.addOperation {
                cell.photoImageView.sd_setImage(with: URL(string: "https://ezv.kr:4447/voting/upload/photo/\(fileURL)"), completed: nil)
            }
        }else{
            cell.photoImageView.image = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoBaseVC = PhotoPopUpBaseViewController()
        photoBaseVC.photoInfos = self.dataArray
        photoBaseVC.startIndex = indexPath.row
        let naviCon = RotatableNavigationController(rootViewController: photoBaseVC)
        naviCon.modalPresentationStyle = .fullScreen
        self.present(naviCon, animated: true) { }
        
        
        
    }
    
}

@objc protocol PhotoCollectionViewCellDelegate {
    @objc optional func photoCollectionViewCelldidHeartButtonSelected( index : Int )
}


class PhotoCollectionViewCell: UICollectionViewCell {
    
    var delegate : PhotoCollectionViewCellDelegate?
    
    var defalultImageView : UIImageView!
    var photoImageView : UIImageView!
    
    var heartInfoLabelBackView : UIView!
    var heartImageView : UIImageView!
    var heartInfoLabel : UILabel!
    
    var heartButton : UIButton!
    
    lazy var heartInfoLabelHeight : CGFloat = {
        return self.frame.size.height * 0.15
    }()
    
    var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size = PhotoCollectionViewLayout().photoSize
        
        self.uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uiSetting() {
        
        self.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        self.layer.borderWidth = 1
        
        defalultImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width * 0.8, height: 0))
        defalultImageView.setImageWithFrameHeight(image: UIImage(named: "logo"))
        defalultImageView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addSubview(defalultImageView)
        
        photoImageView = UIImageView(frame: self.bounds)
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        self.addSubview(photoImageView)
        
        heartInfoLabelBackView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - (heartInfoLabelHeight * 2), width: self.frame.size.width, height: heartInfoLabelHeight * 2))
        heartInfoLabelBackView.setGradientBackgroundColor(colors: [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        self.addSubview(heartInfoLabelBackView)
        
        heartImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: heartInfoLabelHeight, height: heartInfoLabelHeight))
        heartImageView.image = UIImage.fontAwesomeIcon(name: .heart, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.7647058824, green: 0.7647058824, blue: 0.7647058824, alpha: 1), size: heartImageView.frame.size)
        self.addSubview(heartImageView)
        
        heartButton = UIButton(frame: CGRect(x: 15, y: 0, width: heartInfoLabelHeight * 1.5, height: heartInfoLabelHeight * 1.5))
        heartButton.addTarget(self , action: #selector(heartButtonPressed), for: .touchUpInside)
        self.addSubview(heartButton)
        
        heartInfoLabel = UILabel(frame: CGRect(x: heartImageView.frame.maxX + 3, y: self.frame.size.height - (heartInfoLabelHeight * 1.5), width: self.frame.size.width - (heartImageView.frame.maxX + 3), height: heartInfoLabelHeight))
        heartInfoLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Ultra_Light, size: heartInfoLabelHeight * 0.9)
        heartInfoLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.addSubview(heartInfoLabel)
        
        heartImageView.center.y = heartInfoLabel.center.y
        heartButton.center = heartImageView.center
        
        
        
    }
    
    @objc func heartButtonPressed(){
        print("heartButtonPressed : \(self.index)")
        self.delegate?.photoCollectionViewCelldidHeartButtonSelected?(index: self.index)
    }
    
    var numberOfLike : Int = 0 {
        willSet(newNumberOfLike){
            
            if newNumberOfLike != 0 {
                heartImageView.image = UIImage.fontAwesomeIcon(name: .heart, style: FontAwesomeStyle.solid, textColor: #colorLiteral(red: 0.9450980392, green: 0.05882352941, blue: 0.3725490196, alpha: 1), size: heartImageView.frame.size)
            }else{
                heartImageView.image = UIImage.fontAwesomeIcon(name: .heart, style: FontAwesomeStyle.regular, textColor: #colorLiteral(red: 0.7647058824, green: 0.7647058824, blue: 0.7647058824, alpha: 1), size: heartImageView.frame.size)
            }
            
            heartInfoLabel.text = "\(newNumberOfLike)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.sd_cancelCurrentImageLoad()
    }
}




class PhotoListSelectButton: UIButton {
    
    override var isSelected: Bool {
        willSet(newIsSelected){
            if newIsSelected {
                self.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.7647058824, blue: 0.1529411765, alpha: 1)
                self.nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                self.backgroundColor = UIColor.clear
                self.nameLabel.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            }
            
        }
    }
    
    var nameLabel : UILabel!
    init(frame: CGRect, name : String) {
        super.init(frame: frame)
        
        nameLabel = UILabel(frame: self.bounds)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: nameLabel.height * 0.3)
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = name
        self.addSubview(nameLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class AddNewImageButtonBackView: UIView {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name kName : String) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = false
        
        let innerView = UIView(frame: self.bounds)
        self.addSubview(innerView)
        
        iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 0.5, height: self.frame.size.height * 0.5))
        iconImageView.image = UIImage.fontAwesomeIcon(name: .camera, style: .solid, textColor: UIColor.white, size: iconImageView.frame.size)
        iconImageView.center.y = self.frame.size.height / 2
        iconImageView.isUserInteractionEnabled = false
        innerView.addSubview(iconImageView)
        
        nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = kName
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 20)
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

