//
//  ContentView.swift
//  Project_08_Moonshot
//
//  Created by Blaine Dannheisser on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var listView = false
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    ScrollView {
                        if listView == false {
                            LazyVGrid(columns: columns) {
                                ForEach(missions) { mission in
                                    NavigationLink {
                                        MissionView(mission: mission, astronauts: astronauts)
                                    } label: {
                                        VStack {
                                            GridBadge(badge: mission.image)
                                            VStack {
                                                MissionTitle(title: mission.displayName)
                                                DateTitle(date: mission.formattedLaunchDate)
                                            }
                                            .modifier(MissionDateLabel())
                                        }
                                        .modifier(MissionInfoFrame())
                                        
                                    }
                                }
                            }
                            // Challenge 3
                        } else {
                            VStack {
                                ForEach(missions) { mission in
                                    NavigationLink {
                                        MissionView(mission: mission, astronauts: astronauts)
                                    } label: {
                                        VStack {
                                            ListBadge(badge: mission.image)
                                            VStack {
                                                MissionTitle(title: mission.displayName)
                                                DateTitle(date: mission.formattedLaunchDate)
                                            }
                                            .modifier(MissionDateLabel())
                                        }
                                        .modifier(MissionInfoFrame())
                                    }
                                }
                            }
                        }
                    }
                }
                
                .padding([.horizontal, .bottom])
                .navigationTitle("Moonshot")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            listView.toggle()
                        } label: {
                            Image(systemName: listView == true ? "square.grid.2x2" : "list.dash")
                                .foregroundColor(.yellow)
                        }
                        
                    }
                })
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
