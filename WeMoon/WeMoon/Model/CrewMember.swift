//
//  CrewMember.swift
//  WeMoon
//
//  Created by Taylor on 11 October 2022.
//

import Foundation

struct CrewMember {
    let role: String
    let astronaut: Astronaut
    
    static func crew(for mission: Mission) -> [CrewMember] {
        let allAstronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
        
        return mission.crew.map { (crewRole: Mission.CrewRole) in
            guard let astronaut = allAstronauts[crewRole.name] else { fatalError("Missing \(crewRole.name)")}
            return CrewMember(role: crewRole.role, astronaut: astronaut)
        }
    }
}
