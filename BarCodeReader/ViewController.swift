//
//  ViewController.swift
//  BarCodeReader
//
//  Created by Kakha Sepashvili on 2/27/22.
//

import UIKit






class ViewController: UIViewController {

    
    var num1: String = ""
    var num2: String = ""
    private let scanButton: UIButton = {
       let scanButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        scanButton.setTitle("Scan", for: .normal)
        scanButton.setImage(UIImage(systemName: "barcode.viewfinder"), for: .normal)
        scanButton.setTitleColor(.black, for: .normal)
        scanButton.backgroundColor = .white
        scanButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return scanButton
    }()

    let GreetingText =  UILabel()
    let ScanButton = UIButton()
    var resultText = UILabel()
    var result: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GreetingText.setupLabel(text: "Scan the BARCODE to check the country of origin.", size: 25)
        view.backgroundColor = .systemCyan
        [GreetingText, scanButton, resultText].forEach {view.addSubview($0)}
        GreetingText.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: UIScreen.main.bounds.height / 8, left: 40, bottom: 0, right: 40))
        resultText.setupLabel(text: result, size: 30)
        scanButton.anchor(top: GreetingText.bottomAnchor, leading: GreetingText.leadingAnchor, bottom: nil, trailing: GreetingText.trailingAnchor, padding: .init(top: 150, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 50))
        resultText.anchor(top: scanButton.bottomAnchor, leading: scanButton.leadingAnchor, bottom: nil, trailing: scanButton.trailingAnchor, padding: .init(top: 120, left: 30, bottom: 0, right: 40))
    }

    @objc func buttonPressed() {
     let vc = UINavigationController(rootViewController: BarcodeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    
    }
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UILabel {
    func setupLabel(text: String, size: CGFloat) {
        self.textColor = .white
        self.text = text
        self.textAlignment = .center
        self.numberOfLines = 4
        self.font = UIFont(name: "Helvetica", size: size)
    }
}


