//
//  DiffableDataSource.swift
//  CommonUI
//
//  Created by Luthfi Asmara on 13/11/25.
//

import UIKit

public typealias DiffableDataSource<SectionIdentifier: Hashable, ItemIdentifier: Hashable> =
  UICollectionViewDiffableDataSource<SectionIdentifier, ItemIdentifier>

public typealias DiffableSnapshot<SectionIdentifier: Hashable, ItemIdentifier: Hashable> =
  NSDiffableDataSourceSnapshot<SectionIdentifier, ItemIdentifier>

public extension UICollectionViewDiffableDataSource {
  func applyItems(_ items: [ItemIdentifierType], toSection section: SectionIdentifierType, animatingDifferences: Bool = true) {
    var snapshot = self.snapshot()
    guard !items.isEmpty else { return }

    if !snapshot.sectionIdentifiers.contains(section) {
      snapshot.appendSections([section])
    }
    snapshot.appendItems(items, toSection: section)
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  func applyItem(_ item: ItemIdentifierType, toSection section: SectionIdentifierType, animatingDifferences: Bool = true) {
    var snapshot = self.snapshot()
    if !snapshot.sectionIdentifiers.contains(section) {
      snapshot.appendSections([section])
    }
    snapshot.appendItems([item], toSection: section)
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  func applySections(_ sections: [SectionIdentifierType], animatingDifferences: Bool = true) {
    var snapshot = self.snapshot()
    snapshot.appendSections(sections)
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }
}
