//
//  ViewController.swift
//  vadmitrievaPW7
//
//  Created by Varvara on 25.01.2022.
//

import UIKit
import MapKit
import CoreLocation

final class StartViewController: UIViewController {
    
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        mapView.center = view.center
        self.view.addSubview(mapView)
        setupStackView()
        let textStack = UIStackView()
        textStack.axis = .vertical
        view.addSubview(textStack)
        textStack.spacing = 10
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        [startLocation, finishLocation].forEach { textField in
            textField.delegate = self
            textStack.addArrangedSubview(textField)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        configureUI()
    }
    
    private let locationManager = CLLocationManager()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        
        var coords = MKCoordinateRegion()
        coords.center = mapView.userLocation.coordinate
        coords.span.latitudeDelta = 0.02
        coords.span.longitudeDelta = 0.02
        mapView.setRegion(coords, animated: true)
        
        return mapView
    }()

    private func configureUI() {
        
    }
    
    let stackView = UIView()
    let buttonsStack = UIStackView(frame: .zero)
    
    func setupStack() {
        stackView.addSubview(buttonsStack)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        buttonsStack.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        buttonsStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        buttonsStack.alignment = .fill
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 8.0
        
        setupButtons()
    }
    
    let goButton = MapButton(color: .systemIndigo, text: "GO")
    let clearButton = MapButton(color: .darkGray, text: "CLEAR")
    
    func setupButtons() {
        buttonsStack.addArrangedSubview(goButton)
        buttonsStack.addArrangedSubview(clearButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor).isActive = true
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor).isActive = true
        goButton.addTarget(self, action: #selector(goButtonWasPressed), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonWasPressed), for: .touchUpInside)
        disableButton(button: goButton)
        disableButton(button: clearButton)
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        setupStack()
    }
    
    let startLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.lightGray
        control.textColor = UIColor.black
        control.placeholder = "From"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode =
        UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment =
        UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    let finishLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.lightGray
        control.textColor = UIColor.black
        control.placeholder = "To"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode =
        UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment =
        UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        startLocation.resignFirstResponder()
        finishLocation.resignFirstResponder()
    }
    
    @objc func clearButtonWasPressed(_ sender: UIButton) {
        startLocation.text = ""
        finishLocation.text = ""
        disableButton(button: goButton)
        disableButton(button: clearButton)
    }
    
    @objc func goButtonWasPressed(_ sender: UIButton) {
        print("go!")
    }
    
    func disableButton(button: UIButton) {
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
    }
    
    func enableButton(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
    }
}

extension StartViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (startLocation.text != "" && finishLocation.text != "") {
            goButtonWasPressed(goButton)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (startLocation.text == "" || finishLocation.text == "") {
            disableButton(button: goButton)
        } else {
            enableButton(button: goButton)
        }
        if (startLocation.text == "" && finishLocation.text == "") {
            disableButton(button: clearButton)
        } else {
            enableButton(button: clearButton)
        }
    }
}
