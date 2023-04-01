
import UIKit
import AVFoundation

class QRCodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    var captureVideoView : UIView!
    
    var userLabel : UILabel!
    
    var boothEventVC : BoothEventViewController?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topViewHeight : CGFloat = SCREEN.HEIGHT * 0.35
        let captureVideoViewHeight : CGFloat = SCREEN.HEIGHT - topViewHeight + 10
        captureVideoView = UIView(frame: CGRect(x: 0, y: SCREEN.HEIGHT - captureVideoViewHeight, width: SCREEN.WIDTH, height: captureVideoViewHeight))
        self.view.addSubview(captureVideoView)
        
        self.setCaptureView(captureView: captureVideoView)
        
        
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: topViewHeight))
        topView.setCornerRadius(cornerRadius: 20, byRoundingCorners: [UIRectCorner.bottomLeft,UIRectCorner.bottomRight])
        topView.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        
        let flashButton = UIButton(frame: CGRect(x: 25, y: STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT / 2, width: 40, height: 40))
        flashButton.setBackgroundImage(UIImage(named: "flashOff"), for: .normal)
        flashButton.setBackgroundImage(UIImage(named: "flashOn"), for: .selected)
        flashButton.isSelected = flash(isOn: false) ?? false
        flashButton.addTarget(event: .touchUpInside) { (button) in
            flashButton.isSelected = flash(isOn: !flashButton.isSelected) ?? false
        }
        
        topView.addSubview(flashButton)
        
        let closeButton = UIButton(frame: CGRect(x: SCREEN.WIDTH - 40 - 25, y: STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT / 2, width: 30, height: 30))
        closeButton.setBackgroundImage(UIImage(named: "icClose"), for: UIControl.State.normal)
        topView.addSubview(closeButton)
        closeButton.addTarget(event: .touchUpInside) { (button) in
            let _ = flash(isOn: false)
            self.dismiss(animated: true, completion: {
                
            })
        }
        
        ///
        let contentView = UIView(frame: CGRect(x: 0, y: flashButton.frame.maxY + 10, width: SCREEN.WIDTH - 30, height: topView.frame.size.height - (flashButton.frame.maxY + 10) - 20))
        contentView.center.x = SCREEN.WIDTH / 2
        topView.addSubview(contentView)
        
        let innerView = UIView(frame: contentView.bounds)
        contentView.addSubview(innerView)
        
        let boothImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: contentView.height * 0.7))
        boothImageView.setImageWithFrameWidth(image: UIImage(named: "boothTourEvent"))
        innerView.addSubview(boothImageView)
        
        let titleLabel = UILabel(frame: innerView.bounds)
        titleLabel.text = """
        Exhibition
        Stamp Event
        """
        titleLabel.font = UIFont(name: Pretendard_Bold, size: innerView.height * 0.22)
        titleLabel.textColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.6156862745, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        innerView.addSubview(titleLabel)
        
        innerView.frame.size.height = boothImageView.height
        titleLabel.frame.origin.x = boothImageView.maxX + 20
        titleLabel.center.y = innerView.height / 2
        innerView.frame.size.width = titleLabel.frame.maxX
        innerView.center.x = contentView.frame.center.x
        innerView.frame.origin.y = 0
        
//        contentView.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        
//        boothImageView.center = contentView.frame.center
        
//        if let imageURLString = userD.object(forKey: "IMAGE") as? String {
//            if let imageURL = URL(string: "http://ezv.kr/voting/upload/booth/\(imageURLString)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!), let imageData = try? Data(contentsOf: imageURL) {
//                if let boothImage = UIImage(data: imageData) {
//                    boothImageView.setImageWithFrameHeight(image: boothImage)
//                    boothImageView.center = contentView.frame.center
//                }
//                
//            }
//        }
        
        userLabel = UILabel(frame: contentView.bounds)
        userLabel.backgroundColor = UIColor.white
        userLabel.numberOfLines = 0
        userLabel.isHidden = true
        userLabelUpdate(user: "")
        contentView.addSubview(userLabel)
        
        
        
        //////////////////////////////
        
        let noticeLabelBackView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: (captureVideoViewHeight - SAFE_AREA) * 0.3))
        
        let noticeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 70))
        noticeLabel.textAlignment = .center
        noticeLabel.font = UIFont(name: Pretendard_Medium, size: noticeLabel.height * 0.25)
        noticeLabel.numberOfLines = 0
        noticeLabel.text = "Please scan the barcode of each booth"
        noticeLabel.textColor = UIColor.white
        noticeLabel.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.231372549, alpha: 1)
        noticeLabel.center = noticeLabelBackView.frame.center
        noticeLabelBackView.addSubview(noticeLabel)
        
        let lightBox = UIView(frame: CGRect(
            x: 0,
            y: noticeLabelBackView.frame.maxY,
            width: SCREEN.WIDTH * 0.8,
            height: (captureVideoViewHeight - SAFE_AREA) - noticeLabelBackView.frame.maxY - 15 - 15))
