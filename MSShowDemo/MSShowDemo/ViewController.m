//
//  ViewController.m
//  MSShowDemo
//
//  Created by Misheral on 16/6/29.
//  Copyright © 2016年 Misheral. All rights reserved.
//

#import "ViewController.h"

#import "MSSegmentView.h"

@interface ViewController ()<MSSegmentViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MSSegmentView *segment = [[MSSegmentView alloc] initWithFrame:CGRectMake(0, 44, self.view.w, 40)];
    [self.view addSubview:segment];
    segment.delegate = self;
    segment.titles = @[@"新闻",@"热点",@"娱乐",@"游戏"];
}

- (void)segmentView:(MSSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    if (index >= 0) {
          self.infoLabel.text = [NSString stringWithFormat:@"选中了： %@",@(index)];
    }
}

@end
