//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsReport : NSObject
{
    var RoomNo : String!
    var Quantity : [Int] = []
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        RoomNo = json["room_no"].stringValue
        Quantity = json["quantity"].arrayValue.map({ $0.intValue })
    }
    
//    init(prjId : Int, prjName : String, prjDesc : String) {
//        self.ClientId = prjId
//        self.ClientName = prjName
//        self.ClientDescription = prjDesc
//    }
}


class clsReportCharges : NSObject
{
    var RoomNo : String!
    var Data : [Int] = []
    var OptionName : [String] = []
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        RoomNo = json["room_no"].stringValue
        Data = json["data"].arrayValue.map({ $0.intValue })
        OptionName = json["option"].arrayValue.map({ $0.stringValue })
    }
}

class clsChargeReport : NSObject
{
    var RoomNo : String!
    var ResidentName : String!
    var OrderDate : String!
    var IsExtraItem : Int!
    var IsForGuest : Int!
    var IsBrkTrayService : Int!
    var IsLunchTrayService : Int!
    var IsDinnerTrayService : Int!
    var IsBrkEscortService : Int!
    var IsLunchEscortService : Int!
    var IsDinnerEscortService : Int!
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        RoomNo = json["room_number"].stringValue
        ResidentName = json["resident_name"].stringValue
        OrderDate = json["order_date"].stringValue
        IsExtraItem = json["is_extra_item"].intValue
        IsForGuest = json["is_for_guest"].intValue
        IsBrkTrayService = json["is_brk_tray_service"].intValue
        IsLunchTrayService = json["is_lunch_tray_service"].intValue
        IsDinnerTrayService = json["is_dinner_tray_service"].intValue
        IsBrkEscortService = json["is_brk_escort_service"].intValue
        IsLunchEscortService = json["is_lunch_escort_service"].intValue
        IsDinnerEscortService = json["is_dinner_escort_service"].intValue
    }
    
    init(rNO : String) {
        self.RoomNo = rNO
    }
}
