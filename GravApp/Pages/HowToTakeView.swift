//
//  HowToTakeVideo.swift
//  GravApp
//
//  Created by Yoshiyuki Kitaguchi on 2022/02/07.
//
// slideShow: https://www.youtube.com/watch?v=swRm-_2E834&t=97s

import SwiftUI
import CryptoKit
import AVKit

struct HowToTakeView: View {
    
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var imageData : Data = .init(capacity:0)
    @State var rawImage : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .camera

    @State var isActionSheet = true
    @State var isImagePicker = true
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    
    var body: some View {
        NavigationView{
            GeometryReader{bodyView in
                VStack(spacing:0){
                    ScrollView{
                        Group{
                        Text("撮影方法")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.bottom)

                        Text("①画面上部にあるカメラを固視して、自撮り動画を撮影します")
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)


                        Text("②楕円形のガイドに顔の輪郭を合わせます")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width)

                            //.padding(.bottom)

                        Image("starePoint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)

                        Text("③撮影ボタンを押します")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)

                        Text("④まずは正面視で")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width)

                        Image("straight")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)
                        
                        Text("⑤カメラを見たままで顔をゆっくりと回転")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width)
                        
                        Image("rotate")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)
                            
                        Text("⑥3回顔を回したら撮影終了")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width)
                            
                        }
                        


                        Button(action: {
                            self.goTakePhoto = true /*またはself.show.toggle() */
                            self.user.isSendData = false //撮影済みを解除
                            ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                        }) {
                            HStack{
                                Image(systemName: "camera")
                                Text("撮影")
                            }
                                .foregroundColor(Color.white)
                                .font(Font.largeTitle)
                        }
                            .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                            .background(Color.black)
                            .padding()
                        .sheet(isPresented: self.$goTakePhoto) {
                            CameraPage(user: user)
                        }
                    }
                }
            }
        }
    

    }

}

var images: [UIImage]! = [UIImage(named:"1")!,
                          UIImage(named:"1")!,
                          UIImage(named:"1")!,
                          UIImage(named:"2")!,
                          UIImage(named:"3")!,
                          UIImage(named:"4")!,
                          UIImage(named:"5")!,
                          UIImage(named:"6")!,
                          UIImage(named:"7")!,
                          UIImage(named:"8")!,
                          UIImage(named:"9")!,
                          UIImage(named:"10")!]
                          
let imageSlides = UIImage.animatedImage(with: images, duration: 2.0)
            
                          
struct startSlideShow: UIViewRepresentable{
    func makeUIView(context: Self.Context) -> UIView {
        let width = UIScreen.main.bounds.size.width
        let myView = UIView(frame: CGRect(x:0, y:0, width: width, height: width))
        let myImage = UIImageView(frame: CGRect(x:0, y:0, width: width, height: width))
        myImage.contentMode = UIView.ContentMode.scaleAspectFit
        myImage.image = imageSlides
        myView.addSubview(myImage)
        
        return myView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<startSlideShow>){
        print("updated!")
    }
}
