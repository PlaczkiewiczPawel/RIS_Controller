//
//  Func_four.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 22/01/2025.
//

import SwiftUI

struct FunctionFourView: View {
    @StateObject private var mqttManager = MQTTManager()
    let topic = "topic/pattern"
    
    // Lista przycisków z nazwami i wiadomościami
    let buttons: [(name: String, message: String)] = [
        ("Lewa Strona", "FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00"),
        ("Prawa Strona", "AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899"),
        ("Tarcza", "00007FFE40025FFA500A57EA542A55AA55AA542A57EA500A5FFA40027FFE0000"),
        ("Szachownica", "AAAA5555AAAA5555AAAA5555AAAA5555AAAA5555AAAA5555AAAA5555AAAA5555"),
        ("Paski Pionowe", "F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0"),
        ("Paski Poziome", "0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(buttons, id: \.name) { button in
                Button(button.name) {
                    mqttManager.sendMessage(to: topic, message: button.message)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
