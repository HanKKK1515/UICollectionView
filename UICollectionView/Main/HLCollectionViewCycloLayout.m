//
//  HLCollectionViewCycloLayout.m
//  collectionView
//
//  Created by 韩露露 on 16/7/18.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "HLCollectionViewCycloLayout.h"

@implementation HLCollectionViewCycloLayout

/**
 *  当布局改变时刷新
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat itemW = 70;
    CGFloat itemY = itemW;
    attrs.size = CGSizeMake(itemW, itemY);
    
    CGFloat angle = M_PI * 2 / [self.collectionView numberOfItemsInSection:0]; // 计算图片的中点位于圆上的角度
    CGFloat distance = 80; // 圆的半径
    CGPoint center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5); // 圆的中心
    attrs.center = CGPointMake(center.x + distance * cosf(angle * indexPath.item), center.y + distance * sinf(angle * indexPath.item));
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count =  [self.collectionView numberOfItemsInSection:0]; // 获取item的总个数
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attrs.zIndex = [self.collectionView numberOfItemsInSection:0] - i;
        [array addObject:attrs];
    }
    return array;
}

@end
