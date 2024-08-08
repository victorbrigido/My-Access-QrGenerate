//
//  LoginView.swift
//  MyAcess
//
//  Created by Victor Brigido on 11/03/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @StateObject var sessionManager = SessionManager.shared
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    @State private var isRegistering = false

    var body: some View {
        VStack {
            Image("Imagelog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Login")
                .font(.largeTitle)
                .padding(.top, 30)
                
            VStack{
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                SecureField("Senha", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 4)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.callout)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
            
            
            
            Button(action: {
                signIn()
            }) {
                Text("Entrar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            HStack {
                Text("Não é cadastrado ainda?")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Button {
                    isRegistering = true
                } label: {
                    Text("Cadastre-se")
                }
            }
            Spacer()
            
            Text("Version 1.0")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationBarHidden(true) // Esconder a barra de navegação para esta view
        .fullScreenCover(isPresented: $isLoggedIn, content: {
            HomeView()
        })
        .fullScreenCover(isPresented: $isRegistering, content: {
            RegisterView()
        })
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                print(errorMessage)
            } else {
                if let user = authResult?.user {
                    isLoggedIn = true
                    sessionManager.signIn(withUser: User(uid: user.uid,
                                                         nome: "",
                                                         cpf: 0,
                                                         email: "",
                                                         empresaassociada: "",
                                                         eventosregistrados: "",
                                                         nivel: "",
                                                         timeacesso: Date()))
                    sessionManager.fetchUserData()
                    print("Usuário logado: \(user.uid)")
                }
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



