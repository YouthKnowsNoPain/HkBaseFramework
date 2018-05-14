import UIKit

public class loggerswift: NSObject {
    
    static func notification(s:Any){
        #if DEBUG
            print("\(s)")
        #endif
    }
    
    static func success(s:Any){
        #if DEBUG
            print("✅✅✅ \(s)")
        #endif
    }
    
    static func warning(s:String){
        #if DEBUG
            print("❗❗❗WARNING: - \(s)")
        #endif
    }
    
    static func error(s:String){
        #if DEBUG
            print("❌❌❌ERROR: - \(s)")
        #endif
    }
    
    static func emptyRow(){
        #if DEBUG
            print("")
        #endif
    }
    
    static func blankLine(){
        #if DEBUG
            print("--------------------")
        #endif
    }
    
    static func blankStartLine(){
        #if DEBUG
            print("")
            print("--------------------")
        #endif
    }
    
    static func blankEndLine(){
        #if DEBUG
            print("--------------------")
            print("")
        #endif
    }
}
