import Foundation

func main(_ input: String) {
    
    let blocks = input.components(separatedBy: "\n\n").map { block in
        return block.components(separatedBy: "\n").map { line in
            return Array(line.map { String($0) })
        }
    }
    
    let result = blocks.reduce(0) { result, grid in
        result + summary(grid: grid)
    }
    print(result)
    
}

func summary(grid: [[String]]) -> Int {
    let row = grid.count - 1
    let col = grid[0].count - 1
   
    var horiz = -1
    for i in 0..<row where isReflection(grid: grid, with: i) {
        horiz = i
        break
    }
   
    var vert = -1
    let tGrid = transpose(grid: grid)
    for i in 0..<col where isReflection(grid: tGrid, with: i) {
        vert = i
        break
    }
    
    assert(vert == -1 || horiz == -1)
    return vert + 1 + 100 * (horiz + 1)
}



func isReflection(grid: [[String]], with number: Int) -> Bool {
    for i in 0..<grid[0].count {
        for j in 0..<grid.count where (0..<grid.count).contains(number * 2 + 1 - j) {
            if grid[j][i] != grid[number * 2 + 1 - j][i] {
                return false
            }
        }
    }
    return true
}

func transpose(grid: [[String]]) -> [[String]] {
    return (0..<grid[0].count).map { i in
        return (0..<grid.count).map { j in
            return grid[j][i]
        }
    }
}



let test = """
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.
"""


