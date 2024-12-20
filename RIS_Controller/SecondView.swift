//
//  SecondView.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 20/12/2024.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Wybierz funkcję")
                .font(.title)
                .padding()

            ForEach(0..<6, id: \ .self) { index in
                Button(action: {
                    print("Funkcja \(index + 1) wybrana")
                }) {
                    Text(["Funkcja 1", "Funkcja 2", "Funkcja 3", "Funkcja 4", "Funkcja 5", "Funkcja 6"][index])
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
