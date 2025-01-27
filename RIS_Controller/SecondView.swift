import SwiftUI

struct SecondView: View {
    @Environment(\.horizontalSizeClass) var hClass
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Wybierz funkcję")
                    .font(.title)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                let availableHeight = geometry.size.height
                
                let buttonHeight = availableHeight > 600 ? 80 : 60
                
                if hClass == .compact {
                    VStack(spacing: 20) {
                        NavigationLink(destination: FunctionOneView()) {
                            Text("RIS Viewer")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionTwoView(mqttManager: MQTTManager())) {
                            Text("Send HEX")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionThreeView()) {
                            Text("HEX Generator")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionFourView()) {
                            Text("Predefined")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

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
                    .frame(maxWidth: .infinity)
                } else {
                    VStack {
                        NavigationLink(destination: FunctionOneView()) {
                            Text("RIS Viewer")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionTwoView(mqttManager: MQTTManager())) {
                            Text("Send HEX")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionThreeView()) {
                            Text("HEX Generator")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FunctionFourView()) {
                            Text("Predefined")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: CGFloat(buttonHeight))
                                .background(Color.green)
                                .cornerRadius(10)
                        }

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
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
