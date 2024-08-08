//
//  AccountView.swift
//  MyAcess
//
//  Created by Victor Brigido on 17/03/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
//import FirebaseFirestoreSwift

struct AccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var sessionManager = SessionManager.shared
        
    var body: some View {
        
        HStack() {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            }
            .padding()
            
            Spacer()
            
            Text("Dados da conta")
                .font(.title3)
            
            Spacer()
            
            Button(action: {
                // Implemente a ação desejada para o segundo botão
            }) {
                Image(systemName: "qrcode")
                    .foregroundColor(.black)
            }
            .padding()
            
        }
        //        .background(Color.blue)
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
        VStack() {
            
            Divider()
                .shadow(color: Color.black.opacity(2), radius: 3, x: 0, y: 2)
            
            HStack() {
                Text("Detalhes da conta")
                    .padding()
                
                Spacer()
                
                Image(systemName: "globe.americas")
                    .padding(.trailing, 20)
                
            }
            
            HStack {
                CardUser()
            }
            
            HStack() {
                Text("Perfis de acesso")
                    .font(.caption)
                    .padding(.leading)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            HStack () {
            if let user = sessionManager.currentUser {
                Text(user.empresaassociada)
                    .font(.caption2)
                    .padding(.leading)
            } else {
                Text("Empresa associada não disponível")
                    .font(.caption2)
                    .padding(.leading)
            }
                            
                Spacer()
            }
            
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Excluir conta")
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ligthgray)
        .onAppear {
            guard let currentUser = Auth.auth().currentUser else {
                print("Nenhum usuário logado")
                return
            }
            
            retrieveUserData(currentUserUID: currentUser.uid)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    func retrieveUserData(currentUserUID: String) {
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
            
            if let userData = document.data(),
               let nome = userData["nome"] as? String,
               let cpf = userData["cpf"] as? Int,
               let email = userData["email"] as? String,
               let empresaassociada = userData["empresaassociada"] as? String,
               let eventosregistrados = userData["eventosregistrados"] as? String,
               let nivel = userData["nivel"] as? String {
                // Criar um objeto User com os dados recuperados
                let user = User(uid: currentUserUID,
                                nome: nome,
                                cpf: cpf,
                                email: email,
                                empresaassociada: empresaassociada,
                                eventosregistrados: eventosregistrados,
                                nivel: nivel,
                                timeacesso: Date())
                
                // Assinar o usuário no SessionManager
                SessionManager.shared.signIn(withUser: user)
                
                print("Dados do usuário recuperados com sucesso.")
            } else {
                print("Dados do usuário incompletos ou inválidos.")
            }
            
        }
        
    }
    
}




#Preview {
    AccountView()
}
