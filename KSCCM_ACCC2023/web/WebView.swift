import UIKit
import WebKit
import MessageUI
import TUSafariActivity

class WebView: UIView
,WKNavigationDelegate , WKUIDelegate//, WKScriptMessageHandler
    ,UIGestureRecognizerDelegate
{

    let isShowableTypes = ["jpeg","jpg","doc","docx","png","ppt","pptx","xlsx","xls"]
    let notShowableTypes = ["hwp","gif","ai","zip"]
    
    var documentInteractionCon : UIDocumentInteractionController?
    weak var motherVC : UIViewController?
    
    var wkWebView : WKWebView!
    var urlString = ""
    
    var glanceSubTitleString = "Program"
    var boothEvnetNoticeView : BoothEvnetNoticeView?

    init(frame: CGRect, urlString : String) {
        super.init(frame: frame)
        
        print("WebView url:\(urlString)")
    
        self.backgroundColor = UIColor.white
        
        self.wkWebView = WKWebView(frame: self.bounds)
        self.wkWebView.allowsLinkPreview = false
        self.wkWebView.uiDelegate = self
        self.wkWebView.navigationDelegate = self
        self.wkWebView.scrollView.bounces = false
        self.addSubview(self.wkWebView)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longGesture.delegate = self
        self.wkWebView.addGestureRecognizer(longGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPress(gesture:)))
        tapGesture.delegate = self
        self.wkWebView.addGestureRecognizer(tapGesture)
        
        self.urlString = urlString
        self.reloading()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (noti : Notification) in
                let nextPoint = CGPoint(x: 0, y: self.wkWebView.scrollView.contentSize.height - self.wkWebView.scrollView.frame.size.height)
                if self.wkWebView.scrollView.contentOffset.y > nextPoint.y {
                    self.wkWebView.scrollView.setContentOffset(nextPoint, animated: true)
                }
            }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
      }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func tapPress( gesture : UILongPressGestureRecognizer ){
        print("tapPress")
        self.endEditing(true)
    }
    @objc func longPress( gesture : UILongPressGestureRecognizer ){

        if gesture.state == .began {
            print("longPress began")

            self.wkWebView.readImageFrom(point: CGPoint(x: self.lastX, y: self.lastY)) { (image) in
                if let image = image {
                    print("이미지 있음")
                    
                    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                        
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Save Image", style: UIAlertAction.Style.default, handler: { (action) in
                        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    }))
                    DispatchQueue.main.async {
                        self.motherVC?.present(actionSheet, animated: true, completion: {
                            
                        })
                    }
                    
                }
            }
            
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error{
            print("save image fail \(error.localizedDescription)")
        }else{
            toastShow(message: "Complete.")
        }
    }
    

    
    func reloading(){
        
        var newURLString = self.urlString.addParameterToURLString(key: "deviceid", value: deviceID)
        newURLString = newURLString.addParameterToURLString(key: "device", value: "IOS")
        newURLString = newURLString.addPercenterEncoding()
        
        if let url = URL(string: newURLString) {
            let request = URLRequest(url: url)
//            if isLogin { //add Cookie
//                request.httpMethod = "POST"
//                request.addValue("member_id=\(member_id); member_level=\(member_level)", forHTTPHeaderField: "Cookie")
//            }
            self.wkWebView.load(request)
        }else{
            print("urlError : \(urlString)")
            toastShow(message: "Check your internet connection.")
        }
    }
    
    var lastX : CGFloat = 0
    var lastY : CGFloat = 0
    
    //MARK:WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        print("createWebViewWith:\(String(describing: navigationAction.request.url?.absoluteString))")
        if let absoluteString = navigationAction.request.url?.absoluteString {
            self.urlString = absoluteString
            self.reloading()
        }
        
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
    
