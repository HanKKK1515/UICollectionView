//
//  HLCollectionViewWaterflowLayout.m
//  UICollectionView
//
//  Created by 韩露露 on 16/7/19.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "HLCollectionViewWaterflowLayout.h"

@interface HLCollectionViewWaterflowLayout ()

@property (nonatomic, strong) NSMutableDictionary *maxColumnY; // 存储每一列的：最大y值＋行距

@end

@implementation HLCollectionViewWaterflowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    __block CGFloat maxY = 0.0; // 找出最底部的y值
    [self.maxColumnY enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if (obj.floatValue > maxY) maxY = obj.floatValue;
    }];
    return CGSizeMake(0, maxY + self.edgeInsets.bottom - self.rowMargin);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    __block NSString *minKey = @"0"; // 找出最短的那一列的最大y值
    [self.maxColumnY enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if (obj.floatValue < [self.maxColumnY[minKey] floatValue]) {
            minKey = key;
        }
    }];
    
    CGFloat cellW = (self.collectionView.frame.size.width - (self.column - 1) * self.colMargin - self.edgeInsets.left - self.edgeInsets.right) / self.column;
    CGFloat cellH = [self.delegate waterflowLayout:self heightWithWidth:cellW indexPath:indexPath];
    CGFloat cellX = self.edgeInsets.left + (cellW + self.colMargin) * minKey.intValue;
    CGFloat cellY = [self.maxColumnY[minKey] floatValue];
    self.maxColumnY[minKey] = [NSNumber numberWithFloat:cellY + cellH + self.rowMargin]; // 更新最大y值
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    [self clearMaxColumnY];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *itemsAttrb = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        [itemsAttrb addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return itemsAttrb;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 设置默认边距
        self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.colMargin = 10;
        self.rowMargin = 10;
        self.column = 3;
        self.maxColumnY = [NSMutableDictionary dictionary];
        [self clearMaxColumnY];
    }
    return self;
}


/**
 *  初始化最大y值
 */
- (void)clearMaxColumnY {
    for (int i = 0; i < self.column; i++) {
        [self.maxColumnY setObject:[NSNumber numberWithFloat:self.edgeInsets.top] forKey:[NSString stringWithFormat:@"%d", i]];
    }
}

@end
