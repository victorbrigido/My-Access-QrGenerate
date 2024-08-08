//
//  QRCodeScannerView.swift
//  MyAcess
//
//  Created by Victor Brigido on 15/03/24.
//

import SwiftUI
import CodeScanner
import Foundation

struct QRCodeScannerView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a qrCode"
    @State var isUserAuthorized = false
    @State var userName: String? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var scannerSheet: some View {
        CodeScannerView(codeTypes: [.qr]) { result in
            if case let .success(code) = result {
                self.scannedCode = code.string
                self.isPresentingScanner = false
                
                
                FirebaseServices.shared.verificarQrUsuario(qrCodeData: code.string) { isAuthorized, nome in
                    self.isUserAuthorized = isAuthorized
                    self.userName = nome
                }
            }
        }
    }
    
//    var scannerSheet: some View {
//            CodeScannerView(codeTypes: [.qr]) { result in
//                if case let .success(code) = result {
//                    self.scannedCode = code.string
//                    self.isPresentingScanner = false
//
//                    FirebaseServices.shared.verificarQrUsuario(qrCodeData: code.string) { isAuthorized, nome in
//                        self.isUserAuthorized = isAuthorized
//                        self.userName = nome
//
//                        // Define o QR Code como utilizado após a autorização
//                        if isAuthorized {
//                            self.isQRCodeUsed = true
//                        }
//                    }
//                }
//            }
//        }
    



    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
//                Text(scannedCode)
//                    .foregroundColor(.black)
                
                
                if isUserAuthorized {
                    if let nome = userName {
                            Text("Bem-Vindo \(nome)")
                            .foregroundColor(.black)
                        }
                    
                    Text("Usuário autorizado!")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    Text("Usuário não autorizado!")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                
                ScanQRButton {
                    isPresentingScanner = true
                }
                .foregroundColor(.blue)
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                
            }
            .navigationTitle("Scanner QR Code")
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            )
        }
    }

    struct QRCodeScannerView_Previews: PreviewProvider {
        static var previews: some View {
            QRCodeScannerView()
        }
    }
}


