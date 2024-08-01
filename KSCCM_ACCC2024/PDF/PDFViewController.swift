//How to using
//func openPDF(){
//    if let pdfURL = Bundle.main.url(forResource: "swift", withExtension: "pdf") {
//        let pdfVC = PDFViewController(pdfURL: pdfURL)
//        pdfVC.isShareButton = true //option
//        pdfVC.modalPresentationStyle = .fullScreen
//        self.present(pdfVC, animated: true, completion: nil)
//    }
//}


import UIKit
import PDFKit

class PDFViewController: UIViewController {

    var topToolBar = UIToolbar()
    var bottomToolBar = UIToolbar()
    
    let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(cancelItemPressed))
    let shareItem = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(shareItemPressed))
    
    var pdfURL : URL?
    var document : PDFDocument?
    var pdfView = PDFView()
    var thumbnailView = PDFThumbnailView()
    
    init(pdfURL : URL) {
        if let kDocument = PDFDocument(url: pdfURL) {
            self.pdfURL = pdfURL
            self.document = kDocument
            self.pdfView.document = document
        }
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
        
        self.setToolBar()
        self.setPdfView()
        self.setThumbnailView()
        self.setPageInfoView()
    }
    
    var isShareButton : Bool = true {
        willSet(newIsShareButton) {
            self.topToolBar.items = newIsShareButton ? [cancelItem,flexibleSpaceItem,shareItem] : [cancelItem,flexibleSpaceItem]
        }
    }
    
    func setToolBar(){
        
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let topInset = appDel.window?.safeAreaInsets.top ?? 20
        let bottomInset = appDel.window?.safeAreaInsets.bottom ?? 0
        
        topToolBar.frame = CGRect(x: 0, y: topInset, width: UIScreen.main.bounds.size.width, height: UINavigationController().navigationBar.frame.size.height)
        topToolBar.barTintColor = UIColor.white
        topToolBar.barStyle = .black
        self.view.addSubview(topToolBar)

        topToolBar.items = [cancelItem,flexibleSpaceItem,shareItem]
        
        bottomToolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UINavigationController().navigationBar.frame.size.height * 1.5)
        bottomToolBar.frame.origin.y = UIScreen.main.bounds.size.height - bottomToolBar.frame.size.height - bottomInset
        bottomToolBar.barTintColor = UIColor.white
        self.view.addSubview(bottomToolBar)
        
    }
    
    func setPdfView(){
        
        func findScrollView(targetView : UIView) -> UIScrollView? {
            for kSubView in targetView.subviews {
                if let scrollView = kSubView as? UIScrollView {
                    return scrollView
                }
                return findScrollView(targetView: kSubView)
            }
            return nil
        }
        
        self.pdfView.frame = CGRect(x: 0, y: topToolBar.frame.maxY, width: UIScreen.main.bounds.size.width, height: bottomToolBar.frame.minY - topToolBar.frame.maxY)
        self.pdfView.displayMode = .singlePageContinuous
        self.pdfView.displayDirection = .horizontal
        self.pdfView.usePageViewController(true, withViewOptions: [:])
        self.pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.view.addSubview(self.pdfView)
        
        findScrollView(targetView: self.pdfView)?.showsHorizontalScrollIndicator = false
        
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.PDFViewPageChanged, object: nil, queue: nil) { (noti:Notification) in
            
            if let currentPage = self.pdfView.currentPage?.pageRef?.pageNumber,
               let totalPage = self.pdfView.document?.pageCount {
                DispatchQueue.main.async {
                    self.pageInfoLabel.text = "\(currentPage) / \(totalPage)"
                }
            }
        }
        
    }
    
    func setThumbnailView(){
        thumbnailView.frame = bottomToolBar.bounds
        thumbnailView.pdfView = pdfView
        thumbnailView.layoutMode = .horizontal
        let thumbnailSizeHeight = bottomToolBar.bounds.height * 0.7
        let thumbnailSizeWidth = thumbnailSizeHeight * 80 / 100
        thumbnailView.thumbnailSize = CGSize(width: thumbnailSizeWidth, height: thumbnailSizeHeight)
        thumbnailView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        bottomToolBar.addSubview(thumbnailView)
    }
    
    var pageInfoLabel = UILabel()
    func setPageInfoView(){
        
        let totalPage = self.pdfView.document?.pageCount ?? 0
        
        pageInfoLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        pageInfoLabel.font = UIFont.systemFont(ofSize: 15)
        pageInfoLabel.textAlignment = .center
        pageInfoLabel.text = "\(totalPage) / \(totalPage)"
        pageInfoLabel.sizeToFit()
        pageInfoLabel.text = totalPage == 0 ? "0 / 0" : "1 / \(totalPage)"
        pageInfoLabel.frame.size.width += 10
        pageInfoLabel.frame.size.height += 5
        pageInfoLabel.frame.origin.y = bottomToolBar.frame.minY - pageInfoLabel.frame.size.height - 5
        pageInfoLabel.center.x = self.view.frame.size.width / 2
        pageInfoLabel.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        pageInfoLabel.textColor = UIColor.gray
        pageInfoLabel.layer.cornerRadius = 3
        pageInfoLabel.clipsToBounds = true
        self.view.addSubview(pageInfoLabel)
    }
    
    @objc func cancelItemPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    var documentInteractionCon : UIDocumentInteractionController?
    @objc func shareItemPressed(){
        if let fileURL = self.pdfURL {
            self.documentInteractionCon = UIDocumentInteractionController(url: fileURL)
            self.documentInteractionCon?.presentOptionsMenu(from: self.shareItem, animated: true)
        }
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
      }
}
