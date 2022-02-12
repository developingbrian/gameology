//
//  Networking+Helpers.swift
//  collector
//
//  Created by Brian on 12/24/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import Foundation


extension Networking {
    
    func formatPlatformIDToPlatformName(ID: Int) -> String {
        
        switch ID {
        case 50         :   return "3DO"
        case 114        :   return "Amiga CD32"
        case 59         :   return "Atari 2600"
        case 66         :   return "Atari 5200"
        case 60         :   return "Atari 7800"
        case 62         :   return "Jaguar"
        case 61         :   return "Atari Lynx"
        case 68         :   return "ColecoVision"
        case 127        :   return "Fairchild Channel F"
        case 67         :   return "Intellivision"
        case 88         :   return "Magnavox Odyssey"
        case 11         :   return "Xbox"
        case 12         :   return "Xbox 360"
        case 49         :   return "Xbox One"
        case 169        :   return "Xbox Series X"
        case 80         :   return "Neo Geo AES"
        case 136        :   return "Neo Geo CD"
        case 119, 120   :   return "Neo Geo Pocket Color"
        case 307        :   return "Game & Watch"
        case 18         :   return "NES"
        case 19         :   return "Super Nintendo"
        case 87         :   return "Virtual Boy"
        case 4          :   return "Nintendo 64"
        case 21         :   return "Gamecube"
        case 5          :   return "Wii"
        case 41         :   return "Wii U"
        case 130        :   return "Nintendo Switch"
        case 33         :   return "GameBoy"
        case 22         :   return "GameBoy Color"
        case 24         :   return "GameBoy Advance"
        case 20, 159    :   return "Nintendo DS"
        case 37, 137    :   return "Nintendo 3DS"
        case 166        :   return "Pokemon Mini"
        case 42         :   return "N-Gage"
        case 122        :   return "Nuon"
        case 86         :   return "TurboGrafx-16"
        case 128        :   return "JP PC Engine"
        case 117        :   return "CD-i"
        case 84         :   return "JP Sega Mark III"
        case 64         :   return "Sega Master System"
        case 29         :   return "Sega Genesis"
        case 78         :   return "Sega CD"
        case 30         :   return "Sega 32X"
        case 32         :   return "Sega Saturn"
        case 23         :   return "Sega Dreamcast"
        case 35         :   return "Sega Game Gear"
        case 339        :   return "Sega Pico"
        case 7          :   return "Playstation"
        case 8          :   return "Playstation 2"
        case 9          :   return "Playstation 3"
        case 48         :   return "Playstation 4"
        case 167        :   return "Playstation 5"
        case 38         :   return "PSP"
        case 46         :   return "PlayStation Vita"
        case 70         :   return "Vectrex"
        case 57         :   return "WonderSwan"
        case 123        :   return "WonderSwan Color"
        case 240        :   return "Zeebo"
        default         :
            return "Unknown Platform, platform ID is \(ID)"
        }
        
    }
    
    
    func formatPlatformIDToPriceChartingID(ID: Int) -> String {
        
        switch ID {
        case 50     :   return "G25"    //"3DO Interactive Multiplayer"
        case 114    :   return "G92"    //"Amiga CD32"
        case 59     :   return "G24"    //"Atari 2600"
        case 66     :   return "G31"    //"Atari 5200"
        case 60     :   return "G33"    //"Atari 7800"
        case 62     :   return "G21"    //"Atari Jaguar"
        case 61     :   return "G26"    //"Atari Lynx"
        case 68     :   return "G30"    //"ColecoVision"
        case 127    :   return "G83"    //"Fairchild Channel F"
        case 67     :   return "G27"    //"Intellivision"
        case 88     :   return "G130"   //"Magnavox Odyssey"
        case 11     :   return "G8"     //"Microsoft Xbox"
        case 12     :   return "G10"    //"Microsoft Xbox 360"
        case 49     :   return "G54"    //"Microsoft Xbox One"
        case 169    :   return "G7585"  //"Microsoft Xbox Series S|X"
        case 80     :   return "G116"   //"Neo Geo AES"
        case 136    :   return "G60"    //"Neo Geo CD"
        case 119    :   return "G40"    //"Neo Geo Pocket"
        case 120    :   return "G40"    //"Neo Geo Pocket Color"
        case 307    :   return "G68"    //"Nintendo Game & Watch"
        case 18     :   return "G17"    //"Nintendo Entertainment System (NES)"
        case 19     :   return "G13"    //"Super Nintendo Entertainment System (SNES)"
        case 87     :   return "G22"    //"Nintendo Virtual Boy"
        case 4      :   return "G4"     //"Nintendo 64"
        case 21     :   return "G3"     //"Nintendo GameCube"
        case 5      :   return "G11"    //"Nintendo Wii"
        case 41     :   return "G47"    //"Nintendo Wii U"
        case 130    :   return "G59"    //"Nintendo Switch"
        case 33     :   return "G49"    //"Nintendo Game Boy"
        case 22     :   return "G2"     //"Nintendo Game Boy Color"
        case 24     :   return "G1"     //"Nintendo Game Boy Advance"
        case 20     :   return "G5"     //"Nintendo DS"
            //          case 159    :   return ""       //"Nintendo DSi"
        case 37     :   return "G39"    //"Nintendo 3DS"
        case 137    :   return "G39"    //"New Nintendo 3DS"
        case 166    :   return "G143"   //"Nintendo Pokémon Mini"
        case 42     :   return "G42"    //"Nokia N-Gage"
            //          case 122    :   return ""       //"Nuon"
        case 86     :   return "G19"    //"TurboGrafx-16/PC Engine"
        case 128    :   return "G82"    //"PC Engine SuperGrafx"
        case 117    :   return "G37"    //"Philips CD-i"
        case 84     :   return "G6900"  //"Sega SG-1000"
        case 64     :   return "G29"    //"Sega Master System"
        case 29     :   return "G15"    //"Sega Genesis/Mega Drive"
        case 78     :   return "G23"    //"Sega CD"
        case 30     :   return "G50"    //"Sega 32X"
        case 32     :   return "G14"    //"Sega Saturn"
        case 23     :   return "G16"    //"Sega Dreamcast"
        case 35     :   return "G20"    //"Sega Game Gear"
        case 339    :   return "G136"   //"Sega Pico"
        case 7      :   return "G6"     //"Sony PlayStation"
        case 8      :   return "G7"     //"Sony PlayStation 2"
        case 9      :   return "G12"    //"Sony PlayStation 3"
        case 48     :   return "G53"    //"Sony PlayStation 4"
        case 167    :   return "G7468"  //"Sony PlayStation 5"
        case 38     :   return "G9"     //"Sony PlayStation Portable (PSP)"
        case 46     :   return "G43"    //"Sony PlayStation Vita"
        case 70     :   return "G32"    //"Vectrex"
        case 57     :   return "G151"   //"WonderSwan"
        case 123    :   return "G152"   //"WonderSwan Color"
            //          case 240    :   return ""       //"Zeebo"
        default     :
            return ""
        }
        
    }
    
