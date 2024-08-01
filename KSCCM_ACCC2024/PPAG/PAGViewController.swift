import UIKit

class PAGViewController: BaseViewController {
    
    //usingBottomView
    var bottomView : BottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subTitleLabel.text = "Program at a Glance"
        
        //usingBottomView
        bottomView = BottomView()
        self.view.addSubview(bottomView)
        
        //notUsingBottomView
        //        let pagView = PAGView(
        //            frame: CGRect(
        //                x: 0,
        //                y: self.subTitleView.frame.maxY,
        //                width: SCREEN.WIDTH,
        //                height: SCREEN.HEIGHT - self.subTitleView.frame.maxY - SAFE_AREA),
        //            kSubTitleView: self.subTitleView,
        //            kSubTitleLabel: self.subTitleLabel,
        //            kBackButtonimageView: self.backButtonimageView,
        //            kMotherVC: self)
        
        //usingBottomView
        let pagView = PAGView(
            frame: CGRect(
                x: 0,
                y: self.subTitleView.frame.maxY,
                width: SCREEN.WIDTH,
                height: bottomView.frame.minY - self.subTitleView.frame.maxY),
            kSubTitleView: self.subTitleView,
            kSubTitleLabel: self.subTitleLabel,
            kBackButtonimageView: self.backButtonimageView,
            kMotherVC: self)
        
        self.view.addSubview(pagView)
        
    }
    
}
