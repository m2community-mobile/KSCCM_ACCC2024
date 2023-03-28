
import Foundation
import UIKit
import MBProgressHUD

func showPDF(fileURL : URL, inView : UIView, fileName : String? = nil, viewCon : UIViewController){
    appDel.hideHud(animated: false)
    DispatchQueue.main.async {
        appDel.hud = MBProgressHUD.showAdded(to: inView, animated: true)
        if #available(iOS 13.0, *) { appDel.hud?.overrideUserInterfaceStyle = .dark }
        appDel.hud?.mode = .annularDeterminate
        appDel.hud?.button.setTitle("취소", for: .normal)
        appDel.hud?.label.text = "0%"
        
        appDel.hud?.button.addTarget(event: .touchUpInside, buttonAction: { (button) in
            PDF_DownloadCenter.shared.cancel()
            appDel.hud?.hide(animated: true)
        })
    }
    let urlString = fileURL.absoluteString
    var kFileName = fileName
    if kFileName == nil {
        let urlComponents = urlString.components(separatedBy: "/")
        if let lastFileName = urlComponents.last {
            kFileName = lastFileName
        }
    }
    PDF_DownloadCenter.shared.downloadData(url: fileURL , progressUpdate: { (progress:Double) in
        DispatchQueue.main.async {
            if progress >= 0{
                appDel.hud?.progress = Float(progress)
                
                let percentValue = Int(progress * 100)
                appDel.hud?.label.text = "\(percentValue)%"
            }else{
                appDel.hud?.label.text = ""
            }
        }
    }) { (tempURL : URL) in
        
        if let pdfURL = try? savePDF(fileData: Data(contentsOf: tempURL), fileName: kFileName ?? "download.pdf") {
            DispatchQueue.main.async {
                appDel.hud?.hide(animated: true)
                
                let pdfVC = PDFViewController(pdfURL: pdfURL)
                pdfVC.isShareButton = false
                pdfVC.modalPresentationStyle = .fullScreen
                viewCon.present(pdfVC, animated: true, completion: nil)
            }
        }
    }
}



/* using showETC
 showETC(fileURL: url, inView: self) { (fileURL) in
 self.documentInteractionCon = UIDocumentInteractionController(url: fileURL)
 self.documentInteractionCon?.presentOptionsMenu(from: CGRect.zero, in: self, animated: true)
 }
 */

func showETC(fileURL : URL, inView : UIView, fileName : String? = nil, complete:@escaping(_ fileURL:URL) -> Void){
    appDel.hideHud(animated: false)
    DispatchQueue.main.async {
    
        appDel.hud = MBProgressHUD.showAdded(to: inView, animated: true)
        appDel.hud?.mode = .annularDeterminate
        appDel.hud?.button.setTitle("취소", for: .normal)
        appDel.hud?.label.text = "0%"
        
        appDel.hud?.button.addTarget(event: .touchUpInside, buttonAction: { (button) in
            PDF_DownloadCenter.shared.cancel()
            appDel.hud?.hide(animated: true)
        })
    }
    let urlString = fileURL.absoluteString
    var kFileName = fileName
    if kFileName == nil {
        let urlComponents = urlString.components(separatedBy: "/")
        if let lastFileName = urlComponents.last {
            kFileName = lastFileName
        }
    }
    
    PDF_DownloadCenter.shared.downloadData(url: fileURL , progressUpdate: { (progress:Double) in
        DispatchQueue.main.async {
            appDel.hud?.progress = Float(progress)
            
            let percentValue = Int(progress * 100)
            appDel.hud?.label.text = "\(percentValue)%"
        }
    }) { (tempURL : URL) in
        if let fileURL = try? savePDF(fileData: Data(contentsOf: tempURL), fileName: kFileName ?? "download.txt") {
            DispatchQueue.main.async {
                appDel.hud?.hide(animated: true)
                complete(fileURL)
            }
        }
    }
}

func savePDF(fileData : Data, fileName : String) -> URL{
    print("savePDF:\(fileName)")
    let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
    //        try? fileData.write(to: fileURL)
    try? fileData.write(to: fileURL, options: Data.WritingOptions.atomic)
    
    return fileURL
    
}

class PDF_DownloadCenter: NSObject, URLSessionDownloadDelegate {
    
    static let shared : PDF_DownloadCenter = {
        let sharedCenter = PDF_DownloadCenter()
        return sharedCenter
    }()
    
    var currentDataTask : URLSessionDownloadTask?
    var completeFunc : ((_ : URL ) -> Void)?
    var progressUpdateFunc : ((_ : Double ) -> Void)?
    
    func downloadData(url : URL,
                      progressUpdate : @escaping ( _ progress : Double ) -> Void,
                      complete : @escaping ( _ tempUrl : URL ) -> Void ) {
        let sessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        self.currentDataTask = urlSession.downloadTask(with: url)
        self.completeFunc = complete
        self.progressUpdateFunc = progressUpdate
        self.currentDataTask?.resume()
        
        
    }
    
    func cancel(){
        self.currentDataTask?.cancel(byProducingResumeData: { (data) in
            
        })
        self.currentDataTask = nil
        self.progressUpdateFunc = nil
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        self.completeFunc?(location)
        self.completeFunc = nil
        self.progressUpdateFunc = nil
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        let progress = (Double(totalBytesWritten) / Double(totalBytesExpectedToWrite))
        self.progressUpdateFunc?(progress)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
        print(#function)
    }
}


