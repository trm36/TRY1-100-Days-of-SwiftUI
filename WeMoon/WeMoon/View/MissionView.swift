//
//  MissionView.swift
//  WeMoon
//
//  Created by Taylor on 09 October 2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        
                        if let launchDateString = mission.extentedLaunchDate {
                            Text(launchDateString)
                                .padding(.top)
                        }
                        
                        Partition()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Partition()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission) {
        self.mission = mission
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[1])
            .preferredColorScheme(.dark)
    }
}
