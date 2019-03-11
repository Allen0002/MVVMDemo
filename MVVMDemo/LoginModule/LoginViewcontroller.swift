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
        let model = LoginViewModel.init(username: usernameTextFeild.rx.text.orEmpty.asObservable(), password: passwordTextFeild.rx.text.orEmpty.asObservable(), repeatPassword: repeatPasswordTextField.rx.text.orEmpty.asObservable(),login:signupButton.rx.tap.asObservable())
        
        model.invalidationUsername.bind(to: usernameValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.invalidationPassword.bind(to: passwordValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.invalidationRepeatPassword.bind(to: repeatPasswordValidationLabel.rx.invalidationResult).disposed(by: disposeBag)
        model.loginEnable.bind(to: signupButton.rx.signUpEable).disposed(by: disposeBag)
        
        model.loginTaps.bind(to: tipLabel.rx.callback).disposed(by: disposeBag)
        model.loginTaps.subscribe(onNext: {result in
            print(result)
        }).disposed(by: disposeBag)
    }
}
