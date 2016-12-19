//
//  CJLViewController.h
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 当前选择的页数
 */
//static NSInteger selectPageCount;
/**
 当前单页字数
 */
static NSInteger pageTextCount; 
@interface CJLViewController : UIViewController
{
     @public NSInteger selectPageCount;
}
/*文件名*/
@property (nonatomic,copy)NSString * fileName;
@end
