//
//  MissionView.swift
//  Project_08_Moonshot
//
//  Created by Blaine Dannheisser on 1/17/22.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    MissionBadge(badge: mission.image)
                        .frame(maxWidth: geometry.size.width * 0.6)
                    // Challenge 1:
                    LaunchDateTitle(launchTitle: mission.formattedLaunchDate)
                    
                    VStack(alignment: .leading) {
                        
                        RectangleSpacer()
                        
                        MissionDetails(headline: mission.displayName, missionDetails: mission.description)
                        
                        RectangleSpacer()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        AstronautImage(astroImage: crewMember.astronaut.id)
                                            .frame(maxWidth: geometry.size.width * 0.4)
                                        AstronautDetails(astroName: crewMember.astronaut.name, astroBio: crewMember.role)
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
