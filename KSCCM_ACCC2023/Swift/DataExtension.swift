
import Foundation

extension Data {
    
    init?(fromBundle fileName : String, extention : String) {
        if let bundleFilePath = Bundle.main.path(forResource: fileName, ofType: extention) {
            let bundleFileURL = URL(fileURLWithPath: bundleFilePath)
            do {
                self = try Data(contentsOf: bundleFileURL)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }else{
            return nil
        }
    }
    
    init?(fromDocument fileName : String, extention : String) {
        let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileName : String     = "\(fileName).\(extention)"
        let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
        
        do {
            self = try Data(contentsOf: fileURL)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveToDocument(fileName : String, extention : String) -> URL? {
        let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileName : String     = "\(fileName).\(extention)"
        let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
        
        do {
            try self.write(to: fileURL, options: [.atomic])
            return fileURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func toJson() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers)
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func toString() -> String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
}

extension Dictionary where Key == String, Value == Any {
    
    func readIntValueOfDic(key kKey: String) -> Int?{
        var intValue : Int? = nil
        if let valueInt = self[kKey] as? Int {
            intValue = valueInt
        }
        if let valueString = self[kKey] as? String {
            if let valueInt = Int(valueString, radix: 10) {
                intValue = valueInt
            }
        }
        return intValue
    }
}
