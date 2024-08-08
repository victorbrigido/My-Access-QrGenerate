//
//  QrProfileView.swift
//  MyAcess
//
//  Created by Victor Brigido on 13/03/24.
//

import SwiftUI
import Firebase
import CoreImage.CIFilterBuiltins

struct QrProfileView: View {
    @StateObject var sessionManager = SessionManager.shared
//    @State private var qrCodeImage: UIImage? = nil
    
    var body: some View {
        VStack {
            if let qrCodeImage = sessionManager.qrCodeImage {
                Image(uiImage: qrCodeImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
                
                
            } else {
                Text("Carregando informações do usuário...")
                    .padding()
            }
        }
        .onAppear {
            sessionManager.QRCodeGenerate()
        }

    }

}
struct QrProfileView_Previews: PreviewProvider {
    static var previews: some View {
        QrProfileView()
    }
}

