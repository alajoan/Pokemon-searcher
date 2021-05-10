//
//  UIStoryboardExtension.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func buildRegisterViewController() -> UIViewController {
        return registerStoryboard.instantiateViewController(withIdentifier: "Register")
    }
    
    static func buildMainViewController() -> UIViewController {
        return mainStoryboard.instantiateViewController(withIdentifier: "Main")
    }
}

extension UIStoryboard {
    static var registerStoryboard : UIStoryboard {
        return getStoryboard(name: "Register")
    }
    
    static var mainStoryboard : UIStoryboard {
        return getStoryboard(name: "Main")
    }
}

extension UIStoryboard {
    static func getStoryboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
