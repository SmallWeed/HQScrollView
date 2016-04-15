//
//  HQScrollView.h
//  HQScrollView
//
//  Created by mac on 2015-9-15.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "HQScrollView.h"

@interface HQScrollView ()<UIScrollViewDelegate>
{
    NSTimer *_myTimer;
    NSMutableArray *_imageViewArray;
}
@end

@implementation HQScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setPageCount:(int)pageCount
{
    _pageCount = pageCount;
    [self refreshUI];
}

//设置某个位置处的图片
-(void)setImage:(UIImage *)image atIndex:(int)index
{
    if(index<0 || index >_pageCount - 1)
    {
        return;
    }
    
    UIImageView *view = _imageViewArray[index];
    view.image = image;
}

- (void)setImageWithUrlString:(NSString *)urlString atIndex:(int)index WithPlaceHolder:(UIImage *)placeholder
{
    if(index<0 || index >_pageCount - 1)
    {
        return;
    }
    
    UIImageView *view = _imageViewArray[index];
    [view sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder];
}

-(void)refreshUI
{
    if(_pageCount == 0)
    {
        return;
    }
    
    //先移除以前的视图
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //创建滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //[UIImage imageNamed:[_imageArray objectAtIndex:i]]
    _imageViewArray = [[NSMutableArray alloc] init];
    for (int i = 0;i<_pageCount;i++) {
        //loop this bit
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
        
        [_scrollView addSubview:imageView];
        [_imageViewArray addObject:imageView];
        
//        [imageView addTarget:self action:@selector(dealTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * _pageCount, self.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(0,0,self.frame.size.width,self.frame.size.height) animated:YES];

    //添加页面控制
    //创建pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 10);
    
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = _pageCount;
    
    //默认隐藏
    _pageControl.hidden = YES;

    //添加自动滚动
    [self performSelector:@selector(updateScrollView) withObject:nil afterDelay:0.0f];

}

-(void)dealTap:(UIButton *)imageView
{
    if(_setClickAction){
        _setClickAction();
    }
}

#pragma mark - 循环滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / (_pageCount)) / scrollView.frame.size.width) + 1;
    _pageControl.currentPage = currentPage;
    
    [self updatePageControl];
}

-(void)updatePageControl
{
    if(_scrollView.frame.size.width == 0)
    {
        return;
    }
    
    int index = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    
    _pageControl.currentPage = index;
}

#pragma mark - 是否自动隐藏
-(void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}

#pragma mark - 自动滚动
- (void) updateScrollView
{
    [_myTimer invalidate];
    _myTimer = nil;
    NSTimeInterval timeInterval = 3.5;
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:YES];
}

#pragma mark - pageControl 颜色
-(void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    _pageControl.pageIndicatorTintColor = tintColor;
}

-(void)setCurrentTintColor:(UIColor *)currentTintColor
{
    _currentTintColor = currentTintColor;
    _pageControl.currentPageIndicatorTintColor = currentTintColor;
}

- (void)handleMaxShowTimer:(NSTimer*)theTimer
{
    //控制是否自动滚动
    if(_autoScroll == NO)
    {
        return;
    }
    
    
    int currentPage = floor((_scrollView.contentOffset.x - _scrollView.frame.size.width / (_pageCount)) / _scrollView.frame.size.width) + 1;
    
    if(currentPage == (_pageCount-1)){
        [_scrollView scrollRectToVisible:CGRectMake(0,0,_scrollView.frame.size.width,_scrollView.frame.size.height) animated:YES];
    }else{
        currentPage++;
        [_scrollView scrollRectToVisible:CGRectMake(currentPage *_scrollView.frame.size.width,0,_scrollView.frame.size.width,_scrollView.frame.size.height) animated:YES];
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePageControl];
}

@end
