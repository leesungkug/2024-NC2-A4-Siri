//
//  GifImage.swift
//  kkusu
//
//  Created by sungkug_apple_developer_ac on 6/18/24.
//

import SwiftUI
import UIKit
import ImageIO

struct GifImageView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        loadGif(name: gifName, into: imageView)
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        // SwiftUI의 상태 변경에 따라 UI 업데이트를 여기에 구현
    }
    
    private func loadGif(name: String, into imageView: UIImageView) {
        guard
            let gifURL = Bundle.main.url(forResource: name, withExtension: "gif"),
            let gifData = try? Data(contentsOf: gifURL),
            let source = CGImageSourceCreateWithData(gifData as CFData, nil)
        else { return }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()

        (0..<frameCount)
            .compactMap { CGImageSourceCreateImageAtIndex(source, $0, nil) }
            .forEach { images.append(UIImage(cgImage: $0)) }

        imageView.animationImages = images
        imageView.animationDuration = TimeInterval(frameCount) * 0.05 // 0.05는 임의의 값
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
}


struct AontentView: View {
    var body: some View {
        ZStack {
            GifImageView(gifName: "mainBackground")
                .aspectRatio(contentMode: .fill)
        }
        .edgesIgnoringSafeArea(.all)
        .background(.red)
    }
}

struct AontentView_Previews: PreviewProvider {
    static var previews: some View {
        AontentView()
    }
}
