//
//  clsAttachment.swift
//  HHSR
//
//  Created by Intelli on 2024-01-12.
//

import Foundation
import SwiftyJSON

class clsAttachment : NSObject
{
    var Id : Int!
    var Name : String!
    var FormId : Int!
    var Path : String!
    var MediaType : String!
    var ThumbImage : String!
    var MediaSize : Int!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
    
        Id = json["id"].intValue
        Name = json["name"].stringValue
        FormId = json["form_response_id"].intValue
        Path = json["path"].stringValue
        MediaType = json["type"].stringValue
        ThumbImage = json["thumbImage"].stringValue
        MediaSize = json["size_in_kb"].intValue
    }
}
