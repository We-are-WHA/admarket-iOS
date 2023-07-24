//
//  AppHomeViewController.swift
//  AdMarket
//
//  Created by 한현규 on 2023/07/24.
//

import RIBs
import RxSwift
import UIKit

protocol AppHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppHomeViewController: UIViewController, AppHomePresentable, AppHomeViewControllable {

    weak var listener: AppHomePresentableListener?
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    
    
    private func setLayout(){
        view.backgroundColor = .red
    }
}
