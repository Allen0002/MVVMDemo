//
//  BindingExtensions.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/10.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base:UILabel{
    var invalidationResult:Binder<ValidationResult>{
        return Binder(base) { label, result in
            label.textColor = result.textColor
        }
    }
    
    var callback:Binder<LoginModel>{
        return Binder(base) { label, result in
            label.text = result.info
        }
    }
}

extension Reactive where Base: UIButton {
    var signUpEable:Binder<Bool>{
        return Binder(base) { button, enable in
            button.isEnabled = enable
            button.alpha = enable ? 1.0 : 0.5
        }
    }
}
