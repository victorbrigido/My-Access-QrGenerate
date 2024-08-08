//
//  Chronometer.swift
//  MyAcess
//
//  Created by Victor Brigido on 12/03/24.
//


import SwiftUI
import Firebase
import FirebaseFirestore


struct CircleProgressBar: View {

    var progress: Double // Accept the binding as a parameter

  var body: some View {
    ZStack {
      Circle()
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
        .foregroundColor(.white)

      Circle()
        .trim(from: 0, to: 1 - progress)
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
        .foregroundColor(.green)
        .rotationEffect(.degrees(-90))
    }
  }
}

struct Chronometer: View {
    @StateObject var sessionManager = SessionManager.shared
    @State private var timeRemaining = 60 // Tempo inicial em segundos
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack {
      ZStack {
          CircleProgressBar(progress: calculateProgress()) // Pass the binding directly
          .frame(width: 100, height: 100)

          VStack {
              Text("\(timeRemaining)s")
                  .font(.title)
              
              Text("Validade")
                  .font(.caption)
                  .foregroundColor(.gray)
          }
          
      }

    }
    .onReceive(timer) { _ in
      if timeRemaining > 0 {
        timeRemaining -= 1 // Decrementa o tempo restante
      } else {
          
       
          
          sessionManager.QRCodeGenerate()

          
        // Reinicia o cronômetro
        timeRemaining = 60
      }
    }
  }
    
    func calculateProgress() -> Double {
        return 1 - Double(timeRemaining) / Double(60) // Inverted calculation for decreasing progress
      }

    func resetTimer() {
        timeRemaining = 60 // Reinicia o tempo
    }
    func generateNewQrCode() {
        // TODO: Gerar novo QR Code (implementation needed)
        print("Tempo esgotado! Gerando novo QR Code...")
    }
    
}

#Preview {
  Chronometer()
}