    func removeLeadingArticle(fromString: String) -> String{
        let articles = ["the", "a", "an"]
        
        for article in articles {
            if fromString.hasPrefix(article) {
                
                
                let articleLength = article.count
                
                return String(((fromString[(fromString.index(fromString.startIndex, offsetBy: articleLength + 1))])))
            } else {
                return fromString
            }
            
        }
        
        return fromString
        
        
    }
    
    func fetchAgeRatingString(rating: Int) -> String {
        //IGDB returns age ratings as an enum  This will take the rating id and return the string rating
        
        var ratingString = ""
        
        switch rating {
        case 1:
            ratingString = "PEGI 3"
        case 2:
            ratingString = "PEGI 7"
        case 3:
            ratingString = "PEGI 12"
        case 4:
            ratingString = "PEGI 16"
        case 5:
            ratingString = "PEGI 18"
        case 6:
            ratingString = "ESRB RP"
        case 7:
            ratingString = "ESRB EC"
        case 8:
            ratingString = "ESRB E"
        case 9:
            ratingString = "ESRB E10"
        case 10:
            ratingString = "ESRB T"
        case 11:
            ratingString = "ESRB M"
        case 12:
            ratingString = "ESRB AO"
        default :
            ratingString = "ESRB NR"
        }
        
        return ratingString
    }
    
    
    func fetchCompanyName(companyID: Int, game: IGDBGame) -> String {
        //Helper function to convert company ID to company name
        
        var companyName = ""
        if let involvedCompany = game.involvedCompanies {
            
            for company in involvedCompany {
                
                if company.id == companyID {
                    
                    companyName = (company.company?.name!)!
                    
                }
                
                
                
            }
            
        }
        return companyName
        
    }
    
    
    func createGameObject(data: IGDBGame, platformID: Int) -> GameObject {
        
        let gameData = data
        
        var game = GameObject()
        
        game.id = gameData.id
        game.title = gameData.name
        for releaseDate in gameData.releaseDate! {
            
            if releaseDate.platform == platformID {
                if let date = releaseDate.date {
                    let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                    let formattedDate = dateFormatter.string(from: releaseDate as Date)
                    
                    game.releaseDate = "\(formattedDate)"
                }
            }
        }
        
        var genreArray : [String] = []
        if let genreData = gameData.genres {
            
            game.genre = genreData
            
            for genre in genreData {
                
                
                genreArray.append(genre.name!)
            }
            game.genres = genreArray
        }
        game.genreDescriptions = genreArray.joined(separator: " | ")
        
        if let gameModes = gameData.gameModes {
            var modeArray : [String] = []
            
            for mode in gameModes {
                modeArray.append(mode.name!)
            }
            
            if modeArray.count > 0 {
                game.maxPlayers = modeArray.joined(separator: " | ")
            } else {
                game.maxPlayers = ""
            }
            
        } else {
            game.maxPlayers = ""
        }
        
        
        game.overview = gameData.summary
        
        if let totalRating = gameData.totalRating {
            game.totalRating = Int(totalRating)
        }
        
        if let userRating = gameData.rating {
            game.userRating = Int(userRating)
        }
        
        if let ageRatings = gameData.ageRatings {
            
            
            let esrbRatings = ageRatings.filter { $0.category == 1 }
            let pegiRatings = ageRatings.filter { $0.category == 2 }
            
            
            if esrbRatings.count > 0 {
                
                let rating = esrbRatings[0].rating!
                
                game.rating = self.fetchAgeRatingString(rating: rating)
                
            } else {
                
                if esrbRatings.count == 0 {
                    if pegiRatings.count > 0 {
                        
                        let rating = pegiRatings[0].rating!
                        game.rating = self.fetchAgeRatingString(rating: rating)
                    }
                }
            }
            
            
        } else {
            game.rating = "ESRB NR"
        }
        
        
        
        game.screenshots = gameData.screenshots
        
        
        game.youtubePath = gameData.videos?[0].videoID
        
        if let platforms = gameData.platforms {
            for platform in platforms {
                
                if platformID == 165 {
                    game.platformName = "PlayStation 4"
                    game.platformID = 48
                } else if platform.id == platformID {
                    game.platformName = platform.name
                    game.platformID = platformID
                }
                
            }
        }
        
        if let genres = gameData.genres {
            for genre in genres {
                if let genreName = genre.name {
                    game.genres?.append(genreName)
                }
            }
        } else {
            game.genres?.append("")
        }
        
        
        if let involvedCompanies = gameData.involvedCompanies {
            for company in involvedCompanies {
                
                if company.publisher == true {
                    game.developer = company.company?.name
                    game.developerLogo = company.company?.logo
                    
                    
                }
            }
        }
        

        
        game.boxartInfo = gameData.cover
        game.boxartHeight = gameData.cover?.height
        game.boxartWidth = gameData.cover?.width
        
        if let imageID = gameData.cover?.imageID {
            game.boxartFrontImage = imageID + ".jpg"
        }
        
        guard let name = game.title else { return game }
        guard let id = game.id else { return game}
        guard let platformID = game.platformID else { return game}
        
        game.owned = self.delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
        
        
        return game
        
        
    }
    
