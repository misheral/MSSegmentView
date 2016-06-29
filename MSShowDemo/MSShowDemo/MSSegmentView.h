//
//  MSSegmentView.h
//  MSShowDemo
//
//  Created by Misheral on 16/6/29.
//  Copyright © 2016年 lifecycle. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a/1.0]

#define MSBlackFontColor RGB(34,34,34)
#define MSRedFontColor RGB(225,62,62)
#define MSWhiteColor RGB(255,255,255)
#define MSContentBackGroundColor RGB(238,238,238)

@class MSSegmentView;

@protocol MSSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(MSSegmentView *)segmentView
     didSelectIndex:(NSInteger)index;

@end

@interface MSSegmentView : UIView

@property (assign, nonatomic) id<MSSegmentViewDelegate> delegate;

@property (strong, nonatomic) NSArray *titles;//标题

@property (strong, nonatomic) UIFont *titleFont;//字体
@property (strong, nonatomic) UIColor *titleColor;//标题字体颜色
@property (strong, nonatomic) UIColor *selectedTitleColor;//选中时标题字体颜色
@property (strong, nonatomic) UIColor *titleBackgroundColor;//背景颜色
@property (nonatomic, readonly) NSInteger selectIndex;//选中索引

@property (strong, nonatomic, readonly) UIView *lineView;//线
@property (nonatomic) CGFloat lineHeight;//线高度
@property (nonatomic) CGFloat animationTime;//动画时间
@property (strong, nonatomic) UIColor *lineColor;//线的颜色

@end

//扩展UIView的属性
@interface UIView (Vertex)

@property (nonatomic) CGFloat x;//起点的x
@property (nonatomic) CGFloat y;//起点的y
@property (nonatomic) CGFloat w;//宽度
@property (nonatomic) CGFloat h;//高度

@end
