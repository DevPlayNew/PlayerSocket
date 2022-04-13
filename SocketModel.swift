//
//  SocketModel.swift
//  PlayerSocket
//
//  Created by 김원철 on 2022/04/13.
//

import Foundation
import SocketIO

struct PlayerSocket {
    // MARK: - REQUEST | SOCKETDATA
    // socket emit 시 인증 정보 담을 수 있는 구조체
    struct Auth: SocketData {
        let isAdmin : Bool?
        let token : String?
        let userId : String?
        func socketRepresentation() -> SocketData {
            return ["isAdmin": isAdmin, "token": token, "userId": userId]
        }
    }

    // socket emit init 요청에 대한 구조체
    struct Init: SocketData {
        let roomId : String?
        let auth : Auth?
        func socketRepresentation() -> SocketData {
            return ["roomId": roomId, "auth": auth?.socketRepresentation()]
        }
    }
    
    // socket emit sendMessage에 대한 구조체
    struct sendMessage: SocketData {
        let roomId: String?
        let isAdmin: Bool?
        let messageInput: MessageInput?
        
        struct MessageInput {
            let partnerId: String?
            let messageType: Int?
            let message: String?
            let userNick: String?
            let isLive: Bool?
            let userName: String?
            let userId: String?
            let roomId: String?
            let data = "none"
            
            func socketRepresentation() -> SocketData {
                return ["partnerId": partnerId, "messageType": messageType, "message": message, "userNick": userNick, "isLive": isLive, "userName": userName, "userId": userId, "roomId": roomId, "data": data]
            }
        }
        func socketRepresentation() -> SocketData {
            return ["roomId": roomId, "isAdmin": isAdmin, "input": messageInput?.socketRepresentation()]
        }
    }
    
    // socket emit sendLike 요청에 대한 구조체
    struct sendLike: SocketData {
        let roomId : String?
        func socketRepresentation() -> SocketData {
            return ["roomId": roomId, "value": 1]
        }
    }
    
    

    // MARK: - Response | Codable
    struct BanUserInfo : Codable {
        var userId : [String]?
    }

    struct BannedWordInfo : Codable {
        var bannedWord : [String]?
    }

    struct Room : Codable {
        var banUserInfo : BanUserInfo?
        var bannedWordInfo : BannedWordInfo?
        var canChat : Bool?
        var chatCounterInfo : Int64?
        var currentPurchase : Bool?
        var currentQuiz : Bool?
        var currentWinPurchase : Bool?
        var incomingCounterInfo : Int64?
        var publishDate : String?
        var reactionCounterInfo : Int64?
        var regDate : String?
        var roomId : String?
        var roomState : Int?
        var streamInfo : String?
        var title : String?
        var updateDt : String?
    }

    struct JoinUser : Codable {
        var isLive : Bool?
        var message : String?
        var messageId : String?
        var messageType : Int?
        var partnerId : String?
        var regDate : String?
        var roomId : String?
        var userId : String?
        var userName : String?
        var userNick : String?
    }

    struct InitModel : Codable {
        var currentDt : String?
        var joinUser : [JoinUser]?
        var liveUserCount : Int64?
        var room : Room?
        var socketUpdateRoomName : String?
    }

    struct UpdateRoomModel : Codable {
        var joinUser : [JoinUser]?
        var liveUserCount : Int64?
        var room : Room?
        var roomId : String?
    }

    struct MessageModel: Codable {
        let regDate: String?
        let isAdmin: Bool?
        let message: String?
        let messageId: String?
        let partnerId: String?
        let messageType: Int?
        let deleteOwner: String?
        let isLive: Bool?
        let roomId: String?
        let userId: String?
        let userName: String?
        let data: String?
        let updateDt: String?
        let inactive: Bool?
        let userNick: String?
    }
    
    struct LikeModel: Codable {
        let roomId: String?
        let value: Int?
    }

}
