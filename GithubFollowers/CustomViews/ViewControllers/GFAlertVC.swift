//
//  GFAlertVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 27.10.2022.
//

import UIKit

class GFAlertVC: UIViewController {
  private enum Layout {
    static let padding: CGFloat = 20
    static let titleLabelFonstSize: CGFloat = 20
    static let titleLabelHeight: CGFloat = 28
    static let bgColorAlpha: CGFloat = 0.75
    static let containerWidth: CGFloat = 280
    static let containerHeight: CGFloat = 220
    static let buttonHeight: CGFloat = 44
    static let labelNumberOfLines: CGFloat = 4
    static let labelTopPadding: CGFloat = 8
    static let labelBottomPadding: CGFloat = 12
  }
  
  let containerView = GFAlertContainerView()
  let titleLabel = GFTitleLabel(textAligment: .center, fontSize: Layout.titleLabelFonstSize)
  let messageLabel = GFBodyLabel(textAligment: .center)
  let actionButton = GFButton(backgroundColor: .systemPink, title: Constants.Texts.ok)
  
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?
  
  init(
    title: String,
    message: String,
    buttonTitle: String
  ){
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(Layout.bgColorAlpha)
    configureContainerView()
    configureTitleLabel()
    configureActionButton()
    configureMessageLabel()
  }
  
  func configureContainerView(){
    view.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: Layout.containerWidth),
      containerView.heightAnchor.constraint(equalToConstant: Layout.containerHeight)
    ])
  }
  
  func configureTitleLabel(){
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? Constants.Errors.smtError
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.padding),
      titleLabel.heightAnchor.constraint(equalToConstant: Layout.titleLabelHeight)
    ])
  }
  
  func configureActionButton(){
    containerView.addSubview(actionButton)
    actionButton.setTitle(buttonTitle ?? Constants.Texts.ok, for: .normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.padding),
      actionButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight)
    ])
  }
  
  func configureMessageLabel(){
    containerView.addSubview(messageLabel)
    messageLabel.text = message ?? Constants.Errors.uncompleteError
    messageLabel.numberOfLines = 4
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.labelTopPadding),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -Layout.labelBottomPadding)
    ])
  }
  
  
  
  @objc func dismissVC(){
    dismiss(animated: true)
  }
  
}