//        print("decidePolicyFor navigationAction:\(String(describing: navigationAction.request.url?.absoluteString))")
        
        if let absoluteString = navigationAction.request.url?.absoluteString {
            
            let components: [String] = absoluteString.components(separatedBy: ":")
            if (components.count > 1 && components[0] == "myweb") {
                if (components[1] == "touch") {
                    if (components[2] == "start") {
                        if let ptX = Float(components[3]), let ptY = Float(components[4]) {
//                            print("\(ptX),\(ptY)")
                            self.lastX = CGFloat(ptX)
                            self.lastY = CGFloat(ptY)
                            decisionHandler(.cancel); return
                        }
                    }
                }
            }
            print("absoluteString:\(absoluteString)")
            
            if absoluteString.contains("download.php"){
                //로딩 시작
                appDel.showHud()

                //파일 네임을 읽어오자
                Server.readFileName(urlString: urlString) { (fileName : String) in
                    //파일 네임을 읽어오는것에 대한 로딩 제거
                    appDel.hideHud()
                    let fileComponents = fileName.components(separatedBy: ".")
                    if fileComponents.count >= 2 {
                        let lastComponent = fileComponents[fileComponents.count - 1]
                        if lastComponent.lowercased() == "pdf" {    //PDF
                            if let url = URL(string: absoluteString), let motherVC = self.motherVC {
                                showPDF(fileURL: url, inView: self, fileName: fileName, viewCon: motherVC)
                                return
                            }
                        }else if self.isShowableTypes.contains(lastComponent.lowercased()){
                            let popUpVC = WebPopUpViewController()
                            popUpVC.urlString = absoluteString
                            popUpVC.modalPresentationStyle = .fullScreen
                            self.motherVC?.present(popUpVC, animated: true, completion: {
                                
                            })
                            return
                        }else {
                            if let url = URL(string: absoluteString) {
                                var newFileName = fileName
                                if let removeEncodingFileName = fileName.removingPercentEncoding {
                                    newFileName = removeEncodingFileName
                                }
                                showETC(fileURL: url, inView: self, fileName: newFileName) { (fileURL) in
                                    self.documentInteractionCon = UIDocumentInteractionController(url: fileURL)
                                    self.documentInteractionCon?.presentOptionsMenu(from: CGRect.zero, in: self, animated: true)
                                }
                                return
                            }
                        }
                    }
                }
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("session/social.php") {
                
                if let url = navigationAction.request.url {
                
                    let parameters = url.parameters
                    let title = parameters["title"] as? String ?? ""
                    var parameterStrings = [String]()
                    parameters.forEach {
                        parameterStrings.append("\($0.key)=\($0.value as? String ?? "")")
                    }
                    let parameterString = parameterStrings.joined(separator: "&")
                    let newURL = "https://ezv.kr:4447/s/schem.php?\(parameterString)".addPercenterEncoding()
                    print("newURL:\(newURL)")
                    
                    appDel.showHud()
                    Server.makeShotURL(urlString: newURL) {
                        appDel.hideHud()
                        if let shotURL = $0 {
                            let shareContent = "- \(APP_NAME)\n- \(title)\n\(shotURL)"
                            print("shareContent:\n\(shareContent)")
                            let activity = TUSafariActivity()
                            let activityVC = UIActivityViewController(activityItems: [shareContent], applicationActivities: [activity])
                            DispatchQueue.main.async {
                                self.motherVC?.present(activityVC, animated: true, completion: { })
                            }
                            
                        }
                    }
                }
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("app_question.php") {
                let parameterDic = absoluteString.parameterFromURL()
                if let sid = parameterDic["sid"] {
                    let appQuestionVC = QuestionViewController()
                    appQuestionVC.session_sid = sid
                    appQuestionVC.modalPresentationStyle = .fullScreen
                    self.motherVC?.present(appQuestionVC, animated: true, completion: { })
                }
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("tel:") {
                let newURLString = absoluteString.replacingOccurrences(of: "tel:", with: "tel://")
                if let callUrl = URL(string: newURLString) {
                    UIApplication.shared.open(callUrl, options: [:]) { (fi) in
                        
                    }
                }
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("blob:"){
                print("blob: urlString : \(absoluteString)")
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("session/view.php") {
                decisionHandler(.allow); return
            }
            
            if absoluteString.contains("vimeo") {
                decisionHandler(.allow); return
            }
            
            if absoluteString.contains("glance_sub.php") {
                print("glance_sub.php")
                let glanceSubPopUpWC = GlanceSubWebController()
                glanceSubPopUpWC.glanceSubTitleString = self.glanceSubTitleString
                var newURL = absoluteString
                if !newURL.contains("title=") {
                    newURL = "\(newURL)&title=\(self.glanceSubTitleString)".addPercenterEncoding()
                }
                glanceSubPopUpWC.urlString = newURL
                glanceSubPopUpWC.modalPresentationStyle = .fullScreen
                self.motherVC?.present(glanceSubPopUpWC, animated: true, completion: {
                    
                })
                decisionHandler(.cancel)
                return
            }
            
//            if absoluteString.contains("glance.php") {
//                //                goPAG()
//                decisionHandler(.cancel); return
//            }
            
            if absoluteString.contains("back.php"){
                if let boothEvnetNoticeView = self.boothEvnetNoticeView {
                    boothEvnetNoticeView.removeFromSuperview()
                    decisionHandler(.cancel); return
                }
                if self.wkWebView.canGoBack {
                    self.wkWebView.goBack()
                    decisionHandler(.cancel); return
                }else{
                    appDel.naviCon?.popViewController(animated: true)
                    decisionHandler(.cancel); return
                }
            }
            if absoluteString.contains("close.php"){
                if let naviCon = self.motherVC?.navigationController {
                    naviCon.popViewController(animated: true)
                }else{
                    self.motherVC?.dismiss(animated: true, completion: {
                        
                    })
                }
                decisionHandler(.cancel); return
            }
            
            if absoluteString.contains("add_alarm.php") {
                print("addAlarm - \(absoluteString)")
                
                let urlComponnents = absoluteString.components(separatedBy: "?")
                if urlComponnents.count == 2 {
                    let parameterString = urlComponnents[1]
                    let parameterComponents = parameterString.components(separatedBy: "&")
                    var parameterDic = [String:String]()
                    for i in 0..<parameterComponents.count {
                        let parameters = parameterComponents[i].components(separatedBy: "=")
                        if parameters.count == 2{
                            parameterDic[parameters[0]] = parameters[1]
                        }
                    }
                    print("parameterDic:\(parameterDic)")
                    
                    NotiCenter.shared.addAlram(dataDic: parameterDic) { (success) in
                        DispatchQueue.main.async {
                            if success {
                                toastShow(message: "Add alarm complete.")
                            }else{
                                //                                toastShow(message: "Add Alram is fail. Retry after few minite.")
                            }
                        }
                    }
                }
                decisionHandler(.cancel); return
            }
            if absoluteString.contains("remove_alarm.php") {
                print("removeAlram - \(absoluteString)")
                
                let urlComponnents = absoluteString.components(separatedBy: "?")
                if urlComponnents.count == 2 {
                    let parameterString = urlComponnents[1]
                    let parameterComponents = parameterString.components(separatedBy: "&")
                    var parameterDic = [String:String]()
                    for i in 0..<parameterComponents.count {
                        let parameters = parameterComponents[i].components(separatedBy: "=")
                        if parameters.count == 2{
                            parameterDic[parameters[0]] = parameters[1]
                        }
                    }
                    print("parameterDic:\(parameterDic)")
                    
                    if let sid = parameterDic["sid"] {
                        NotiCenter.shared.removeAlram(id: sid)
                        toastShow(message: "Remove alarm complete.")
                    }
                    
                }
                decisionHandler(.cancel); return
            }
        
            let urlComponents = absoluteString.components(separatedBy: ".")
            if let lastComponent = urlComponents.last {
//                print("lastComponent:\(lastComponent)")
                
                if absoluteString.contains("mailto") {
                    if MFMailComposeViewController.canSendMail() {
                        let mailVC = MFMailComposeViewController()
                        if let mailURLString = absoluteString.subString(from: "mailto:".count) {
                            mailVC.setToRecipients([mailURLString])
                            mailVC.mailComposeDelegate = self
                            mailVC.modalPresentationStyle = .fullScreen
                            self.motherVC?.present(mailVC, animated: true, completion: { })
                        }
                    }else{
                        print("메일 설정이 안되어있음")
                        DispatchQueue.main.async {
                            toastShow(message: "Mail is not set up.\nPlease set up mail through the Settings app.")
                        }
                    }
                    decisionHandler(.cancel)
                    return
                }else if lastComponent.lowercased() == "pdf" {
                    let pdfURLString = absoluteString.addPercenterEncoding()
                    if let url = URL(string: pdfURLString), let motherVC = self.motherVC {
                        showPDF(fileURL: url, inView: self, fileName: nil, viewCon: motherVC)
                        decisionHandler(.cancel)
                        return
                    }
                }else if isShowableTypes.contains(lastComponent.lowercased()){
                    let popUpVC = WebPopUpViewController()
                    popUpVC.urlString = absoluteString
                    popUpVC.modalPresentationStyle = .fullScreen
                    self.motherVC?.present(popUpVC, animated: true, completion: {
                        
                    })
                    decisionHandler(.cancel)
                    return
                }else if notShowableTypes.contains(lastComponent.lowercased()){
                    let fileURLString = absoluteString.addPercenterEncoding()
                    if let url = URL(string: fileURLString) {
                        showETC(fileURL: url, inView: self, fileName: nil) { (fileURL) in
                            self.documentInteractionCon = UIDocumentInteractionController(url: fileURL)
                            self.documentInteractionCon?.presentOptionsMenu(from: CGRect.zero, in: self, animated: true)
                        }
                        decisionHandler(.cancel)
                        return
                    }
                }
            }
        
            if !absoluteString.contains(URL_KEY.BASE_URL) && !absoluteString.contains(URL_KEY.EZV_URL){
                //about:blank
                if absoluteString.contains("https://www.google.com/maps") || absoluteString.contains("about:blank"){
                    decisionHandler(.allow)
                    return
                }
                
                print("not contains")
                
                if let url = URL(string: absoluteString) {
                    UIApplication.shared.open(url, options: [:]) { (fi) in }
                    decisionHandler(.cancel)
                    return
                }
                
//                let popUpVC = WebPopUpViewController()
//                popUpVC.urlString = absoluteString
//                popUpVC.modalPresentationStyle = .fullScreen
//                self.motherVC?.present(popUpVC, animated: true, completion: {
//
//                })
//                decisionHandler(.cancel)
//                return
            }
        }
        
        decisionHandler(.allow)
    }

    func webViewDidClose(_ webView: WKWebView){
//        print(#function)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView){
//        print(#function)
    }


    //MARK:WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
//        print(#function)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!){
//        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
//        print(#function)
        print("error : \(error.localizedDescription)")
//        self.endEditing(true)

    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        print(#function)
        
        webView.touchCalloutNone()
        
        let kTouchJavaScriptString: String = """
document.ontouchstart=function(event){
x=event.targetTouches[0].clientX;
y=event.targetTouches[0].clientY;
document.location=\"myweb:touch:start:\"+x+\":\"+y;
};
"""
        webView.evaluateJavaScript(kTouchJavaScriptString) { (result : Any?, error : Error?) in  }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
//        print(#function)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        appDel.showAlert(title: "Notice", message: message)
        
        completionHandler()
    }
    
    
    var confirmPanelValue = 0
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        self.confirmPanelValue = 0
        
        let alertCon = UIAlertController(title: "Notice", message: message, preferredStyle: UIAlertController.Style.alert)
        alertCon.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) in
            self.confirmPanelValue = 1
        }))
        alertCon.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in
            self.confirmPanelValue = 2
        }))
        self.motherVC?.present(alertCon, animated: true, completion: {})
        
        while confirmPanelValue == 0 {
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.01))
        }
        
        if confirmPanelValue == 1 {
            completionHandler(true)
        }else{
            completionHandler(false)
        }
        
        
    }
    
