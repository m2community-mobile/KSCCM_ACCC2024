
/*
 pod 'Toaster', '2.3.0'
 */

import Foundation
import Toaster

class ToastViewCenter: NSObject {
    
    static let shared : ToastViewCenter = {
        print("ToastViewCenterInit")
        let sharedCenter = ToastViewCenter()
        ToastView.appearance().bottomOffsetPortrait = UIScreen.main.bounds.size.height * 0.3
        ToastView.appearance().font = UIFont.systemFont(ofSize: 20)
        return sharedCenter
    }()
    
    func show(text:String) {
        print("show")
        Toast(text: text).show()
    }
}


func toastShow( message : String ){
    print("toastShow")
    ToastViewCenter.shared.show(text: message)
}
