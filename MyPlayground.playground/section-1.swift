// Playground - noun: a place where people can play

import Cocoa

let n:UInt32 = 6
let sap = 1, tree = 2, elder = 3, bear = 4, lumberjack = 5, month = 200
var cutWood = 0, year = 0, maw = 0

//searches for a random empty spot
func emptySpot(map:Array<Array<Int>>) -> (y: Int, x: Int) {
    var forest = map
    var x = 0, y = 0
    var bool = true
    while bool {
        var r = Int(arc4random_uniform(n))
        var q = Int(arc4random_uniform(n) )
        if forest[r][q] == 0 {
            x = q
            y = r
            bool = false
        }
    }
    return (y, x)
}

func removeFromArray(array:Array<Array<Int>>, yPos: Int, xPos: Int) ->( arrayS: Array<Array<Int>>, boolR: Bool) {
    var arrayS = array, y = yPos, x = xPos, boolR = false
    for var counter = 0; counter < arrayS.count; counter++ {
        if arrayS[counter][1] == y && arrayS[counter][2] == x {
            arrayS.removeAtIndex(counter)
            boolR = true
        }
    }
    return (arrayS, boolR)
}

//function that checks for empty space around single point
func freeSpace(map:Array<Array<Int>>, yPos: Int, xPos: Int, searchV: Int) -> (yPos: Int, xPos: Int, boolTest: Bool) {
    var x = xPos, y = yPos, s = searchV
    var bool = false, loop = true
    var randomValue: UInt32 = 8
    var test = 0
    var checkedArray = Array<Int>()
    for test; test < 8; test++ {
        checkedArray.append(0)
    }
    test = 0
    /*
    x-1,y-1 x,y-1, x+1,y-1
    x-1,y   x,y    x+1,y
    x-1,y+1 x,y+1, x+1,y+1
    */
    while loop{
        if test != 8 {
    var r = Int(arc4random_uniform(8) + 1)
    switch r {
    case 1:
        if checkedArray[r-1] == 0 {
        if (x-1 >= 0 && y-1 >= 0) {
            if (map[y-1][x-1] == s) {
                y--; x--; bool=true;loop=false;
            }
        }
        test++
        checkedArray[r-1] = 1
        }
    case 2:
        if checkedArray[r-1] == 0 {
        if (x >= 0 && y-1 >= 0) {
            if (map[y-1][x] == s) {
                y--; bool=true;loop=false;
            }
        }
        test++
            checkedArray[r-1] = 1
        }
    case 3:
        if checkedArray[r-1] == 0 {
        if (x+1 <= Int(n-1) && y-1 >= 0) {
            if (map[y-1][x+1] == s) {
                y--; x++; bool=true;loop=false;
            }
        }
        test++
        checkedArray[r-1] = 1
            }
    case 4:
        if checkedArray[r-1] == 0 {
        if (x-1 >= 0 && y >= 0) {
            if (map[y][x-1] == s) {
                x--; bool=true;loop=false;
            }
        }
        test++
            checkedArray[r-1] = 1
        }
    case 5:
        if checkedArray[r-1] == 0 {
        if (x+1 <= Int(n-1) && y >= 0) {
            if (map[y][x+1] == s) {
                x++; bool=true;loop=false;
            }
        }
        test++
        checkedArray[r-1] = 1
    }
    case 6:
        if checkedArray[r-1] == 0 {
        if (x-1 >= 0 && y+1 <= Int(n-1)) {
            if (map[y+1][x-1] == s) {
                y++; x--; bool=true;loop=false;
            }
        }
        test++
            checkedArray[r-1] = 1
        }
    case 7:
        if checkedArray[r-1] == 0 {
        if (x >= 0 && y+1 <= Int(n-1)) {
            if (map[y+1][x] == s) {
                y++; bool=true;loop=false;
            }
        }
            test++
            checkedArray[r-1] = 1
        }
    case 8:
        if checkedArray[r-1] == 0 {
        if (x+1 <= Int(n-1) && y+1 <= Int(n-1)) {
            if (map[y+1][x+1] == 0) {
                y++; x++; bool=true;loop=false;
            }
        }
        test++
            checkedArray[r-1] = 1
        }
    default:
        loop = false
            }
        }
        
        else {
            loop = false; bool = false
        }
    }
    return (y, x, bool)
}

