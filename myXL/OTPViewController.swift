import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var otpText1: UITextField!
    @IBOutlet weak var otpText2: UITextField!
    @IBOutlet weak var otpText3: UITextField!
    @IBOutlet weak var otpText4: UITextField!
    @IBOutlet weak var otpText5: UITextField!
    @IBOutlet weak var otpText6: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!

    // Variable untuk menyimpan nomor HP yang diterima
    var phoneNumber: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menampilkan nomor HP pada label
        if let number = phoneNumber {
            phoneNumberLabel.text = "Nomor Anda adalah: \(number)"
        }
        
        // Memulai timer
        startTimer()

        // Menyiapkan TextField untuk input OTP
        setupOTPTextFields()
    }

    // Fungsi untuk memulai timer hitungan mundur
    func startTimer() {
        var remainingTime = 60
        timerLabel.text = "Kirim ulang dalam \(remainingTime) detik"

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if remainingTime > 0 {
                remainingTime -= 1
                self.timerLabel.text = "Kirim ulang dalam \(remainingTime) detik"
            } else {
                timer.invalidate()
                self.resendButton.isEnabled = true // Aktifkan tombol kirim ulang setelah waktu habis
                self.timerLabel.text = "Kirim ulang sekarang"
            }
        }
    }


    func setupOTPTextFields() {
        otpText1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otpText2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otpText3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otpText4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otpText5.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otpText6.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    // Fungsi untuk berpindah TextField ketika pengguna mengetik
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count >= 1 {
            switch textField {
            case otpText1:
                otpText2.becomeFirstResponder()
            case otpText2:
                otpText3.becomeFirstResponder()
            case otpText3:
                otpText4.becomeFirstResponder()
            case otpText4:
                otpText5.becomeFirstResponder()
            case otpText5:
                otpText6.becomeFirstResponder()
            case otpText6:
                otpText6.resignFirstResponder()
            default:
                break
            }
        }
    }

    // Aksi tombol kirim ulang
    @IBAction func resendButtonPressed(_ sender: Any) {
        print("Kode OTP dikirim ulang.")
        startTimer() // Memulai ulang timer setelah kode dikirim ulang
    }

    // Aksi tombol submit
    @IBAction func submitButtonPressed(_ sender: Any) {

        print("Kode OTP disubmit.")
    }
}
