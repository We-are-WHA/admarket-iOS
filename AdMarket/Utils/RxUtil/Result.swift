import Foundation
import RxSwift
import Network


public enum Result<T> {
    case Success(T)
    case Error(T : Error )
    case Loading
}


extension Observable {
    public func asResult() -> Observable<Result<Element>>{
        self.map{
            Result.Success($0)
        }
        .startWith(Result.Loading)
        .observe(on : MainScheduler.instance)
        .catch(catchError)
    }
    
    private func catchError( error : Error) -> Observable<Result<Element>>{
        .just(Result<Element>.Error(T: error))
    }
    
    
//    func getSuccess<T>() -> Observable<T> where Element == Result<T>{
//        self.compactMap { result in
//            guard case .Success(let value) = result else { return nil }
//            return value
//        }
//    }
//
//    func getLoading<T>() -> Observable<Bool> where Element == Result<T>{
//        self.compactMap { result in
//            guard case .Loading = result else { return false }
//            return true
//        }
//    }
//
//    func getError<T>() -> Observable<String> where Element == Result<T>{
//        self.compactMap { result in
//            guard case .Error(let error) = result else { return nil}
//            debugPrint("*******************Error*******************")
//            debugPrint(String(describing: error))            
//            Analytics.logEvent("NetworkError", parameters: [
//              "name": "NetworkError",
//              "full_text": error.errorMessage(),
//            ])
//            return error.errorMessage()
//        }
//    }
 
}


