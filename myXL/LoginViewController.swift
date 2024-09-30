import UIKit

class LoginViewController: UIViewController, MyLoginViewProtocol {
    @IBOutlet weak var nomorHp: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let msisdn = nomorHp.text else { return }
        presenter?.handleLogin(msisdn: msisdn)
    }

    func navigateToOTP(with msisdn: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
            otpVC.phoneNumber = msisdn // Mengirimkan nomor hp ke OTPViewController
            navigationController?.pushViewController(otpVC, animated: true)
        }
    }

    func displayError(message: String) {
        print("Error: \(message)")
    }
}

