//
//  GeneratorVC.swift
//  QR
//
//  Created by David Chavarria on 5/5/18.
//  Copyright © 2018 David Chavarria. All rights reserved.
//

import UIKit

class GeneratorVC: UIViewController {
    @IBOutlet weak var InputTF: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var GenerateButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    private let pickerOptions: [String: CIColor] = ["white": .white, "red": .red, "cyan": .cyan,
                                                    "black": .black, "yellow": .yellow, "green": .green]
    private var selectedBackground = CIColor.yellow
    private var selectedColor = CIColor.yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
    }
    
    func generateQRCode(from string: String, color: CIColor = .black, background: CIColor = .white) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        guard let qr = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qr.setValue(data, forKey: "inputMessage")
        
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(qr.outputImage, forKey: "inputImage")
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(background, forKey: "inputColor1")
        
        let scaleX = ImageView.frame.size.width
        let scaleY = ImageView.frame.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        if let  qrImage = colorFilter.outputImage?.transformed(by: transform)  {
            return UIImage(ciImage: qrImage)
        }
    
        return nil
    }
    
    @IBAction func GenerateAction(_ sender: Any) {
        reloadQR()
    }
    
    @IBAction func BackAction(_ sender: Any) {
        performSegue(withIdentifier: "generatorToMain", sender: self)
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        InputTF.resignFirstResponder()
        reloadQR()
    }
    
    private func reloadQR() {
        guard let text = InputTF.text, !text.isEmpty else { return }
        let image = generateQRCode(from: text, color: selectedColor, background: selectedBackground)
        ImageView.image = image
    }
}

extension GeneratorVC: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerOptions.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let key = Array(pickerOptions)[row].key
            return key
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadAllComponents()
            if component == 1 {
                selectedBackground = Array(pickerOptions)[row].value
            } else {
                selectedColor = Array(pickerOptions)[row].value
            }
            
            reloadQR()
        }
}
