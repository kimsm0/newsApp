/**
 @class Array+Ex.swift
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */

import Foundation


public extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

