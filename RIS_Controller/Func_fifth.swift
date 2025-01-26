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
                // Tryb portretowy (VStack wyśrodkowane w poziomie, wyświetlane od góry)
                VStack {
                    HStack {
                        Spacer() // Spacer z lewej strony, aby wyśrodkować w poziomie
                        
                        VStack(spacing: 20) {
                            // Serial Numbers
                            VStack(alignment: .leading) {
                                Text("NR seryjny RISA:")
                                    .font(.headline)
                                ForEach(serialNumbers, id: \.self) { serial in
                                    Text(serial)
                                        .padding(.leading)
                                }
                            }
                            .padding()

                            // Voltages
                            VStack(alignment: .leading) {
                                Text("Napięcie:")
                                    .font(.headline)
                                ForEach(voltages, id: \.self) { voltage in
                                    Text(voltage)
                                        .padding(.leading)
                                }
                            }
                            .padding()

                            // Pattern in Hex
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
                        .frame(maxWidth: .infinity) // Sprawia, że zawartość jest wyśrodkowana w poziomie
                        
                        Spacer() // Spacer z prawej strony, aby wyśrodkować w poziomie
                    }
                    
                    Spacer() // Spacer na dole, aby wyświetlanie zaczynało się od góry
                }
            } else {
                // Tryb poziomy (landscape) - HStack z 3 kolumnami
                HStack(spacing: 20) {
                    // Kolumna dla numerów seryjnych
                    VStack {
                        Text("NR seryjny RISA:")
                            .font(.headline)
                        ForEach(serialNumbers, id: \.self) { serial in
                            Text(serial)
                        }
                    }
                    .frame(width: geometry.size.width / 3)

                    // Kolumna dla napięć
                    VStack {
                        Text("Napięcie:")
                            .font(.headline)
                        ForEach(voltages, id: \.self) { voltage in
                            Text(voltage)
                        }
                    }
                    .frame(width: geometry.size.width / 3)

                    // Kolumna dla wzorów w hex
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
            // Subskrybujemy odpowiednie tematy MQTT
            mqttManager.sendMessage(to: "topic/command", message: "?Params")
            mqttManager.subscribeToTopic("topic/Params")
        }
        .onReceive(mqttManager.$receivedMessage) { message in
            print("Received message: \(message)")
            handleReceivedMessage(message)
        }
        .padding()
    }
    
    // Funkcja obsługująca odbiór wiadomości MQTT
    func handleReceivedMessage(_ message: String) {
        // Możesz rozbić wiadomości na podstawie tematów:
        if message.starts(with: "Serial:") {
            let serial = message.replacingOccurrences(of: "Serial:", with: "").trimmingCharacters(in: .whitespaces)
            // Dodajemy numer seryjny do tablicy, jeśli jest mniej niż 4
            if serialNumbers.count < 4 {
                serialNumbers.append(serial)
            }
        } else if message.starts(with: "Voltage:") {
            let voltage = message.replacingOccurrences(of: "Voltage:", with: "").trimmingCharacters(in: .whitespaces)
            // Dodajemy napięcie do tablicy, jeśli jest mniej niż 4
            if voltages.count < 4 {
                voltages.append(voltage)
            }
        } else if message.starts(with: "Pattern:") {
            let pattern = message.replacingOccurrences(of: "Pattern:", with: "").trimmingCharacters(in: .whitespaces)
            // Dodajemy pattern do tablicy, jeśli jest mniej niż 4
            if patternHexs.count < 4 {
                patternHexs.append(pattern)
            }
        }

        // Upewniamy się, że tablica nie przekroczy 4 elementów
        if serialNumbers.count > 4 { serialNumbers.removeFirst() }
        if voltages.count > 4 { voltages.removeFirst() }
        if patternHexs.count > 4 { patternHexs.removeFirst() }
    }
}
