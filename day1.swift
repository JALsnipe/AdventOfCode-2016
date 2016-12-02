// original revision history here: https://gist.github.com/JALsnipe/e2e6365489f80e51fa57d101d809a453

import Foundation

enum Direction: String {
    case right = "R"
    case left = "L"
}

enum CompassPoint {
    case north
    case south
    case east
    case west
    
    func rotate(direction: Direction) -> CompassPoint {
        switch self {
        case .north:
            switch direction {
            case .right:
                return .east
            case .left:
                return .west
            }
        case .south:
            switch direction {
            case .right:
                return .west
            case .left:
                return .east
            }
        case .east:
            switch direction {
            case .right:
                return .south
            case .left:
                return .north
            }
        case .west:
            switch direction {
            case .right:
                return .north
            case .left:
                return .south
            }
        }
    }
}

struct Map {
    
    var position = CGPoint(x: 0, y: 0)
    var currentDirection = CompassPoint.north
    var history = [CGPoint : Int]()
    
    var input = "R5, R4, R2, L3, R1, R1, L4, L5, R3, L1, L1, R4, L2, R1, R4, R4, L2, L2, R4, L4, R1, R3, L3, L1, L2, R1, R5, L5, L1, L1, R3, R5, L1, R4, L5, R5, R1, L185, R4, L1, R51, R3, L2, R78, R1, L4, R188, R1, L5, R5, R2, R3, L5, R3, R4, L1, R2, R2, L4, L4, L5, R5, R4, L4, R2, L5, R2, L1, L4, R4, L4, R2, L3, L4, R2, L3, R3, R2, L2, L3, R4, R3, R1, L4, L2, L5, R4, R4, L1, R1, L5, L1, R3, R1, L2, R1, R1, R3, L4, L1, L3, R2, R4, R2, L2, R1, L5, R3, L3, R3, L1, R4, L3, L3, R4, L2, L1, L3, R2, R3, L2, L1, R4, L3, L5, L2, L4, R1, L4, L4, R3, R5, L4, L1, L1, R4, L2, R5, R1, R1, R2, R1, R5, L1, L3, L5, R2"
    
    mutating func runInput() {
        // strip whitespace
        let parsedInput = input.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
        
        for instruction in parsedInput {
            // orient
            
            let index = instruction.index(after: instruction.startIndex)
            
            guard let direction = Direction(rawValue: instruction.substring(to: index)) else {
                fatalError("Invalid direction")
            }
            
            currentDirection = currentDirection.rotate(direction: direction)
            
            // get distance to move
            guard let distance = Int(instruction.substring(from: index)) else {
                fatalError("Invalid distance")
            }
            
            // move
            move(spaces: distance)
        }
        
        print("Position is \(position)")
        
        print("Distance is \(calculateDistance())")
    }
    
    mutating func move(spaces: Int) {
        switch currentDirection {
        case .north:
            // position.y += spaces
            
            for _ in 1...spaces {
                position.y += CGFloat(1)
                recordMove()
            }
            
        case .south:
            // position.y -= spaces
            
            for _ in 1...spaces {
                position.y -= CGFloat(1)
                recordMove()
            }
            
        case .east:
            // position.x -= spaces
            
            for _ in 1...spaces {
                position.x -= CGFloat(1)
                recordMove()
            }
            
        case .west:
            // position.x += spaces
            
            for _ in 1...spaces {
                position.x += CGFloat(1)
                recordMove()
            }
        }
    }
    
    func calculateDistance() -> Int {
        return abs(Int(position.x)) + abs(Int(position.y))
    }
    
    mutating func recordMove() {
        if var count = history[position] {
            count += 1
            
            if count == 2 {
                print("Second visit to \(position)")
                print("Position of second visit \(abs(Int(position.x)) + abs(Int(position.y)))")
            }
            history[position] = count
        } else {
            history[position] = 1
        }
    }
}

extension CGPoint: Hashable {
    public var hashValue: Int {
        return hash()
    }
    
    func hash() -> Int {
        var hash = 23
        hash = hash &* 31 &+ Int(self.x)
        return hash &* 31 &+ Int(self.y)
    }
}

var map = Map()
map.runInput()
