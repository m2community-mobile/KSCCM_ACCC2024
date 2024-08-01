//
//  BarCodeView.swift
//  koa2019s
//
//  Created by m2comm on 14/03/2019.
//  Copyright © 2019 m2community. All rights reserved.
//

import UIKit

@objc protocol BarCodeView_Delegate {
    @objc optional func didDismissBarCodeView()
}

//class BarCodeView: UIView {
//
//    var delegate : BarCodeView_Delegate?
//    var grayView : UIView!
//    var backView : UIView!
//
//    init(barCode : String) {
//        super.init(frame: SCREEN.BOUND)
//        print("barCode:\(barCode)")
//        grayView = UIView(frame: SCREEN.BOUND)
//        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        grayView.isUserInteractionEnabled = false
//        self.addSubview(grayView)
//        grayView.alpha = 0
//
//        let grayCloseButton = UIButton(frame: self.bounds)
//        grayCloseButton.addTarget(event: UIControl.Event.touchUpInside) { [weak self] (button) in
//            self?.close()
//        }
//        self.addSubview(grayCloseButton)
//
//        backView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT * 0.4))
//        backView.backgroundColor = UIColor.white
//        backView.setCornerRadius(cornerRadius: 10, byRoundingCorners: [.bottomLeft,.bottomRight])
//        self.addSubview(backView)
//        backView.frame.origin.y = -backView.frame.size.height
//
//        ///
//        let closeButton = UIButton(frame: CGRect(x: SCREEN.WIDTH - (NAVIGATION_BAR_HEIGHT * 1.5), y: STATUS_BAR_HEIGHT, width: NAVIGATION_BAR_HEIGHT, height: NAVIGATION_BAR_HEIGHT))
//        closeButton.addTarget(event: UIControl.Event.touchUpInside) { [weak self] (button) in
//            self?.close()
//        }
//        backView.addSubview(closeButton)
//
//        let closeButtonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: closeButton.frame.size.width * 0.4, height: closeButton.frame.size.height * 0.4))
//        closeButtonImageView.image = #imageLiteral(resourceName: "btnClose").withRenderingMode(.alwaysTemplate)
//        closeButtonImageView.tintColor = UIColor.black
//        closeButtonImageView.center = CGPoint(x: closeButton.frame.size.width / 2, y: closeButton.frame.size.height / 2)
//        closeButton.addSubview(closeButtonImageView)
//
//        ////
//
//        let label = UILabel(frame: CGRect(x: 0, y: closeButton.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT * 0.12))
//        label.numberOfLines = 0
//        label.text = """
//        출결 또는 바코드 이벤트에
//        해당 바코드를 사용해 주세요
//        """
//        label.textAlignment = .center
//        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
//        label.font = UIFont(name: Nanum_Barun_Gothic_OTF_Light, size: 23)
//
//        backView.addSubview(label)
//
//        let barcodeImageView = UIImageView(frame: CGRect(x: 0, y: label.frame.maxY + 10, width: 0, height: SCREEN.HEIGHT * 0.15))
//        barcodeImageView.frame.size.width = barcodeImageView.frame.size.height * 21 / 9
//        barcodeImageView.center.x = SCREEN.WIDTH / 2
//        barcodeImageView.image = UIImage.makeQRCodeImage(type: UIImage.CodeType.barCode, code: barCode, size: barcodeImageView.frame.size)
//        backView.addSubview(barcodeImageView)
//
//    }
//
//    func show(){
//        UIView.animate(withDuration: 0.3, animations: {
//            self.backView.frame.origin.y = 0
//            self.grayView.alpha = 1
//        }) { (fi) in
//
//        }
//    }
//
//    func close(){
//        UIView.animate(withDuration: 0.3, animations: {
//            self.backView.frame.origin.y = -self.backView.frame.size.height
//            self.grayView.alpha = 0
//        }) { (fi) in
//            self.removeFromSuperview()
//            self.delegate?.didDismissBarCodeView?()
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class BarcodeView: UIView {

    static func show(delegate kDelegate : BarCodeView_Delegate?){

        let barcode = userD.string(forKey: USER_BARCODE) ?? ""
        let urlString = "https://www.aocc2023.or.kr/app/2020s/php/get_print_chk.php?barcode=\(barcode)&asdf=\(Date().timeIntervalSince1970)"
        print("show barcode : \(urlString)")

        Server.postData(urlString: urlString) { (kData : Data?) in
            if let data = kData {
                if let dataString = data.toString() {
                    print("BarcodeView show dataString : \(dataString)")
                }
                if let dataDic = data.toJson() as? [String:Any]{
                    var isPrint = false

                    if let rows = dataDic["rows"] as? String,
                    rows.lowercased() == "y"{
                        isPrint = true
                    }

                    let barCodeView = BarcodeView(isPrint: isPrint)
                    barCodeView.delegate = kDelegate
                    barCodeView.grayView.alpha = 0
                    barCodeView.backView.frame.origin.y = SCREEN.HEIGHT
                    appDel.window?.addSubview(barCodeView)

                    appDel.barCodeView = barCodeView
                    UIView.animate(withDuration: 0.3, animations: {
                        barCodeView.grayView.alpha = 1
                        barCodeView.backView.frame.origin.y = SCREEN.HEIGHT - barCodeView.backView.frame.size.height
                    }) { (fi) in

                    }
                }
            }
        }




    }
    func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.grayView.alpha = 0
            self.backView.frame.origin.y = SCREEN.HEIGHT
        }) { (fi) in
            self.removeFromSuperview()
            appDel.barCodeView = nil
            self.delegate?.didDismissBarCodeView?()
        }
    }

    var delegate : BarCodeView_Delegate?
    var grayView : UIView!
    var backView : UIView!

    init(isPrint : Bool = false) {
        super.init(frame: SCREEN.BOUND)
        print("barCode:\(user_barcode)")
        grayView = UIView(frame: SCREEN.BOUND)
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        grayView.isUserInteractionEnabled = false
        self.addSubview(grayView)
        grayView.alpha = 0

        let grayCloseButton = UIButton(frame: self.bounds)
        grayCloseButton.addTarget(event: UIControl.Event.touchUpInside) { [weak self] (button) in
            self?.hide()
        }
        self.addSubview(grayCloseButton)


        backView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT * 0.5 + SAFE_AREA))
        backView.backgroundColor = UIColor.white
        self.addSubview(backView)

        let noticeLabel = UILabel(frame: CGRect(x: 0, y: 30, width: SCREEN.WIDTH * 0.7, height: 1000))
        if IS_IPHONE_SE {
            noticeLabel.frame.size.width = SCREEN.WIDTH * 0.8
        }
        noticeLabel.numberOfLines = 0
        noticeLabel.font = UIFont(name: ROBOTO_REGULAR, size: 18)
        noticeLabel.textAlignment = .center
        noticeLabel.text = "Please use this barcode in the attendance and booth event."
        noticeLabel.sizeToFit()
        noticeLabel.center.x = SCREEN.WIDTH / 2
        backView.addSubview(noticeLabel)

        let barcodeImageBackView = UIView(frame: CGRect(x: 0, y: noticeLabel.frame.maxY + 30, width: SCREEN.WIDTH * 0.9, height: 180))
        if IS_IPHONE_SE {
            barcodeImageBackView.frame.origin.y = noticeLabel.frame.maxY + 15
        }
        barcodeImageBackView.center.x = SCREEN.WIDTH / 2
        barcodeImageBackView.layer.borderWidth = 2
        barcodeImageBackView.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).cgColor
        backView.addSubview(barcodeImageBackView)

        let barcodeImageBackView2 = UIView(frame: barcodeImageBackView.bounds)
        barcodeImageBackView.addSubview(barcodeImageBackView2)

        let barcodeImageView = UIImageView(frame: barcodeImageBackView2.bounds)
