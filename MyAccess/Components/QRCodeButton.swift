//
//  QRCodeButton.swift
//  MyAcess
//
//  Created by Victor Brigido on 15/03/24.
//

import SwiftUI

struct QRCodeButton: View {
    var body: some View {
        HStack {
            Button{
                print("invite button tapped!")
            } label: {
                Text("Ler QrCode")
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
    QRCodeButton()
}
