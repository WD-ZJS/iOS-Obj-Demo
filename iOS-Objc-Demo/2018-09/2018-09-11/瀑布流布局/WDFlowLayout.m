//
//  WDFlowLayout.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDFlowLayout.h"

//默认的列数
static const CGFloat ZYYCollumCoutnt = 3;
//列间距
static const CGFloat ZYYCollumMargin = 10;
//行间距
static const CGFloat ZYYRowMargin = 10;
//边缘间距
static const UIEdgeInsets ZYYEdgeUnsets = {10,10,10,10};

@interface WDFlowLayout ()

//用于存放cell属性的数组
@property (strong,nonatomic) NSMutableArray *attrsArray;

//用于存放所有列高度数组
@property (strong,nonatomic) NSMutableArray *maxH;

@end

@implementation WDFlowLayout

//懒加载属性数组
- (NSMutableArray *)attrsArray {
    if (_attrsArray ==nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

//懒加载高度属性数组
- (NSMutableArray *)maxH {
    if (_maxH ==nil) {
        _maxH = [NSMutableArray array];
    }
    return _maxH;
}


//准备布局每次刷新都会调用此方法
- (void)prepareLayout {
    [super prepareLayout];
    //先清除以前计算的所有高度，这种做法比较严谨，如果有下拉刷新，不及时清空数组的话会造成数据混乱
    [self.maxH removeAllObjects];
    //这里先将数组里面的初始值设为0
    for (NSInteger i =0; i < ZYYCollumCoutnt; i ++) {
        [self.maxH addObject:@0];
    }
    
    //清除以前的所有属性
    [self.attrsArray removeAllObjects];
    //开始创建每个cell对应的布局属性
    //1、获取collectionView里面的有多少个item
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    //创建多少collectionViewcell属性
    for (NSInteger i=1; i<count; i++) {
        
        //获取item对应的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //创建属性调用下面的layoutAttributesForItemAtIndexPath方法
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        //设置cell的属性直接调用layoutAttributesForItemAtIndexPath方法即可
        [self.attrsArray addObject:attrs];
    }
}



/**
 * 决定布局的关键所在
 *
 *  @param rect 属性rect
 *
 *  @return 返回属性数组
 */

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

/**
 *  返回indexPath位置cell对应的布局属性
 *  这个方法是核心算法
 */

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    //collectionView的宽度
    CGFloat collectionViewW =self.collectionView.frame.size.width;
    
    //列号
    NSInteger cloumIndex =0;
    
    //默认第一行是最小的，这样做的话可以让下面的for循环从i=1开始遍历，这样做可以优化性能
    CGFloat minClumnHeight = [self.maxH[0]doubleValue];
    
    
    for (NSInteger i =1; i < ZYYCollumCoutnt; i++) {
        
        //取出第i列元素的y值
        CGFloat cheight = [self.maxH[i]doubleValue];
        
        if (minClumnHeight > cheight) {
            minClumnHeight = cheight;
            cloumIndex = i;
        }
    }
    
    //每个item的宽度 == （collectionView的宽度 -左边距 -右边距 -（列数-1）*间距）再除于列数
    CGFloat w = (collectionViewW -ZYYEdgeUnsets.left -ZYYEdgeUnsets.right - (ZYYCollumCoutnt -1) * ZYYCollumMargin)/3.0;
    //高度这里用的是随机数，做项目时根据的是素材的高度
    CGFloat h = 50 + arc4random_uniform(100);
    
    //x可以根据列来算
    CGFloat x = ZYYEdgeUnsets.left + cloumIndex * (ZYYRowMargin + w);
    
    //y最小itme值计算
    CGFloat y = minClumnHeight +ZYYRowMargin;
    
    //设置布局属性的frame，这个frame是最终item的frame
    attrs.frame =CGRectMake(x, y, w, h);
    
    //更新最短那列的高度
    self.maxH[cloumIndex] =@(CGRectGetMaxY(attrs.frame));

    return attrs;
}

//尺寸
- (CGSize)collectionViewContentSize {
    //找出y值最大的的那一列，和上面找出最小高度相似
    CGFloat maxColunmHeight = [self.maxH[0]doubleValue];
    
    for (NSInteger i =1; i < ZYYCollumCoutnt; i++) {
        CGFloat my = [self.maxH[i]doubleValue];
        if (maxColunmHeight < my) {
            maxColunmHeight = my;
        }
    }

    return CGSizeMake(0, maxColunmHeight +ZYYEdgeUnsets.bottom);    
}

@end
