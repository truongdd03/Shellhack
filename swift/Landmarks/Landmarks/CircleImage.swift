//
//  CircleImage.swift
//  Landmarks
//
//  Created by Don Truong on 11/2/21.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            Image("turtlerock")
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
