//
//  ContentView.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var fakeCallSet: [FakeCallSetting]
    @StateObject var callProviderDelegate = FakeCallProviderDelegate()
    @State var isWait = false
    @State private var isShortcutHandled = false
    @State var isShowModal = false

    var body: some View {
        if fakeCallSet.isEmpty{
            MainView(isShowModal: $isShowModal)
        } else {
            ActivatedView(callProviderDelegate : callProviderDelegate, isWait: $isWait, isShowModal: $isShowModal)
                .onContinueUserActivity(UserActivityShortcutsManager.Shortcut.fakeCall.type, perform: { userActivity in
                    
                    guard !isShortcutHandled else { return }
                    isShortcutHandled = true
                    
                    isWait = true
                    if let firstFakeCall = fakeCallSet.first {
                        let initialDelay = Double(firstFakeCall.delayTime)
//                        let reAlertDelay = initialDelay + 120

                        DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) {
                            triggerFakeCall(callProviderDelegate: callProviderDelegate, caller: firstFakeCall.caller)
                        }

//                        if firstFakeCall.reAlret {
//                            print("reAlert")
//                            DispatchQueue.main.asyncAfter(deadline: .now() + reAlertDelay) {
//                                triggerFakeCall(callProviderDelegate: callProviderDelegate, caller: firstFakeCall.caller)
//                            }
//                        }
                    }
                })
                .onChange(of: callProviderDelegate.isCallEnded) { oldValue, newValue in
                    if newValue {
                        isWait = false
                    }
                }
                
        }
    }
}

func triggerFakeCall(callProviderDelegate : FakeCallProviderDelegate, caller: String) {
    let uuid = UUID()
    let handle = caller
    callProviderDelegate.reportIncomingCall(uuid: uuid, handle: handle)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
