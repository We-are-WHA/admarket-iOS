//
//  AppRootRouter.swift
//  AdMarket
//
//  Created by 한현규 on 2023/07/24.
//

import RIBs

protocol AppRootInteractable: Interactable  , AppHomeListener{
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable{
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

    private let appHomeBuilder : AppHomeBuildable
    private var appHomeRouter : AppHomeRouting?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        appHomeBuildable : AppHomeBuildable
    ) {
        self.appHomeBuilder = appHomeBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
 
    func attachTabs() {
        let appHomeRouting = appHomeBuilder.build(withListener: interactor)
        
        
        attachChild(appHomeRouting)
        
        
        
        let viewControllers = [
          NavigationControllerable(root: appHomeRouting.viewControllable),
        ]
        
        viewController.setViewControllers(viewControllers)
    }
}
