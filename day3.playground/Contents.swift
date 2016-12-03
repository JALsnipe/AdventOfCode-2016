//: Playground - noun: a place where people can play

import UIKit

struct Triangle {
    var side1: Int
    var side2: Int
    var side3: Int
    
    var isValid: Bool {
        return (side1 + side2) > side3 &&
            (side2 + side3) > side1 &&
            (side1 + side3) > side2
    }
}

let inputPath = Bundle.main.path(forResource: "input", ofType: "txt")!

let input = try! String(contentsOfFile: inputPath)

// split by newline

let triangles = input.components(separatedBy: "\n").filter{ $0 != "" }

var validCount = 0
var invalidCount = 0

for triangle in triangles {
    // split by space
    
    let sides = triangle.components(separatedBy: " ").filter{ $0 != "" }
    
    guard sides.count == 3 else {
        fatalError("Invalid input")
    }
    
    let numericSides = sides.map{ Int($0) }
    
    let t = Triangle(side1: numericSides[0]!, side2: numericSides[1]!, side3: numericSides[2]!)
    
    if t.isValid {
        validCount += 1
    } else {
        invalidCount += 1
    }
    
}

print(validCount)
print(invalidCount)