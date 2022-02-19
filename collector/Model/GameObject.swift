//
//  GameObject.swift
//  gameology
//
//  Created by Brian on 2/17/22.
//  Copyright © 2022 Brian. All rights reserved.
//

import UIKit

struct GameObject: Equatable {
    static func == (lhs: GameObject, rhs: GameObject) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }

    var title : String?
    var id : Int?
    var overview : String?
    var boxartFrontImage : String?
    var boxartInfo : ImageInfo?
    var boxartImage: UIImage?
    var boxartHeight : Int?
    var boxartWidth : Int?
    var boxartResolution : String?
    var boxartRearImage: String?
    var fanartImage : String?
    var rating : String?
    var releaseDate: String?
    var owned : Bool?
    var index: Int?
    var screenshots : [ImageInfo]?
    var developerIDs, genreIDs, pusblisherIDs : [Int]?
    var youtubePath: String?
    var platformID : Int?
    var platformName : String?
    var maxPlayers : String?
    var genreDescriptions : String?
    var genre : [Genre]?
    var genres : [String]?
    var developer : String?
    var developerLogo: ImageInfo?
    var gamePhotos: [NSData]?
    var manualPhotos : [NSData]?
    var boxPhotos : [NSData]?
    var totalRating : Int?
    var userRating : Int?
    var indexSection : Int?
    var namePrefix : String?

    func fetchPlatformFlag(platformID: Int, uiMode: UIUserInterfaceStyle) -> UIImage {

            var platformImageName = UIImage()

            switch platformID {
            case 18:

                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "NESLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "NESLogoInverse")!

                }

            case 19:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "SNESLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "SNESLogoInverse")!

                }
            case 4:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "N64Logo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "N64LogoInverse")!

                }
            case 21:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "GCLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "GCLogoInverse")!

                }
            case 33:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "GBLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "GBLogoInverse")!

                }
            case 24:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "GBALogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "gbaLogoInverse")!
                }
            case 29:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "SegaGenesisLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "SegaGenesisLogoInverse")!
                }
            case 78:
                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "SegaCDLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "SegaCDLogoInverse")!
                }

            case 339:
                platformImageName = UIImage(named: "SegaPicoLogo")!

            case 8:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPlaystation2Logo")!
                } else {

                    platformImageName = UIImage(named: "SonyPlaystation2LogoInverse")!
                }

            case 88:
                platformImageName = UIImage(named: "OdysseyLogo")!

            case 68:
                platformImageName = UIImage(named: "ColecovisionLogo")!
            case 35:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SegaGameGearLogo")!
                } else {
                    platformImageName = UIImage(named: "SegaGameGearLogoInverse")!
                }
            case 123:
                if uiMode == .light {
                    platformImageName = UIImage(named: "WonderSwanColorLogo")!
                } else {
                    platformImageName = UIImage(named: "WonderSwanColorLogoInverse")!
                }
            case 136:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NeoGeoCDLogo")!
                } else {
                    platformImageName = UIImage(named: "NeoGeoCDLogoInverse")!

                }

            case 62:
                platformImageName = UIImage(named: "AtariJaguarLogo")!

            case 87:
                platformImageName = UIImage(named: "VirtualBoyLogo")!
            case 89:
                platformImageName = UIImage(named: "MicrovisionLogo")!
            case 128:
                platformImageName = UIImage(named: "SuperGrafxLogo")!
            case 23:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SegaDreamcastLogo")!
                } else {
                    platformImageName = UIImage(named: "SegaDreamcastLogoInverse")!
                }
            case 70:
                if uiMode == .light {
                    platformImageName = UIImage(named: "VectrexLogo")!
                } else {
                    platformImageName = UIImage(named: "VectrexLogoInverse")!
                }

            case 119:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NeoGeoPocketLogo")!
                } else {
                    platformImageName = UIImage(named: "NeoGeoPocketLogoInverse")!
                }

            case 124:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SwanCrystalLogo")!
                } else {
                    platformImageName = UIImage(named: "SwanCrystalLogoInverse")!
                }
            case 127:
                if uiMode == .light {
                    platformImageName = UIImage(named: "FairchildChannelFLogo")!
                } else {
                    platformImageName = UIImage(named: "FairchildChannelFLogoInverse")!
                }
            case 130:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NintendoSwitchLogo")!
                } else {
                    platformImageName = UIImage(named: "NintendoSwitchLogoInverse")!
                }
            case 138:
                if uiMode == .light {
                    platformImageName = UIImage(named: "VC4000Logo")!

                } else {
                    platformImageName = UIImage(named: "VC4000LogoInverse")!
                }
            case 159:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NintendoDSiLogo")!
                } else {
                    platformImageName = UIImage(named: "NintendoDSiLogoInverse")!
                }
            case 11:
                platformImageName = UIImage(named: "XBoxLogo")!
            case 50:
                if uiMode == .light {
                    platformImageName = UIImage(named: "3DOLogo")!
                } else {
                    platformImageName = UIImage(named: "3DOLogoInverse")!
                }
            case 60:
                if uiMode == .light {
                    platformImageName = UIImage(named: "Atari7800Logo")!
                } else {
                    platformImageName = UIImage(named: "Atari7800LogoInverse")!
                }
            case 30:
                if uiMode == .light {
                    platformImageName = UIImage(named: "Sega32XLogo")!
                } else {
                    platformImageName = UIImage(named: "Sega32XLogoInverse")!
                }
            case 22:
                platformImageName = UIImage(named: "GameBoyColorLogo")!

            case 41:
                platformImageName = UIImage(named: "NintendoWiiULogo")!
            case 114:
                if uiMode == .light {
                    platformImageName = UIImage(named: "AmigaCD32Logo")!
                } else {
                    platformImageName = UIImage(named: "AmigaCD32LogoInverse")!
                }
            case 117:
                if uiMode == .light {
                    platformImageName = UIImage(named: "PhilipsCDiLogo")!
                } else {
                    platformImageName = UIImage(named: "PhilipsCDiLogoInverse")!
                }

            case 122:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NuonLogo")!
                } else {
                    platformImageName = UIImage(named: "NuonLogoInverse")!
                }
            case 120:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NeoGeoPocketColorLogo")!
                } else {
                    platformImageName = UIImage(named: "NeoGeoPocketColorLogoInverse")!

                }
            case 37:
                if uiMode == .light {
                    platformImageName = UIImage(named: "Nintendo3DSLogo")!
                } else {
                    platformImageName = UIImage(named: "Nintendo3DSLogoInverse")!

                }
            case 64:
                platformImageName = UIImage(named: "SegaMasterSystemLogo")!
            case 38:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPSPLogo")!
                } else {
                    platformImageName = UIImage(named: "SonyPSPLogoInverse")!

                }
            case 86:
                platformImageName = UIImage(named: "TurboGrafx16Logo")!
            case 307:
                if uiMode == .light {
                    platformImageName = UIImage(named: "GameAndWatchLogo")!
                } else {
                    platformImageName = UIImage(named: "GameAndWatchLogoInverse")!
                }
            case 20:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NintendoDSLogo")!
                } else {
                    platformImageName = UIImage(named: "NintendoDSLogoInverse")!
                }
            case 32:
                platformImageName = UIImage(named: "SegaSaturnLogo")!
            case 42:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NokiaNGageLogo")!
                } else {
                    platformImageName = UIImage(named: "NokiaNGageLogoInverse")!
                }
            case 66:
                if uiMode == .light {
                    platformImageName = UIImage(named: "Atari5200Logo")!
                } else {
                    platformImageName = UIImage(named: "Atari5200LogoInverse")!
                }
            case 67:
                if uiMode == .light {
                    platformImageName = UIImage(named: "MattelIntelliVisionLogo")!
                } else {
                    platformImageName = UIImage(named: "MattelIntelliVisionLogoInverse")!

                }

            case 9:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPlaystation3Logo")!
                } else {
                    platformImageName = UIImage(named: "SonyPlaystation3LogoInverse")!
                }
            case 46:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPSVitaLogo")!
                } else {
                    platformImageName = UIImage(named: "SonyPSVitaLogoInverse")!

                }
            case 48:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPlaystation4Logo")!
                } else {
                    platformImageName = UIImage(named: "SonyPlaystation4LogoInverse")!

                }
            case 49:
                if uiMode == .light {
                    platformImageName = UIImage(named: "XBoxOneLogo")!
                } else {
                    platformImageName = UIImage(named: "XBoxOneLogoInverse")!
                }
            case 61:
                platformImageName = UIImage(named: "AtariLynxLogo")!
            case 12:
                if uiMode == .light {
                    platformImageName = UIImage(named: "XBox360Logo")!
                } else {
                    platformImageName = UIImage(named: "XBox360LogoInverse")!
                }
            case 167:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPlaystation5Logo")!
                } else {
                    platformImageName = UIImage(named: "SonyPlaystation5LogoInverse")!

                }
            case 137:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NewNintendo3DSLogo")!
                } else {
                    platformImageName = UIImage(named: "NewNintendo3DSLogoInverse")!

                }

            case 7:
                if uiMode == .light {
                    platformImageName = UIImage(named: "SonyPlaystationLogo")!
                } else {
                    platformImageName = UIImage(named: "SonyPlayStationLogoInverse")!
                }
            case 80:
                if uiMode == .light {
                    platformImageName = UIImage(named: "NeoGeoLogo")!
                } else {
                    platformImageName = UIImage(named: "NeoGeoLogoInverse")!

                }
            case 84:
                platformImageName = UIImage(named: "SegaSG1000Logo")!



            case 57:
                if uiMode == .light {
                    platformImageName = UIImage(named: "WonderSwanLogo")!
                } else {
                    platformImageName = UIImage(named: "WonderSwanLogoInverse")!

                }

            case 169:
                if uiMode == .light {
                    platformImageName = UIImage(named: "XBoxSeriesLogo")!
                } else {
                    platformImageName = UIImage(named: "XBoxSeriesLogoInverse")!

                }
            case 5:
                platformImageName = UIImage(named: "NintendoWiiLogo")!
            case 166:
                platformImageName = UIImage(named: "PokemonMiniLogo")!
            case 240:
                platformImageName = UIImage(named: "ZeeboLogo")!
            case 274:
                platformImageName = UIImage(named: "PCFXLogo")!
            case 59:
                platformImageName = UIImage(named: "Atari2600Logo")!

            case 0:

                if uiMode == .light {
                    //Light Mode
                    platformImageName = UIImage(named: "allPlatformLogo")!
                } else {
                    //Dark Mode
                    platformImageName = UIImage(named: "allPlatformLogoInverse")!

                }

            default:
                print("Invalid Platform")


            }
            return platformImageName


    }

    func fetchLibraryIcon(platformID: Int, isOwned: Bool) -> UIImage? {
        var image = UIImage(named: "cd-plus-inversed")

        switch platformID {

        case 240                :   if isOwned {
            image = UIImage(named:"hdd-minus-inversed")}
            else {
                image = UIImage(named:"hdd-plus-inversed")}

        case 57, 123            :   if isOwned {
            image = UIImage(named:"wonderswan-minus-inversed")}
            else {
                image = UIImage(named:"wonderswan-plus-inversed")}

        case 70                 :   if isOwned {
            image = UIImage(named:"vectrex-minus-inversed")}
            else {
                image = UIImage(named:"vectrex-plus-inversed")}

        case 86, 128            :   if isOwned {
                    image = UIImage(named:"turbografx-minus-inversed")}
            else {
                        image = UIImage(named:"turbografx-plus-inversed")}

        case 42                 :   if isOwned {
            image = UIImage(named:"ngage-minus-inversed")}
            else {
                image = UIImage(named:"ngage-plus-inversed")}

        case 61                 :   if isOwned {
            image = UIImage(named:"atarilynx-minus-inversed")}
            else {
                image = UIImage(named:"atarilynx-plus-inversed")}

        case 66                 :   if isOwned {
            image = UIImage(named:"atari5200-minus-inversed")}
            else {
                image = UIImage(named:"atari5200-plus-inversed")}

        case 59, 60             :   if isOwned {
            image = UIImage(named:"atari2600-minus-inversed")}
            else {
                image = UIImage(named:"atari2600-plus-inversed")}

        case 307                :   if isOwned {
            image = UIImage(named:"gameandwatch-minus-inversed")}
            else {
                image = UIImage(named:"gameandwatch-plus-inversed")}

        case 18                 :   if isOwned {
            image = UIImage(named:"nes-minus-inversed")}
            else {
                image = UIImage(named:"nes-plus-button")}

        case 19                 :   if isOwned {
            image = UIImage(named:"snes-minus-inversed")}
            else {
                image = UIImage(named:"snes-plus-inversed")}

        case 4                  :   if isOwned {
            image = UIImage(named:"n64-minus-inversed")}
            else {
                image = UIImage(named:"n64-plus-inversed")}

        case 87                 :   if isOwned {
            image = UIImage(named:"nvb-minus-inversed")}
            else {
                image = UIImage(named:"nvb-plus-inversed")}

        case 20, 159, 37, 137   :   if isOwned {
            image = UIImage(named:"nds-minus-inversed")}
            else {
                image = UIImage(named:"nds-plus-inversed")}

        case 21                 :   if isOwned {
            image = UIImage(named:"gc-minus-inversed")}
            else {
                image = UIImage(named:"gc-plus-inversed")}

        case 33, 22             :   if isOwned {
            image = UIImage(named:"gb-minus-inversed")}
            else {
                image = UIImage(named:"gb-plus-inversed")}

        case 24                 :   if isOwned {
            image = UIImage(named:"gba-minus-inversed")}
            else {
                image = UIImage(named:"gba-plus-inversed")}

        case 166                :   if isOwned {
            image = UIImage(named:"nintendopokemonmini-minus-inversed")}
            else {
                image = UIImage(named:"nintendopokemonmini-plus-inversed")}

        case 130                :   if isOwned {
            image = UIImage(named:"switch-minus-inversed")}
            else {
                image = UIImage(named:"switch-plus-inversed")}

        case 64                 :   if isOwned {
            image = UIImage(named:"sms-minus-inversed")}
            else {
                image = UIImage(named:"sms-plus-inversed")}

        case 35                 :   if isOwned {
            image = UIImage(named:"gamegear-minus-inversed")}
            else {
                image = UIImage(named:"gamegear-plus-inversed")}

        case 30                 :   if isOwned {
            image = UIImage(named:"32x-minus-inversed")}
            else {
                image = UIImage(named:"32x-plus-inversed")}

        case 62                 :   if isOwned {
            image = UIImage(named:"atarijaguar-minus-inversed")}
            else {
                image = UIImage(named:"atarijaguar-plus-inversed")}

        case 29                 :   if isOwned {
            image = UIImage(named:"genesis-minus-inversed")}
            else {
                image = UIImage(named:"genesis-plus-inversed")}

        case 80                 :   if isOwned {
            image = UIImage(named:"neogeo-minus-inversed")}
            else {
                image = UIImage(named:"neogeo-plus-inversed")}
        case 78, 7, 167, 12,
            49, 48, 9, 32,
            117, 114, 50, 11,
            23, 136, 8, 169,
            5, 122, 41         :   if isOwned {
                image = UIImage(named:"cd-minus-inversed")}
            else {
                image = UIImage(named:"cd-plus-inversed")}

        case 84                 :   if isOwned {
            image = UIImage(named:"segasg1000-minus-inversed")}
            else {
                image = UIImage(named:"segasg1000-plus-inversed")}

        case 339                :   if isOwned {
            image = UIImage(named:"segapico-minus-inversed")}
            else {
                image = UIImage(named:"segapico-plus-inversed")}

        case 38                 :   if isOwned {
            image = UIImage(named:"sonypsp-minus-inversed")}
            else {
                image = UIImage(named:"sonypsp-plus-inversed")}

        case 46                 :   if isOwned {
            image = UIImage(named:"psvita-minus-inversed")}
            else {
                image = UIImage(named:"psvita-plus-inversed")}

        case 68                 :   if isOwned {
            image = UIImage(named:"colecovision-minus-inversed")}
            else {
                image = UIImage(named:"colecovision-plus-inversed")}

        case 127                :   if isOwned {
            image = UIImage(named:"fairchild-minus-inversed")}
            else {
                image = UIImage(named:"fairchild-plus-inversed")}

        case 67                 :   if isOwned {
            image = UIImage(named:"intellivision-minus-inversed")}
            else {
                image = UIImage(named:"intellivision-plus-inversed")}

        case 88                 :   if isOwned {
            image = UIImage(named:"odyssey-minus-inversed")}
            else {
                image = UIImage(named:"odyssey-plus-inversed")}

        case 119, 120           :   if isOwned {
            image = UIImage(named:"neogeopocket-minus-inversed")}
            else {
                image = UIImage(named:"neogeopocket-plus-inversed")}

        default                 :   print("Invalid Platform")

        }

        return image

    }


    func fetchGenreImage(for genreID: Int) -> UIImage? {
        var image : UIImage?

        switch genreID {

        case 4:
            image = UIImage(named: "genre-icon-fighting")
        case 5:
            image = UIImage(named: "genre-icon-shooter")
        case 7:
            image = UIImage(named: "genre-icon-music")
        case 8:
            image = UIImage(named: "genre-icon-platform")
        case 9:
            image = UIImage(named: "genre-icon-puzzle")
        case 10:
            image = UIImage(named: "genre-icon-racing")
        case 11:
            image = UIImage(named: "genre-icon-strategy")
        case 12:
            image = UIImage(named: "genre-icon-rpg")
        case 13:
            image = UIImage(named: "genre-icon-simulator")
        case 14:
            image = UIImage(named: "genre-icon-sport")
        case 15:
            image = UIImage(named: "genre-icon-strategy")
        case 16:
            image = UIImage(named: "genre-icon-turn-based-strategy")
        case 24:
            image = UIImage(named: "genre-icon-tactical")
        case 26:
            image = UIImage(named: "genre-icon-quiz-trivia")
        case 25:
            image = UIImage(named: "genre-icon-hack-and-slash")
        case 30:
            image = UIImage(named: "genre-icon-pinball")
        case 33:
            image = UIImage(named: "genre-icon-arcade")
        case 31:
            image = UIImage(named: "genre-icon-adventure")
        case 34:
            image = UIImage(named: "genre-icon-visual-novel")
        case 32:
            image = UIImage(named: "genre-icon-indie")
        case 35:
            image = UIImage(named: "genre-icon-card-board-game")
        case 36:
            image = UIImage(named: "genre-icon-moba")
        case 2:
            image = UIImage(named: "genre-icon-point-and-click")


        default: print("invalid genre id, id is ", genreID)



        }

        return image
    }

    func fetchAgeRatingIcon(for rating: String) -> UIImage? {
        var image : UIImage?

        switch rating {
        //setting the PEGI or ESRB label icon based on age rating from api
        case "PEGI 3":
            image = UIImage(named: "pegi3")
        case "PEGI 7":
            image = UIImage(named: "pegi7")
        case "PEGI 12":
            image = UIImage(named: "pegi12")
        case "PEGI 16":
            image = UIImage(named: "pegi16")
        case "PEGI 18":
            image = UIImage(named: "pegi18")
        case "ESRB EC":
            image = UIImage(named: "ESRB-EC")
        case "ESRB E":
            image = UIImage(named: "ESRB-E")
        case "ESRB E10":
            image = UIImage(named: "ESRB-E10Plus")
        case "ESRB T":
            image = UIImage(named: "ESRB-T")
        case "ESRB M":
            image = UIImage(named: "ESRB-M")
        case "ESRB AO":
            image = UIImage(named: "ESRB-AO")
        case "ESRB RP":
            image = UIImage(named: "ESRB-NR")
        default:
            image = UIImage(named: "ESRB-NR")
        }

        return image

    }

    func formatPrettyPlatformNameToID(platformName: String) -> Int {

        switch platformName {
        case "3DO Interactive Multiplayer"                  :   return 50
        case "Amiga CD32"                                   :   return 114
        case "Atari 2600"                                   :   return 59
        case "Atari 5200"                                   :   return 66
        case "Atari 7800"                                   :   return 60
        case "Atari Jaguar"                                 :   return 62
        case "Atari Lynx"                                   :   return 61
        case "ColecoVision"                                 :   return 68
        case "Fairchild Channel F"                          :   return 127
        case "Intellivision"                                :   return 67
        case "Magnavox Odyssey"                             :   return 88
        case "Microsoft Xbox"                               :   return 11
        case "Microsoft Xbox 360"                           :   return 12
        case "Microsoft Xbox One"                           :   return 49
        case "Microsoft Xbox Series S|X"                    :   return 169
        case "Neo Geo AES"                                  :   return 80
        case "Neo Geo CD"                                   :   return 136
        case "Neo Geo Pocket"                               :   return 119
        case "Neo Geo Pocket Color"                         :   return 120
        case "Nintendo Game & Watch"                        :   return 307
        case "Nintendo Entertainment System (NES)"          :   return 18
        case "Super Nintendo Entertainment System (SNES)"   :   return 19
        case "Nintendo Virtual Boy"                         :   return 87
        case "Nintendo 64"                                  :   return 4
        case "Nintendo GameCube"                            :   return 21
        case "Nintendo Wii"                                 :   return 5
        case "Nintendo Wii U"                               :   return 41
        case "Nintendo Switch"                              :   return 130
        case "Nintendo Game Boy"                            :   return 33
        case "Nintendo Game Boy Color"                      :   return 22
        case "Nintendo Game Boy Advance"                    :   return 24
        case "Nintendo DS"                                  :   return 20
        case "Nintendo DSi"                                 :   return 159
        case "Nintendo 3DS"                                 :   return 37
        case "New Nintendo 3DS"                             :   return 137
        case "Nintendo Pokémon Mini"                        :   return 166
        case "Nokia N-Gage"                                 :   return 42
        case "Nuon"                                         :   return 122
        case "TurboGrafx-16/PC Engine"                      :   return 86
        case "PC Engine SuperGrafx"                         :   return 128
        case "Philips CD-i"                                 :   return 117
        case "Sega SG-1000"                                 :   return 84
        case "Sega Master System"                           :   return 64
        case "Sega Genesis/Mega Drive"                      :   return 29
        case "Sega CD"                                      :   return 78
        case "Sega 32X"                                     :   return 30
        case "Sega Saturn"                                  :   return 32
        case "Sega Dreamcast"                               :   return 23
        case "Sega Game Gear"                               :   return 35
        case "Sega Pico"                                    :   return 339
        case "Sony PlayStation"                             :   return 7
        case "Sony PlayStation 2"                           :   return 8
        case "Sony PlayStation 3"                           :   return 9
        case "Sony PlayStation 4"                           :   return 48
        case "Sony PlayStation 5"                           :   return 167
        case "Sony PlayStation Portable (PSP)"              :   return 38
        case "Sony PlayStation Vita"                        :   return 46
        case "Vectrex"                                      :   return 70
        case "WonderSwan"                                   :   return 57
        case "WonderSwan Color"                             :   return 123
        case "Zeebo"                                        :   return 240
        default                                             :   return 18
        }

    }
}
