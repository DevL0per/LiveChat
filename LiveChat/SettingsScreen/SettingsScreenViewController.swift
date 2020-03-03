//
//  SettingsScreenViewController.swift
//  LiveChat
//
//  Created by Роман Важник on 29/02/2020.
//  Copyright (c) 2020 Роман Важник. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

fileprivate struct Constants {
    static let changeImageButtonHeight: CGFloat = 30
    static let imageViewHeightAndWidth = UIScreen.main.bounds.width/1.7
    static let textFieldHeight: CGFloat = 45
    static let textFieldWidth: CGFloat = UIScreen.main.bounds.width/1.2
    static let changePasswordButtonHeight: CGFloat = 45
}

protocol SettingsScreenDisplayLogic: class {
    func displayCurrentUserImage(viewModel: SettingsScreen.FetchCurrentUserImage.ViewModel)
    func newImageWasUpload(viewModel: SettingsScreen.ChangeProfileImage.ViewModel)
    func displayNewUserName(viewModel: SettingsScreen.ChangeName.ViewModel)
}

class SettingsScreenViewController: UIViewController, SettingsScreenDisplayLogic {
    
    var interactor: SettingsScreenBusinessLogic?
    
    var imagePickerContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var passwordTextFieldsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var changeImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeProfileImage), for: .touchUpInside)
        button.setTitle("Change profile image", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var imageViewPicker: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageWasTapped)))
        imageView.layer.cornerRadius = Constants.imageViewHeightAndWidth/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageViewPickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newNameTextField = AuthorizationScreenTextField()
    //let newEmailTextField = AuthorizationScreenTextField()
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9317067266, green: 0.3866539598, blue: 0.6329562068, alpha: 1)
        button.alpha = 0.5
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("change name", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.231372549, blue: 0.3607843137, alpha: 1)
        layoutFirstLayer()
        layoutSecondLayer()
        setupTextField()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageViewPickerLabel.text = "Tap to select an image"
        interactor?.fetchCurrentProfileImage(request: SettingsScreen.FetchCurrentUserImage.Request())
    }
    
    func displayCurrentUserImage(viewModel: SettingsScreen.FetchCurrentUserImage.ViewModel) {
        if viewModel.userURL != "" {
            imageViewPickerLabel.text = ""
            imageViewPicker.setImage(with: viewModel.userURL)
        }
    }
    
    func newImageWasUpload(viewModel: SettingsScreen.ChangeProfileImage.ViewModel) {
    }
    
    func displayNewUserName(viewModel: SettingsScreen.ChangeName.ViewModel) {
        
    }
    
    @objc private func profileImageWasTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func changeProfileImage() {
        guard let image = imageViewPicker.image else { return }
        interactor?.changeProfileImage(request: SettingsScreen.ChangeProfileImage.Request(image: image))
    }
    
    private func setupTextField() {
        newNameTextField.setPlaceHolderWithWhiteColor(text: "new name")
        newNameTextField.addTarget(self, action: #selector(newNameTextFieldWasChanged), for: .editingChanged)
    }
    
    @objc private func newNameTextFieldWasChanged() {
        if let text = newNameTextField.text, !text.isEmpty {
            changePasswordButton.alpha = 1
        } else {
            changePasswordButton.alpha = 0.5
        }
    }
    
    private func layoutSecondLayer() {
        // imagePickerContentView elements
        imagePickerContentView.addSubview(imageViewPicker)
        imageViewPicker.topAnchor.constraint(equalTo: imagePickerContentView.topAnchor).isActive = true
        imageViewPicker.centerXAnchor.constraint(equalTo: imagePickerContentView.centerXAnchor).isActive = true
        imageViewPicker.heightAnchor.constraint(equalToConstant: Constants.imageViewHeightAndWidth).isActive = true
        imageViewPicker.widthAnchor.constraint(equalToConstant: Constants.imageViewHeightAndWidth).isActive = true
        
        imageViewPicker.addSubview(imageViewPickerLabel)
        imageViewPickerLabel.centerYAnchor.constraint(equalTo: imageViewPicker.centerYAnchor).isActive = true
        imageViewPickerLabel.centerXAnchor.constraint(equalTo: imageViewPicker.centerXAnchor).isActive = true
        
        imagePickerContentView.addSubview(changeImageButton)
        changeImageButton.topAnchor.constraint(equalTo: imageViewPicker.bottomAnchor, constant: 8).isActive = true
        changeImageButton.widthAnchor.constraint(equalToConstant: Constants.imageViewHeightAndWidth).isActive = true
        changeImageButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        changeImageButton.centerXAnchor.constraint(equalTo: imageViewPicker.centerXAnchor).isActive = true
        
        // passwordTextFieldsContentView elements
        passwordTextFieldsContentView.addSubview(newNameTextField)
        newNameTextField.topAnchor.constraint(equalTo: passwordTextFieldsContentView.topAnchor).isActive = true
        newNameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        newNameTextField.leadingAnchor.constraint(equalTo: passwordTextFieldsContentView.leadingAnchor).isActive = true
        newNameTextField.trailingAnchor.constraint(equalTo: passwordTextFieldsContentView.trailingAnchor).isActive = true
        
//        passwordTextFieldsContentView.addSubview(newEmailTextField)
//        newEmailTextField.topAnchor.constraint(equalTo: newNameTextField.bottomAnchor, constant: 5).isActive = true
//        newEmailTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
//        newEmailTextField.leadingAnchor.constraint(equalTo: passwordTextFieldsContentView.leadingAnchor).isActive = true
//        newEmailTextField.trailingAnchor.constraint(equalTo: passwordTextFieldsContentView.trailingAnchor).isActive = true
        
        passwordTextFieldsContentView.addSubview(changePasswordButton)
        changePasswordButton.topAnchor.constraint(equalTo: newNameTextField.bottomAnchor, constant: 20).isActive = true
        changePasswordButton.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        changePasswordButton.leadingAnchor.constraint(equalTo: passwordTextFieldsContentView.leadingAnchor).isActive = true
        changePasswordButton.trailingAnchor.constraint(equalTo: passwordTextFieldsContentView.trailingAnchor).isActive = true
    }
    
    private func layoutFirstLayer() {
        view.addSubview(imagePickerContentView)
        imagePickerContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        imagePickerContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imagePickerContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imagePickerContentView.heightAnchor.constraint(equalToConstant:
            Constants.imageViewHeightAndWidth + 8 + Constants.changeImageButtonHeight).isActive = true
        
        view.addSubview(passwordTextFieldsContentView)
        passwordTextFieldsContentView.topAnchor.constraint(equalTo:
            imagePickerContentView.bottomAnchor, constant: 25).isActive = true
        passwordTextFieldsContentView.widthAnchor.constraint(equalToConstant: Constants.textFieldWidth).isActive = true
        passwordTextFieldsContentView.heightAnchor.constraint(equalToConstant:
            Constants.textFieldHeight + 20 + Constants.changeImageButtonHeight).isActive = true
        passwordTextFieldsContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setup() {
        let viewController = self
        let interactor = SettingsScreenInteractor()
        let presenter = SettingsScreenPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension SettingsScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var optionalImage: UIImage?
        if let image = info[.editedImage] {
            optionalImage = image as? UIImage
        } else if let image = info[.originalImage] {
            optionalImage = image as? UIImage
        }
        guard let image = optionalImage else { return }
        picker.dismiss(animated: true, completion: nil)
        imageViewPicker.image = image
        imageViewPickerLabel.text = ""
    }
}

