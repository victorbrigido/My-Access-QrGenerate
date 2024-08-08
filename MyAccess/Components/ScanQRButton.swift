//
//  ScanQRButton.swift
//  MyAcess
//
//  Created by Victor Brigido on 15/03/24.
//

import SwiftUI

struct ScanQRButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Ler QRCode")
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 120, height: 50)
        .background(Color.green)
        .cornerRadius(.infinity)//
    }
}

#Preview {
    ScanQRButton(action: {})
}
