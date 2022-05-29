//
//  ResultHolder.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/19.
//  Created by Kuniaki Ohara on 2021/01/30.
//
import SwiftUI

class ResultHolder{
    init() {}
    
    // インスタンスを保持する必要はなく、すべてのインスタンス変数をstaticにする実装で良いと思います。
    static var instance: ResultHolder?
    public static func GetInstance() -> ResultHolder{
        if (instance == nil) {
            instance = ResultHolder()
            
        }

        return instance!

    }

    private (set) public var Images: [Int:CGImage] = [:]
    private (set) public var MovieUrl: String = ""
    
    public func GetUIImages() -> [UIImage]{
        //print("get UI images")
        var uiImages: [UIImage] = []
        let length = Images.count
        for i in 0 ..< length {
            if (Images[i] != nil){
                uiImages.append(UIImage(cgImage: Images[i]! ))
            }
        }
        return uiImages
    }
    
    public func SetImage(index: Int, cgImage: CGImage){
        Images[index] = cgImage
        //print("set images to resultHolder")
    }
    
    
    public func SetMovieUrls(Url:String){
        print(MovieUrl)
        MovieUrl = Url
    }
    
    public func GetMovieUrls() ->String{
        let Url = MovieUrl
        return Url
    }
    
    
    
    
    public func GetImageJsons() -> [String]{
        var imageJsons:[String] = []
        let uiimages = GetUIImages()
        let jsonEncoder = JSONEncoder()
        let length = uiimages.count
        for i in 0 ..< length {
            if (Images[i] != nil){
                let data = PatientImageData()
                
                data.image = uiimages[i].resize(size: ConstHolder.EVALIMAGESIZE)!.pngData()!.base64EncodedString()
                let jsonData = (try? jsonEncoder.encode(data)) ?? Data()
                let json = String(data: jsonData, encoding: String.Encoding.utf8)!
                imageJsons.append(json)
            }
        }
        
        return imageJsons
    }
    
    private (set) public var Answers: [String:String] = ["q1":"", "q2":"", "q3":"", "q4":"", "q5": "", "q6": "", "q7":"", "q8":"", "q9":"", "q10":"", "q11":"", "q12":"", "q13":"", "q14":"", "q15": "", "q16": "", "q17":"", "q18":"", "q19":"", "q20":"", "q21":"", "q22":"", "q23":"", "q24":"", "q25": "", "q26": "", "q27":"", "q28":""]

    public func SetAnswer(q1:String, q2:String, q3:String, q4:String, q5:String, q6:String, q7:String, q8:String, q9:String, q10:String, q11:String, q12:String, q13:String, q14:String, q15:String, q16:String, q17:String, q18:String, q19:String, q20:String,q21:String, q22:String, q23:String, q24:String, q25:String, q26:String, q27:String, q28:String){
        Answers["q1"] = q1 //date
        Answers["q2"] = q2 //hashID
        Answers["q3"] = q3 //ID
        Answers["q4"] = q4 //imgNum
        Answers["q5"] = q5 //hospital
        Answers["q6"] = q6 //free
        Answers["q7"] = q7 //Age
        Answers["q8"] = q8 //Sex
        Answers["q9"] = q9 //CAS_眼瞼発赤
        Answers["q10"] = q10 //CAS_眼瞼腫脹
        Answers["q11"] = q11 //CAS_結膜充血
        Answers["q12"] = q12 //CAS_結膜浮腫
        Answers["q13"] = q13 //CAS_涙丘充血
        Answers["q14"] = q14 //瞼裂高R
        Answers["q15"] = q15 //瞼裂高L
        Answers["q16"] = q16 //HertelR
        Answers["q17"] = q17 //HertelL
        Answers["q18"] = q18 //Severity
        Answers["q19"] = q19 //Steroid
        Answers["q20"] = q20 //Smoking history
        Answers["q21"] = q21 //Smoking years
        Answers["q22"] = q22 //Smoking number per day
        Answers["q23"] = q23 //Symptom_retroorbital pain
        Answers["q24"] = q24 //Symptom_eye movement pain
        Answers["q25"] = q25 //Symptom_swollen eyelid
        Answers["q26"] = q26 //Symptom_blurred vision
        Answers["q27"] = q27 //Symptom_primary gaze diplopia
        Answers["q28"] = q28 //Symptom_peripheral gaze diplopia
        
    }

    public func GetAnswerJson() -> String{
        let data = QuestionAnswerData()
        data.pq1 = Answers["q1"] ?? ""
        data.pq2 = Answers["q2"] ?? ""
        data.pq3 = Answers["q3"] ?? ""
        data.pq4 = Answers["q4"] ?? ""
        data.pq5 = Answers["q5"] ?? ""
        data.pq6 = Answers["q6"] ?? ""
        data.pq7 = Answers["q7"] ?? ""
        data.pq8 = Answers["q8"] ?? ""
        data.pq9 = Answers["q9"] ?? ""
        data.pq10 = Answers["q10"] ?? ""
        data.pq11 = Answers["q11"] ?? ""
        data.pq12 = Answers["q12"] ?? ""
        data.pq13 = Answers["q13"] ?? ""
        data.pq14 = Answers["q14"] ?? ""
        data.pq15 = Answers["q15"] ?? ""
        data.pq16 = Answers["q16"] ?? ""
        data.pq17 = Answers["q17"] ?? ""
        data.pq18 = Answers["q18"] ?? ""
        data.pq19 = Answers["q19"] ?? ""
        data.pq20 = Answers["q20"] ?? ""
        data.pq21 = Answers["q21"] ?? ""
        data.pq22 = Answers["q22"] ?? ""
        data.pq23 = Answers["q23"] ?? ""
        data.pq24 = Answers["q24"] ?? ""
        data.pq25 = Answers["q25"] ?? ""
        data.pq26 = Answers["q26"] ?? ""
        data.pq27 = Answers["q27"] ?? ""
        data.pq28 = Answers["q28"] ?? ""
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = (try? jsonEncoder.encode(data)) ?? Data()
        let json = String(data: jsonData, encoding: String.Encoding.utf8)!
        return json
    }
}

class PatientImageData: Codable{
    var image = ""
}

class QuestionAnswerData: Codable{
    var pq1 = ""
    var pq2 = ""
    var pq3 = ""
    var pq4 = ""
    var pq5 = ""
    var pq6 = ""
    var pq7 = ""
    var pq8 = ""
    var pq9 = ""
    var pq10 = ""
    var pq11 = ""
    var pq12 = ""
    var pq13 = ""
    var pq14 = ""
    var pq15 = ""
    var pq16 = ""
    var pq17 = ""
    var pq18 = ""
    var pq19 = ""
    var pq20 = ""
    var pq21 = ""
    var pq22 = ""
    var pq23 = ""
    var pq24 = ""
    var pq25 = ""
    var pq26 = ""
    var pq27 = ""
    var pq28 = ""
}
