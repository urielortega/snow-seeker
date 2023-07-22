//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Uriel Ortega on 21/07/23.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var priceLabel: String {
        switch resort.price {
        case 1:
            return "Low"
        case 2:
            return "Moderate"
        default:
            return "High"
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
            .accessibilityElement()
            .accessibilityLabel("Size: \(size).")
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
            .accessibilityElement()
            .accessibilityLabel("Price: \(priceLabel).")
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
