import SwiftUI

struct FunctionFifthView: View {
    @Environment(\.horizontalSizeClass) var hClass
    @State private var serialNumbers: [String] = []
    @State private var voltages: [String] = []
    @State private var patternHexs: [String] = []
    
    @ObservedObject var mqttManager = MQTTManager()

    var body: some View {
        GeometryReader { geometry in
            if hClass == .compact {
                VStack {
                    HStack {
                        Spacer()
                        VStack(spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("NR seryjny RISA:")
                                    .font(.headline)
                                ForEach(serialNumbers, id: \.self) { serial in
                                    Text(serial)
                                        .padding(.leading)
                                }
                            }
                            .padding()
                            VStack(alignment: .leading) {
                                Text("Napięcie:")
                                    .font(.headline)
                                ForEach(voltages, id: \.self) { voltage in
                                    Text(voltage)
                                        .padding(.leading)
                                }
                            }
                            .padding()
                            VStack(alignment: .leading) {
                                Text("Patern w hex:")
                                    .font(.headline)
                                ForEach(patternHexs, id: \.self) { pattern in
                                    Text(pattern)
                                        .padding(.leading)
                                }
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                HStack(spacing: 20) {
                    VStack {
                        Text("NR seryjny RISA:")
                            .font(.headline)
                        ForEach(serialNumbers, id: \.self) { serial in
                            Text(serial)
                        }
                    }
                    .frame(width: geometry.size.width / 3)
                    VStack {
                        Text("Napięcie:")
                            .font(.headline)
                        ForEach(voltages, id: \.self) { voltage in
                            Text(voltage)
                        }
                    }
                    .frame(width: geometry.size.width / 3)
                    VStack {
                        Text("Patern w hex:")
                            .font(.headline)
                        ForEach(patternHexs, id: \.self) { pattern in
                            Text(pattern)
                        }
                    }
                    .frame(width: geometry.size.width / 3)
                }
                .padding()
            }
        }
        .onAppear {
            mqttManager.sendMessage(to: "topic/command", message: "?Params")
            mqttManager.subscribeToTopic("topic/Params")
        }
        .onReceive(mqttManager.$receivedMessage) { message in
            print("Received message: \(message)")
            handleReceivedMessage(message)
        }
        .padding()
    }
    
    func handleReceivedMessage(_ message: String) {
        if message.starts(with: "Serial:") {
            let serial = message.replacingOccurrences(of: "Serial:", with: "").trimmingCharacters(in: .whitespaces)
            if serialNumbers.count < 4 {
                serialNumbers.append(serial)
            }
        } else if message.starts(with: "Voltage:") {
            let voltage = message.replacingOccurrences(of: "Voltage:", with: "").trimmingCharacters(in: .whitespaces)
            if voltages.count < 4 {
                voltages.append(voltage)
            }
        } else if message.starts(with: "Pattern:") {
            let pattern = message.replacingOccurrences(of: "Pattern:", with: "").trimmingCharacters(in: .whitespaces)
            if patternHexs.count < 4 {
                patternHexs.append(pattern)
            }
        }

        if serialNumbers.count > 4 { serialNumbers.removeFirst() }
        if voltages.count > 4 { voltages.removeFirst() }
        if patternHexs.count > 4 { patternHexs.removeFirst() }
    }
}
