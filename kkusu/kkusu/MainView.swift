//
//  MainView.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import SwiftData
import Lottie

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    @Query var fakeCallSet: [FakeCallSetting]
    @State private var sliderValue: Double = 50.0
    @Binding var isShowModal: Bool

    var body: some View {
        ZStack{
            GifView("mainBackground")
                .frame(height: 990)
            
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading) {
                        Text("Exit Call")
                            .foregroundStyle(.white)
                            .font(.system(size: 36, weight: .regular))
                            .padding(.top, 209)
                            .padding(.bottom, 1)
                        Text("가짜 전화 Siri를 사용해서\n불편한 상황에서 벗어나보세요")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .padding(.leading, 26)
                    Spacer()
                }
                
                Spacer()

                SetCallButton(showModal: $isShowModal)
                    .padding(.bottom, 152)
            }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $isShowModal, content: {
            SetView(showModal: $isShowModal)
        })

    }
}

//#Preview {
//    MainView(isShowModal: <#T##Binding<Bool>#>)
//}