//        barcodeImageView.frame.size.width *= 0.85
        barcodeImageView.frame.size.width = 120
        barcodeImageView.frame.size.height = 120

//        barcodeImageView.image = UIImage.makeQRCodeImage(type: UIImage.CodeType.barCode, code: user_barcode, size: barcodeImageView.frame.size)
        barcodeImageView.image = UIImage.makeQRCodeImage(type: UIImage.CodeType.qrCode, code: user_barcode, size: barcodeImageView.frame.size)
        barcodeImageView.center.x = barcodeImageBackView2.frame.size.width / 2
        barcodeImageBackView2.addSubview(barcodeImageView)

        let barCodeLabel = UILabel(frame: CGRect(x: 0, y: barcodeImageView.frame.maxY + 5, width: SCREEN.WIDTH, height: 1000))
        barCodeLabel.font = UIFont(name: ROBOTO_REGULAR, size: 20)
        barCodeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        barCodeLabel.text = user_barcode
        barCodeLabel.sizeToFit()
        barCodeLabel.center.x = barcodeImageBackView2.frame.size.width / 2
        barcodeImageBackView2.addSubview(barCodeLabel)

        barcodeImageBackView2.frame.size.height = barCodeLabel.frame.maxY
        barcodeImageBackView.frame.size.height = barcodeImageBackView2.frame.size.height + 50
        if IS_IPHONE_SE {
            barcodeImageBackView.frame.size.height = barcodeImageBackView2.frame.size.height + 30
        }
        barcodeImageBackView2.center.y = barcodeImageBackView.frame.size.height / 2


        let noticeLabel2 = NoticeLabel2(frame: CGRect(x: 0, y: barcodeImageBackView.frame.maxY + 30, width: SCREEN.WIDTH * 0.9, height: 1000))
        if IS_IPHONE_SE {
            noticeLabel2.frame.origin.y = barcodeImageBackView.frame.maxY + 15
        }
        noticeLabel2.center.x = SCREEN.WIDTH / 2
        backView.addSubview(noticeLabel2)
        if isPrint {
            noticeLabel2.frame.size.height = 0 //todo
        }

        let closeButtonHeight : CGFloat = 50
        let closeButton = UIButton(frame: CGRect(x: 0, y: noticeLabel2.frame.maxY + 30, width: SCREEN.WIDTH, height: closeButtonHeight + SAFE_AREA))
        if IS_IPHONE_SE {
            closeButton.frame.origin.y = noticeLabel2.frame.maxY + 15
        }