let data = """
.##.#....####..
###....###...##
.....###..#####
.....###..#####
###....###...##
.##.#....####..
#.#..#.#...#.##
##..#.##.#.##..
.#.#.#.#..#.###
.#.###.#..#..##
.#..#.....#.###
..###.###..##..
...#.#..#..####
#.####.##..#.##
..##.##.###.###
#.#.##.#..#.###
#..###...###.#.

....##..##...
..#..####..#.
.############
.############
..#..####..#.
....##..##...
###......#.##

.##..#..#.###
.##.#...#..##
..#.######.#.
.......#.....
.......#.....
..#.######.#.
.##.#...#..##
.##..#..#.###
####.#####.#.
####.#####.#.
.##.....#.###

#..##.##.
#...###..
##..###.#
##.##..##
##.##..##
##..###.#
#...###..
#..##.##.
##.##.###
..##.....
..#...###
..##..#..
..#...#..
..#...###
..##.....

..##.##.##...
##.#......###
..########...
#####..######
..#......#...
.####..####..
#....##....##
....#..#.....
#...####...##
##.#....#.###
#...#..#...##
#####..######
##..#..#..###
.#...##...#..
..#.#..#.#...

.####..
.####..
##..###
..##...
.####..
##..###
#.##.#.
.####..
#####.#

#.#..##..#.#..###
#.##.##.##.#.####
#.#......#.#.#...
#..........#.####
.##########..#.##
#..######..####..
##...###..##.####
#..........######
#.########.#..#..
.#..#..#..#.###..
.##..##..##..#...
#.########.#..#..
...#....#...#..##

#......
.#.#.#.
.##..##
.##...#
.#.#.#.
#......
#.###..
#.###..
#......
.#.#.#.
.##...#

.##.##.
#.##..#
....##.
#..####
##.#..#
####..#
.#.....
##.#...
..#.##.
###.##.
###.##.

....#.##.
#.#....#.
#.#....#.
....#.###
.#....###
.####.##.
...##....
##.######
.##.#....
#..#.##.#
.####.###
#...####.
#...####.

..##...###..#..#.
..##...###..#..#.
####.#.#.#..#.#.#
..###.#....#.####
##.###.#####...##
...#.#...##..#...
...#..###....#..#
###.....#......#.
#.###...#####.##.
..###.#.##..#..#.
..#####.#.#......
###....#.#.#..##.
..#.####.##.#....

.###..#.#
.###..#.#
..##.##.#
#.#####.#
#.#.#####
.###.....
##.#.##.#
.#.###.#.
#.####.##
#.####.##
.#.###.#.
##.#.##.#
.###.#...

########.
...#.#.##
#..#####.
#..#.....
..##.#...
..##...#.
..##...#.
..##.#...
#.##.....
#..#####.
...#.#.##
########.
##.##.###
....#####
..#.....#
..#.....#
....#####

....##....#
.##.#.####.
#..#.######
#..###.##.#
....#.#..#.
#.#########
....##....#
#..##......
#####..##..
#..#..####.
.##...#..#.

........#......
.........#.####
##....##....#..
.##..##...##..#
.##..##.##...#.
########.####.#
########.####.#
.##..##.##...#.
.##..##...##..#
##....##....#..
.........#.####
........#......
.#...##.#.#...#
#.#..#.#....##.
###..####.####.
#......#...##.#
##########...##

##.#.#..#####
##.###.#.#...
.....##..#...
####.######..
.##..###.#.##
#.####.####..
.#...#..#.#..
.###.##..#.##
##.##...#####
#..####.#####
...##.....###
#.#...###..##
#.#...###..##
...##...#.###
#..####.#####

....#..##.#..####
#.##.######.###.#
#####.#.#.#.#....
#####.#.#.#.#....
#.##.######.###.#
....#..####..####
..##.#####.....##
#.#.#....###.#..#
..#...#.##.####..
.##...###.#.###..
.##...###.#.###..

.###.#..#.###..
#.#.#.##.#.#.##
..#.######.#...
..#...##...#...
#.##.####..#.##
##.########.###
..#..####..#...
#.##......##.##
##.#..##..#.###

##.#........#.###
###..##..##..####
#..#..#.....#..##
...#.##..##.#....
#..#..#..#..#..##
...###.##.###....
#.#####..#####.##
....########.....
..#.#..##..#.#...
.#.###.##.###.#..
..##..####..##...
#.#..#....#..#.##
.#..##.##.##..#..
####..####..#####
##.#.##..##.#.###

#.#.##.#.###..#
##......###.##.
....##...##....
####..######..#
.##....##.#####
#........#.....
##......####..#

..###.#..####
..###.###..##
..###.###.###
..#.#..#....#
..#.#..##...#
..###.###.###
..###.###..##
..###.#..####
###..#...#.##
###....#.#.#.
...#.###..##.
######.###..#
##......#..#.

.#######.##.#####
.#...#........#..
##...###....###..
##...###....###..
.#...#........#..
.#######.##.#####
#.####..####.####
#.##..########..#
.#.#...#....#...#
..###..#....#..##
...#.#..#..#..#.#

##.#...##...#
...#.#....#.#
###.#.####.#.
..###.####.##
##.#.#....#.#
##..#..##..#.
......####...
##.#.#....#.#
..#.##....##.
......#..#...
...##.####.##
..#....##....
##...######.#

............#.#
##.#....#.###..
.##.#..#.##...#
###########..##
....####....##.
#..##..##..##..
####....####.#.
...#.##.#......
#..#....#..###.
.#........#.###
.#.#....#.#...#
.##......##.###
....####....#..
##.#....#.##.##
#..######..###.
#...#..#...###.
#...#..#...###.

.#..#.#.#
.#..#.#.#
....##..#
#.#######
##..#..#.
.#.#.#..#
...#....#
.###..#.#
...#..###
.#.##.##.
#####...#
#####...#
.#.##.##.
...#..###
.####.#.#
...#....#
.#.#.#..#

##.#.#.
###..##
##.#.##
.###...
.###...
##.#.##
###..##
##.#.#.
...###.
.#.###.
##.#.#.
###..##
##.#.##

.####..##
.#.##..##
##.######
.....##..
###..##..
....#..#.
##.######
....####.
.#.#....#

#.#..#.#.##..##
........#.#####
...##....#..##.
.#.##.####.###.
########.#.#.##
##.##.##..##..#
..#..#..##..#.#
..#..#..##..#.#
##.##.##..##..#

..#...#.#######
#.##....#..##..
..###..########
#....#.##..##..
#....####..##..
..###..########
#.##....#..##..
..#...#.#######
..####.###....#
#####.###.####.
.##..####......
...##...##.##.#
#...###..######

#..#...#..#
#......#..#
.##......#.
####..#.###
..##..##...
#.##.#.#..#
#...##.###.
##.#...##..
##..###...#
##..###...#
##.#...##..
#...##.###.
#.##.#.#..#

.########....##..
###.##.###.##..##
..#.##.#..##.##.#
.##....##..######
##.#.##.##..####.
##.#..#.##.#....#
..######.........

.##..##.#.#..#.
#......########
#########......
#########.####.
###..###.#.##.#
##.######.####.
##.##.##.......
.######..#....#
..####...##..##
########..#..#.
..#..#..##.##.#
#.#..#.###....#
...##....#....#
...##....#.##.#
#......##..##..
#########.#..#.
...........##..

#....#..#.#.##.
...##.#...#####
...##.#....####
#....#..#.#.##.
..###.###...##.
#..##..##.##..#
##...#......##.
.####.#..#.....
.##.##.#....##.
.#..#..#.##.##.
##.##.###......
#..#.....##....
#.#..#..#..####
.###.#.#...####
...#....#######
..#.#.#...#.##.
...#........##.

.......##.......#
#..###....###..#.
####.######.#####
....###..###.....
.##..#....#..##..
.##..#....#..##..
#####.####.######
.##.###..###.##.#
.##.#..##..#.##..
#..#........#..##
####.##..##.#####
###.##.##.##.###.
....###..###.....

.....#........#
.....#........#
..###...#.#.#..
##.#.##....#..#
###..#.#.####.#
.###....#..#..#
...#.#.#.#..##.
...#.#.#.#..##.
.###....#.....#

#####.#
.....##
#####..
#####..
#..####
####.##
....#..
....#..
####.##
#..####
######.

##.##.#######
.###.#...##..
###.##...##..
..#.#....##..
#..###.######
.#.#.#.#....#
...#...##..##
..##.##......
..##.####..##
.##.##.##..##
.#####.######

....##...
..#....#.
....##...
####..###
####..###
##.#..#.#
..#....#.
###.....#
..#....#.
..##..##.
...####..

#########....
##.##.####...
.#....#..#...
#.#..#.##.#..
.##..##..#...
.########....
#.####.#.....
#..##..#.##..
########.....
.######.#####
.######...#..
..####..##...
#.####.#.####
#.####.#.....
...##......##

...##.##.....#.
..###.##.....#.
....##.#..###.#
..####.#.###.#.
##...##..###.#.
##.####...##..#
###.##.####.#.#
...#....#.#....
##.#####..##.##
....##.#.###...
##.#.####.#.###
......##..##.##
####.#..####..#

.##..#.##
#..##.##.
#..##.###
.##..#.##
####..##.
....#.###
.##...#..

...#..##..#..#..#
.#.#..##..#..#..#
#......#.#.##.#.#
#...####.#.##.#.#
...###.###....###
...#.#...######..
#..####..........
..##..##.#.##.#.#
##.#.#..#..##..#.

####.#..#.####.
.##..####..##..
##.##.##.##.###
..###.#..###...
##.#..##..#.##.
##..######..##.
...###..###...#
...###..###...#
##..######..##.
##.#..##..#.##.
..###.#..###...

..##..##..#.##..#
.####.###########
.#..#.##........#
.####.##..#..#..#
##..##.#.#.##.#.#
#....#..###..###.
......#..........

#.#..##.###..##
####.#.#..#..#.
..##.#..###..##
.#..##..##.##.#
.#..#...#######
##.#.#####.##.#
#.#.......#..#.
#.#...#........
#...#...#######
#.#...#.#.#..#.
.#...#..#.#..#.
##.#..##..#..#.
####..##..#..#.

####..#...###..#.
.##.#.#.##.######
..#.##...######.#
##.##..##.#####.#
#.##....#........
#.##....#........
##.##...#.#####.#
..#.##...###...##
..#.##...###...##
##.##...#.#####.#
#.##....#........
#.##....#........
##.##..##.#####.#

####..###.######.
#....##.####..###
#....##.####..###
####..###.######.
#..#.####.#.##.#.
#####....#..##..#
.#.#...#...#.##..
...##.#.#..#..#..
#.#.#..#.#......#
#.####.##........
#.###...#..#..#..
.#####.#.########
....#..#...####..
.#..#.#.##.####.#
..##..#.#.#....#.
.##.#..###.####.#
.#....#..########

#..##...#..#....#
####.#.#....#..#.
.#.....###.######
..####.##.##.##.#
..####.##.##.##.#
.#.....##########
####.#.#....#..#.
#..##...#..#....#
#...######.######
##..#.#...##....#
#....###.####..##
#...##..###.####.
.###..#....#.##.#

..##.#..#.##...
..#.#....#.#...
..#.#....#.#...
..##.#..#.##...
.####.##.####.#
#.#.######.#.##
#.#.#.##.#.#.##
..###.##.###.##
#..##.##.##..##
##.##.##.##.##.
##..##..##..##.

#.###.##.#.#.##.#
#..####....######
##...##..###....#
####..#.###.#..#.
##.##...#.#..#...
...#...##.#..##..
###.#.#.#.#..##..
..#..##.##.#.##.#
.##.####.#.......
.##.####.#.......
..#..##.##.#.##.#
###.#.#.#.#..##..
...#...##.#..##..

....##...
....##...
####.#..#
.##.#.#..
..#.###.#
.##.#.###
#####.###
.##.###..
#####.##.

.#.#......#######
###.###....#.####
#...#.#.##...####
.###.#..##...####
#####....####....
#.##..##.#...####
#.#.###.#.....##.
.##.###.#..#.....
###..#..##.#.####
..#.#.#..#.#.....
.###....#........
####.#..##..#....
#.##....#..#.####
.###.###.#..#####
.##..#.#..#######

...#.####
....###.#
#.#.#...#
#.#.#...#
....#.#.#
...#.####
##.#..#.#
##..#....
.#....###
##...#.##
##...#.##
.#....###
##..#....
##.#..#.#
...#.####
....#.#.#
#.#.#...#

##..##..#######
..######.......
....##....####.
....##....####.
#..#..#..######
#.#....#.##..##
###....########
###....###....#
.#......#..##..
...####...#..#.
#.#....#.######
#.#####..##..##
..#....#..#..#.
####..#########
...#..#...#..#.

####...####
####...####
##...#....#
.####..####
...##..#...
.##.#.#..#.
##..#..#..#
#.#..##.#.#
.#..##..#.#
##.#####...
####.####..
####.####..
##.#####...
.#..##..#.#
..#..##.#.#

#.#.#.#.###
#...#.#.###
.######.#.#
####......#
..#.##.###.
.##...###..
.##...###..
..#.##.###.
####......#
.######.#.#
#...#.#.###

##..#.#
...#.##
...#.##
.#..#.#
####..#
.#####.
.#####.

#.##.#.##....
#######..####
....#.#.##..#
..##..##..##.
......###....
.#..#.###....
#######.##..#
########.....
.#..#.##.####
#.##.#...####
#....#.#.#..#
##..##...####
##..##.######

#..##.#..##
##.##.#.###
####....#..
####....#..
##.##.#.###
#..##.#..##
#...#....#.
...##.####.
##..##...##
.#...#.#...
.###.#.##.#
#..###..##.
#..###...#.
.###.#.##.#
.#...#.#...

..#.####.#..##.
.....##.....###
..#.#..#.#...#.
##.#....#.####.
.#........#.#.#
...##..##...##.
###.####.###..#
###......######
####.##.####.##

...##....####....
########..##..###
########......###
#......#..##..#..
#.#..#.#..##..#.#
#.#..#.########.#
...##...######...
.#....#.######.#.
#..##..##.##.###.
#########....####
##....###....###.

..#.##..######..#
..#.##..######..#
##.##..#..##..#..
#...#.#..####..#.
.....#..######..#
.#.##.####..####.
#...#.#.#....###.
##...#####..#####
..#..#.#..##..#.#

.......####
##..##.#.#.
##..###.#..
#.##.##..##
#....##..##
.####.##...
#######....
##..###....
.#..#.##...
.#..#.#..##
......###..
..##....#..
##..####.##

.##....#.
####....#
.##..##..
...##..##
...##..##
.##..##..
####....#

#.#.#.#.###
...##.....#
.######.##.
......#.##.
.#####.#...
.#...##...#
.#...##...#
.#####.#...
.#....#.##.
.######.##.
...##.....#
#.#.#.#.###
##.#.##.#.#
.#.##..#.#.
.#....###..
.#....###..
.#.##..#.#.

#....#.####..
#.####.###..#
.#..#.#..#.#.
#.#..#....##.
#######..####
.#.#####.###.
.#.#####.###.
#######..####
#.#..#....##.
.#..#.#..#.#.
#.########..#
#....#.####..
#....#.####..

.#...###.##.#
.......######
.##.##..#..##
....#.#...#..
.##.###..#.##
.##.####..#.#
####.###.#..#
#..#.#....###
....##.....#.
....##.....#.
#..#.#....###

.##.##..#......
.#.#.....##.###
.#.#.....##.###
.##.##..#......
...#..##..#.#.#
#####.#....#.##
#####.###.#.###
..#.#.#.#..##..
..#.#.###..#...

#.#...##.##..
####.##.#####
#...#....#.##
##..####.##..
##.#.#..#....
.##..##.#..##
.#..#.##.####
.#..#.....#..
#######.#####
##.##..#.....
##.##........
#######.#####
.#..#.....#..
.#..#.##.####
.##..##.#..##
##.#.#..#....
##..####.##..

..#.###..###.#..#
..#.###..###.#..#
......#..#.......
.#..##....##..#..
.#.#...##...#.#.#
..#.#......#.#...
##............##.
#.##........##.##
..###.#..#.###...
.#....#..#....#..
#...#.#..#.#...##
######.##.######.
.#.##########.#.#
##.#.#.##.#.#.##.
.#.#.##..##.#.#..
#.############.##
#####......###.#.

#..#...
..#####
.#....#
.#..###
#...###
.#.####
.#.#...
...####
.#.##..
..###..
...##..
...##..
..###..
.#.##..
...####

#.#######....#.#.
#..#.##.##......#
...#.##.##......#
#.#######....#.#.
#.#######....#.#.
...#.##.##......#
#..#.##.##......#
#.#######....#.#.
##.#.#######....#
###.###...##.#...
#..#....#####....
..#.#..##.......#
###.######.#.#.#.
.#.#####.........
...##.#..######..
.###.#.##..#####.
#...#.#..#.###.##

#...#.#
####...
####...
#...#.#
.....##
..##.##
.##...#
..##...
#.##.##
..###..
..###..
#.##.##
..##...
..#...#
..##.##

.#..#..##.#...##.
.#..#..##.#...##.
#.#.#####..####.#
....#.##....#.##.
.##.##.#.####....
###..###.....####
#.##.#..##.......

.#.#.###.#.##
#.###..#.#.##
#####.#.###..
#####.#.###..
#.###..#.#.##
.#.#.###.#.##
#....##..#...
#...####..###
##.#.###..#.#
##..#...#.###
##..#...#.###
##.#.###..#.#
#...####..###
#....##..#...
.#.#.###.####

.##.##.
#..#.#.
######.
#..#...
#..#..#
#..#..#
#..##..
######.
#..#.#.

.##.#.##.#..#.##.
.##.#.##.#..#.##.
###.#.##.#.##....
#.#.##.....#.####
##..#.##.#######.
....#.##.#.###..#
..#......#.##....
.#......###.#.##.
#..#.###.#...#..#

...##...#..##
#.####.###...
...##.....#..
.#.##.#..##..
##....###....
........#..##
#......####..
#..##..#.....
###..###..###
.######..#...
#.####.....##

##....##..##..##.
...#####.#..#.###
####.##.######.##
..##...#..##..#..
##.#...########..
..##....##..##...
..#.#############
..####....##....#
###....##....##.#
..##.###.#..#.###
##...#.#......#.#
##..##.###..###.#
...#.#...####...#
...#...##.##.##..
###..##.##..##.##
..#.#..##....##..
..###.###....###.

........#.###
..##...#####.
.####.#.##..#
.####.#..#.#.
##..####..#.#
##..##..#...#
##..##..#...#
##..####..#.#
.####.#..#.#.
.####.#.##..#
..##...#####.
........#.###
######.#.#..#
##..####..###
#....#..#....
#.##.#.#....#
##.####.###.#

#.#..#.#.#.#.####
###..#####....##.
#..##..##..###..#
#.######.###.#..#
########..#..####
.#.##.#.##...####
#.####.#.#..##..#
##....##..#..#..#
..####...##..#..#
#.####.#.#.......
...##...###..#..#
.#....#.###..#..#
..#..#..#.#..####

...#...###.#.#...
.......#....#..##
.##.....##.####..
.#..######.#.##..
.#####.....###...
.#...###..###..##
###.#..#....##...
.#.####.#.#..#.##
#.####..##.#.####
#.#.##..##.#.####
.#.####.#.#..#.##

.##.#....#..#..#.
#....####....#...
#.#...##...#.####
.#...####...#.###
#.##.####.##.#.##
.#.##.##.##.#.#.#
#..###..###..##.#
#..###..###..##.#
.#.##.##.##.#.#.#
#.##.####.##.#.##
.#...####...#.###

.#..#.##...
.##..###...
####..##.##
.......#.##
.##.#.#....
....####...
.##.#...#..
####.#.##..
.##..##..##

.#.####..
#..######
##.##....
.##.##...
.##.##...
##.##....
#..######
.#.####..
#..#..###
.#...####
##.......
##....#..
#..#...##
.###..###
#...#...#
.#..#....
#.###....

.##.###.###.###
.#####.##.#..##
.#####.##.#..##
.##.###.#######
.#.##....##.###
##.###..#...###
.#...#.#####.##
##.###...######
.#.#.##....##..
##.#.#.##..#...
###.##..##.#...
#####....###...
#....#......###

.###...#.###.
#...#.#.....#
#...#.#.....#
.###...#.###.
.#..#....#..#
#..###.##.#..
#.##..#..#...
#.######...#.
#.######...#.
#.##..#..#...
##.###.##.#..
.#..#....#..#
.###...#.###.

......####.#...#.
......##.##..#.#.
.#..#..#.####...#
.#..#..##.##.####
#.##.###..##..###
#######.##..###..
#.##.#....##..#..
..##...###.######
......##..##...##
......#.#...#.###
......#.#...#.###
......##..##.#.##
..##...###.######

#..#..#..
.....####
.##.#...#
.##.#...#
.....####
#..#..#..
##.##.#..
#..#..#..
......#.#
.##...#..
####...#.
#####.#.#
#..#..#..
.##..#...
#####....
#..#.####
.......#.

.....#.#.
###...#..
..#..#.##
..###.##.
##.##....
##.##....
..###.##.
..#..#.##
###...#..
....##.#.
...######

...##.##.#..####.
...##.##.#..####.
#.####..#..#.....
#..........#....#
..#.##...#..#..#.
.#...##..#.#.##.#
.#.#..##...##..##
#...#...#########
.#.##.#..###....#

..#.##.
....###
.....##
##...##
...#...
##..##.
###....
...##.#
##..#..
..##..#
..##..#
##..#.#
...##.#

#..#..#......#..#
#..#..#......#..#
###.######.#..#.#
.#.####.#.#####..
##..####..###.#..
.##...###.#.#.##.
...#....#.#.#####
##.#..####..#....
##.#..###..#..##.
##.#..###..#..##.
##.#..####..#....
...#....#.#.#####
.##...###.#.#.##.
##...###..###.#..
.#.####.#.#####..
###.######.#..#.#
#..#..#......#..#

..#...#.#.##.
.###.#....##.
.##.#..######
#.##.##.#....
#######..####
#.#.##..#....
##.#..#.##..#
..#....######
......#######
......#######
..#....######
#..#..#.##..#
#.#.##..#....
#######..####
#.##.##.#....
.##.#..######
.###.#....##.

##..#..#..#
...#...##..
###..##..##
..#..##..#.
###.####.##
###..##..##
##.#.##.#.#
##.######.#
..########.

##..###
####.##
.#.#...
.....##
..#.###
..#.###
###....
##.....
##...##
..#....
##.#...
###.#..
..#.###

..##....#
...####.#
...##..##
#####..##
...######
####....#
.....##..
...#.##.#
##.#....#

####...#.#.......
#.#.####.####...#
..#.##.#...##....
..#.##.#...##....
#.#.####.####...#
####...#.#.......
#..#.#..#.#.#.##.
.#....#....#..###
..#.##.#...#.#.#.
..#.##.#...#.#.#.
.##...#....#..###
#..#.#..#.#.#.##.
####...#.#.......

#.######.
#.#....##
.#..#.###
.#..#.###
#.#....##
#.######.
......#.#
.#....#.#
#.######.
#.#....##
.#..#.###

.##...#..#...##..
##..#.####.#..###
#......#.......##
##..#..##..#..###
..###..##..###...
#..#..####..#..##
#.##.#....#.##.##
#.##.#....#.##.##
.###.#....#.###..
"""

main(data)

