//
//  WishList+CoreDataClass.swift
//  collector
//
//  Created by Brian on 9/29/21.
//  Copyright © 2021 Brian. All rights reserved.
//
//

import UIKit
import CoreData

@objc(WishList)
public class WishList: NSManagedObject {

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
}
