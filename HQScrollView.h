//
//  HQScrollView.h
//  HQScrollView
//
//  Created by mac on 2015-9-15.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

//========用法============
/*
//1.先包含头文件
//#import "HQScrollView.h"
 
 
//2.创建循环滚动视图
 HQScrollView *HQScrollView = [[HQScrollView alloc] init];
 HQScrollView.frame = CGRectMake(0, 20, 320, 460);
 HQScrollView.pageCount = 4;
 HQScrollView.autoScroll = YES;
 
//点击事件
外部Block 实现setClickAction
 
//设置网络图片
_imageArray = @[@"http://mp.manzuo.com/pic/act/wap.jpg",
                @"http://mp.manzuo.com/pic/act/banner_20141110154630.jpg",
                @"http://mp.manzuo.com/pic/act/banner_20141106115308.jpg",
                @"http://mp.manzuo.com/pic/act/hlbanner.jpg"];
 
for (int i=0; i<_imageArray.count; i++) {
    [HQScrollView setImageWithUrlString:_imageArray[i] atIndex:i];
}

HQScrollView.autoScroll = YES;
[self.view addSubview:HQScrollView];
*/


//功能: 自动循环滚动显示多张图片
@interface HQScrollView : UIView

//需要显示的页数
@property (nonatomic) int pageCount;

//是否自动滚动
@property (nonatomic) BOOL autoScroll;

//是否显示pageControl
@property (nonatomic) BOOL showPageControl;

// 滚动pageControl 颜色
@property (nonatomic,retain) UIColor *tintColor;

// 滚动pageControl 当前颜色
@property (nonatomic,retain) UIColor *currentTintColor;

//设置某个位置处的图片
-(void)setImage:(UIImage *)image atIndex:(int)index;
-(void)setImageWithUrlString:(NSString *)urlString atIndex:(int)index WithPlaceHolder:(UIImage *)placeholder;

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;

//每张添加点击处理 - block
@property (nonatomic,copy) void (^setClickAction)();
@end
