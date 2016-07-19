//
//  HLCollectionFlowLayout.m
//  collectionView
//
//  Created by 韩露露 on 16/7/17.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "HLCollectionLevelFlowLayout.h"

#define HLScreenW [UIScreen mainScreen].bounds.size.width

@implementation HLCollectionLevelFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    CGFloat itemW = 100;
    CGFloat itemY = itemW;
    self.itemSize = CGSizeMake(itemW, itemY);
    self.minimumInteritemSpacing = 200;
    self.minimumLineSpacing = 40;
    CGFloat margin = (self.collectionView.frame.size.width - itemW) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect currentRect;
    currentRect.size = self.collectionView.frame.size;
    currentRect.origin = proposedContentOffset;
    NSArray *itemsAttrib = [self layoutAttributesForElementsInRect:currentRect];
    
    CGFloat itemCX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDistance = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attris in itemsAttrib) {
        if (ABS(attris.center.x - itemCX) < ABS(minDistance)) {
            minDistance = attris.center.x - itemCX;
        }
    }
    return CGPointMake(proposedContentOffset.x + minDistance, proposedContentOffset.y);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    static const CGFloat changeSizeRect = 200; // 图片开始放大时的center距离collectionView中心x的距离
    
    CGRect currentFrame; // 可视区域的frame
    currentFrame.size = self.collectionView.frame.size;
    currentFrame.origin = self.collectionView.contentOffset;
    
    CGFloat centerX = self.collectionView.contentOffset.x + HLScreenW * 0.5; // 可视区域的center.x
    
    // 获取所有item属性的拷贝
    NSArray *currentItemAttrb = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:currentFrame] copyItems:YES];
    for (UICollectionViewLayoutAttributes *itemAttris in currentItemAttrb) {
        CGFloat distance = ABS(centerX - itemAttris.center.x); // 每个item中心到可视区域的center.x的距离
        CGFloat scale;
        if (distance <= changeSizeRect) {
            scale = 1.5 - distance * 0.5 / changeSizeRect;
        } else {
            scale = 1;
        }
        itemAttris.transform3D = CATransform3DMakeScale(scale, scale, 0.0);
    }
    return currentItemAttrb;
}

@end
