import UIKit
import RxSwift
import RxCocoa

class LoginViewcontroller: BaseViewController {
    
    @IBOutlet weak var usernameTextFeild: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordValidationLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = LoginViewModel.init(username: usernameTextFeild.rx.text.orEmpty.asDriver(), password: passwordTextFeild.rx.text.orEmpty.asDriver(), repeatPassword: repeatPasswordTextField.rx.text.orEmpty.asDriver(),login:signupButton.rx.tap.asDriver())
        
        model.invalidationUsername.drive(usernameValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.invalidationPassword.drive(passwordValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.invalidationRepeatPassword.drive(repeatPasswordValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.loginEnable.drive(signupButton.rx.signUpEable).disposed(by: disposeBag)
        
        model.loginTaps.drive(tipLabel.rx.callback).disposed(by: disposeBag)
        model.loginTaps.drive(onNext: {result in
            print(result)
        }).disposed(by: disposeBag)
    }
}
