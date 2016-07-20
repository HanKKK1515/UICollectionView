//
//  HLCollectionViewCell.m
//  collectionView
//
//  Created by 韩露露 on 16/7/17.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "HLCollectionViewCell.h"

@interface HLCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@end

@implementation HLCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.borderWidth = 3; // 设置边框宽度
    self.iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconView.layer.cornerRadius = 8;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconView.image = [UIImage imageNamed:icon];
}

@end
