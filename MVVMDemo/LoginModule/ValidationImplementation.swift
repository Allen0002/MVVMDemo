//
//  ValidationImplementation.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/10.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationImplementation {
    static func validationUsername(_ name: String) -> Observable<ValidationResult>{
        if name.isEmpty {
            return Observable.just(ValidationResult.empty)
        }
        
        if name.count < 3 {
            return Observable.just(ValidationResult.failed(message: "username count must be more than 3 character"))
        }
        
        return ServerAPI.userAvailable(name).map({ aviable in
            if aviable {
                return ValidationResult.success
            }else{
                return ValidationResult.failed(message: "server 404")
            }
        })
    }
    
    static func validationPassword(_ pwd:String) -> Observable<ValidationResult>{
        if pwd.isEmpty {
            return Observable.just(ValidationResult.empty)
        }
        if pwd.count < 6 {
            return Observable.just(ValidationResult.failed(message: "username count must be more than 6 character"))
        }
        return Observable.just(ValidationResult.success)
    }
    
    static func validationRepeatPassword(_ password: String,repeatPwd:String) -> Observable<ValidationResult>{
        if repeatPwd.count == 0 {
            return Observable.just(ValidationResult.empty)
        }
        if password == repeatPwd{
            return Observable.just(ValidationResult.success)
        }else{
            return Observable.just(ValidationResult.failed(message: "repeatPassword must be equal to password"))
        }
    }
}
