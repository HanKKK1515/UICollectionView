//
//  ViewController.m
//  collectionView
//
//  Created by 韩露露 on 16/7/17.
//  Copyright © 2016年 韩露露. All rights reserved.
//

#import "ViewController.h"
#import "HLCollectionViewCell.h"
#import "HLCollectionLevelFlowLayout.h"
#import "HLCollectionViewOverlayLayout.h"
#import "HLCollectionViewCycloLayout.h"
#import "HLCollectionViewWaterflowLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, HLCollectionViewWaterflowLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *phone; // 用来存储图片名
@end

@implementation ViewController

/**
 *  cell的重用标识
 */
static NSString *const ID = @"phone";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    [self setupButton];
}

/**
 *  添加collectionView
 */
- (void)setupCollectionView {
    const CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, screenW, screenW * 0.6) collectionViewLayout:[[HLCollectionLevelFlowLayout alloc] init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    // 注册自定义的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HLCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
}

/**
 *  添加切换效果的按钮
 */
- (void)setupButton {
    UIButton *level = [self creatBtnWithtitle:@"水平" tag:1];
    UIButton *vertical = [self creatBtnWithtitle:@"竖直" tag:2];
    UIButton *overlay = [self creatBtnWithtitle:@"折叠" tag:3];
    UIButton *cyclo = [self creatBtnWithtitle:@"环形" tag:4];
    UIButton *water = [self creatBtnWithtitle:@"瀑布流" tag:5];
    NSArray *consH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[level]-10-[vertical(==level)]-10-[overlay(==level)]-10-[cyclo(==level)]-10-[water(==level)]-20-|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:@{@"level" : level, @"vertical" : vertical, @"overlay" : overlay, @"cyclo" : cyclo, @"water" : water}];
    NSArray *consV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[level(35)]" options:NSLayoutFormatAlignmentMask metrics:nil views:@{@"level" : level}];
    [self.view addConstraints:consH];
    [self.view addConstraints:consV];
}

/**
 *  添加按钮的方法
 */
- (UIButton *)creatBtnWithtitle:(NSString *)title tag:(int)tag {
    UIButton *btn = [[UIButton alloc] init];
    btn.layer.cornerRadius = 7;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickBtn:(UIButton *)btn {
    if (!self.phone.count) return;
    
    if (btn.tag == 1) {
        [self.collectionView setCollectionViewLayout:[[HLCollectionLevelFlowLayout alloc] init] animated:YES];
    } else if (btn.tag == 2) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = 100;
        CGFloat itemY = itemW;
        flowLayout.itemSize = CGSizeMake(itemW, itemY);
        flowLayout.minimumInteritemSpacing = 35;
        flowLayout.minimumLineSpacing = 35;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
    } else if (btn.tag == 3) {
        [self.collectionView setCollectionViewLayout:[[HLCollectionViewOverlayLayout alloc] init] animated:YES];
    } else if (btn.tag == 4) {
        [self.collectionView setCollectionViewLayout:[[HLCollectionViewCycloLayout alloc] init] animated:YES];
    } else if (btn.tag == 5) {
        HLCollectionViewWaterflowLayout *waterLayout = [[HLCollectionViewWaterflowLayout alloc] init];
        waterLayout.delegate = self;
        waterLayout.column = 3;
        waterLayout.colMargin = 10;
        waterLayout.rowMargin = 10;
        waterLayout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.collectionView setCollectionViewLayout:waterLayout animated:YES];
    }
}

#pragma mark - HLCollectionViewWaterflowLayout的代理方法
- (CGFloat)waterflowLayout:(HLCollectionViewWaterflowLayout *)waterflow heightWithWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath {
    
    return width + ((indexPath.item * 500) % 199);  // 模拟不同高度
}

#pragma mark - UICollectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.phone.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.icon = self.phone[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.phone removeObjectAtIndex:indexPath.item];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]]; // 点击删除对应的图片
}

- (NSMutableArray *)phone {
    if (!_phone) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        self.phone = array;
    }
    return _phone;
}

@end
