import Foundation

enum Direction: Character {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

struct Bathroom {
    
    let pinpad = [[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]]
    
    var position = (x: 1, y: 1) {
        didSet {
            if position.x < 0 {
                position.x = 0
            }
            
            if position.x > 2 {
                position.x = 2
            }
            
            if position.y < 0 {
                position.y = 0
            }
            
            if position.y > 2 {
                position.y = 2
            }
        }
    }
    
    let instructions = "ULL\n" +
                   "RRDDD\n" +
                   "LURDL\n" +
                   "UUUUD"
                   
    let password = [Int]()
    
    mutating func runInput() {
        let parsedInstructions = instructions.components(separatedBy: "\n")
        
        for instruction in parsedInstructions {
            
            for directionChar in instruction.characters {
                guard let direction = Direction(rawValue: directionChar) else {
                    fatalError("Invalid Direction")
                }
                
                move(direction: direction)
            }
            
            printKeyAtCurrentPosition()
        }
    }
    
    mutating func move(direction: Direction) {
        switch direction {
            case .up:
                position.y -= 1
            
            case .down:
                position.y += 1
            
            case .left:
                position.x -= 1
                
            case .right:
                position.x += 1
        }
    }
    
    func printKeyAtCurrentPosition() {
        print(pinpad[position.y][position.x], terminator: "")
    }
}


var b = Bathroom()
b.runInput()
