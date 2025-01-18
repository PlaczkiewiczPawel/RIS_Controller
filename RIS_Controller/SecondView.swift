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

            Button(action: {
                print("RIS Viewer wybrany")
            }) {
                NavigationLink(destination: FunctionOneView()) {
                    Text("RIS_Viewer")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Button(action: {
                print("Funkcja 2")
            }) {
                NavigationLink(destination: MQTTMessageView(mqttManager: MQTTManager())) {
                    Text("Send HEX")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Button(action: {
                print("RIS Viewer wybrany")
            }) {
                NavigationLink(destination: FunctionOneView()) {
                    Text("RIS_Viewer")
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

//struct SecondView_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondView()
//    }
//}
