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
    
    @Environment(\.horizontalSizeClass) var hClass // Sprawdzanie, czy widok jest w trybie portretowym czy poziomym

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Tytuł
                Text("Ostatnie 10 wygenerowanych wzorców")
                    .font(.headline)
                    .padding(.top, 20)
                
                // W trybie poziomym ustawiamy HStack, a w pionowym pozostawiamy VStack
                if hClass == .compact {
                    // Tryb portretowy - lista i przycisk w jednej kolumnie
                    VStack(spacing: 15) {
                        List(generatedMessages, id: \.self) { message in
                            Button(action: {
                                sendMessage(message)
                            }) {
                                Text(message)
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .frame(height: 300) // Określenie wysokości listy
                        
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
                    // Tryb poziomy - HStack z listą i przyciskiem obok siebie
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
                            .frame(width: geometry.size.width * 0.45, height: 300) // Zmieniamy szerokość listy w trybie poziomym
                        }
                        
                        VStack {
                            Button(action: generateAndSendRandomHex) {
                                Text("Generowanie wzorca")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .frame(width: geometry.size.width * 0.45, height: 80) // Zwiększamy przycisk w trybie poziomym
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
