//
//  AppComponent.swift
//  AdMarket
//
//  Created by 한현규 on 2023/07/24.
//

import Foundation
import RIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
}
