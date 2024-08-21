//
//  kkusuApp.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import SwiftData

@main
struct kkusuApp: App {
    @AppStorage("deviceHeight") var deviceHeight: Int = UserDefaults.standard.integer(forKey: "deviceHeight")
    
    var modelContainer : ModelContainer = {
        let schema = Schema([FakeCallSetting.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .modelContainer(modelContainer)
                    .onAppear(perform: {
                        let screenSize = UIScreen.main.bounds.size
                        deviceHeight = Int(screenSize.height)
                        print("Screen width: \(screenSize.width), height: \(screenSize.height)")
                    })
        }
    }
}


