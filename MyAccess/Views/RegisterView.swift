//
//  RegisterView.swift
//  MyAcess
//
//  Created by Victor Brigido on 15/03/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var nome = ""
    @State private var cpf = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Nome", text: $nome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("CPF", text: $cpf)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("senha", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 5)
                
                SecureField("Confirme sua senha", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 5)
                
                Button(action: {
                    registerUser()
                }) {
                    Text("Cadastrar")
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: 300 , height: 30)
                .background(Color.green)
                .cornerRadius(9.0)
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sucesso!"), message: Text("Usuário criado com sucesso."), dismissButton: .default(Text("OK"), action: {
                        clearFields()
                        presentationMode.wrappedValue.dismiss()
                    }))
                }
                
                Spacer()
            }
            .padding()
            .padding(.top, 20)
            .navigationTitle("Cadastre-se")
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
    
    func registerUser() {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Erro ao criar o usuário: \(error.localizedDescription)")
                } else {
                    print("Usuário criado com sucesso.")
                    createUserDocumentIfNeeded()
                    showAlert = true
                }
            }
        } else {
            print("As senhas não coincidem.")
        }
    }
    
    func createUserDocumentIfNeeded() {
            guard let currentUser = Auth.auth().currentUser else {
                print("Nenhum usuário está autenticado.")
                return
            }
            
            guard !nome.isEmpty else {
                print("O nome do usuário está vazio.")
                return
            }
            
            let db = Firestore.firestore()
            let userRef = db.collection("usuarios").document(currentUser.uid)
            
            let userData: [String: Any] = [
                "email": email,
                "nome": nome,
                "cpf": cpf, // Inclui o CPF no documento do usuário
                "UID": currentUser.uid
            ]
            
            userRef.setData(userData) { error in
                if let error = error {
                    print("Erro ao criar o documento do usuário: \(error.localizedDescription)")
                } else {
                    print("Documento do usuário criado com sucesso no Firestore.")
                }
            }
        }
    
    func clearFields() {
        email = ""
        password = ""
        confirmPassword = ""
        nome = ""
    }
}

#Preview {
    RegisterView()
}
