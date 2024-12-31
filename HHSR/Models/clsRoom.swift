//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsRoom : NSObject
{
    var RoomId : Int!
    var RoomName : String!
    var ResidentName : String!
    var Occupancy : Int!
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        RoomId = json[RoomKeys.RoomId].intValue
        RoomName = json[RoomKeys.RoomName].stringValue
        Occupancy = json[RoomKeys.Occupancy].intValue
        ResidentName = json[RoomKeys.ResidentName].stringValue
    }
}


class clsReportRoom : NSObject
{
    var RoomId : Int!
    var RoomName : String!
    var HasSpecialInst : Int!
    var HasBrkOrder : Int!
    var HasLunchOrder : Int!
    var HasDinnerOrder : Int!
    var isForGuest : Int!
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        RoomId = json["room_id"].intValue
        RoomName = json["room_name"].stringValue
        HasSpecialInst = json["has_special_ins"].intValue
        HasBrkOrder = json["has_breakfast_order"].intValue
        HasLunchOrder = json["has_lunch_order"].intValue
        HasDinnerOrder = json["has_dinner_order"].intValue
        isForGuest = json["is_for_guest"].intValue
    }
}
