//
//  ResortDetailsView.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/8/22.
//

import SwiftUI

// MARK: - ResortDetailsView

struct ResortDetailsView: View {
    let resort: Resort

    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Medium"
        case 3:
            return "Large"
        default:
            return "Unknown"
        }
    }

    var price: String {
        String(repeating: "$", count: resort.price)
    }

    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }

            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - ResortDetailsView_Previews

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
