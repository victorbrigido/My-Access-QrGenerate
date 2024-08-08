//
//  TestView.swift
//  MyAcess
//
//  Created by Victor Brigido on 18/03/24.
//

import SwiftUI

struct TestView: View {
    @State private var name: String = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack {
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
        .padding()
    }
}

#Preview {
    TestView()
}
