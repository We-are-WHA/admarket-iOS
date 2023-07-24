import UIKit
import AnyFormatKit



extension UITextField {
    
    public func formatPhoneNumber(range: NSRange, string: String) {
        guard let text = self.text else {
            return
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return
        }
        
        let newLength = text.count + string.count - range.length
        let formatter: DefaultTextInputFormatter
        let onlyPhoneNumber = text.filter { $0.isNumber }
        
        let currentText: String
        if newLength < 13 {
            if text.count == 13, string.isEmpty { // crash 방지
                formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
            } else {
                formatter = DefaultTextInputFormatter(textPattern: "###-###-####")
            }
        } else {
            formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        }
        
        currentText = formatter.format(onlyPhoneNumber) ?? ""
        let result = formatter.formatInput(currentText: currentText, range: range, replacementString: string)
        if text.count == 13, string.isEmpty {
            self.text = DefaultTextInputFormatter(textPattern: "###-###-####").format(result.formattedText.filter { $0.isNumber })
        } else {
            self.text = result.formattedText
        }
        
        setCursorLocation(result.caretBeginOffset)
    }
    
    public func formatMoney(format : String, range: NSRange, string: String){
        guard let text = self.text else{
            return
        }
        
        let formatter = SumTextInputFormatter(textPattern: "#,###,## \(format)")
        let result =  formatter.formatInput(currentText: text, range: range, replacementString: string)
        self.text = result.formattedText
        
        setCursorLocation(result.caretBeginOffset)
    }
    
    
    public func checkMaxLength( maxLength : Int , string: String) -> Bool{
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }

        guard let text = self.text else { return false }
        if text.count >= maxLength {
            return false
        }

        return true
    }
    
    private func setCursorLocation(_ location: Int) {
        guard let cursorLocation = position(from: beginningOfDocument, offset: location) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
        }
    }
}




//TODO: Delete This File
//extension Reactive where Base : UITextField{
//
//    typealias WillChangeCharacters = ( textField: UITextField, shouldChangeCharactersIn : NSRange, replacementString : String )
//
//    var delegateProxy : RxTextFeildDelegateProxy {
//            return RxTextFeildDelegateProxy.proxy(for: self.base)
//   }
//
//
//    var shouldChangeCharacters: Observable<Bool> {
//        return delegateProxy.methodInvoked(#selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:)))
//            .map { (a) in
//                try castOrThrow(WillChangeCharacters.self, a[1])
//            }
//            .map{
//                let textField = $0.textField
//                let range = $0.shouldChangeCharactersIn
//                let replacementString = $0.replacementString
//                guard let text = textField.text else { return false }
//                let characterSet = CharacterSet(charactersIn: replacementString)
//                if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
//                    return false
//                }
//
//                let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
//                let result = formatter.formatInput(currentText: text, range: range, replacementString: replacementString)
//                textField.text = result.formattedText
//                textField.setCursorLocation(result.caretBeginOffset)
//                return false
//            }
//
//
//
//
//    }
//
//
//
//}
//
//
//
//final class RxTextFeildDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
//    static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
//        return object.delegate
//    }
//
//    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
//        object.delegate = delegate
//    }
//
//
//    static func registerKnownImplementations() {
//        self.register { RxTextFeildDelegateProxy(parentObject: $0, delegateProxy: RxTextFeildDelegateProxy.self) }
//     }
//}
//
//
//
//private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
//    guard let returnValue = object as? T else {
//        throw RxCocoaError.castingError(object: object, targetType: resultType)
//    }
//
//    return returnValue
//}
//
//
//
//private extension UITextField {
//
//    func setCursorLocation(_ location: Int) {
//        guard let cursorLocation = position(from: beginningOfDocument, offset: location) else { return }
//        DispatchQueue.main.async { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
//        }
//    }
//
//}
