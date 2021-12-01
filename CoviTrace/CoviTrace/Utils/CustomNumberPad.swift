//
//  CustomNumberPad.swift
//  CoviTrace
//
//  Created by Appè Latte on 26/11/2021.
//

import SwiftUI
import Firebase

struct CustomNumberPad : View {
    @Binding var value : String
    var isVerify: Bool
    var rows = ["1","2","3","4","5","6","7","8","9","","0","clear"]
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        GeometryReader { reader in
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 15) {
                    ForEach(rows, id: \.self){ value in
                        Button(action: { buttonAction(value: value)}) {
                            ZStack {
                                if value == "clear" {
                                    Image(systemName: "delete.left")
                                        .font(.title2)
                                        .foregroundColor(green)
                                } else {
                                    Text(value)
                                        .fontWeight(.bold)
                                        .foregroundColor(purple)
                                        .font(.title2)
                                }
                            }
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(bgWhite())
                            .clipShape(Circle())
                            .cornerRadius(10)
                        }
                        
                        // MARK: Disable empty button
                        .disabled(value == "" ? true : false)
                    }
                }
            }
        }.padding()
    }
    
    // MARK: Height & Width for dynamic sizing
    func getWidth(frame: CGRect) -> CGFloat {
        let width = frame.width
        let actualWidth = width - 40
        return actualWidth / 4
    }
    
    func getHeight(frame: CGRect) -> CGFloat {
        let height = frame.height
        let actualHeight = height - 30
        return actualHeight / 5
    }
    
    func buttonAction(value: String) {
        
        if value == "clear" && self.value != "" {
            self.value.removeLast()
        }
        
        if value != "clear" {
            if isVerify {
                if self.value.count < 6 {
                    self.value.append(value)
                }
            } else {
                self.value.append(value)
            }
        }
    }
}
