//
//  FlowLayout.swift
//  Home
//
//  Created by Luthfi Asmara on 15/11/25.
//

import SwiftUI

public struct FlowLayout<Data: Identifiable, Content: View>: View {
  public let data: [Data]
  public let columns: Int
  public let spacing: CGFloat
  public let content: (Data) -> Content
  
  public init(
    _ data: [Data],
    columns: Int,
    spacing: CGFloat = 8,
    @ViewBuilder content: @escaping (Data) -> Content
  ) {
    self.data = data
    self.columns = columns
    self.spacing = spacing
    self.content = content
  }
  
  private func distributeItems() -> [[Data]] {
    var grid = Array(repeating: [Data](), count: columns)
    var columnHeights = Array(repeating: CGFloat.zero, count: columns)
    
    for item in data {
      let shortestIndex = columnHeights.firstIndex(of: columnHeights.min() ?? 0) ?? 0
      grid[shortestIndex].append(item)
      columnHeights[shortestIndex] += 1
    }
    
    return grid
  }
  
  public var body: some View {
    HStack(alignment: .top, spacing: spacing) {
      let columnsData = distributeItems()
      
      ForEach(0..<columns, id: \.self) { columnIndex in
        LazyVStack(spacing: spacing) {
          ForEach(columnsData[columnIndex]) { item in
            content(item)
          }
        }
      }
    }
    .padding(.horizontal)
  }
}