//        lightBox.backgroundColor = UIColor.white.withAlphaComponent(0)
        lightBox.center.x = SCREEN.WIDTH / 2
        
        //////////////////////////////
        
        
        let grayColor = UIColor.black.withAlphaComponent(0.7)
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: lightBox.frame.minY))
        view1.backgroundColor = grayColor
        captureVideoView.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 0, y: lightBox.frame.maxY, width: SCREEN.WIDTH, height: captureVideoView.frame.size.height - lightBox.frame.maxY))
        view2.backgroundColor = grayColor
        captureVideoView.addSubview(view2)
        
        let view3 = UIView(frame: CGRect(x: 0, y: lightBox.frame.minY, width: lightBox.frame.minX, height: lightBox.frame.maxY - lightBox.frame.minY))
        view3.backgroundColor = grayColor
        captureVideoView.addSubview(view3)
        
        let view4 = UIView(frame: CGRect(x: lightBox.frame.maxX, y: lightBox.frame.minY, width: SCREEN.WIDTH - lightBox.frame.maxX, height: lightBox.frame.maxY - lightBox.frame.minY))
        view4.backgroundColor = grayColor
        captureVideoView.addSubview(view4)
        
        
        //////////////////////////////
        
        captureVideoView.addSubview(noticeLabelBackView)
        captureVideoView.addSubview(lightBox)
        
        
        
        //////
        let rectWidth : CGFloat = 50
        let rectBorderWidth : CGFloat = 8
        let rectColor = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.2588235294, alpha: 1)
        
        let view11 = UIView(frame: CGRect(x: lightBox.frame.minX - rectBorderWidth, y: lightBox.frame.minY - rectBorderWidth, width: rectBorderWidth, height: rectWidth))
        view11.backgroundColor = rectColor
        captureVideoView.addSubview(view11)
        let view12 = UIView(frame: CGRect(x: lightBox.frame.minX - rectBorderWidth, y: lightBox.frame.minY - rectBorderWidth, width: rectWidth, height: rectBorderWidth))
        view12.backgroundColor = rectColor
        captureVideoView.addSubview(view12)
        
        let view21 = UIView(frame: CGRect(x: lightBox.frame.maxX + rectBorderWidth, y: lightBox.frame.minY - rectBorderWidth, width: -rectBorderWidth, height: rectWidth))
        view21.backgroundColor = rectColor
        captureVideoView.addSubview(view21)
        let view22 = UIView(frame: CGRect(x: lightBox.frame.maxX + rectBorderWidth, y: lightBox.frame.minY - rectBorderWidth, width: -rectWidth, height: rectBorderWidth))
        view22.backgroundColor = rectColor
        captureVideoView.addSubview(view22)
        
        let view31 = UIView(frame: CGRect(x: lightBox.frame.minX - rectBorderWidth, y: lightBox.frame.maxY + rectBorderWidth, width: rectBorderWidth, height: -rectWidth))
        view31.backgroundColor = rectColor
        captureVideoView.addSubview(view31)
        let view32 = UIView(frame: CGRect(x: lightBox.frame.minX - rectBorderWidth, y: lightBox.frame.maxY, width: rectWidth, height: rectBorderWidth))
        view32.backgroundColor = rectColor
        captureVideoView.addSubview(view32)
        
        let view41 = UIView(frame: CGRect(x: lightBox.frame.maxX , y: lightBox.frame.maxY + rectBorderWidth, width: rectBorderWidth, height: -rectWidth))
        view41.backgroundColor = rectColor
//        view41.backgroundColor = UIColor.blue
        captureVideoView.addSubview(view41)
        let view42 = UIView(frame: CGRect(x: lightBox.frame.maxX + rectBorderWidth, y: lightBox.frame.maxY, width: -rectWidth, height: rectBorderWidth))
        view42.backgroundColor = rectColor
