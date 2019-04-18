//
//  ServerAPI.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/10.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ServerAPI {
    /// 模拟检查用户名重复
    static func userAvailable(_ username:String) -> Observable<Bool>{
        let result = Int.random(in: (0...20)) % 10 == 0 ? false : true
        return Observable.just(result).catchErrorJustReturn(false)
    }
    /// 模拟登录成功
    static func signUp(_ username:String, password:String) -> Observable<LoginModel>{
        var result: LoginModel {
            let model = LoginModel.init(statusCode: 200, info: "Login Success")
            return model
        }
        
        var error: LoginModel {
            let model = LoginModel.init(statusCode: 404, info: "server is avalid")
            return model
        }
        return Observable.just(result).delay(2.9, scheduler: MainScheduler.instance).catchErrorJustReturn(error)
    }
}