//initialize map
var xMap = Int(n)
var yMap = Int(n)
var map = Array<Array<Int>>()
var sapp = Array<Array<Int>>()
var treeArray = Array<Array<Int>>()
var elderArray = Array<Array<Int>>()
var bearArray = Array<Array<Int>>()
var lumberArray = Array<Array<Int>>()
for column in 0..yMap {
    map.append(Array(count:xMap, repeatedValue:Int()))
    
}

//populate
//tree take up half of n^2.
var treeMax = (n*n)/2
while treeMax > 0 {
    treeMax--
    let count = emptySpot(map)
    var r = Int(arc4random_uniform(3) + 1)
    map[count.y][count.x] = r
    if r == 1 {
        var indivSapp = Int[]()
        indivSapp.append(0)
        indivSapp.append(count.y)
        indivSapp.append(count.x)
        sapp.append(indivSapp)
    }
    if r == 2 {
        var indivTree = Int[]()
        indivTree.append(0)
        indivTree.append(count.y)
        indivTree.append(count.x)
        treeArray.append(indivTree)
    }
    if r == 3 {
        var indivTree = Int[]()
        indivTree.append(0)
        indivTree.append(count.y)
        indivTree.append(count.x)
        elderArray.append(indivTree)
    }
}

//bear take up 2% of n^2.
var bearMax = Int(n*n/100*2)
while bearMax > 0 {
    bearMax--
    let count = emptySpot(map)
    map[count.y][count.x] = 4
    var indivTree = Int[]()
    indivTree.append(0)
    indivTree.append(count.y)
    indivTree.append(count.x)
    bearArray.append(indivTree)
}
//lumber take up 10% of n^2.
var lumberMax = Int(n*n/10)
while lumberMax > 0 {
    lumberMax--
    let count = emptySpot(map)
    map[count.y][count.x] = 5
    var indivTree = Int[]()
    indivTree.append(0)
    indivTree.append(count.y)
    indivTree.append(count.x)
    lumberArray.append(indivTree)
}

