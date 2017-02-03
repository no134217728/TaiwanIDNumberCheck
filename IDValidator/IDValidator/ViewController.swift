//
//  ViewController.swift
//  IDValidator
//
//  Created by WeiJenWang on 2017/1/10.
//  Copyright © 2017年 Apacer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCheckClick(_ sender: Any) {
//        if isValidateIDNumber(idNumber: txtInput.text!) {
//            lblResult.text = "正確"
//        } else {
//            lblResult.text = "不正確"
//        }
        
        if nicksIsValidateIDNumber(ID: txtInput.text!) {
            lblResult.text = "正確"
        } else {
            lblResult.text = "不正確"
        }
    }
    
    func validateID(strID: String) -> Bool {
        let idRegex: String = "^[A-Z]{1}[1-2]{1}[0-9]{8}$"
        let idTest: NSPredicate = NSPredicate(format: "SELF MATCHES[c] %@", idRegex)
        
        return idTest.evaluate(with: strID)
    }
    
    
    // 進階 Map 版
    func nicksIsValidateIDNumber(ID:String)->Bool{
        /// 過不了正則驗證就一定不是正確的身分證字號
        guard NSPredicate(format: "SELF MATCHES %@","^[A-Za-z]{1}[1-2]{1}[0-9]{8}$").evaluate(with: ID) else {
            return false
        }
        
        /// 英文比對
        let dicFurIDNumber = ["A":"10","B":"11","C":"12","D":"13","E":"14","F":"15","G":"16","H":"17","I":"34","J":"18","K":"19","L":"20","M":"21","N":"22","O":"35","P":"23","Q":"24","R":"25","S":"26","T":"27","U":"28","V":"29","W":"32","X":"30","Y":"31","Z":"33"]
        
        /// 取得第一個字(英文)換得數字文字
        let n00 = dicFurIDNumber["\(ID.characters.first!)".uppercased()]!
        /// 把換到的數字文字加上原本的數字文字
        let nn = n00 + ID.substring(from: ID.index(after: ID.startIndex))
        
        var ans = 0
        
        /// 將數字陣列每個字都轉成Int然後根據所在位置乘以該乘的數字 加進 ans
        nn.characters.map{Int("\($0)")!}.enumerated().forEach{
            switch $0.offset{
            case 1...8 :
                ans += $0.element * (10 - $0.offset)
            default :
                ans += $0.element
            }
        }
        /// 確認 ans 除以 10 是否為0 ， 若為0 就是正確的
        return ans % 10 == 0
    }
    
    // 入門版
    func isValidateIDNumber(idNumber: String) -> Bool {
        if validateID(strID: idNumber) { // 先確認格式
            let N00: String
            let N01, N02, N03, N04, N05, N06, N07, N08, N09, N10, N11: Int
            
            let dicFurIDNumber:[String: String] = ["A":"10",
                                                   "B":"11",
                                                   "C":"12",
                                                   "D":"13",
                                                   "E":"14",
                                                   "F":"15",
                                                   "G":"16",
                                                   "H":"17",
                                                   "I":"34",
                                                   "J":"18",
                                                   "K":"19",
                                                   "L":"20",
                                                   "M":"21",
                                                   "N":"22",
                                                   "O":"35",
                                                   "P":"23",
                                                   "Q":"24",
                                                   "R":"25",
                                                   "S":"26",
                                                   "T":"27",
                                                   "U":"28",
                                                   "V":"29",
                                                   "W":"32",
                                                   "X":"30",
                                                   "Y":"31",
                                                   "Z":"33",]
            
            N00 = dicFurIDNumber[idNumber.substring(to: 1).uppercased()]!
            
            let startIndex = idNumber.index(idNumber.startIndex, offsetBy: 1)
            let newIDNumber = N00 + idNumber.substring(from: startIndex)
            
            N01 = Int(newIDNumber.substring(to: 1))!
            N02 = Int(newIDNumber.substring(with: 1..<2))!
            N03 = Int(newIDNumber.substring(with: 2..<3))!
            N04 = Int(newIDNumber.substring(with: 3..<4))!
            N05 = Int(newIDNumber.substring(with: 4..<5))!
            N06 = Int(newIDNumber.substring(with: 5..<6))!
            N07 = Int(newIDNumber.substring(with: 6..<7))!
            N08 = Int(newIDNumber.substring(with: 7..<8))!
            N09 = Int(newIDNumber.substring(with: 8..<9))!
            N10 = Int(newIDNumber.substring(with: 9..<10))!
            N11 = Int(newIDNumber.substring(with: 10..<11))!
            
            let calculate = N01 + N02*9 + N03*8 + N04*7 + N05*6 + N06*5 + N07*4 + N08*3 + N09*2 + N10 + N11
            
            if calculate % 10 == 0 {
                return true
            }
        }
        
        return false
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
