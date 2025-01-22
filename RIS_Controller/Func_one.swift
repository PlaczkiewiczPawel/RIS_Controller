//
//  Func_one.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 09/01/2025.
//

import SwiftUI

struct FunctionOneView: View {
    @State private var matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)
    @ObservedObject var mqttManager = MQTTManager()
    
    var body: some View {
        VStack {
            Text("RIS Viewer")
                .font(.title)
                .padding()
            
            VStack(spacing: 2) {
                ForEach(0..<16, id: \ .self) { row in
                    HStack(spacing: 2) {
                        ForEach(0..<16, id: \ .self) { col in
                            Rectangle()
                                .fill(matrix[row][col] ? Color.green : Color.gray)
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    matrix[row][col].toggle()
                                    sendMatrixToMQTT()
                                }
                        }
                    }
                }
            }
            .padding()
            
            Button("Reset") {
                matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)
                sendMatrixToMQTT()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text("Oczekiwanie na wiadomość...")
                .padding()
        }
        .padding()
        .onAppear {
            mqttManager.subscribeToTopic("topic/pattern")
        }
        .onReceive(mqttManager.$receivedMessage) { message in
            print("Otrzymano wiadomość: \(message)")
            updateMatrixFromHex(message)
        }
    }
    
    func updateMatrixFromHex(_ hexString: String) {
        var bitArray: [Bool] = []
        for char in hexString {
            if let hexValue = Int(String(char), radix: 16) {
                let binaryString = String(hexValue, radix: 2).padLeft(toSize: 4)
                bitArray.append(contentsOf: binaryString.map { $0 == "1" })
            }
        }
        
        for row in 0..<16 {
            for col in 0..<16 {
                let index = row * 16 + col
                if index < bitArray.count {
                    matrix[row][col] = bitArray[index]
                }
            }
        }
    }
    
    func sendMatrixToMQTT() {
        var hexString = ""
        for row in matrix {
            for chunk in row.chunked(into: 4) {
                let binaryString = chunk.map { $0 ? "1" : "0" }.joined()
                let hexValue = Int(binaryString, radix: 2) ?? 0
                hexString.append(String(format: "%X", hexValue))
            }
        }
        mqttManager.sendMessage(to: "topic/pattern", message: hexString)
    }
}

extension String {
    func padLeft(toSize: Int) -> String {
        return String(repeating: "0", count: max(0, toSize - count)) + self
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


