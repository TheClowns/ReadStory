//
//  CJLCollection.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLCollection.h"
NSString *const CJLCollectionViewCellId = @"CJLCollectionViewCellId";
@interface CJLCollection ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation CJLCollection
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CJLCollectionViewCellId];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
    
}

- (NSInteger ) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJLCollectionViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
@end
