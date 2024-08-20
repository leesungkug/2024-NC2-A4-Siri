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
            Button(action: {
                if let fakeCall = fakeCallSet.first {
                    modelContext.delete(fakeCall)
                }
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 24)
                        .foregroundStyle(.tint)
                    Text("뒤로")
                        .font(.system(size: 16))
                        .foregroundStyle(.tint)
                    Spacer()
                }
            })
            .padding(.top , 140)
            .padding(.horizontal)
            VStack {
                Text("말해보세요")
                    .font(.system(size: 16))
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .padding(.top, 409)
                Text("\(shortcut?.userActivity?.suggestedInvocationPhrase ?? "값이 설정되어 있지 않아요")")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 1)
                Spacer()
//                HStack{
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
//                    Spacer()
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
//                }
                .padding(.bottom, 140)
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
                Text("ds")
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
