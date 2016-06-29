//
//  MSSegmentView.m
//  MSShowDemo
//
//  Created by Misheral on 16/6/29.
//  Copyright © 2016年 lifecycle. All rights reserved.
//

#import "MSSegmentView.h"

@interface MSSegmentView ()

@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) UIView *line;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation MSSegmentView

#pragma mark Lifecycle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        //设置宽度可变，高度不变
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = MSWhiteColor;
        [self prepareForView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //更新frame
    if (self.buttons.count) {
        CGFloat itemWidth = self.w/((float)self.buttons.count);
        for (int i = 0; i < self.buttons.count; i ++) {
            UIButton *itemButton = self.buttons[i];
            itemButton.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.h - self.lineHeight/2.0);
        }
        UIButton *itemButton = self.buttons[self.selectedIndex];
        _line.frame=CGRectMake(itemButton.x, self.h - self.lineHeight, itemWidth, _line.h);
    }
}

//初始化数据
- (void)prepareForView{
    _titleFont = [UIFont systemFontOfSize:16];
    _titleColor = MSBlackFontColor;
    _selectedTitleColor = MSRedFontColor;
    _titleBackgroundColor = MSContentBackGroundColor;
    
    _lineHeight = 2;
    _animationTime = 0.2;
    _lineColor = _selectedTitleColor;
    
    _selectedIndex = -1;
}

#pragma mark Line

- (UIView *)lineView{
    return self.line;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    self.line.h = self.lineHeight;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.line.backgroundColor = self.lineColor;
}

#pragma mark button Property

- (void)setTitleFont:(UIFont *)titleFont{
    if (!titleFont) {
        titleFont = [UIFont systemFontOfSize:15];
    }
    _titleFont = titleFont;
    for (UIButton *itemBtn in self.buttons) {
        [itemBtn.titleLabel setFont:titleFont];
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    if (!titleColor) {
        titleColor = MSBlackFontColor;
    }
    _titleColor = titleColor;
    for (UIButton *itemBtn in self.buttons) {
        [itemBtn setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    if (!selectedTitleColor) {
        selectedTitleColor = MSRedFontColor;
    }
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *itemBtn in self.buttons) {
        [itemBtn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}


#pragma mark Buttons init

- (void)setTitles:(NSArray *)titles{
    if (!titles) {
        titles = @[];
    }
    _titles = titles;
    [self initButtons:titles];
}

- (void)initButtons:(NSArray *)titles{
    //删除子view，清空视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!titles.count) {
        return;
    }
    NSMutableArray *tempButtons = [NSMutableArray arrayWithCapacity:titles.count];
     CGFloat itemWidth = self.w/((float)titles.count);
    for (int i = 0; i < titles.count; i ++) {
        NSString *itemTitle = titles[i];
        if (![titles[i] isKindOfClass:[NSString class]]) {
           itemTitle = @"格式错误";
        }
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectZero];
        btn.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.h - self.lineHeight/2.0);
        btn.backgroundColor= _titleBackgroundColor;
        btn.tag = 20000 + i;
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        btn.selected = NO;
        [btn addTarget:self action:@selector(segmentIndexSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn setTitle:itemTitle forState:UIControlStateNormal];
        [tempButtons addObject:btn];
    }
    self.buttons = tempButtons;
    
    //添加line
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, self.h - self.lineHeight, itemWidth, self.lineHeight)];
    self.line.backgroundColor = self.lineColor;
    self.line.tag = 5555;
    [self addSubview:self.line];
    
    //默认选中第一个segment
    [self.buttons[0] sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)segmentIndexSelected:(UIButton *)button{
    for (UIButton *btn in self.buttons) {
        btn.selected = NO;
    }
    button.selected = YES;
    self.selectedIndex = (int)button.tag - 20000;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex < 0) {
        return;
    }
    _selectedIndex = selectedIndex;
    UIButton *itemButton = self.buttons[self.selectedIndex];
    [UIView animateWithDuration:self.animationTime animations:^{
        _line.frame = CGRectMake(itemButton.x, self.h - self.lineHeight , _line.w, _line.h);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(segmentView:didSelectIndex:)]) {
            [self.delegate segmentView:self didSelectIndex:self.selectIndex];
        }
    }];
}

- (NSInteger)selectIndex{
    return self.selectedIndex;
}

@end

// 获取起点的x,y，以及view 的宽高

@implementation UIView (Vertex)

#pragma mark category Vertex

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(x, frame.origin.y);
    self.frame = frame;
}

- (CGFloat)x{
    return CGRectGetMinX(self.frame);
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(frame.origin.x, y);
    self.frame = frame;
}

- (CGFloat)y{
    return CGRectGetMinY(self.frame);
}

- (void)setW:(CGFloat)w{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(w, frame.size.height);
    self.frame = frame;
}

- (CGFloat)w{
    return CGRectGetWidth(self.frame);
}

- (void)setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame.size = CGSizeMake(frame.size.width, h);
    self.frame = frame;
}

- (CGFloat)h{
    return CGRectGetHeight(self.frame);
}

@end