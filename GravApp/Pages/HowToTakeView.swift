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
    private let player = AVPlayer(url: Bundle.main.url(forResource: "Tutorial", withExtension: "mp4")!)
    
    
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

                        Text("①楕円形のガイドに顔の輪郭を合わせます（少しはみ出てもOK）")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)


                        Text("②画面上部にあるカメラを固視")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)

                            //.padding(.bottom)

                        Image("starePoint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)

                        Text("③撮影ボタンを押す")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)

                        Text("④まずは正面視でカメラを見て")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                            
                        Text("⑤（カメラから目線を外して）顔を上向き→下向き")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                            
                        Text("⑥（カメラから目線を外して）顔を右向き→左向き")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                            
                        Text("⑦（再びカメラ目線で）目を見開く")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                            
                        Text("⑧撮影終了ボタンを押す")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                        }
                        
                        //Tutorial動画
                        ZStack{
                            VideoPlayer(player: player).frame(width: bodyView.size.width, height:bodyView.size.width)
                        }
                        

                        Button(action: {
                            self.user.isSendData = false //撮影済みを解除
                            ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                            //self.presentationMode.wrappedValue.dismiss()
                            self.goTakePhoto = true /*またはself.show.toggle() */
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



