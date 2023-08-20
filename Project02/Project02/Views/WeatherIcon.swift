//
//  WeatherIcon.swift
//  Project02
//
//  Created by Muneera Y on 04/02/1445 AH.
//

import Foundation
import SwiftUI
struct WeatherImageView: View {
    var icon: String
    
    var body: some View {
        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 150 , alignment: .center)
            default:
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