//        closeButton.frame.origin.y = backView.frame.size.height - closeButton.frame.size.height
        closeButton.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1647058824, blue: 0.3058823529, alpha: 1)
        closeButton.addTarget(event: .touchUpInside) { (button) in
            self.hide()
        }
        backView.addSubview(closeButton)

        let closeButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: closeButtonHeight))
        closeButtonLabel.text = "Close"
        closeButtonLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        closeButtonLabel.font = UIFont(name: NanumSquareB, size: closeButtonHeight * 0.45)
        closeButtonLabel.textAlignment = .center
        closeButtonLabel.isUserInteractionEnabled = false
        closeButton.addSubview(closeButtonLabel)

        backView.frame.size.height = closeButton.frame.maxY
        backView.frame.origin.y = SCREEN.HEIGHT - backView.frame.size.height
        backView.setCornerRadius(cornerRadius: 10, byRoundingCorners: [.topLeft,.topRight])

        ///



    }

    class NoticeLabel2 : UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)

            self.numberOfLines = 0

            var fontSize : CGFloat = 50 * 0.35
            var fontSize2 : CGFloat = 50 * 0.4
            if IS_IPHONE_SE {
                fontSize = 45 * 0.35
                fontSize2 = 45 * 0.4
            }

            let para = NSMutableParagraphStyle()
            para.alignment = .center
            para.lineSpacing = 5

            let att1 : [NSAttributedString.Key : NSObject] = [
                NSAttributedString.Key.font : UIFont(name: NanumSquareR, size: fontSize)!,
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                NSAttributedString.Key.paragraphStyle : para
            ]
            let att2 : [NSAttributedString.Key : NSObject] = [
                NSAttributedString.Key.font : UIFont(name: NanumSquareB, size: fontSize)!,
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8392156863, green: 0.07843137255, blue: 0.262745098, alpha: 1),
                NSAttributedString.Key.paragraphStyle : para
            ]
            let att3 : [NSAttributedString.Key : NSObject] = [
                NSAttributedString.Key.font : UIFont(name: NanumSquareB, size: fontSize2)!,
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                NSAttributedString.Key.paragraphStyle : para
            ]

            var attInfos : [(String,[NSAttributedString.Key:NSObject])] = [
                ("행사 당일 행사장 ",att1),
                ("셀프 출력 데스크",att2),
                ("로 가시어\n해당 ",att1),
                ("바코드",att2),
                ("를 등록처에 비치되어 있는\n",att1),
                ("스캐너",att2),
                ("에 스캔하시면 자동으로\n",att1),
                ("명찰이 출력됩니다.\n\n",att2),
                ("출력이 어려우신 분은 등록처로\n문의 주시기 바랍니다.\n\n",att1),
                ("대한이비인후과학회",att3),
            ]
            if IS_IPHONE_SE {
                attInfos = [
                    ("행사 당일 행사장 ",att1),
                    ("셀프 출력 데스크",att2),
                    ("로 가시어\n해당 ",att1),
                    ("바코드",att2),
                    ("를 등록처에 비치되어 있는\n",att1),
                    ("스캐너",att2),
                    ("에 스캔하시면 자동으로\n",att1),
                    ("명찰이 출력됩니다.\n\n",att2),
                    ("출력이 어려우신 분은 등록처로\n문의 주시기 바랍니다.\n\n",att1),
                    ("대한이비인후과학회",att3),
                ]
            }
            self.attributedText = NSMutableAttributedString(stringsInfos: attInfos)
            self.sizeToFit()

        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
