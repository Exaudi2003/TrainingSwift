import Quick
import Nimble
@testable import myXL

class LoginPresenterSpec: QuickSpec {
    override class func  spec () {
        describe("LoginPresenter") {
            var presenter: LoginPresenter!
            var mockView: MockLoginView!
            var mockInteractor: MockLoginInteractor!

            beforeEach {
                mockView = MockLoginView()
                mockInteractor = MockLoginInteractor()
                presenter = LoginPresenter(view: mockView)
                presenter.interactor = mockInteractor
            }

            context("ketika handleLogin dipanggil dengan MSISDN valid") {
                it("menyimpan MSISDN dan menavigasi ke OTP") {
                    let msisdn = "08123456789"
                    
                    presenter.handleLogin(msisdn: msisdn)
                    
                    expect(mockInteractor.savedMsisdn).to(equal(msisdn))
                    expect(mockView.navigatedToOTP).to(beTrue())
                }
            }

            context("ketika handleLogin dipanggil dengan MSISDN kosong") {
                it("menampilkan error") {
                    presenter.handleLogin(msisdn: "")
                    
                    expect(mockView.errorMessage).to(equal("MSISDN tidak boleh kosong"))
                }
            }
        }
    }
}

// Mock class untuk View
class MockLoginView: MyLoginViewProtocol {
    var navigatedToOTP = false
    var errorMessage: String?

    func navigateToOTP(with msisdn: String) {
        navigatedToOTP = true
    }

    func displayError(message: String) {
        errorMessage = message
    }
}

// Mock class untuk Interactor
class MockLoginInteractor: LoginInteractorProtocol {
    var savedMsisdn: String?

    func saveMsisdn(msisdn: String) {
        savedMsisdn = msisdn
    }

    func fetchBitcoinPrice(completion: @escaping (Double?) -> Void) {
        completion(nil) // Simulasi tanpa harga bitcoin
    }
}
