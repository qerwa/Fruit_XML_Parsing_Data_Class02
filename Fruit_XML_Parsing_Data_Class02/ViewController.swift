//
//  ViewController.swift
//  Fruit_XML_Parsing_Data_Class02
//
//  Created by D7703_17 on 2018. 10. 1..
//  Copyright © 2018년 D7703_17. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

      
      //데이터 객체 초기화
      var myFruitData = [FruitData]()
      var fName = ""
      var fColor = ""
      var fCost = ""
      
      var currentElement = ""
      
      
      override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
                  if let myParser = XMLParser(contentsOf: path) {
                        myParser.delegate = self
                        
                        // 파싱 시작
                        if myParser.parse() {
                              print("Parsing succeed")
//                              print(myFruitData[0].name)
//                              print(myFruitData[0].color)
//                              print(myFruitData[0].cost)
                        } else {
                              print("Parsing failed")
                        }
                  } else {
                        print("path error")
                  }
            } else {
                  print("file error")
            }
      }
      // XMLParserDelegate 메소드 호출
      // <tag>를 만날때
      func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            currentElement = elementName
            print(currentElement)
      }
      // tag 다음에 문자열을 만날때
      func parser(_ parser: XMLParser, foundCharacters string: String) {
            //공백제거
            let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            if !data.isEmpty {
                  switch currentElement {
                  case "name" : fName = data
                  case "color" : fColor = data
                  case "cost" : fCost = data
                  default : break
                  }
            }
      }
      
      // </tag>를 만날때
      func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "item" {
                  let myItem = FruitData()
                  myItem.name = fName
                  myItem.color = fColor
                  myItem.cost = fCost
                  myFruitData.append(myItem)
            }
      }
}