//        view42.backgroundColor = UIColor.red
        captureVideoView.addSubview(view42)
        
        ////////
        
        
    }
    
    func userLabelUpdate(user : String){
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let noticeInfoDic = [NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF, size: 30)!,
                             NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1),
                             NSAttributedString.Key.paragraphStyle:paragraphStyle] as [NSAttributedString.Key : NSObject]
        let userInfoDic = [NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 45)!,
                           NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1568627451, green: 0.1921568627, blue: 0.3568627451, alpha: 1),
                           NSAttributedString.Key.paragraphStyle:paragraphStyle] as [NSAttributedString.Key : NSObject]

        let infos : [(String,[NSAttributedString.Key:NSObject])] = [
        ("안녕하세요\n",noticeInfoDic),
        ("\(user)님\n",userInfoDic),
        ("방문해 주셔서 감사합니다.",noticeInfoDic)
        ]

        userLabel.attributedText = NSMutableAttributedString(stringsInfos: infos)
    }
    
    
    func codeCheck(code kCode : String){
        self.qrCodeFrameView.frame = CGRect.zero
        
        captureSession.stopRunning()

        print("code : \(kCode)")
        var codeString = kCode
        codeString = codeString.replacingOccurrences(of: "A", with: "")
        codeString = codeString.replacingOccurrences(of: "a", with: "")
        print("codeString:\(codeString)")
        let urlString =
        "https://ezv.kr:4447/voting/php/booth/set_post.php?code=\(code)&deviceid=\(deviceID)&regist_sid=\(regist_sid)&booth_sid=\(codeString)"
        print("urlString : \(urlString)")
      
        Server.postData(urlString: urlString) { (kData : Data?) in
            
            if let data = kData {
                print("codeCheck return : \(String(describing: data.toString()))")
//                Optional("Y\r\n\r\n")
                
                if let dataString = data.toString(),
                    dataString.lowercased() == "y"
                {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: {
                            
                        })
                    }
                    return
                }
                //아니면
                DispatchQueue.main.async {
                    self.captureSession.startRunning()
                }
                
            }
        }
        
    }

                
//                DispatchQueue.main.async {
                
//                        print("DataDic : \(dataDic)")
//                        if let name = dataDic["name"] as? String {
//                            self.userLabelUpdate(user: name)
//                            self.userLabel.isHidden = false
//                        }
//                        if let msg = dataDic["msg"] as? String {
//                            toastShow(message: msg)
//                        }
//                    }
//                    
//                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
//                        self.userLabelUpdate(user: "")
//                        self.userLabel.isHidden = true
//                        self.captureSession.startRunning()
//                    })
//                }
//            }
//        }
        
        
        
        
        /*
         http://kgca.m2comm.co.kr/pharmaceutical/app/check_in.php?
         
         tab=kingca2019
         
         code=(부스코드)
         
         barcode=(바코드)
         
         
         
         http://kgca.m2comm.co.kr/pharmaceutical/app/list.php
         
         tab=kingca2018
         
         code=(부스코드)
         */
//    }
//    }
    
    
    
    
    var captureSession:AVCaptureSession!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView!
    
    // Added to support different barcodes
    //    [.ean8, .ean13, .pdf417]
    let supportedBarCodes : [AVMetadataObject.ObjectType] =
        [
            .qr,
            .code128,
            .code39,
            .code93,
            .upce,
            .pdf417,
            .ean13,
            .aztec,
            
            //            .ean8,
            //            .ean13,
    ]
    
    
    func setCaptureView( captureView : UIView ){
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return print("captureDevice not initialze")
        }
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            return print("videoInput error : \(error)")
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        
        // Set the input device on the capture session.
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else{
            print("captureSession can't input")
            return
        }
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(captureMetadataOutput) {
            captureSession.addOutput(captureMetadataOutput)
        }else{
            print("captureSession can't output")
            return
        }
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // Detect all the supported bar code
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        videoPreviewLayer?.frame = captureView.layer.bounds
        captureView.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture
        captureSession.startRunning()
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(qrCodeFrameView)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.contains(metadataObj.type) {
            //        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            //?/
            if metadataObj.stringValue != nil {
                if let codeString = metadataObj.stringValue {
                    print("codeString : \(String(describing: codeString))")
                    
                    self.codeCheck(code: codeString)
                    
//                    let alertCon = UIAlertController(title: "코드 확인", message: codeString, preferredStyle: UIAlertController.Style.alert)
//                    alertCon.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
//                        self.qrCodeFrameView.frame = CGRect.zero
//                        self.captureSession.startRunning()
//                    }))
//                    self.present(alertCon, animated: true) { }
                }
//                captureSession.stopRunning()
            }
        }
    }
    
    
}
