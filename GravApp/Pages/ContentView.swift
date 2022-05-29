//
//  ContentView.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//
//写真Coredata参考サイト：https://tomato-develop.com/swiftui-camera-photo-library-core-data/
//


//hoWToTakeViewでカメラビューに移行する際にシートが消えない問題→ボタンを分ける実装wで


import SwiftUI
import CoreData

//変数を定義
class User : ObservableObject {
    @Published var date: Date = Date()
    @Published var age: Int = -1
    @Published var smokeYear: Int = 0
    @Published var smokeNum: Int = 0
    @Published var id: String = ""
    @Published var hashid: String = ""
    @Published var selected_gender: Int = -1
    @Published var selected_hospital: Int = 0
    @Published var selected_smoking: Int = -1
    @Published var selected_severity: Int = -1
    @Published var selected_CAS_retroBulbarPain: Int = -1
    @Published var selected_CAS_gazePain: Int = -1
    @Published var selected_subj_lidSwelling: Int = -1
    @Published var selected_subj_blurredVision: Int = -1
    @Published var selected_subj_primaryDiplopia: Int = -1
    @Published var selected_subj_periDiplopia: Int = -1
    
    @Published var selected_CAS_lidSwelling: Int = -1
    @Published var selected_CAS_lidErythema: Int = -1
    @Published var selected_CAS_conjRedness: Int = -1
    @Published var selected_CAS_conjChemosis: Int = -1
    @Published var selected_CAS_caruncularRedness: Int = -1
    @Published var hertel_R: Int = -1
    @Published var hertel_L: Int = -1
    @Published var aperture_R: Int = -1
    @Published var aperture_L: Int = -1
    @Published var selected_needSteroids: Int = -1

    @Published var free_disease: String = ""
    @Published var gender: [String] = ["男", "女"]
    @Published var YesNo: [String] = ["あり", "なし"]
    @Published var hospitals: [String] = ["", "オリンピア眼科病院", "大阪大"]
    @Published var severity: [String] = ["なし", "軽症", "中等症〜"]

    @Published var imageNum: Int = 0 //写真の枚数（何枚目の撮影か）
    @Published var isNewData: Bool = false
    @Published var isSendData: Bool = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera //撮影モードがデフォルト

    }


struct ContentView: View {
    @ObservedObject var user = User()

    @State private var goTakePhoto: Bool = false  //撮影ボタン
    @State private var isPatientInfo: Bool = false  //患者情報入力ボタン
    @State private var goInterview: Bool = false  //問診ボタン
    @State private var goSendData: Bool = false  //送信ボタン
    @State private var uploadData: Bool = false  //アップロードボタン
    @State private var newPatient: Bool = false  //新規患者ボタン
    @State private var goSearch: Bool = false  //検索ボタン
    
    
    var body: some View {
        VStack(spacing:0){
            Text("Grav app")
                .font(.largeTitle)
                .padding(.bottom)
            
            Image("gravPhoto")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button(action: {
                //病院番号はアプリを落としても保存されるようにしておく
                self.user.selected_hospital = UserDefaults.standard.integer(forKey: "hospitaldefault")
                self.isPatientInfo = true /*またはself.show.toggle() */
                
            }) {
                HStack{
                    Image(systemName: "info.circle")
                    Text("患者情報入力")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$isPatientInfo) {
                Informations(user: user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            Button(action: {
                self.goInterview = true /*またはself.show.toggle() */
            }) {
                HStack{
                    Image(systemName: "highlighter")
                    Text("問診")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
                .sheet(isPresented: self.$goInterview) {
                GravInterview(user: user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            
            HStack{
                
                
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
                    HowToTakeView(user: user)
                }
                

                //送信するとボタンの色が変わる演出
                if self.user.isSendData {
                    Button(action: {self.goSendData = true /*またはself.show.toggle() */}) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("送信済み")
                        }
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                    }
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                        .background(Color.blue)
                        .padding()
                    .sheet(isPresented: self.$goSendData) {
                        SendData(user: user)
                    }
                } else {
                    Button(action: { self.goSendData = true /*またはself.show.toggle() */ }) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("送信")
                        }
                            .foregroundColor(Color.white)
                            .font(Font.largeTitle)
                    }
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                        .background(Color.black)
                        .padding()
                    .sheet(isPresented: self.$goSendData) {
                        SendData(user: user)
                    }
                }
            }
            
            HStack(spacing:-10){
            
            Button(action: {
                 self.user.sourceType = UIImagePickerController.SourceType.photoLibrary
                 self.user.isSendData = false //撮影済みを解除
                 self.uploadData = true /*またはself.show.toggle() */
                 
             }) {
                 HStack{
                     Image(systemName: "folder")
                     Text("Up")
                 }
                     .foregroundColor(Color.white)
                     .font(Font.largeTitle)
             }
                 .frame(minWidth:0, maxWidth:200, minHeight: 75)
                 .background(Color.black)
                 .padding()
             .sheet(isPresented: self.$uploadData) {
                 CameraPage(user: user)
             }
                
                
            Button(action: { self.newPatient = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "stop.circle")
                    Text("次患者")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
            .alert(isPresented:$newPatient){
                Alert(title: Text("データをクリアしますか？"), primaryButton:.default(Text("はい"),action:{
                    //データの初期化
                    self.user.date = Date()
                    self.user.id = ""
                    self.user.imageNum = 0
                    self.user.selected_hospital = 0
                    self.user.free_disease = ""
                    self.user.isSendData = false
                    
                }),
                      secondaryButton:.destructive(Text("いいえ"), action:{}))
                }
                .frame(minWidth:0, maxWidth:200, minHeight: 75)
                .background(Color.black)
                .padding()
            }
            
            Button(action: {self.goSearch = true /*またはself.show.toggle() */}) {
                HStack{
                    Image(systemName: "applepencil")
                    Text("修正")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:160, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goSearch) {
                //Search(user: user)
            }
        }
    }
}
