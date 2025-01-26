import SwiftUI

struct FunctionOneView: View {
    @Environment(\.horizontalSizeClass) var hClass
    @State private var matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)
    @ObservedObject var mqttManager = MQTTManager()

    var body: some View {
        GeometryReader { geometry in
            Group {
                if hClass == .compact {
                    // Widok w trybie portretowym
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
                        mqttManager.sendMessage(to: "topic/command", message: "?Pattern")
                        mqttManager.subscribeToTopic("topic/pattern")
                    }
                    .onReceive(mqttManager.$receivedMessage) { message in
                        print("Received message: \(message)")
                        updateMatrixFromHex(message)
                    }
                } else {
                    // Widok w trybie poziomym (landscape)
                    HStack(spacing: 16) {
                        // Lewa kolumna: Tekst i przycisk
                        VStack {
                            Text("RIS Viewer")
                                .font(.title)
                                .padding(.bottom, 16)

                            Button("Reset") {
                                matrix = Array(repeating: Array(repeating: false, count: 16), count: 16)
                                sendMatrixToMQTT()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)

                            Spacer()

                            Text("Oczekiwanie na wiadomość...")
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(width: geometry.size.width * 0.2) // 20% szerokości ekranu
                        .padding()

                        // Prawa kolumna: Wycentrowana macierz
                        VStack {
                            Spacer()

                            let gridWidth = geometry.size.width * 0.70
                            let gridHeight = geometry.size.height
                            let gridSize = min(gridWidth / 16, gridHeight / 16) // Ustawiamy minimalny rozmiar

                            VStack(spacing: 2) {
                                ForEach(0..<16, id: \.self) { row in
                                    HStack(spacing: 2) {
                                        ForEach(0..<16, id: \.self) { col in
                                            Rectangle()
                                                .fill(matrix[row][col] ? Color.green : Color.gray)
                                                .frame(width: gridSize, height: gridSize)
                                                .onTapGesture {
                                                    matrix[row][col].toggle()
                                                    sendMatrixToMQTT()
                                                }
                                        }
                                    }
                                }
                            }

                            Spacer()
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height)
                    }
                    .onAppear {
                        mqttManager.sendMessage(to: "topic/command", message: "?Pattern")
                        mqttManager.subscribeToTopic("topic/pattern")
                    }
                    .onReceive(mqttManager.$receivedMessage) { message in
                        print("Received message: \(message)")
                        updateMatrixFromHex(message)
                    }
                }
            }
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
