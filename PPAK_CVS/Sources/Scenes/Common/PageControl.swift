//
//  PageControl.swift
//  PPAK_CVS
//
//  Created by 김응철 on 2022/09/16.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class PageControl: UIControl {

  // MARK: - Properties

  private let items: [String] = ["All", "1+1", "2+1"]

  private var labels: [UILabel] = []
  private var focusedView: UIView!

  private var selectedIndex: Int = 0 {
    didSet {
      updateFocusView()
      pageIndexSubject.accept(selectedIndex)
    }
  }

  let pageIndexSubject = BehaviorRelay<Int>(value: 0)
  let disposeBag = DisposeBag()

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStyles()
    setupLabels()
    setupFocusView()
    bind()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - LifeCycle

  override func layoutSubviews() {
    super.layoutSubviews()

    let labelSize = labels[selectedIndex].intrinsicContentSize

    var selectedFrame = self.bounds
    let newWidth = labelSize.width + 50
    let newHeight = labelSize.height + 25
    selectedFrame.size.width = newWidth
    selectedFrame.size.height = newHeight

    focusedView.frame = selectedFrame
    focusedView.center = labels[selectedIndex].center

    let labelHeight = self.bounds.height
    let labelWidth = self.bounds.width / CGFloat(items.count)

    for index in 0..<labels.count {
      let label = labels[index]
      let xPosition = CGFloat(index) * labelWidth
      label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
    }
  }

  // MARK: - Setup

  private func setupLabels() {
    for index in 0..<items.count {
      let label = UILabel(frame: self.bounds)
      label.text = items[index]
      label.textColor = .white
      label.textAlignment = .center
      label.font = .systemFont(ofSize: 18.0, weight: .heavy)
      self.addSubview(label)
      self.labels.append(label)
    }
  }

  private func setupStyles() {
    self.backgroundColor = .white.withAlphaComponent(0.2)
    self.layer.cornerRadius = 25.0
  }

  private func setupFocusView() {
    let focusView = UIView()
    self.focusedView = focusView
    self.insertSubview(focusedView, at: 0)
    focusedView.backgroundColor = .blue
    focusedView.layer.cornerRadius = 20.0
  }

  // MARK: - Bind

  private func bind() {
    let allLabel = labels[0]
    let onePlusLabel = labels[1]
    let twoPlusLabel = labels[2]

    onePlusLabel.rx.tapGesture()
      .map { _ in 1 }
      .bind(to: pageIndexSubject)
      .disposed(by: disposeBag)

    twoPlusLabel.rx.tapGesture()
      .map { _ in 2 }
      .bind(to: pageIndexSubject)
      .disposed(by: disposeBag)

    allLabel.rx.tapGesture()
      .map { _ in 0 }
      .bind(to: pageIndexSubject)
      .disposed(by: disposeBag)

    pageIndexSubject
      .bind(onNext: { [unowned self] index in
        let label = labels[index]
        self.focusedView.center = label.center
      })
      .disposed(by: disposeBag)
  }

  // MARK: - Helpers

  private func updateFocusView() {
    let label = labels[selectedIndex]
    self.focusedView.center = label.center
  }
}
