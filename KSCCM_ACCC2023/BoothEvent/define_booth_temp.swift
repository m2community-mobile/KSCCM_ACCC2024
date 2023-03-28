//
//  define_booth_temp.swift
//
//  Created by JinGu on 2022/09/25.
//

import Foundation

let USER_BARCODE = "USER_BARCODE"
var user_barcode : String {
    get{
        if let value = userD.object(forKey: USER_BARCODE) as? String {
            return "\(value)A"
        }else{
            return ""
        }
    }
}

//var user_id : String {
//    get{
//         return regist_id
//    }
//}

