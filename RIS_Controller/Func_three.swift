//
//  Func_three.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 22/01/2025.
//

import SwiftUI

struct FunctionThreeView: View {
    @ObservedObject var mqttManager = MQTTManager()
    @State private var generatedMessages: [String] = UserDefaults.standard.stringArray(forKey: "GeneratedMessages") ?? []
    let topic = "topic/command"
    
    @Environment(\.horizontalSizeClass) var hClass

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Ostatnie 10 wygenerowanych wzorców")
                    .font(.headline)
                    .padding(.top, 20)
                
                if hClass == .compact {
                    VStack(spacing: 15) {
                        List(generatedMessages, id: \.self) { message in
                            Button(action: {
                                sendMessage(message)
                            }) {
                                Text(message)
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .frame(height: 300)
                        
                        Button(action: generateAndSendRandomHex) {
                            Text("Generowanie wzorca")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.bottom)
                    }
                } else {
                    HStack(spacing: 20) {
                        VStack(spacing: 15) {
                            List(generatedMessages, id: \.self) { message in
                                Button(action: {
                                    sendMessage(message)
                                }) {
                                    Text(message)
                                        .font(.system(.body, design: .monospaced))
                                }
                            }
                            .frame(width: geometry.size.width * 0.45, height: 300)
                        }
                        
                        VStack {
                            Button(action: generateAndSendRandomHex) {
                                Text("Generowanie wzorca")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .frame(width: geometry.size.width * 0.45, height: 80)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    func generateAndSendRandomHex() {
        let randomHex = (0..<64).map { _ in String("0123456789ABCDEF".randomElement()!) }.joined()
        sendMessage(randomHex)
        
        if generatedMessages.count >= 10 {
            generatedMessages.removeFirst()
        }
        generatedMessages.append(randomHex)
        
        UserDefaults.standard.set(generatedMessages, forKey: "GeneratedMessages")
    }
    
    func sendMessage(_ message: String) {
        mqttManager.sendMessage(to: topic, message: message)
    }
}
