//
//  UserManager.swift
//  MyAcess
//
//  Created by Victor Brigido on 18/03/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct User: Equatable {
    let uid: String
    let nome: String
    let cpf: Int
    let email: String
    let empresaassociada: String
    let eventosregistrados: String
    let nivel: String
    var timeacesso: Date
}

class SessionManager: ObservableObject {
    @Published var currentUser: User?
    @Published var userDataLoaded = false // Indica se os dados do usuário foram carregados
    private let db = Firestore.firestore()
    static let shared = SessionManager()
    
    
    private init() {}
    
    func signIn(withUser user: User) {
        currentUser = user
        // Chame a função para obter os dados do usuário do Firestore após o login
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let currentUser = currentUser else {
            print("currentUser é nil2")
            return
        }

        // Obtém a referência do documento do usuário no Firestore usando o ID do usuário
        let userDocRef = db.collection("usuarios").document(currentUser.uid)

        // Obtém os dados do documento do usuário
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                // O documento do usuário existe, então podemos acessar os dados
                if let data = document.data() {
                    // Mapeia os dados do documento para o objeto User
                    if let nome = data["nome"] as? String,
                       let cpf = data["cpf"] as? Int,
                       let email = data["email"] as? String,
                       let empresaassociada = data["empresaassociada"] as? String,
                       let eventosregistrados = data["eventosregistrados"] as? String,
                       let nivel = data["nivel"] as? String,
                       let timeacessoTimestamp = data["timeacesso"] as? Timestamp {

                        let timeacesso = timeacessoTimestamp.dateValue()

                        let fetchedUser = User(uid: currentUser.uid,
                                               nome: nome,
                                               cpf: cpf,
                                               email: email,
                                               empresaassociada: empresaassociada,
                                               eventosregistrados: eventosregistrados,
                                               nivel: nivel,
                                               timeacesso: timeacesso)

                        self.currentUser = fetchedUser
                        self.userDataLoaded = true
                    }
                }
            } else {
                print("Documento do usuário não encontrado")
            }
        }
    }

    
    
    func updateUserData(timeacesso: Date) {
            guard let currentUser = currentUser else {
                print("currentUser é nil ao tentar atualizar dados do usuário")
                return
            }

            let userDocRef = db.collection("usuarios").document(currentUser.uid)
            userDocRef.updateData(["timeacesso": timeacesso]) { error in
                if let error = error {
                    print("Erro ao atualizar dados do usuário: \(error.localizedDescription)")
                } else {
                    print("Dados do usuário atualizados com sucesso")
                }
            }
        }
    
    
    func QRCodeGenerate() {
        guard var currentUser = currentUser else {
            print("QRgenerate currentUser é nil")
            return
        }
        
        // Atualiza o tempo de acesso do usuário
        currentUser.timeacesso = Date()
        updateUserData(timeacesso: currentUser.timeacesso)
        
        // Cria um DateFormatter para formatar o horário
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current // Configura o fuso horário local do dispositivo
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Formato desejado da data
        
        // Formata o tempo de acesso para uma string usando o DateFormatter
        let formattedTime = dateFormatter.string(from: currentUser.timeacesso)
        
        // Cria uma string composta pelo UID do usuário e o tempo de acesso formatado
        let qrCodeData = "\(currentUser.uid)_\(formattedTime)"
        print("QR Code Data:", qrCodeData)
        
        // Atualiza o qrCodeData no Firestore
        updateQRCodeData(qrCodeData: qrCodeData)
        
        // Aqui você pode continuar com a lógica para gerar o código QR com base na string gerada
        generateQRCode(from: qrCodeData)
    }
    
    func updateQRCodeData(qrCodeData: String) {
        guard let currentUser = currentUser else {
            print("currentUser é nil ao tentar atualizar qrCodeData")
            return
        }
        
        let userDocRef = db.collection("usuarios").document(currentUser.uid)
        userDocRef.updateData(["qrCodeData": qrCodeData]) { error in
            if let error = error {
                print("Erro ao atualizar qrCodeData no Firestore: \(error.localizedDescription)")
            } else {
                print("qrCodeData atualizado com sucesso no Firestore")
            }
        }
    }

    
    
    
   @Published var qrCodeImage: UIImage? = nil
    
    func generateQRCode(from string: String) {
        guard let data = string.data(using: .ascii) else {
            print("Erro ao converter a string em data")
            return
        }
        
       
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")
        
        
        if let outputImage = filter.outputImage {
            let scaleX = UIScreen.main.scale * 10// Ajuste a escala conforme necessário
            let scaleY = UIScreen.main.scale * 10// Ajuste a escala conforme necessário
            let scaledOutput = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            if let cgImage = context.createCGImage(scaledOutput, from: scaledOutput.extent) {
                // Atualize a propriedade qrCodeImage com o novo QR Code
                DispatchQueue.main.async {
                    self.qrCodeImage = UIImage(cgImage: cgImage)
                }
            }
        }
    }
    

    



}
