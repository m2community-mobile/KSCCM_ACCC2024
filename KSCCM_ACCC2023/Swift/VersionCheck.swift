import UIKit

func newVersionCheck( complete:@escaping( _ isNew : Bool, _ urlString : String?) -> Void ) {
    
    guard let bundleId = Bundle.main.bundleIdentifier else {
        complete(false, nil)
        return
    }
    
    let urlString = "http://itunes.apple.com/lookup?bundleId=\(bundleId)&asdf=\(Date().timeIntervalSince1970)"
    print("newVersionCheck urlString : \(urlString)")
    
    let _ = Server.postData(urlString: urlString) { (kData : Data?) in
        if let data = kData {
            if let dataDic = data.toJson() as? [String:Any] {
                print("newVersionCheck dataDic :\(dataDic)")
                
                if let results = dataDic["results"] as? [[String:Any]] {
                    if results.count >= 1 {
                        let firstResultsDic = results[0]
                        if var versionString = firstResultsDic["version"] as? String {
                            versionString = versionString.replacingOccurrences(of: ".", with: "")
                            versionString = versionString.replacingOccurrences(of: " ", with: "")
                            if versionString.count == 2 {
                                versionString = "\(versionString)0"
                            }
                            if let appStoreVersion = Int(versionString, radix: 10) {
                                print("appStoreVersion:\(appStoreVersion)")
                                print("currentAppVersion:\(currentAppVersion())")
                                if appStoreVersion > currentAppVersion() {
                                    if let downloadURLString = firstResultsDic["trackViewUrl"] as? String {
                                        complete(true, downloadURLString)
                                        return
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    complete(false, nil)
    return
}


func currentAppVersion() -> Int {
    
    let infoDic = Bundle.main.infoDictionary
    if var versionString = infoDic!["CFBundleShortVersionString"] as? String {
        versionString = versionString.replacingOccurrences(of: ".", with: "")
        versionString = versionString.replacingOccurrences(of: " ", with: "")
        if versionString.count == 2 {
            versionString = "\(versionString)0"
        }
        if let currentVersion = Int(versionString, radix: 10) {
            return currentVersion
        }
    }
    return 0
}





func versionCheck(){
    newVersionCheck { (isNew : Bool, urlString : String?) in
        if isNew, let newVersionDownloadURLString = urlString,
           let url = URL(string: newVersionDownloadURLString), UIApplication.shared.canOpenURL(url) {
            
            let alertCon = UIAlertController(title: "UPDATE", message: "버전이 업데이트되었습니다.\n앱스토어에서 업데이트 해주세요.", preferredStyle: UIAlertController.Style.alert)
            alertCon.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (fi) in
                        
                    })
                }
            }))
            
            DispatchQueue.main.async {
                appDel.topVC?.present(alertCon, animated: true, completion: { })
            }
        }
    }
}





