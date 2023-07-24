import UIKit.UIApplication


//TODO : url 정의해두기
//private extension UIApplication{
//    let openTelURLString = "tel:"
//}

public final class URLSchemeHelper{
    
    func openSettingApp(){
        if let url = URL(string: UIApplication.openSettingsURLString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openCallApp(phoneNumber : String){
        if let url = URL(string: "tel:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    func openMessageApp(phoneNumber : String){
        if let url = URL(string: "sms:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    func openAppStore( appStoreAppID : String){
        let url = URL(string: "itms-apps://itunes.apple.com/app/id" + appStoreAppID)!
        UIApplication.shared.open(url)
    }
    
    
}
