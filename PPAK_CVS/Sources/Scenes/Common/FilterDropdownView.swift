//
//  FilterDropdownView.swift
//  PPAK_CVS
//
//  Created by 김응철 on 2022/09/27.
//

import UIKit

import SnapKit

final class FilterDropdownView: UIView {

  // MARK: - Properties

  var stackView: UIStackView! // Then이 프로퍼티 인식을 못하는 것 같아요 ...

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStyles()
    setupStackView()
    setupLayout()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup
  private func setupStyles() {
    backgroundColor = .white
    layer.shadowOpacity = 0.2
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.cornerRadius = 12.0
  }

  private func setupLayout() {
    addSubview(stackView)
  }

  private func setupConstraints() {
    stackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  private func setupStackView() {
    let ascendingButton = createButton("낮은가격순 ↓")
    let descendingButton = createButton("높은가격순 ↑")
    let stackView = UIStackView(arrangedSubviews: [ascendingButton, descendingButton])
    stackView.axis = .vertical
    stackView.spacing = 4
    self.stackView = stackView
  }
}

// MARK: - Helpers

extension FilterDropdownView {
  private func createButton(_ title: String) -> UIButton {
    var config = UIButton.Configuration.plain()
    var container = AttributeContainer()
    container.font = .systemFont(ofSize: 16.0, weight: .bold)
    container.foregroundColor = .black
    config.attributedTitle = AttributedString(title, attributes: container)
    let button = UIButton(configuration: config)

    return button
  }

  static func showDropdown(_ view: UIView) {
    view.isHidden = false
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
      view.layer.opacity = 1
    }
  }

  static func hideDropdown(_ view: UIView) {
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
      view.layer.opacity = 0
    } completion: { _ in
      view.isHidden = true
    }
  }
}
