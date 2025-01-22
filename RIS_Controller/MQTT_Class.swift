//
//  MQTT_Class.swift
//  RIS_Controller
//
//  Created by Paweł Płaczkiewicz on 18/01/2025.
//
import SwiftUI
import CocoaMQTT

class MQTTManager: ObservableObject {
    var mqtt: CocoaMQTT?
    @Published var receivedMessage: String = ""
    
    init() {
        setupMQTT()
    }
    
    func setupMQTT() {
        let clientID = "iOSClient-\(UUID().uuidString)"
        mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.191", port: 1883)
        mqtt?.keepAlive = 60
        _ = mqtt?.connect()
        handleMQTTEvents()
    }
    
    func sendMessage(to topic: String, message: String) {
        mqtt?.publish(topic, withString: message, qos: .qos1)
        print("Send to \(topic): \(message)")
    }
    
    func subscribeToTopic(_ topic: String) {
        mqtt?.subscribe(topic, qos: .qos1)
        print("Subscribed to: \(topic)")
    }
    
    func handleMQTTEvents() {
        mqtt?.didConnectAck = { mqtt, ack in
            print("Connected to MQTT! Ack: \(ack)")
        }
        
        mqtt?.didReceiveMessage = { mqtt, message, id in
            if let msgString = message.string {
                DispatchQueue.main.async {
                    self.receivedMessage = msgString
                    print("Received message from \(message.topic): \(msgString)")
                }
            }
        }
        
        mqtt?.didPublishMessage = { mqtt, message, id in
            print("Message published to \(message.topic): \(message.string ?? "No message")")
        }
        
        mqtt?.didPublishAck = { mqtt, id in
            print("Publish ack ID: \(id)")
        }
        
        mqtt?.didSubscribeTopics = { mqtt, success, failed in
            print("Subscribtion success: \(success)")
        }
        
        mqtt?.didUnsubscribeTopics = { mqtt, topics in
            print("Unsubscribed from: \(topics)")
        }
        
        mqtt?.didDisconnect = { mqtt, err in
            print("Disconnected: \(err?.localizedDescription ?? "No error")")
        }
    }
}
