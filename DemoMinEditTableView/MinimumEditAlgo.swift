//
//  MinimumEditAlgo.swift
//  DemoMinEditTableView
//
//  Created by Manas Mishra on 26/03/21.
//

import Foundation

struct IndexPathShift {
    var replaces: [IndexPath] = []
    var deletes: [IndexPath] = []
    var inserts: [IndexPath] = []
    var moves: [IndexPath] {
      return []
    }
}


func minimumEditIndexpathsForUpdate(_ a: [Int], _ b: [Int]) -> IndexPathShift {
    
    if a.isEmpty {
        return IndexPathShift(replaces: [], deletes: [], inserts: b.map({ (n) -> IndexPath in
            IndexPath(row: n, section: 0)
        }))
    }
    if b.isEmpty {
        return IndexPathShift(replaces: [], deletes: a.map({ (n) -> IndexPath in
            IndexPath(row: n, section: 0)
        }), inserts: [])
    }
 
    // initialize the matrix
    var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: b.count+1), count: a.count+1)
    for c in 1..<matrix.first!.count {
        matrix[0][c] = matrix[0][c-1] + 1
    }
    for r in 1..<matrix.count {
        matrix[r][0] = matrix[r-1][0] + 1
    }
    
    // fill the matrix
    for i in 0..<a.count {
        for j in 0..<b.count {
            if a[i] == b[j] {
                matrix[i+1][j+1] = matrix[i][j]
            } else {
                let replace = matrix[i][j]
                let delete = matrix[i][j+1]
                let insert = matrix[i+1][j]
                let minm = min(replace,delete,insert)
                matrix[i+1][j+1] = minm+1
            }
        }
    }
    
    // find the shortest edit from the matrix
    var replaces: [IndexPath] = []
    var deletes: [IndexPath] = []
    var inserts: [IndexPath] = []
    
    var row = a.count
    var column = b.count
    
    while row > 0 && column > 0 {
        let replace = matrix[row-1][column-1]
        let delete = matrix[row-1][column]
        let insert = matrix[row][column-1]
        let minm = min(replace,delete,insert)
        let curr = matrix[row][column]
        if minm == curr {
            row -= 1
            column -= 1
        } else {
            switch curr-1 {
            case replace:
                replaces.append(IndexPath(row: column-1, section: 0))
                row -= 1
                column -= 1
            case delete:
                deletes.append(IndexPath(row: row-1, section: 0))
                row -= 1
            case insert:
                inserts.append(IndexPath(row: column-1, section: 0))
                column -= 1
            default:
                fatalError("Invalid min")
            }
        }
    }
    
    return IndexPathShift(replaces: replaces, deletes: deletes, inserts: inserts)
}