var currentMonth = 0
while currentMonth < month {
    currentMonth++
    year++
    //saplings
    var counter = 0
    for counter; counter < sapp.count; counter++ {
        sapp[counter][0]++
        if sapp[counter][0] == 12 {
            sapp[counter][0] = 0
            map[sapp[counter][1]][sapp[counter][2]] = 2
            treeArray.append(sapp[counter])
            sapp.removeAtIndex(counter)
        }
    }
    map
    //trees
    for counter = 0; counter < treeArray.count; counter++ {
        var r = Int(arc4random_uniform(10) + 1)
        //10% chance, doesnt matter what number to put, its 1-10
        if (r == 4) {
            let count = freeSpace(map, treeArray[counter][1], treeArray[counter][2],0)
            if count.boolTest {
                map[count.yPos][count.xPos] = 1
                var indivSapp = Int[]()
                indivSapp.append(0)
                indivSapp.append(count.yPos)
                indivSapp.append(count.xPos)
                sapp.append(indivSapp)
            }
        }

        treeArray[counter][0]++;
        if treeArray[counter][0] == 120 {
            treeArray[counter][0] = 0
            map[treeArray[counter][1]][treeArray[counter][2]] = 3
            elderArray.append(treeArray[counter])
            treeArray.removeAtIndex(counter)
        }
    }
    //ElderTree
    for counter = 0; counter < elderArray.count; counter++ {
        var r = Int(arc4random_uniform(10) + 1)
        //10% chance, doesnt matter what number to put, its 1-10
        if (r == 4 || r == 8) {
            let count = freeSpace(map, treeArray[counter][1], treeArray[counter][2],0)
            if count.boolTest {
                map[count.yPos][count.xPos] = 1
                var indivSapp = Int[]()
                indivSapp.append(0)
                indivSapp.append(count.yPos)
                indivSapp.append(count.xPos)
                sapp.append(indivSapp)
            }
        }

        
        elderArray[counter][0]++;

    }
    
    //bear
    for counter = 0; counter < bearArray.count; counter++ {
        for var c2 = 0; c2 < 5; c2++ {
             var y = bearArray[counter][1], x = bearArray[counter][2]
           var count = freeSpace(map, bearArray[counter][1], bearArray[counter][2],5)
            if count.boolTest {
                map[y][x] = 0
                bearArray[counter][1] = count.yPos
                bearArray[counter][2] = count.xPos
                map[count.yPos][count.xPos] = 4
                let lumberArrayS = removeFromArray(lumberArray, count.yPos, count.xPos)
                lumberArray = lumberArrayS.arrayS
                if(lumberArrayS.boolR) {
                    maw++
                }
                lumberArray.count
                if lumberArray.count == 0 {
                    let count = emptySpot(map)
                    map[count.y][count.x] = 5
                    var indivTree = Int[]()
                    indivTree.append(0)
                    indivTree.append(count.y)
                    indivTree.append(count.x)
                    lumberArray.append(indivTree)
                }

                break
            
            } else {
                count = freeSpace(map, bearArray[counter][1], bearArray[counter][2],0)
                if count.boolTest {
                    map[y][x] = 0
                    bearArray[counter][1] = count.yPos
                    bearArray[counter][2] = count.xPos
                    map[count.yPos][count.xPos] = 4
                }
            }
        }
        
    }
    //lumber
    for counter = 0; counter < lumberArray.count; counter++ {
        for var c2 = 0; c2 < 3; c2++ {
            var y = lumberArray[counter][1], x = lumberArray[counter][2]
            var count = freeSpace(map, lumberArray[counter][1], lumberArray[counter][2],3)
            if count.boolTest {
                map[y][x] = 0
                lumberArray[counter][1] = count.yPos
                lumberArray[counter][2] = count.xPos
                map[count.yPos][count.xPos] = 5
                let elderArrayS = removeFromArray(elderArray, count.yPos, count.xPos)
                elderArray = elderArrayS.arrayS
                if(elderArrayS.boolR) {
                    cutWood+=2
                }
                break
            }
            else if !count.boolTest {
                count = freeSpace(map, lumberArray[counter][1], lumberArray[counter][2],2)
                if count.boolTest {
                map[y][x] = 0
                lumberArray[counter][1] = count.yPos
                lumberArray[counter][2] = count.xPos
                map[count.yPos][count.xPos] = 5
                let elderArrayS = removeFromArray(treeArray, count.yPos, count.xPos)
                treeArray = elderArrayS.arrayS
                    if(elderArrayS.boolR) {
                        cutWood+=1
                    }
                    break
                }
                else {
                    count = freeSpace(map, lumberArray[counter][1], lumberArray[counter][2],0)
                    if count.boolTest {
                        map[y][x] = 0
                        lumberArray[counter][1] = count.yPos
                        lumberArray[counter][2] = count.xPos
                        map[count.yPos][count.xPos] = 5
                    }
                }
            }
        }
    }
    if year == 12 {
        year = 0
        if cutWood < lumberArray.count {
            var lumberCount:UInt32 = UInt32(lumberArray.count)
            var r = Int(arc4random_uniform(lumberCount))
            map[lumberArray[r][1]][lumberArray[r][2]] = 0
            var lumberArrayS = removeFromArray(lumberArray, lumberArray[r][1], lumberArray[r][2])
            while !lumberArrayS.boolR {
                lumberArrayS = removeFromArray(lumberArray, lumberArray[r][1], lumberArray[r][2])
            }
            lumberArray = lumberArrayS.arrayS
        }
        else if cutWood >= lumberArray.count {
            var total:Double = Double(cutWood/lumberArray.count)
            var newLumber = floor(total)
            for var counter = 0; counter < Int(newLumber); counter++ {
                let count = emptySpot(map)
                map[count.y][count.x] = 5
                var indivTree = Int[]()
                indivTree.append(0)
                indivTree.append(count.y)
                indivTree.append(count.x)
                lumberArray.append(indivTree)
            }
        }
        if maw == 0 {
            let count = emptySpot(map)
            map[count.y][count.x] = 4
            var indivTree = Int[]()
            indivTree.append(0)
            indivTree.append(count.y)
            indivTree.append(count.x)
            bearArray.append(indivTree)
        }
        if maw >= 1 {
            var lumberCount:UInt32 = UInt32(bearArray.count)
            var r = Int(arc4random_uniform(lumberCount))
            map[bearArray[r][1]][bearArray[r][2]] = 0
            var lumberArrayS = removeFromArray(bearArray, bearArray[r][1], bearArray[r][2])
            while !lumberArrayS.boolR {
                lumberArrayS = removeFromArray(bearArray, bearArray[r][1], bearArray[r][2])
            }
            bearArray = lumberArrayS.arrayS
        }
        cutWood = 0
        maw = 0
    }
    if bearArray.count == 0 {
        let count = emptySpot(map)
        map[count.y][count.x] = 4
        var indivTree = Int[]()
        indivTree.append(0)
        indivTree.append(count.y)
        indivTree.append(count.x)
        bearArray.append(indivTree)
    }
    
}
map
