//
//  Func_two.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 18/01/2025.
//

import SwiftUI

struct FunctionTwoView: View {
    @State private var hexInput: String = ""
    @ObservedObject var mqttManager: MQTTManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Wyślij wiadomość HEX na MQTT")
                .font(.headline)
                .padding()

            TextField("Wprowadź 64-znakowy HEX", text: $hexInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.allCharacters)
                .disableAutocorrection(true)

            HStack {
                Button("Cofnij") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                
                Button("Wyślij") {
                    sendHexMessage(hexInput)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }

    private func sendHexMessage(_ hexString: String) {
        let hexPattern = "^[0-9A-Fa-f]{64}$"
        let regex = try? NSRegularExpression(pattern: hexPattern)
        let range = NSRange(location: 0, length: hexString.utf16.count)
        
        if regex?.firstMatch(in: hexString, options: [], range: range) != nil {
            mqttManager.sendMessage(to: "topic/command",message: hexString)
        } else {
            print("Błąd: Niepoprawny format HEX!")
        }
    }
}
