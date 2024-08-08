//
//  CardUser.swift
//  MyAcess
//
//  Created by Victor Brigido on 17/03/24.
//

import SwiftUI

struct CardUser: View {
    @ObservedObject var sessionManager = SessionManager.shared
    
    var body: some View {
        HStack {
            
            HStack() {
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80) // Defina o tamanho do círculo
                    .overlay(
                        Circle()
                            .stroke(Color.green, lineWidth: 4) // Defina a cor e a largura da borda
                            .frame(width: 80, height: 80) // Defina o tamanho da borda (um pouco maior que o círculo interno)
                    )
                    .overlay(
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray) // Cor da imagem
                            .padding(12) // Espaçamento interno da imagem dentro do círculo
                            .padding(.leading, 8)
                    )
                    .padding(.leading, 10)
            }
            .frame(width: 100)
            
//            Divider()
            
            
            VStack(alignment: .leading) {
            if let user = sessionManager.currentUser {
                Text(user.nome)
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                    .bold()
                
                Text("CPF: \(formatCPF(user.cpf))")
                    .font(.caption)
                    
                
                
                Text("E-mail:")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Text("Nenhum usuário logado") // Se não houver usuário logado
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                
                    
            }
            .padding()
           
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(15)
        .padding()
    }
    
    
    func formatCPF(_ cpf: Int) -> String {
            let cpfString = String(cpf)
            return cpfString
        }
}

#Preview {
    CardUser()
}
