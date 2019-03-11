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
    let invalidationUsername: Observable<ValidationResult>
    let invalidationPassword: Observable<ValidationResult>
    let invalidationRepeatPassword: Observable<ValidationResult>
    
    let loginEnable: Observable<Bool>
    let loginTaps: Observable<LoginModel>
    
    init(username:Observable<String>,
         password: Observable<String>,
         repeatPassword: Observable<String>,
         login:Observable<Void>
         ) {
        invalidationUsername = username.flatMapLatest({ username in
            return ValidationImplementation.validationUsername(username)
        })
        
        invalidationPassword = password.flatMapLatest({ pwd in
            return ValidationImplementation.validationPassword(pwd)
        })
        
        invalidationRepeatPassword = Observable.combineLatest(password, repeatPassword).flatMapLatest({password,repeatPassword in
            return ValidationImplementation.validationRepeatPassword(password, repeatPwd: repeatPassword)
        })
        
        let usernameAndPassword = Observable.combineLatest(username, password)
        loginTaps = login.withLatestFrom(usernameAndPassword).flatMapLatest{ name, pwd in
            return ServerAPI.signUp(name, password: pwd)
        }
        
        loginEnable = Observable.combineLatest(invalidationUsername, invalidationRepeatPassword, invalidationRepeatPassword).map({ username,password,repeatPassword in
            return username.isValid && password.isValid && repeatPassword.isValid
        })
    }
}
