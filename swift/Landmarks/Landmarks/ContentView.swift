//
//  ContentView.swift
//  Landmarks
//
//  Created by Don Truong on 9/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
                .ignoresSafeArea(edges: .top)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                .foregroundColor(.green)
                
                HStack() {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                
                Divider()
                
                Text("About the Turtle Rock")
                    .font(.title)
                Text("Descriptive text goes here")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
