import SwiftUI

struct SecondView: View {
    @Environment(\.horizontalSizeClass) var hClass // Sprawdzanie orientacji ekranu (portrait vs landscape)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Tytuł na górze, zarówno w trybie portretowym, jak i poziomym
                Text("Wybierz funkcję")
                    .font(.title)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Sprawdzamy dostępne miejsce w pionie
                let availableHeight = geometry.size.height
                
                // Jeśli jest wystarczająco dużo miejsca na dole ekranu, zwiększamy przyciski
                let buttonHeight = availableHeight > 600 ? 80 : 60 // Jeśli dostępna wysokość jest większa niż 600, przyciski są większe
                
                // Tryb portretowy (VStack z przyciskami wyświetlanymi pod tytułem)
                if hClass == .compact {
                    VStack(spacing: 20) { // Zmniejszono przestrzeń między przyciskami
                        // Przycisk RIS Viewer
                       
                        NavigationLink(destination: FunctionOneView()) {
                            Text("RIS Viewer")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Send HEX
                        NavigationLink(destination: FunctionTwoView(mqttManager: MQTTManager())) {
                            Text("Send HEX")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk HEX Generator
                        NavigationLink(destination: FunctionThreeView()) {
                            Text("HEX Generator")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Predefined
                        NavigationLink(destination: FunctionFourView()) {
                            Text("Predefined")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Read parameters from RIS
                        NavigationLink(destination: FunctionFifthView()) {
                            Text("Read parameters from RIS")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity) // Przycisk zajmujący całą szerokość
                } else {
                    // Tryb poziomy (landscape) - HStack z przyciskami w jednej kolumnie
                    VStack {
                        // Przycisk RIS Viewer
                        NavigationLink(destination: FunctionOneView()) {
                            Text("RIS Viewer")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Send HEX
                        NavigationLink(destination: FunctionTwoView(mqttManager: MQTTManager())) {
                            Text("Send HEX")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk HEX Generator
                        NavigationLink(destination: FunctionThreeView()) {
                            Text("HEX Generator")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Predefined
                        NavigationLink(destination: FunctionFourView()) {
                            Text("Predefined")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        // Przycisk Read parameters from RIS
                        NavigationLink(destination: FunctionFifthView()) {
                            Text("Read parameters from RIS")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity) // Rozciąganie na całą szerokość ekranu
                }
            }
        }
    }
}
