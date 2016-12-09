//
//  FindArticle.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    
    case business = "business"
    case entertainment = "entertainment"
    case gaming = "gaming"
    case general = "general"
    case music = "music"
    case scienceAndNature = "science-and-nature"
    case technology = "technology"
    
    var displayValue: String {
        switch self{
        case .business :
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .gaming:
            return "Gaming"
        case .general:
            return "General"
        case .music:
            return "Music"
        case .scienceAndNature:
            return "Science And Nature"
        case .technology:
            return "Technology"
        }
    }
    
    
    static func asArray() -> [Category] {
        return [.business, .entertainment, .gaming, .general, .music, .scienceAndNature, .technology]
    }
}

enum Source: String {
    
    case financialTimes = "financial-times"
    case bloombergNews = "bloomberg"
    case theEconomist = "the-economist"
    case businessInsider = "business-insider"
    case usaToday = "usa-today"
    case cnn = "cnn"
    case wallStreetJournal = "the-wall-street-journal"
    case searchAll = "search all"
    
    var displayValue: String {
        switch self{
        case .financialTimes :
            return "Financial Times"
        case .bloombergNews:
            return "Bloomberg News"
        case .theEconomist:
            return "The Economist"
        case .businessInsider:
            return "Business Insider"
        case .usaToday:
            return "USA Today"
        case .cnn:
            return "CNN"
        case .wallStreetJournal:
            return "the-wall-street-journal"
        case .searchAll:
            return "Search all"
        }
        
    }
    
    static func asArray2() -> [Source] {
        return [.financialTimes, .bloombergNews, .theEconomist, .businessInsider, .usaToday, .cnn, .wallStreetJournal]
    }
}
