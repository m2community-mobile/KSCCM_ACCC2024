import Foundation
import UIKit

func showLoginAlert(){
    appDel.leftView?.close()
    
    let alertCon = UIAlertController(title: "로그인", message: "로그인이 필요합니다.\n로그인 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
    alertCon.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: { (action) in
        
    }))
    alertCon.addAction(UIAlertAction(title: "예", style: .default, handler: { (action) in
        DispatchQueue.main.async {
//            goLogin()
        }
    }))
    appDel.topVC?.present(alertCon, animated: true, completion: {
        
    })
}

func loginCheckWithShow(afterIsLogin complete:@escaping ()->Void){
    if !isLogin{
        showLoginAlert()
        return
    }else{
        complete()
    }
}

func contentShow(dataDic : [String:Any]){
    
    if let _ = dataDic[INFO.KEY.IS_REQUIRED_LOGIN] {
        if !isLogin {
            showLoginAlert()
            return
        }
    }
    
    if let _ = dataDic[INFO.KEY.IS_PHOTO_GALLERY] as? String {
        goPhotoGallery()
        return
    }
    
    if let _ = dataDic[INFO.KEY.IS_PROGRAM_AT_A_GLANCE] as? String {
        goPAG()
        return
    }
    
    if let _ = dataDic[INFO.KEY.IS_VOTING] as? String {
        goVoting()
        return
    }
    
    if let _ = dataDic[INFO.KEY.IS_POPUP] as? String,
        let urlString = dataDic[INFO.KEY.URL] as? String {
        goPopUp(urlString: urlString)
        return
    }
    
    if let _ = dataDic[INFO.KEY.IS_OPEN_SAFARI] as? String,
        let urlString = dataDic[INFO.KEY.URL] as? String{
        goOpenSafari(urlString: urlString)
        return
    }
    
    if let _ = dataDic[INFO.KEY.IS_BOOTH_EVENT] as? String{
        goBoothEvent()
        return
    }
    
    if let urlString = dataDic[INFO.KEY.URL] as? String {
        goURL(urlString: urlString)
    }
}

func goPhotoGallery(){
    let vc = PhotoListViewController()

    appDel.naviCon?.popToRootViewController(animated: false)
    appDel.naviCon?.pushViewController(vc, animated: true)
    appDel.leftView?.close()
}

func goURL(urlString : String, popAnimation : Bool = false, pushAnimation : Bool = true ){
    print("goURL urlstring:\(urlString)")

    let webVC = WebViewController()
    webVC.urlString = urlString
    webVC.hideSubTitleView = true

    appDel.naviCon?.popToRootViewController(animated: popAnimation)
    appDel.naviCon?.pushViewController(webVC, animated: pushAnimation)
    appDel.leftView?.close()

}

func goPopUp(urlString : String, popAnimation : Bool = false ){
    let popUpVC = WebPopUpViewController()
    popUpVC.urlString = urlString
    popUpVC.modalPresentationStyle = .fullScreen
    appDel.naviCon?.popToRootViewController(animated: popAnimation)
    appDel.naviCon?.present(popUpVC, animated: true, completion: {

    })
    appDel.leftView?.close()
}

func goOpenSafari(urlString : String, popAnimation : Bool = false ){
    if let url = URL(string: urlString),
        UIApplication.shared.canOpenURL(url) {
        appDel.leftView?.close()
        UIApplication.shared.open(url, options: [:]) { (fi) in }
    }
}

func goPAG(popAnimation : Bool = false, pushAnimation : Bool = true){

    let vc = PAGViewController()

    appDel.naviCon?.popToRootViewController(animated: popAnimation)
    appDel.naviCon?.pushViewController(vc, animated: pushAnimation)
    appDel.leftView?.close()

}

func goVoting(popAnimation : Bool = false, pushAnimation : Bool = true){
    let vc = VotingViewController()
    vc.modalPresentationStyle = .fullScreen
    appDel.leftView?.close()
    appDel.naviCon?.present(vc, animated: true, completion: {

    })
}

//func goQuestion(popAnimation : Bool = false, pushAnimation : Bool = true){
//    let vc = QuestionViewController()
//
//    appDel.leftView?.close()
//    appDel.naviCon?.present(vc, animated: true, completion: {
//
//    })
//}

func goSetting(popAnimation : Bool = false, pushAnimation : Bool = true){
    let nextVC = SettingViewController()
    
    appDel.naviCon?.popToRootViewController(animated: popAnimation)
    appDel.naviCon?.pushViewController(nextVC, animated: pushAnimation)
    appDel.leftView?.close()
}

func goBoothEvent(){
    let vc = BoothEventViewController()

    appDel.naviCon?.popToRootViewController(animated: false)
    appDel.naviCon?.pushViewController(vc, animated: true)
    appDel.leftView?.close()
}
