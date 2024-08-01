import UIKit

class WebViewController: BaseViewController {
    
    var webView : WebView!
    var urlString = ""
    
    var hideSubTitleView = false
    
    var bottomView : BottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hideSubTitleView {
            self.subTitleView.frame.size.height = 0
        }
        
        //usingBottomView
        bottomView = BottomView()
        self.view.addSubview(bottomView)
        
        //notUsingBottomView
        //        webView = WebView(frame: CGRect(
        //            x: 0,
        //            y: subTitleView.frame.maxY,
        //            width: SCREEN.WIDTH,
        //            height: SCREEN.HEIGHT - subTitleView.frame.maxY - SAFE_AREA), urlString: self.urlString)
        
        //usingBottomView
        webView = WebView(frame: CGRect(
            x: 0,
            y: subTitleView.frame.maxY,
            width: SCREEN.WIDTH,
            height: bottomView.frame.minY - subTitleView.frame.maxY), urlString: self.urlString)
        webView.motherVC = self
        self.view.addSubview(webView)
        
        let underBar = UIView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: 0.5))
        underBar.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1).withAlphaComponent(0.5)
        self.view.addSubview(underBar)
        
    }
    
}