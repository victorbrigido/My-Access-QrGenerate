//
//  HomeView.swift
//  MyAcess
//
//  Created by Victor Brigido on 11/03/24.
//

import SwiftUI

struct HomeView: View {
    @State private var isMenuOpen = false
    
    var body: some View {
        ZStack {
            // Conteúdo principal com efeito de desfoque quando o menu estiver aberto
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            isMenuOpen.toggle() // Alterna o estado do menu
                        }
                    } label: {
                        Image(systemName: "text.justify")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.green)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("MyAccess")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button {
                        // Ação do botão
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                    .padding()
                }
                .padding(.top, 50)
               
                
                InviteButton()
                    .padding(.top, 30)
                
                Spacer()
                
                Chronometer()
                    .padding()
                
                HStack {
                   QrProfileView()
                }
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .zIndex(0) // Coloca o conteúdo principal atrás do menu
            .blur(radius: isMenuOpen ? 10 : 0) // Efeito de desfoque
            
            // Menu lateral
            if isMenuOpen {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.toggle() // Recolhe o menu quando clicado fora dele
                        }
                    }
                
                MenuView()
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: .leading))
                    .zIndex(1) // Coloca o menu sobre o conteúdo principal
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}





#Preview {
    HomeView()
}