//    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//
//
//        completionHandler(nil)
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WebView : MFMailComposeViewControllerDelegate,UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            
        }
    }
}


extension WKWebView {
    
    func readImageFrom(point : CGPoint, complete:@escaping(_ image : UIImage?) -> Void ) {
        
        let js = "document.elementFromPoint(\(point.x), \(point.y)).tagName"
        var tagName = ""
        
        self.evaluateJavaScript(js) { (result : Any?, error : Error?) in
            tagName = result as? String ?? ""
            if tagName == "IMG" {
                print("tagName == IMG")
                var imageURLString = ""
                self.evaluateJavaScript("document.elementFromPoint(\(point.x), \(point.y)).src") { (result : Any?, error : Error?) in
                    imageURLString = result as? String ?? ""
                    //                    print("imageURLString:\(imageURLString)")
                    
                    if let imageURL = URL(string: imageURLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!){
                        if let imageData = try? Data(contentsOf: imageURL) {
                            if let image = UIImage(data: imageData) {
                                complete(image)
                                return
                            }
                        }
                    }
                }
            }
            
            complete(nil)
            return
        }
    }
    
    func touchCalloutNone(){
        let javaCode = "document.body.style.webkitTouchCallout='none';"
        self.evaluateJavaScript(javaCode)  { (result : Any?, error : Error?) in
            print("after touchCalloutNone")
            if let error = error {
                print("error : \(error.localizedDescription)")
            }
        }
    }
}

