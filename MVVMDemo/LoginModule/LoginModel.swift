//
//  LoginModel.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/11.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit

enum ValidationResult {
    case failed(message:String)
    case success
    case empty
    
    var textColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty,.failed:
            return UIColor.red
        }
    }
    
    var isValid:Bool {
        switch self {
        case .success:
            return true
        case .empty,.failed:
            return false
        }
    }
    
    var result: [String: Any]? {
        return nil
    }
}

struct LoginModel {
    var statusCode:Int
    var info:String
    init(statusCode:Int,info:String) {
        self.info = info
        self.statusCode = statusCode
    }
}
