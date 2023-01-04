//
//  Bluetooth.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-31.
//

import Foundation
import SwiftUI
import CoreBluetooth
import UIKit


struct CBUUIDs{

    static let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)

}


struct PreviewViewController: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}


extension ControllerView: UIViewControllerRepresentable{
    func makeUIViewController(context: UIViewControllerRepresentableContext<ControllerView>) -> ControllerView{
        let ViewContoller = ControllerView()
        
        return ViewContoller
    }
    
    func updateUIViewController(_ pageViewController: ControllerView, context: UIViewControllerRepresentableContext<ControllerView>){
    }
}

extension ControllerView: CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
         switch central.state {
              case .poweredOff:
                  print("Is Powered Off.")
              case .poweredOn:
                  print("Is Powered On.")
                  startScanning()
              case .unsupported:
                  print("Is Unsupported.")
              case .unauthorized:
              print("Is Unauthorized.")
              case .unknown:
                  print("Unknown")
              case .resetting:
                  print("Resetting")
              @unknown default:
                print("Error")
              }
      }
    
    
    func startScanning() -> Void {
      // Start Scanning
      centralManager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID])
    }
    
    
}

extension ControllerView: CBPeripheralDelegate {
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        bluefruitPeripheral = peripheral
        bluefruitPeripheral.delegate = self

        print("Peripheral Discovered: \(peripheral)")
        print("Peripheral name: \(peripheral.name)")
        print ("Advertisement Data : \(advertisementData)")
        
        centralManager?.connect(bluefruitPeripheral!, options: nil)
       }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
       bluefruitPeripheral.discoverServices([CBUUIDs.BLEService_UUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            print("*******************************************************")

            if ((error) != nil) {
                print("Error discovering services: \(error!.localizedDescription)")
                return
            }
            guard let services = peripheral.services else {
                return
            }
            //We need to discover the all characteristic
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
            print("Discovered Services: \(services)")
        }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
           
               guard let characteristics = service.characteristics else {
              return
          }

          print("Found \(characteristics.count) characteristics.")

          for characteristic in characteristics {

            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx)  {

              rxCharacteristic = characteristic

              peripheral.setNotifyValue(true, for: rxCharacteristic!)
              peripheral.readValue(for: characteristic)

              print("RX Characteristic: \(rxCharacteristic.uuid)")
            }

            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Tx){
              
              txCharacteristic = characteristic
              
              print("TX Characteristic: \(txCharacteristic.uuid)")
            }
          }
        func disconnectFromDevice () {
            if bluefruitPeripheral != nil {
            centralManager?.cancelPeripheralConnection(bluefruitPeripheral!)
            }
         }
        
    }
}

extension ControllerView: CBPeripheralManagerDelegate {

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    switch peripheral.state {
    case .poweredOn:
        print("Peripheral Is Powered On.")
    case .unsupported:
        print("Peripheral Is Unsupported.")
    case .unauthorized:
    print("Peripheral Is Unauthorized.")
    case .unknown:
        print("Peripheral Unknown")
    case .resetting:
        print("Peripheral Resetting")
    case .poweredOff:
      print("Peripheral Is Powered Off.")
    @unknown default:
      print("Error")
    }
  }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

          var characteristicASCIIValue = NSString()

          guard characteristic == rxCharacteristic,

          let characteristicValue = characteristic.value,
          let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

          characteristicASCIIValue = ASCIIstring

          print("Value Recieved: \((characteristicASCIIValue as String))")
    }
    
    func writeOutgoingValue(data: String){
          
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        
        if let bluefruitPeripheral = bluefruitPeripheral {
              
          if let txCharacteristic = txCharacteristic {
                  
            bluefruitPeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
              }
          }
      }

}


final class ControllerView: UIViewController {
    var centralManager: CBCentralManager!
    private var bluefruitPeripheral: CBPeripheral!
    private var txCharacteristic: CBCharacteristic!
    private var rxCharacteristic: CBCharacteristic!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        CreateButton()
     }
    
    func CreateButton(){
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y:100, width: 100, height: 50)
        button.backgroundColor = UIColor.green
        button.setTitle("Press me", for: .normal)
        
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
}
