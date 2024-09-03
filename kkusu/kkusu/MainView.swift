//
//  MainView.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @AppStorage("deviceHeight") var deviceHeight: Int = UserDefaults.standard.integer(forKey: "deviceHeight")
    @Environment(\.modelContext) var modelContext
    @Query var fakeCallSet: [FakeCallSetting]
    @State private var sliderValue: Double = 50.0
    @Binding var isShowModal: Bool
    @State var isInfo = false
    
    var body: some View {
        ZStack(alignment: .top) {
//            GifView("mainBackground")
//                .frame(height: 990)
            GifImageView(gifName: "mainBackground")
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        isInfo.toggle()
                    }, label: {
                        
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(Color.infoButton)
                    })
                }
                .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Exit Call")
                            .foregroundStyle(.white)
                            .font(.system(size: 36, weight: .regular))
                            .padding(.bottom, 1)
                        Text("가짜 전화 Siri를 사용해서\n불편한 상황에서 벗어나보세요")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .padding(.top, 69)
                    .padding(.leading, 26)
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    isShowModal.toggle()
                } label: {
                    Image("setbutton")
                        .resizable()
                        .scaledToFit()
                }
//                .padding(.bottom, 12)
                .padding(.horizontal, 24)


//                SetCallButton(showModal: $isShowModal)
//                    .padding(.bottom, 12)

            }
            .padding(.vertical, deviceHeight < 800 ? 120 : 80)
            
            if isInfo {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0){
                        Text("ExitCall 사용법")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.backcolor)
                        Text("설정하기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.button1)
                            .padding(.top, 16)
                        Text("타이머 - 전화가 오는 타이밍을 설정해요")
                            .font(.system(size: 14, weight: .regular))
                            .padding(.top, 6)
                            .foregroundStyle(.black)
                        
                        Text("발신자 = 누구와 전화가 오게 할 지 정해요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text("Siri 문구 설정 - Siri에게 전화가 오게 할 문구를 입력해요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text("사용하기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.button1)
                            .padding(.top, 12)
                        Text("1. Siri를 실행해주세요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.top, 6)
                        
                        Text("2. 설정한 문구를 말하고 전화를 받으세요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text("Siri없이 사용하기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.button1)
                            .padding(.top, 12)
                        Text("설정 후 실행하기를 누르면 바로 전화가 와요")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.top, 6)
                        
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 14)
                }
                .background(Color.infoBackground.opacity(96.0))
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 16)
                .padding(.top , deviceHeight < 800 ? 160 : 120)
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
