//
//  ContentView.swift
//  SwiftUI_Compus
//
//  Created by Towhid on 4/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var compassHeading = CompassHeading()
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 5,
                       height: 50)
            // 1
            ZStack {
                // 2
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegress: 0)
                }
            }
            .frame(width: 300,
                   height: 300)
            .rotationEffect(Angle(degrees: self.compassHeading.degrees))// 3
            .statusBar(hidden: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }

    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }

    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "S"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "W"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "N"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "E"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}


struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double
    
    var body: some View {
        VStack {Text(marker.degreeText())
                .fontWeight(.light)
                .rotationEffect(self.textAngle()) // 1
            
            Capsule()
                .frame(width: self.capsuleWidth(), // 2
                       height: self.capsuleHeight()) // 3
                .foregroundColor(self.capsuleColor()) // 4
                .padding(.bottom, 120)
            
            Text(marker.label)
                .fontWeight(.bold)
                .rotationEffect(self.textAngle()) // 5
                .padding(.bottom, 80)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }
    
    // 1
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }
    
    // 2
    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45 : 30
    }
    
    // 3
    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }
    
    // 4
    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
    
}



