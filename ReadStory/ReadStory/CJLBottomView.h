//
//  CJLBottomView.h
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/12.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJLBottomView;
@protocol CJLBottomViewDelegate <NSObject>

- (void) CJLBottomViewBtnClick:(UIButton *)sender;

@end
@interface CJLBottomView : UIView
@property (nonatomic,assign) CGFloat appLight;
@property (nonatomic,weak) id<CJLBottomViewDelegate> delegate;
@end
