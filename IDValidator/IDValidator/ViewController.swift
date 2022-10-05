//
//  ViewController.swift
//  IDValidator
//
//  Created by WeiJenWang on 2017/1/10.
//  Copyright © 2022年 TPIsoftware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    @IBAction func btnCheckClick(_ sender: Any) {
        lblResult.text = isValidateIDNumberEnu(idNumber: txtInput.text ?? "") ? "正確" : "不正確"
    }
    
    private func isValidateIDNumberEnu(idNumber: String) -> Bool {
        let pred = NSPredicate(format:"SELF MATCHES %@", "[A-Za-z][1,2][0-9]{8}")
        guard pred.evaluate(with: idNumber) else { return false }
            
        let uppercasedSource = idNumber.uppercased()
        let cityAlphabets: [String: Int] = [
            "A": 10, "B": 11, "C": 12, "D": 13, "E": 14,
            "F": 15, "G": 16, "H": 17, "J": 18, "K": 19,
            "L": 20, "M": 21, "N": 22, "P": 23, "Q": 24,
            "R": 25, "S": 26, "T": 27, "U": 28, "V": 29,
            "X": 30, "Y": 31, "W": 32, "Z": 33, "I": 34,
            "O": 35
        ]
        
        guard let key = uppercasedSource.first, let cityNumber = cityAlphabets[String(key)] else { return false }
        
        var ints: [Int] = []
        ints.append(cityNumber % 10)
        ints.append(contentsOf: uppercasedSource.compactMap { Int(String($0)) })
        
        guard let last = ints.last else { return false }
        let initialNumber = cityNumber / 10 + last
        let total = ints.enumerated().reduce(initialNumber, { sum, next in
            return sum + next.element * (9 - next.offset)
        })
        
        return total % 10 == 0
    }
}
