//
//  ActivatedView.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import SwiftData
import Intents

struct ActivatedView: View {
    @AppStorage("deviceHeight") var deviceHeight: Int = UserDefaults.standard.integer(forKey: "deviceHeight")
    @Environment(\.modelContext) var modelContext
    @Query var fakeCallSet: [FakeCallSetting]
    var callProviderDelegate : FakeCallProviderDelegate
    @State var shortcut: INShortcut? = nil
    @Binding var isWait: Bool
    @Binding var isShowModal: Bool
    
    var body: some View {
        if !isWait{
            CheckView
        } else{
            WaitView
        }
    }
    
    func fetchShortcut() {
        UserActivityShortcutsManager.getExistingVoiceShortcut(for: UserActivityShortcutsManager.Shortcut.fakeCall.type) { fetchedShortcut in
            if let fetchedShortcut = fetchedShortcut {
                self.shortcut = fetchedShortcut
            }
        }
    }
    
    var CheckView: some View {
        ZStack(alignment: .top) {
            GifView("checkBackground")
                .frame(height: 990)
            HStack {
                Button(action: {
                    if let fakeCall = fakeCallSet.first {
                        modelContext.delete(fakeCall)
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 24)
                        .foregroundStyle(.tint)
                    Text("뒤로")
                        .font(.system(size: 16))
                        .foregroundStyle(.tint)
                })
                Spacer()
            }
            .padding(.top, deviceHeight < 800 ? 200 : 140)
            .padding(.horizontal)
            
            VStack {
                Text("Siri에게 말해보세요")
                    .font(.system(size: 16))
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .padding(.top, 409)
                Text("\(shortcut?.userActivity?.suggestedInvocationPhrase ?? "값이 설정되어 있지 않아요")")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 1)
                Spacer()
                //                    Button(action: {
                //                        guard let model = fakeCallSet.first else {
                //                            return
                //                        }
                //                        isShowModal = true
                //                        modelContext.delete(model)
                //                    }, label: {
                //                        VStack{
                //                            Image("재설정버튼")
                //                                .resizable()
                //                                .scaledToFit()
                //                                .frame(width: 79, height: 79)
                //                            Text("재설정")
                //                                .foregroundStyle(.black)
                //                        }
                //                    })
                
                Button(action: {
                    triggerFakeCall(callProviderDelegate: callProviderDelegate, caller: fakeCallSet.first?.caller ?? "엄마")
                }, label: {
                    VStack{
                        Image("재설정버튼")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 79, height: 79)
                        Text("실행하기")
                            .foregroundStyle(.black)
                    }
                })
                .padding(.bottom, deviceHeight < 800 ? 200 : 140)
                .padding(.horizontal, 39)
            }
        }
        .onAppear{
            fetchShortcut()
        }
    }
    
    var WaitView: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
            }
            Spacer()
        }
        .background(.black)
        .background(ignoresSafeAreaEdges: .all)
    }
}


//struct ActivatedView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        @State var iswait = true
//
//        ActivatedView(callProviderDelegate: FakeCallProviderDelegate(), isWait: $iswait)
//    }
//}
