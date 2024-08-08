//
//  FirebaseServices.swift
//  MyAcess
//
//  Created by Victor Brigido on 11/03/24.
//

//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//
//
//class FirebaseServices {
//    static let shared = FirebaseServices() // Singleton para acessar facilmente os serviços Firebase
//    
//    private let db = Firestore.firestore()
//    
//    func verificarUsuario(uid: String, completion: @escaping (Bool, String?) -> Void) {
//        // Consulta para verificar se existe um usuário com o UID fornecido
//        db.collection("usuarios").whereField("UID", isEqualTo: uid).getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Erro ao consultar o Firestore: \(error.localizedDescription)")
//                completion(false, nil)
//                return
//            }
//            
//            if let snapshot = snapshot, !snapshot.isEmpty {
//                // Um usuário com o UID fornecido foi encontrado
//                if let document = snapshot.documents.first, let nome = document.data()["nome"] as? String {
//                    completion(true, nome)
//                } else {
//                    completion(true, nil)
//                }
//            } else {
//                // Nenhum usuário com o UID fornecido foi encontrado
//                completion(false, nil)
//            }
//        }
//    }
//}

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseServices: ObservableObject {
    static let shared = FirebaseServices() // Singleton para acessar facilmente os serviços Firebase
    private let db = Firestore.firestore()
    
    @Published var currentUser: User?
    @Published var userDataLoaded = false // Indica se os dados do usuário foram carregados

    
    func verificarQrUsuario(qrCodeData: String, completion: @escaping (Bool, String?) -> Void) {
        // Consulta se o qrCodeData existe no Firestore e seleciona apenas os campos 'nome' e 'qrCodeData'
        db.collection("usuarios").whereField("qrCodeData", isEqualTo: qrCodeData).getDocuments { (snapshot, error) in
            if let error = error {
                print("Erro ao consultar o Firestore: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            
            if let snapshot = snapshot, !snapshot.isEmpty {
                // qrCodeData encontrado no Firestore, usuário autorizado
                if let document = snapshot.documents.first, let nome = document.data()["nome"] as? String {
                    completion(true, nome)
                } else {
                    completion(true, nil)
                }
            } else {
                // qrCodeData não encontrado no Firestore, usuário não autorizado
                completion(false, nil)
            }
        }
    }

    
}