    func filterRegions(releaseDate: ReleaseDate, consoleReleaseYear: Int, maxYear: Int,gameData: IGDBGame, platformID: Int) -> [GameObject] {
        var game : GameObject?
        var array : [GameObject] = []
        
        var firstReleaseYear : String?
        
        if let date = gameData.firstReleaseDate {
            let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            let formattedDate = dateFormatter.string(from: releaseDate as Date)
            
            firstReleaseYear = "\(formattedDate)"
        }
        let releasePlatform = releaseDate.platform
        if firstReleaseYear != nil {
            if let releaseYear = releaseDate.y {
                let region = releaseDate.region
                
                
                if region == 2 && releaseYear >= consoleReleaseYear && releaseYear < maxYear && releasePlatform == platformID {
                    game = (self.createGameObject(data: gameData, platformID: platformID))
                    
                    array.append(game!)
                    
                } else if region == 1 && releaseYear >= consoleReleaseYear && releaseYear < maxYear && releasePlatform == platformID {
                    game = (self.createGameObject(data: gameData, platformID: platformID))
                    
                    
                    array.append(game!)
                    
                } else if region == 8 && releaseYear >= consoleReleaseYear && releaseYear < maxYear && releasePlatform == platformID {
                    game = (self.createGameObject(data: gameData, platformID: platformID))
                    
                    
                    
                    array.append(game!)
                    
                }
            }
        }
        
        return array
        
        
    }
    
    
    func createGameWithPlatformDateFiltered(releaseDates: [ReleaseDate], platformID: Int, gameData: IGDBGame) -> [GameObject] {
        var array : [GameObject] = []
        
        //IGDB returns games official and unoffical games for all platforms.  Most unofficial games are hacks and roms and their release years are more recent than the last official year of game releases for the respective platform.  This method will filter results to only those between the official platform release period
        
        for releaseDate in releaseDates {
            
            if releaseDate.platform == platformID {
                switch platformID {
                    
                case 50     :
                    //"3DO Interactive Multiplayer"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1993, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 114    :   //return "Amiga CD32"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1993, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 59     :   //return "Atari 2600"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1977, maxYear: 1993, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 66                                   :   //return "Atari 5200"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1984, maxYear: 1987, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 60:   //return "Atari 7800"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1984, maxYear: 1992, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 62                                 :   //return "Atari Jaguar"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1993, maxYear: 1999, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 61                                   :   //return "Atari Lynx"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1989, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 68                                 :   //return "ColecoVision"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1982, maxYear: 1987, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 127                          :   //return "Fairchild Channel F"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1976, maxYear: 1982, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 67                                :   //return "Intellivision"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1980, maxYear: 1990, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 88                             :   //return "Magnavox Odyssey"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1980, maxYear: 1985, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 11                               :   //return "Microsoft Xbox"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2001, maxYear: 2009, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 12                           :   //return "Microsoft Xbox 360"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2005, maxYear: 2019, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 49                           :   //return "Microsoft Xbox One"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2013, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 169                    :   //return "Microsoft Xbox Series S|X"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2020, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 80                                  :   //return "Neo Geo AES"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1991, maxYear: 2005, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 136                                   :   //return "Neo Geo CD"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1994, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 119                               :   //return "Neo Geo Pocket"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1998, maxYear: 2001, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 120                         :   //return "Neo Geo Pocket Color"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1999, maxYear: 2002, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 307                        :   //return "Nintendo Game & Watch"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1980, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 18          :   //return "Nintendo Entertainment System (NES)"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1985, maxYear: 1998, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 19   :   //return "Super Nintendo Entertainment System (SNES)"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1991, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 87                         :   //return "Nintendo Virtual Boy"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1995, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 4                                  :   //return "Nintendo 64"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1996, maxYear: 2003, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 21                            :   //return "Nintendo GameCube"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2001, maxYear: 2008, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 5                                 :   //return "Nintendo Wii"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2006, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 41                               :   //return "Nintendo Wii U"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2012, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 130                              :
                    //return "Nintendo Switch"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2017, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 33                            :
                    
                    //return "Nintendo Game Boy"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1989, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 22     :   //return "Nintendo Game Boy Color"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1998, maxYear: 2003, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 24                    :   //return "Nintendo Game Boy Advance"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2001, maxYear: 2009, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 20                                  :   //return "Nintendo DS"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2004, maxYear: 2015, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 159                                 :   //return "Nintendo DSi"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2009, maxYear: 2017, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 37                                 :   //return "Nintendo 3DS"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2011, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 137                             :   //return "New Nintendo 3DS"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2014, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 166                        :   //return "Nintendo Pokémon Mini"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2001, maxYear: 2003, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 42                                 :   //return "Nokia N-Gage"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2003, maxYear: 2007, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 122                                         :   //return "Nuon"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2000, maxYear: 2005, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 86                      :   //return "TurboGrafx-16/PC Engine"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1989, maxYear: 2000, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 128                         :   //return "PC Engine SuperGrafx"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1990, maxYear: 1995, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 117                                 :   //return "Philips CD-i"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1991, maxYear: 2000, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 84                                 :   //return "Sega SG-1000"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1983, maxYear: 1988, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 64                           :   //return "Sega Master System"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1986, maxYear: 1999, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 29                      :   //return "Sega Genesis/Mega Drive"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1989, maxYear: 1999, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 78                                      :   //return "Sega CD"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1992, maxYear: 1997, gameData: gameData, platformID: platformID)
                    
                    if array.count > 0 {
                        return array
                    }
                    
                case 30                                     :   //return "Sega 32X"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1994, maxYear: 1997, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 32                                  :   //return "Sega Saturn"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1995, maxYear: 1999, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 23                               :   //return "Sega Dreamcast"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1999, maxYear: 2005, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 35                               :   //return "Sega Game Gear"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1991, maxYear: 1998, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 339                                    :   //return "Sega Pico"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1993, maxYear: 1999, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 7                             :   //return "Sony PlayStation"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1995, maxYear: 2006, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 8                           :   //return "Sony PlayStation 2"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2000, maxYear: 2014, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                    
                case 9                           :   //return "Sony PlayStation 3"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2006, maxYear: 2021, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 48                           :   //return "Sony PlayStation 4"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2013, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                
                case 165                           :    //PS VR
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2013, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 167                           :   //return "Sony PlayStation 5"
                    
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2020, maxYear: 2050, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 38              :   //return "Sony PlayStation Portable (PSP)"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2005, maxYear: 2017, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 46                        :   //return "Sony PlayStation Vita"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2012, maxYear: 2022, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 70                                      :   //return "Vectrex"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1982, maxYear: 1984, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 57                                   :   //return "WonderSwan"  JP
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 1993, maxYear: 2002, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 123                             :   //return "WonderSwan Color" JP
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2000, maxYear: 2005, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                case 240                                        :   //return "Zeebo"
                    array = filterRegions(releaseDate: releaseDate, consoleReleaseYear: 2009, maxYear: 2011, gameData: gameData, platformID: platformID)
                    if array.count > 0 {
                        return array
                    }
                    
                default                                             : print("Unkown Platform, platform ID is \(platformID)")
                }
                
                
            }
        }
        return array
        
        
        
        
        
    }
    
    
    func addGameToArray(gameFromRegion: [ReleaseDate], gameData: IGDBGame, platform: Int) -> [GameObject]{
        
        var array : [GameObject] = []
        let game = createGameWithPlatformDateFiltered(releaseDates: gameFromRegion, platformID: platform, gameData: gameData)
        
        array.append(contentsOf: game)
        
        return array
        
    }
    
    
    func createFilterParameters(title:String, platforms: [Int], genres: [Int], yearRange: [Int]) -> String {
        //        print("create filter parameters")
        
        var requestParameters = ""
        
        var platformsString: String?
        for platform in platforms {
            if platformsString == nil {
                platformsString = String(platform)
            } else {
                platformsString = platformsString! + ", " + String(platform)
            }
        }
        
        var genreString: String?
        for genre in genres {
            if genreString == nil {
                genreString = String(genre)
            } else {
                genreString = genreString! + ", " + String(genre)
            }
        }
        var startYear = 0
        var endYear = 0
        
        if yearRange.count >= 2 {
            
            let calendar = Calendar.current
            
            let firstDateComponents = DateComponents(calendar: nil, timeZone: TimeZone(secondsFromGMT: -18000), era: nil, year: yearRange.first, month: 1, day: 1, hour: 1, minute: 0, second: 0, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            
            
            let secondDateComponents = DateComponents(calendar: nil, timeZone: TimeZone(secondsFromGMT: -18000), era: nil, year: yearRange.last, month: 1, day: 1, hour: 1, minute: 0, second: 0, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            
            
            startYear = Int(calendar.date(from: firstDateComponents)!.timeIntervalSince1970)
            
            
            endYear = Int(calendar.date(from: secondDateComponents)!.timeIntervalSince1970)
        }
        print("new parameters", title, platforms, genres, yearRange)
        switch (title == "", platforms.isEmpty, genres.isEmpty, yearRange.isEmpty) {
            
            
        case (true, true, true, true):
            //no search parameters
            //Title
            //Platforms
            //Genres
            //Years
            print("no search parameters")
            
        case (false, false, false,false):
            //Title         X
            //Platforms     X
            //Genres        X
            //Years         X
            
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & first_release_date > \(startYear) & first_release_date <= \(endYear) & genres = (\(genreString!)); search \"\(title)\"; limit 500;"
            
        case (false, true, true, true):
            //Title         X
            //Platforms
            //Genres
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7); search \"\(title)\"; limit 500;"
            
        case(false, false, true, true):
            //Title         X
            //Platforms     X
            //Genres
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)); search \"\(title)\"; limit 500;"
            
            
        case(false, true, true, false):
            //Title         X
            //Platforms
            //Genres
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & first_release_date > \(startYear) & first_release_date <= \(endYear); search \"\(title)\"; limit 500;"
        case(false, true, false, true):
            //Title         X
            //Platforms
            //Genres        X
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & genres = (\(genreString!)); search \"\(title)\"; limit 500;"
        case(false, false, false, true):
            //Title         X
            //Platforms     X
            //Genres        X
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & genres = (\(genreString!)); search \"\(title)\"; limit 500;"
        case(false, false, true, false):
            //Title         X
            //Platforms     X
            //Genres
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & first_release_date > \(startYear) & first_release_date <= \(endYear); search \"\(title)\"; limit 500;"
        case(false, true, false, false):
            //Title         X
            //Platforms
            //Genres        X
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & genres = (\(String(describing: genreString))) & first_release_date > \(startYear) & first_release_date <= \(endYear); search \"\(title)\"; limit 500;"
        case(true, false, true, true):
            //Title
            //Platforms     X
            //Genres
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7)  & platforms = (\(platformsString!)); limit 500; sort name asc;"
        case (true, false, false, true):
            //Title
            //Platforms     X
            //Genres        X
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & genres = (\(genreString!)); limit 500; sort name asc;"
        case(true, false, false, false):
            //Title
            //Platforms     X
            //Genres        X
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & genres = (\(genreString!)) & first_release_date > \(startYear) & first_release_date <= \(endYear); limit 500; sort name asc;"
        case(true, false, true, false):
            //Title
            //Platforms     X
            //Genres
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = (\(platformsString!)) & genres = (\(genreString!)) & first_release_date > \(startYear) & first_release_date <= \(endYear); limit 500; sort name asc;"
        case(true, true, false, true):
            //Title
            //Platforms
            //Genres        X
            //Years
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & genres = (\(genreString!)); limit 500; sort name asc;"
        case(true, true, false, false):
            //Title
            //Platforms
            //Genres        X
            //Years         X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & genres = (\(genreString!)) & first_release_date > \(startYear) & first_release_date <= \(endYear); limit 500; sort name asc;"
        case(true, true, true, false):
            //Title
            //Platforms
            //Genres
            //Years     X
            requestParameters = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & first_release_date > \(startYear) & first_release_date <= \(endYear); limit 500; sort name asc;"
            
            
        }
        //        print("request parameters",requestParameters)
        return requestParameters
        
    }
    
    func createHTTPBody(sortByField: String?, sortAscending: Bool?, filterBy: String?, platformID: Int?, searchByName: String?, offset: Int, resultsPerPage: Int?) -> String {
        var sortDirection = "asc"
        var sort : String?
        var filter : String?
        
        if let sortField = sortByField {
            if let sortAsc = sortAscending {
                
                switch sortAsc {
                    
                case true:
                    sortDirection = "asc"
                case false:
                    sortDirection = "dsc"
                    
                }
                
                sort = " sort" + " \(sortField)" + " \(sortDirection);"
            }
            
        }
        
        if let filterParameters = filterBy {
            if let platformID = platformID {
                
                if let searchName = searchByName {
                    if platformID == 48 {
                        //igdb considers ps4 & psvr separate platforms, this will assist merging to one category
                        filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(48,165) & name ~ *\"\(searchName)\"*; sort name asc;"

                        
                        
                    } else {
                        filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)) & name ~ *\"\(searchName)\"*; sort name asc;"
                        
                    }
                } else {
                    
                    if platformID == 48 {
                        //igdb considers ps4 & psvr separate platforms, this will assist merging to one category
                        filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(48,165); sort name asc;"

                        
                        
                    } else {
                
                    filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)); sort name asc;"
                    }
                }
            } else {
                if let searchName = searchByName {
                    
                    
                    filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters) & name ~ *\"\(searchName)\"*; sort name asc;"
                } else {
                    
                    filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & release_dates.region != (5,6,7) & \(filterParameters); sort name asc;"
                    
                }
            }
        }
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.company.logo.*,  involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id, release_dates.*;"
        
        
        
        var httpBodyString = fields + " offset \(offset);"
        
        if let limit = resultsPerPage {
            httpBodyString += " limit \(limit);"
        }
        
        if let sortFields = sort {
            httpBodyString += sortFields
        }
        
        if let filterData = filter {
            httpBodyString += filterData
        }
        
        return httpBodyString
    }
    
    
    
}
