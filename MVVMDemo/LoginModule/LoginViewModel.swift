//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/10.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel{
    let invalidationUsername: Driver<ValidationResult>
    let invalidationPassword: Driver<ValidationResult>
    let invalidationRepeatPassword: Driver<ValidationResult>
    
    let loginEnable: Driver<Bool>
    let loginTaps: Driver<LoginModel>
    
    init(username:Driver<String>,
         password: Driver<String>,
         repeatPassword: Driver<String>,
         login:Driver<Void>
         ) {
        
        invalidationUsername = username.flatMapLatest { username in
            return ValidationImplementation.validationUsername(username)
                .asDriver(onErrorJustReturn: .failed(message: "Error"))
        }
        
        invalidationPassword = password.flatMapLatest({ pwd in
            return ValidationImplementation.validationPassword(pwd).asDriver(onErrorJustReturn: .failed(message: "Error"))
        })
        
        invalidationRepeatPassword = Driver.combineLatest(password, repeatPassword).flatMapLatest({password,repeatPassword in
            return ValidationImplementation.validationRepeatPassword(password, repeatPwd: repeatPassword).asDriver(onErrorJustReturn: .failed(message: "Error"))
        })
        
        let usernameAndPassword = Driver.combineLatest(username, password)
        loginTaps = login.withLatestFrom(usernameAndPassword).flatMapLatest{ (arg) -> SharedSequence<DriverSharingStrategy, LoginModel> in
            
            let (_, _) = arg
            return ServerAPI.signUp(arg.0, password: arg.1).asDriver(onErrorJustReturn: LoginModel.init(statusCode: 404, info: "error"))
        }
        
        loginEnable = Driver.combineLatest(invalidationUsername, invalidationRepeatPassword, invalidationRepeatPassword).map({ username,password,repeatPassword in
            return username.isValid && password.isValid && repeatPassword.isValid
        })
    }
}
