//
//  ViewController.m
//  Demo3_JS_ArchiverTest_Photos
//
//  Created by  江苏 on 16/3/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray* imageViews;
@property(nonatomic)int count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建版式
//    NSMutableArray* views=[NSMutableArray array];
//    for (UIView* v  in self.view.subviews) {
//        if ([v isMemberOfClass:[UIView class]]) {
//            [views addObject:v];
//        }
//    }
//    NSMutableData* data=[NSMutableData data ];
//    NSKeyedArchiver* arch=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [arch encodeObject:views forKey:@"views"];
//    [arch finishEncoding];
//    [data writeToFile:@"/Users/jiangsu/Desktop/name/style4" atomically:YES];
    self.imageViews=[NSMutableArray array];
    [self initUI];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeStyle) userInfo:nil repeats:YES];
}
-(void)changeStyle{
     NSString* path =[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"style%d",++self.count%4+1] ofType:@""];
    NSData* data=[NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver* unArch=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSArray* views =[unArch decodeObjectForKey:@"views"];
    [UIView animateWithDuration:0.5 animations:^{
        for (int i=0; i<views.count; i++) {
            UIImageView* imageV=self.imageViews[i];
            UIView* view=views[i];
            imageV.frame=view.frame;
        }
    } completion:nil];
}
-(void)initUI{
    //拿到路径
    NSString* path =[[NSBundle mainBundle] pathForResource:@"style1" ofType:@""];
    NSData* data=[NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver* unArch=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSArray* views =[unArch decodeObjectForKey:@"views"];
    for (int i=0;i<views.count;i++) {
        UIView* view=views[i];
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:view.frame];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"yangmi0%d.jpg",i+1]];
        //防止图片变形
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds=YES;
        [self.view addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
