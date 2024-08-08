//
//  MenuView.swift
//  MyAcess
//
//  Created by Victor Brigido on 12/03/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct MenuView: View {
    
    @State private var isShowingLogin = false
    @State private var isShowingQRScanner = false
    @State private var isShowingAccount = false
    @State private var userLevel: String = ""
    
    var onQRCodeTap: () -> Void = {} // Action for QR Code button
    var onReservationsTap: () -> Void = {} // Action for Reservations button
    var onAssociateCompanyTap: () -> Void = {} // Action for Associate Company button
    var onTermsOfUseTap: () -> Void = {} // Action for Terms of Use button
    var onPrivacyPoliciesTap: () -> Void = {} // Action for Privacy Policies button
    
    var body: some View {
        VStack(alignment: .leading) {
         
                Button {
                    onReservationsTap()
                } label: {
                    HStack {
                        Image(systemName: "calendar.badge.plus") // Optional icon for reservations
                            .foregroundColor(.white)
                        Text("Reservas")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 80)
                
                Button {
                    onAssociateCompanyTap()
                } label: {
                    HStack {
                        Image(systemName: "link") // Optional icon for association
                            .foregroundColor(.white)
                        Text("Associar Empresa")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
                
            Button(action: onAccountDetailsTap) {
                    
                    HStack {
                        Image(systemName: "person.circle") // Optional icon for account details
                            .foregroundColor(.white)
                        Text("Dados da Conta")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
                
                Button {
                    onTermsOfUseTap()
                } label: {
                    HStack {
                        Image(systemName: "doc.text") // Optional icon for terms of use
                            .foregroundColor(.white)
                        Text("Termos de Uso")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
                
                Button {
                    onPrivacyPoliciesTap()
                } label: {
                    HStack {
                        Image(systemName: "lock.shield") // Optional icon for privacy policies
                            .foregroundColor(.white)
                        Text("Políticas de Privacidade")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
            
            
            if userLevel == "moderador" { // Verificar se o usuário é moderador
                Button {
                    isShowingQRScanner = true
                } label: {
                    HStack {
                        Image(systemName: "qrcode")
                            .foregroundColor(.white)
                        Text("QR Code")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
                .fullScreenCover(isPresented: $isShowingQRScanner) {
                    QRCodeScannerView ()
                }
            }
                
                Spacer()
                
                Button(action: onLogoutTap) { 
                    HStack {
                        Image(systemName: "power")
                            .foregroundColor(.white)
//                            .bold()
                        Text("Logoff")
                            .foregroundColor(.white)
//                            .bold()
                    }
                    .padding(.leading)
                }
                .padding(.bottom)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Allow full height and width
            .edgesIgnoringSafeArea(.vertical) // Remove safe area insets
            .offset(x: -80) // Set horizontal offset to 0 (center) initially
            .fullScreenCover(isPresented: $isShowingLogin) {
                LoginView()
            }
            .fullScreenCover(isPresented: $isShowingAccount) {
                AccountView()
            }
            .onAppear {
                        // Recuperar o nível do usuário ao carregar a tela
                retrieveUserLevel()
            }
    }
    
    
    
    private func retrieveUserLevel() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("Usuário não autenticado.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("usuarios").document(currentUserUID)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Erro ao recuperar documento do usuário: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Documento do usuário não encontrado.")
                return
            }
            
            if let userData = document.data(), let nivel = userData["nivel"] as? String {
                self.userLevel = nivel
                print("Nível do usuário: \(nivel)")
            } else {
                print("Dados do usuário incompletos ou inválidos.")
            }
        }
    }

    
    
    private func onLogoutTap() {
        // Lógica de logoff
        do {
            try Auth.auth().signOut()
            isShowingLogin = true
            print("usuario desconectado")
        } catch {
            
            print("Erro ao fazer logoff: \(error.localizedDescription)")
        }
    }
    
    private func onAccountDetailsTap() {
        isShowingAccount = true
    }
}



#Preview {
    MenuView()
}
