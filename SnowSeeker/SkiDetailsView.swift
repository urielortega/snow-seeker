//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Uriel Ortega on 21/07/23.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }
            .accessibilityElement()
            .accessibilityLabel("Elevation: \(resort.elevation) meters.")
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
            .accessibilityElement()
            .accessibilityLabel("Snow depth: \(resort.snowDepth) centimeters.")

        }
        .frame(maxWidth: .infinity)
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: .example)
    }
}
