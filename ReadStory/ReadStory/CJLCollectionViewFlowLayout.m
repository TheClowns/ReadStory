//
//  CJLCollectionViewFlowLayout.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLCollectionViewFlowLayout.h"

@implementation CJLCollectionViewFlowLayout
//系统调用  在 collectionView 的第一次布局的时候，被调用，此时 collectionView 的 frame 已经设置完毕

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    
    
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
}
@end
