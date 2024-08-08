//
//  InviteButton.swift
//  MyAcess
//
//  Created by Victor Brigido on 12/03/24.
//

import SwiftUI

struct InviteButton: View {
    var body: some View {
        HStack {
            Button{
                
            } label: {
                Text("Convidar")
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .frame(width: 120, height: 50)
        .background(Color.green)
        .cornerRadius(.infinity)
    }
}

#Preview {
    InviteButton()
}
