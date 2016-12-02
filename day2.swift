import Foundation

enum Direction: Character {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

struct Bathroom {
    
    // let pinpad = [[1, 2, 3],
    //               [4, 5, 6],
    //               [7, 8, 9]]
    
    let pinpad = [[0, 0, 1, 0, 0],
                  [0, 2, 3, 4, 0],
                  [5, 6, 7, 8, 9],
                  [0, "A", "B", "C", 0],
                  [0, 0, "D", 0, 0]]
    
    var position = (x: 0, y: 2) {
        didSet {
        }
    }
    
    let instructions =
    "DDDURLURURUDLDURRURULLRRDULRRLRLRURDLRRDUDRUDLRDUUDRRUDLLLURLUURLRURURLRLUDDURUULDURDRUUDLLDDDRLDUULLUDURRLUULUULDLDDULRLDLURURUULRURDULLLURLDRDULLULRRRLRLRULLULRULUUULRLLURURDLLRURRUUUDURRDLURUURDDLRRLUURLRRULURRDDRDULLLDRDDDDURURLLULDDULLRLDRLRRDLLURLRRUDDDRDLLRUDLLLLRLLRUDDLUUDRLRRRDRLRDLRRULRUUDUUDULLRLUDLLDDLLDLUDRURLULDLRDDLDRUDLDDLDDDRLLDUURRUUDLLULLRLDLUURRLLDRDLRRRRUUUURLUUUULRRUDDUDDRLDDURLRLRLLRRUDRDLRLDRRRRRRUDDURUUUUDDUDUDU\n" +
    "RLULUULRDDRLULRDDLRDUURLRUDDDUULUUUDDRDRRRLDUURDURDRLLLRDDRLURLDRRDLRLUURULUURDRRULRULDULDLRRDDRLDRUDUDDUDDRULURLULUDRDUDDDULRRRURLRRDLRDLDLLRLUULURLDRURRRLLURRRRRLLULRRRDDLRLDDUULDLLRDDRLLUUDRURLRULULRLRUULUUUUUDRURLURLDDUDDLRDDLDRRLDLURULUUDRDLULLURDLLLRRDRURUDDURRLURRDURURDLRUDRULUULLDRLRRDRLDDUDRDLLRURURLUDUURUULDURUDULRLRDLDURRLLDRDUDRUDDRLRURUDDLRRDLLLDULRRDRDRRRLURLDLURRDULDURUUUDURLDLRURRDRULLDDLLLRUULLLLURRRLLLDRRUDDDLURLRRRDRLRDLUUUDDRULLUULDURLDUUURUDRURUDRDLRRLDRURRLRDDLLLULUDDUULDURLRUDRDDD\n" +
    "RDDRUDLRLDDDRLRRLRRLUULDRLRUUURULRRLUURLLLRLULDDLDLRLULULUUDDDRLLLUDLLRUDURUDDLLDUDLURRULLRDLDURULRLDRLDLDRDDRUDRUULLLLRULULLLDDDULUUDUUDDLDRLRRDLRLURRLLDRLDLDLULRLRDLDLRLUULLDLULRRRDDRUULDUDLUUUUDUDRLUURDURRULLDRURUDURDUULRRULUULULRLDRLRLLRRRLULURLUDULLDRLDRDRULLUUUDLDUUUDLRDULRDDDDDDDDLLRDULLUDRDDRURUDDLURRUULUURURDUDLLRRRRDUDLURLLURURLRDLDUUDRURULRDURDLDRUDLRRLDLDULRRUDRDUUDRLURUURLDLUDLLRDDRDU\n" +
    "LLDDDDLUDLLDUDURRURLLLLRLRRLDULLURULDULDLDLLDRRDLUDRULLRUUURDRLLURDDLLUDDLRLLRDDLULRLDDRURLUDRDULLRUDDLUURULUUURURLRULRLDLDDLRDLDLLRUURDLUDRRRDDRDRLLUDDRLDRLLLRULRDLLRLRRDDLDRDDDUDUDLUULDLDUDDLRLDUULRULDLDULDDRRLUUURUUUDLRDRULDRRLLURRRDUDULDUDUDULLULLULULURLLRRLDULDULDLRDDRRLRDRLDRLUDLLLUULLRLLRLDRDDRUDDRLLDDLRULLLULRDDDLLLDRDLRULDDDLULURDULRLDRLULDDLRUDDUDLDDDUDRDRULULDDLDLRRDURLLRLLDDURRLRRULLURLRUDDLUURULULURLRUDLLLUDDURRLURLLRLLRRLDULRRUDURLLDDRLDLRRLULUULRRUURRRDULRLRLRDDRDULULUUDULLLLURULURRUDRLL\n" +
    "UULLULRUULUUUUDDRULLRLDDLRLDDLULURDDLULURDRULUURDLLUDDLDRLUDLLRUURRUDRLDRDDRRLLRULDLLRUUULLLDLDDULDRLRURLDRDUURLURDRUURUULURLRLRRURLDDDLLDDLDDDULRUDLURULLDDRLDLUDURLLLLLRULRRLLUDRUURLLURRLLRDRLLLRRDDDRRRDLRDRDUDDRLLRRDRLRLDDDLURUUUUULDULDRRRRLUDRLRDRUDUDDRULDULULDRUUDUULLUDULRLRRURDLDDUDDRDULLUURLDRDLDDUURULRDLUDDLDURUDRRRDUDRRDRLRLULDRDRLRLRRUDLLLDDDRURDRLRUDRRDDLDRRLRRDLUURLRDRRUDRRDLDDDLRDDLRDUUURRRUULLDDDLLRLDRRLLDDRLRRRLUDLRURULLDULLLUDLDLRLLDDRDRUDLRRDDLUU"
    
    // let instructions = "ULL\n" +
    //                   "RRDDD\n" +
    //                   "LURDL\n" +
    //                   "UUUUD"
                   
                   
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
                let oldY = position.y
                position.y -= 1
                
                // range check
                if position.x > 4 ||
                   position.x < 0 ||
                   position.y > 4 ||
                   position.y < 0 {
                    // out of bounds, use old value
                    position.y = oldY
                }
                
                let key = pinpad[position.x][position.y]
                
                if key as? Int == 0 {
                    position.y = oldY
                }
            
            case .down:
                let oldY = position.y
                position.y += 1
                
                // range check
                if position.x > 4 ||
                   position.x < 0 ||
                   position.y > 4 ||
                   position.y < 0 {
                    // out of bounds, use old value
                    position.y = oldY
                }
                
                let key = pinpad[position.x][position.y]
                
                if key as? Int == 0 {
                    position.y = oldY
                }
            
            case .left:
                let oldX = position.x
                position.x -= 1
                
                // range check
                if position.x > 4 ||
                   position.x < 0 ||
                   position.y > 4 ||
                   position.y < 0 {
                    // out of bounds, use old value
                    position.x = oldX
                }
                
                let key = pinpad[position.x][position.y]
                
                if key as? Int == 0 {
                    position.x = oldX
                }
                
            case .right:
                let oldX = position.x
                position.x += 1
                
                // range check
                if position.x > 4 ||
                   position.x < 0 ||
                   position.y > 4 ||
                   position.y < 0 {
                    // out of bounds, use old value
                    position.x = oldX
                }
                
                let key = pinpad[position.x][position.y]
                
                if key as? Int == 0 {
                    position.x = oldX
                }
        }
    }
    
    func printKeyAtCurrentPosition() {
        print(pinpad[position.y][position.x], terminator: "")
    }
}


var b = Bathroom()
b.runInput()
