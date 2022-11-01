//
//  BookmarkCoordinator.swift
//  PPAK_CVS
//
//  Created by 김응철 on 2022/10/08.
//

import UIKit

final class BookmarkCoordinator: BaseCoordinator {

  override func start() {
    let viewController = BookmarkViewController()
    let viewModel = BookmarkViewModel()
    self.navigationController.setViewControllers([viewController], animated: true)
    viewController.viewModel = viewModel
  }
}
