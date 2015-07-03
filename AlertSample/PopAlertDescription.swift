//
//  PopAlertDescription.swift
//  VegasApp
//
//  Created by suzuki_kiwamu on 2015/04/16.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation


/**
AlertDescriptionType
アラートの文言の種別enum
*/
enum AlertDescriptionType: Int {
    case Text=0, Error, IsNull, Save, Provide, Logout, CompleteSave, CheckProvide, CastAdd, EndProvide, NotAgreement, NotAgreementInqury
    
    /**
    getDescription
    アラート説明文の取得
    */
    func getDescription(text: String?) -> String {
        switch self {
        case .Text:
            let str = text ?? ""
            return str
        case .Error:
            return "正常に処理が行えませんでした。再度操作して下さい。"
        case .IsNull:
            let str = text ?? ""
            return str + "の入力が確認できません。\n" + str + "を入力して下さい"
        case .Save:
            return "完了しますか？"
        case .Provide:
            return "放送を開始しますか？"
        case .Logout:
            return "ログアウトしますか？"
        case .CompleteSave:
            return "完了しました"
        case .CheckProvide:
            return "配信を開始しますか？"
        case .CastAdd:
            return "キャストを追加しますか？"
        case .EndProvide:
            return "配信を終了しますか？"
        case .NotAgreement:
            return "利用規約に同意していません。"
        case .NotAgreementInqury:
            return "利用規約に同意後、\n再度お問い合わせください"
        }
    }
}



/**
AlertSelectionType
アラートの文言の種別enum
*/
enum AlertSelectionType: Int {
    case Text=0, Yes, No, Done, Cancel, Provide, Add
    
    /**
    getDescription
    アラート説明文の取得
    */
    func getDescription(text: String?) -> String {
        switch self {
        case .Text:
            let str = text ?? ""
            return str
        case .Yes:
            return "はい"
        case .No:
            return "いいえ"
        case .Done:
            return "実行する"
        case .Cancel:
            return "キャンセル"
        case .Provide:
            return "配信する"
        case .Add:
            return "追加する"
        }
    }
}

