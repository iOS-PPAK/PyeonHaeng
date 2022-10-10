//
//  ProductCollectionHeaderView.swift
//  PPAK_CVS
//
//  Created by 홍승현 on 2022/10/10.
//

import UIKit

final class ProductCollectionHeaderView: UICollectionReusableView {
  static let id = "ProductCollectionHeaderView"

  private let shareButton = UIButton().then {
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(systemName: "square.and.arrow.up")
    $0.configuration = configuration
  }

  private let productImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .systemBlue // temporary color
  }

  private let nameLabel = UILabel().then {
    $0.font = Font.nameLabel
    $0.text = "코카)씨그램피치탄산수350ML"
  }

  private let priceLabel = UILabel().then {
    $0.font = Font.priceLabel
    $0.text = "1,500원"
  }

  private let priceDiscriptionLabel = UILabel().then {
    $0.font = Font.priceDescriptionLabel
    $0.text = "(개당 750원)"
  }

  private let previousHistoryLabel = UILabel().then {
    $0.font = Font.previousHistoryLabel
    $0.text = "이전 행사 내역"
    $0.textColor = .white
  }

  private let priceStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.spacing = 3
  }

  private let wholeStackView = UIStackView().then {
    $0.alignment = .center
    $0.distribution = .fillProportionally
    $0.axis = .vertical
    $0.spacing = 10
  }

  private let curveView = BottomCurveView().then {
    $0.backgroundColor = .systemPurple
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayouts()
    setupConstraints()
    setupStyles()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - setup

extension ProductCollectionHeaderView {
  private func setupLayouts() {

    // == views ==
    [shareButton, wholeStackView, curveView].forEach {
      addSubview($0)
    }

    // == stackViews ==
    [priceLabel, priceDiscriptionLabel].forEach {
      priceStackView.addArrangedSubview($0)
    }

    [productImageView, nameLabel, priceStackView].forEach {
      wholeStackView.addArrangedSubview($0)
    }

    // == curveView ==
    curveView.addSubview(previousHistoryLabel)
  }

  private func setupConstraints() {
    shareButton.snp.makeConstraints { make in
      make.trailing.top.equalToSuperview().inset(Inset.shareButton)
    }

    wholeStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(Inset.StackView.top)
    }

    curveView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(wholeStackView.snp.bottom).inset(Inset.curveView)
    }

    productImageView.snp.makeConstraints { make in
      make.width.height.equalTo(240)
    }

    previousHistoryLabel.snp.makeConstraints { make in
      make.bottom.trailing.equalToSuperview().inset(Inset.previousHistoryLabel)
    }
  }

  private func setupStyles() {
    backgroundColor = .systemBackground
  }
}

// MARK: - Constants

extension ProductCollectionHeaderView {

  private enum Font {
    static let nameLabel = UIFont.boldSystemFont(ofSize: 20)
    static let priceLabel = UIFont.systemFont(ofSize: 20, weight: .medium)
    static let priceDescriptionLabel = UIFont.systemFont(ofSize: 16, weight: .regular)

    static let previousHistoryLabel = UIFont.boldSystemFont(ofSize: 16)
  }

  private enum Inset {

    static let shareButton = 5

    static let previousHistoryLabel = 10

    static let curveView = 10

    enum StackView {
      static let top = 10
    }
  }
}