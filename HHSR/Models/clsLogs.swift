//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsLogs : NSObject
{
    var LogId : Int!
    var RoomId : Int!
    var RoomName : String!
    var ResidentName : String!
    var LogDetails : String!
    var ActionTaken : String!
    var FollowUpRequired : String!
    var LogDateTime : String!
    var LoggedBy : String!
    var CompletedBy : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        LogId = json["id"].intValue
        RoomId = json["id"].intValue
        RoomName = json["name"].stringValue
        ResidentName = json["c_name"].stringValue
        LogDetails = json["name"].stringValue
        ActionTaken = json["c_name"].stringValue
        FollowUpRequired = json["name"].stringValue
        LogDateTime = json["c_name"].stringValue
        LoggedBy = json["name"].stringValue
        CompletedBy = json["c_name"].stringValue
    }
    
}


class clsForms : NSObject
{
    var FormId : Int!
    var FormName : String!
    var IsPrintAllowed : Int = 0
    var IsMailAllowed : Int = 0
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        FormId = json["id"].intValue
        FormName = json["name"].stringValue
        IsPrintAllowed = json["allow_print"].intValue
        IsMailAllowed = json["allow_mail"].intValue
    }
    
    init(formId : Int, formName : String) {
        self.FormId = formId
        self.FormName = formName
    }
    
}

struct clsFormFields
{
    var FieldLabel : String!
    var FieldType : String!
    var FieldVal : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        FieldLabel = json["fieldLabel"].stringValue
        FieldType = json["fieldType"].stringValue
        FieldVal = json["fieldVal"].stringValue
    }
    
    init(fromDictionary dictionary: [String:Any]){
        FieldLabel = dictionary["fieldLabel"] as? String
        FieldType = dictionary["fieldType"] as? String
        FieldVal = dictionary["fieldVal"] as? String ?? ""
    }
    
    init(fieldLabel : String, fieldType : String) {
        self.FieldLabel = fieldLabel
        self.FieldType = fieldType
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if FieldLabel != nil{
            dictionary["fieldLabel"] = FieldLabel
        }
        if FieldType != nil{
            dictionary["fieldType"] = FieldType
        }
        if FieldVal != nil{
            dictionary["fieldVal"] = FieldVal
        }
        return dictionary
    }
}
