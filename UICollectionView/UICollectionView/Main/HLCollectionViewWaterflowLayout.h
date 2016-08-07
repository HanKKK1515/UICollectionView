//
//  HLCollectionViewWaterflowLayout.h
//  UICollectionView
//
//  Created by 韩露露 on 16/7/19.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLCollectionViewWaterflowLayout;
@protocol HLCollectionViewWaterflowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(HLCollectionViewWaterflowLayout *)waterflow heightWithWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath;

@end

@interface HLCollectionViewWaterflowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<HLCollectionViewWaterflowLayoutDelegate> delegate;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat column;
@property (nonatomic, assign) CGFloat colMargin;
@property (nonatomic, assign) CGFloat rowMargin;

@end
