//
//  Func_one.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 09/01/2025.
//

import SwiftUI

struct FunctionOneView: View {
    @State private var matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)

    var body: some View {
        VStack {
            Text("RIS Viewer")
                .font(.title)
                .padding()

            VStack(spacing: 2) {
                ForEach(0..<16, id: \.self) { row in
                    HStack(spacing: 2) {
                        ForEach(0..<16, id: \.self) { col in
                            Rectangle()
                                .fill(matrix[row][col] ? Color.green : Color.gray)
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    matrix[row][col].toggle()
                                }
                        }
                    }
                }
            }
            .padding()

            Button("Reset") {
                matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

//struct FunctionOneView_Previews: PreviewProvider {
//    static var previews: some View {
//        FunctionOneView()
//    }
//}

