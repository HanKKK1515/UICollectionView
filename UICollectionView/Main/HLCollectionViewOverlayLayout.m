//
//  HLCollectionViewOverlayLayout.m
//  collectionView
//
//  Created by 韩露露 on 16/7/18.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "HLCollectionViewOverlayLayout.h"

@implementation HLCollectionViewOverlayLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat itemW = 100;
    CGFloat itemY = itemW;
    attrs.size = CGSizeMake(itemW, itemY);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    if (indexPath.item >= 5) attrs.hidden = YES;
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attrs.transform = CGAffineTransformMakeRotation(i * arc4random_uniform(111));
        attrs.zIndex = [self.collectionView numberOfItemsInSection:0] - i;
        [array addObject:attrs];
    }
    return array;
}

@end
