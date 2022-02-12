//
//  QuestionPage.swift
//  GravApp
//
//  Created by Yoshiyuki Kitaguchi on 2022/01/20.
//
import SwiftUI

//変数を定義
struct GravInterview: View {
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var isSaved = false
    @State private var questionCompleted: Bool = false  //問診完了
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            GeometryReader{bodyView in
                Form{
//                    Section(header: Text("基本情報")){
//                    Sliderを用いた実装（使いにくいのでdepricateした）
//                        HStack {
//                            Text("年齢 ")
//                                .frame(width: bodyView.size.width * 1/10, height: 30, alignment:.leading)
//
//                            TextField("年齢を入力してください", value: $user.age, formatter: formatter)
//                            .keyboardType(.numbersAndPunctuation)
//                            .frame(width: bodyView.size.width * 1/12, height: 30, alignment:.leading)
//
//                            Slider(value: $user.age, in: 0...100, step: 1)
//                                .frame(width: bodyView.size.width * 3/5, height: 30, alignment:.leading)
//                                .onChange(of: user.age) {_ in
//                                    self.user.isSendData = false
//                                }
//                            //ScanButton(text: $user.id)
//                            //.frame(width: 100, height: 30, alignment: .leading)
//                        }
                        
//                            Picker(selection: $user.age,
//                                   label: Text("年齢")) {
//                                ForEach(0..<100){ age in
//                                    Text("\(age)")
//                                }
//                            }
//                           .onChange(of: user.age) { _ in
//                               self.user.isSendData = false
//                               }
//
//
//                            HStack{
//                                Text("性別")
//                                Picker(selection: $user.selected_gender,
//                                           label: Text("性別")) {
//                                    ForEach(0..<user.gender.count) {
//                                        Text(self.user.gender[$0])
//                                            }
//                                    }
//                                    .onChange(of: user.selected_gender) {_ in
//                                        self.user.isSendData = false
//                                        }
//                                    .pickerStyle(SegmentedPickerStyle())
//                            }
//                    }
                
                        Section(header: Text("喫煙"), footer: Text("")){
                            HStack{
                                Text("喫煙歴？")
                                Picker(selection: $user.selected_smoking,
                                           label: Text("性別")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_gender) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Picker(selection: $user.smokeYear,
                                   label: Text("（ありの場合）喫煙年数")) {
                                ForEach(0..<100){ year in
                                    Text("\(year)年")
                                }
                            }
                           .onChange(of: user.smokeYear) { _ in
                               self.user.isSendData = false
                               }
                            
                            Picker(selection: $user.smokeNum,
                                   label: Text("（ありの場合）1日の喫煙本数")) {
                                ForEach(0..<100){ num in
                                    Text("\(num)本")
                                }
                            }
                           .onChange(of: user.smokeNum) { _ in
                               self.user.isSendData = false
                               }
                            
                        }
                    
                    
                        Section(header: Text("症状"), footer: Text("")){
                            HStack{
                                Text("目の奥の違和感や痛み")
                                Picker(selection: $user.selected_CAS_retroBulbarPain,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_CAS_retroBulbarPain) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                            }
                            
                            HStack{
                                Text("目を動かすと痛い")
                                Picker(selection: $user.selected_CAS_gazePain,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_CAS_gazePain) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                            }
                            
                            HStack{
                                Text("上or下まぶたが腫れぼったい")
                                Picker(selection: $user.selected_subj_lidSwelling,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_subj_lidSwelling) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                            }
                            
                            HStack{
                                Text("片目ずつで見え方がぼける")
                                Picker(selection: $user.selected_subj_blurredVision,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_subj_blurredVision) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                            }
                            
                            HStack{
                                Text("両目で正面がだぶって見える")
                                Picker(selection: $user.selected_subj_primaryDiplopia,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_subj_primaryDiplopia) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                                    
                            }
                            
                            HStack{
                                Text("両目で上や横がだぶって見える")
                                Picker(selection: $user.selected_subj_periDiplopia,
                                           label: Text("YesNo")) {
                                    ForEach(0..<user.YesNo.count) {
                                        Text(self.user.YesNo[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_subj_periDiplopia) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(minHeight: 100)
                            }
                            
                        }
                    

                    
                }.navigationTitle("患者アンケート")
                .onAppear(){
                    }
                }
            }
                
            
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
               }
                
            ) {
                Text("保存")
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
