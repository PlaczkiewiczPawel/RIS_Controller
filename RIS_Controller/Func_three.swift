//
//  Func_three.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 22/01/2025.
//

import SwiftUI

struct FunctionThreeView: View {
    @ObservedObject var mqttManager = MQTTManager()
    @State private var generatedMessages: [String] = []
    let topic = "topic/pattern"
    
    var body: some View {
        VStack {
            Text("Ostatnie 10 wygenerowanych wzorców")
                .font(.headline)
            
            List(generatedMessages, id: \..self) { message in
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
            .padding()
        }
        .padding()
    }
    
    func generateAndSendRandomHex() {
        let randomHex = (0..<64).map { _ in String("0123456789ABCDEF".randomElement()!) }.joined()
        sendMessage(randomHex)
        
        if generatedMessages.count >= 10 {
            generatedMessages.removeFirst()
        }
        generatedMessages.append(randomHex)
    }
    
    func sendMessage(_ message: String) {
        mqttManager.sendMessage(to: topic, message: message)
    }
}

//struct MQTTView_Previews: PreviewProvider {
//    static var previews: some View {
//        MQTTView()
//    }
//}
