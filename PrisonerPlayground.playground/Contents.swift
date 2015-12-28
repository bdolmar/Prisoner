//: Playground - noun: a place where people can play

import Cocoa

enum PrisonerAppTypes: String {
    case JVM = "jar"
    case DotNET = "exe"
    case Ruby = "rb"
    case PHP = "php"
    case Python = "py"
    case JavaScript = "js"
    case Native = "native"
    
}
let appURL = NSURL(fileURLWithPath: "bin/Prisoner.js")
let pathComponent = appURL.pathExtension?.lowercaseString

if let unwrappedPathComponent = pathComponent, appType = PrisonerAppTypes(rawValue: unwrappedPathComponent) {
    print(appType)
} else {
    print("Couldn't match type")
}
