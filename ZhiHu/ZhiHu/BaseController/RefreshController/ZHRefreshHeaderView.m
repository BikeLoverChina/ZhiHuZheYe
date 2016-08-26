//
//  ZHRefreshHeaderView.m
//  ZhiHu
//
//  Created by Apple on 16/7/24.
//  Copyright © 2016年 ywj. All rights reserved.
//
/*
#import "ZHRefreshHeaderView.h"

#import "ZHRefreshHeader.h"
#import "MJRefreshComponent.h"

@interface ZHRefreshHeader ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@property (nonatomic, strong) CAShapeLayer *backCircleLayer;
@property (nonatomic, strong) CAShapeLayer *frontCircleLayer;
@property (nonatomic, strong) CAShapeLayer *pieLayer;
@property (nonatomic, assign) BOOL     isAnimating;

@property (nonatomic, strong) UIImageView *testLogo;

@end

@implementation ZHRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //    // 打酱油的开关
    //    UISwitch *s = [[UISwitch alloc] init];
    //    [self addSubview:s];
    //    self.s = s;
    
    // logo
    NSBundle *refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MJRefreshComponent class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    UIImage *circleImage = [[UIImage imageWithContentsOfFile:[refreshBundle pathForResource:@"Night_Now_Loading@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *logo = [[UIImageView alloc] initWithImage:circleImage];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    //    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    [self addSubview:loading];
    //    self.loading = loading;
    
    // pie
    self.backCircleLayer = [CAShapeLayer layer];
    self.frontCircleLayer = [CAShapeLayer layer];
    self.pieLayer = [CAShapeLayer layer];
    self.frontCircleLayer.mask = _pieLayer;
    
    self.testLogo = [[UIImageView alloc] initWithImage:circleImage];
    [self.testLogo.layer addSublayer:self.backCircleLayer];
    [self.testLogo.layer addSublayer:self.frontCircleLayer];
    [self.testLogo.layer addSublayer:self.pieLayer];
    
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0]  addSubview:self.testLogo];
    self.testLogo.backgroundColor = [UIColor redColor];
    //    self.backCircleLayer.contents = (__bridge id)[backCircleImage CGImage];
    //    self.frontCircleLayer.contents = (__bridge id)[frontCircleImage CGImage];
    
    // TEST_YWJ
    self.label.backgroundColor = [UIColor redColor];
    self.logo.backgroundColor = [UIColor yellowColor];
    self.backCircleLayer.backgroundColor = [UIColor orangeColor].CGColor;
    self.frontCircleLayer.backgroundColor = [UIColor brownColor].CGColor;
    self.pieLayer.backgroundColor = [UIColor purpleColor].CGColor;
    // TEST_YWJ
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.mj_h, self.mj_h);
    //    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
    self.logo.center = CGPointMake((self.bounds.size.width-self.mj_h*0.5)*0.5, self.mj_h * 0.5);
    //    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
    self.testLogo.frame = CGRectMake(100, 100, self.logo.frame.size.width, self.logo.frame.size.height);
    self.backCircleLayer.frame = self.logo.bounds;
    self.frontCircleLayer.frame = self.logo.bounds;
    self.pieLayer.frame = self.logo.bounds;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    NSLog(@"%f",pullingPercent);
    
    if (pullingPercent == 1.0) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        [self updatePie:self.pieLayer forAngle:0.5 * 360.0f];
        self.frontCircleLayer.mask = self.pieLayer;
        [CATransaction commit];
    }
}

#pragma mark - Private Methods

- (void)updatePie:(CAShapeLayer *)layer forAngle:(CGFloat)degrees {
    NSLog(@"== %@ %f ==",layer,degrees);
    CGFloat angle = -90 * (M_PI / 180.0);
    CGPoint center_ = CGPointMake(CGRectGetWidth(layer.frame)/2.0, CGRectGetWidth(layer.frame)/2.0);
    CGFloat radius = CGRectGetWidth(layer.frame)/2.0;
    
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center_];
    [piePath addLineToPoint:CGPointMake(center_.x, center_.y - radius)];
    [piePath addArcWithCenter:center_ radius:radius startAngle:angle endAngle:(degrees - 90.0f) * (M_PI / 180.0) clockwise:YES];
    [piePath addLineToPoint:center_];
    [piePath closePath];
    
    layer.path = piePath.CGPath;
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
            //            // TEST_YWJ
            //            [self stopAnimating:self.logo.layer];
            //            // TEST_YWJ
            //self.logo.hidden = NO;
            if (self.isAnimating) {
                [self stopAnimating:self.logo.layer];
                self.isAnimating = NO;
            }
            //            NSLog(@"1.空闲状态");
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
            // TEST_YWJ
            [self startAnimating];
            // TEST_YWJ
            //            NSLog(@"2.正在下拉");
            break;
        case MJRefreshStateWillRefresh:
            //            // TEST_YWJ
            //            [self startAnimating];
            //            // TEST_YWJ
            //            NSLog(@"3.即将刷新");
            break;
        case MJRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中(开关是打酱油滴)";
            [self.loading startAnimating];
            
            // TEST_YWJ
            //            [self stopAnimating:self.logo.layer];
            // TEST_YWJ
            //            NSLog(@"4.正在刷新");
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark- 动画
- (void)startAnimating
{
    //NSLog(@"== 开始动画 ==");
    self.isAnimating = YES;
    self.logo.hidden = NO;
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定动画选项
    animation.duration = 20; // 持续时间
    animation.repeatCount = MAXFLOAT; // 重复次数
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    // 设定选装角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:50 * M_PI]; // 终止角度
    // 添加动画
    [self.logo.layer addAnimation:animation forKey:@"rotate-layer"];
}

- (void)stopAnimating:(CALayer *)layer
{
    //NSLog(@"== 结束动画 ==");
    self.logo.hidden = YES;
    [layer removeAllAnimations];
    self.logo.hidden = NO;
}
*/
 //
 //  ZHRefreshHeaderView.m
 //  ZhiHu
 //
 //  Created by Apple on 16/7/24.
 //  Copyright © 2016年 ywj. All rights reserved.
 //
 
 #import "ZHRefreshHeaderView.h"
 #import "MJRefreshComponent.h"
 #import "PieProgressView.h"
 
 @interface ZHRefreshHeaderView ()
 
 @property (weak, nonatomic) UILabel *label;
 @property (weak, nonatomic) UISwitch *s;
 @property (weak, nonatomic) UIImageView *logo;
 @property (nonatomic, strong) PieProgressView *pieProgressView;
 @property (nonatomic, assign) BOOL     isAnimating;
 
 @end
 
 @implementation ZHRefreshHeaderView
 
 #pragma mark - 重写方法
 #pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 30;

    // logo
    NSBundle *refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MJRefreshComponent class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    UIImage *circleImage = [[UIImage imageWithContentsOfFile:[refreshBundle pathForResource:@"Night_Now_Loading@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    circleImage = [UIImage imageNamed:@"Night_Now_Loading@2x.png"];
    UIImageView *logo = [[UIImageView alloc] initWithImage:circleImage];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // pieProgressView
    self.pieProgressView = [[PieProgressView alloc] init];
    [self.logo addSubview:self.pieProgressView];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.logo.bounds = CGRectMake(0, 0, self.mj_h, self.mj_h);
    self.logo.center = CGPointMake((self.bounds.size.width-self.mj_h*0.5)*0.5, self.mj_h * 0.5);
    self.logo.layer.cornerRadius = self.mj_h * 0.5;
    self.logo.layer.masksToBounds = YES;
    self.pieProgressView.frame = CGRectMake(0, 0, self.logo.frame.size.width, self.logo.frame.size.height);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    
    if (self.pullingPercent < 1.0 && self.pullingPercent >= 0.0) {
        [self updatePieForAngle:pullingPercent];
    }
}

#pragma mark - Private Methods

- (void)updatePieForAngle:(CGFloat)degrees {
    if (degrees >= 0.25) {
        [self.pieProgressView setProgress:degrees-0.25];
    }
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            if (self.isAnimating) {
                [self stopAnimating:self.logo.layer];
                self.isAnimating = NO;
            }
            break;
        case MJRefreshStatePulling:
            [self startAnimating];
            break;
        case MJRefreshStateWillRefresh:
            break;
        case MJRefreshStateRefreshing:
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark- 动画
- (void)startAnimating
{
    self.isAnimating = YES;
    self.logo.hidden = NO;
    self.pieProgressView.hidden = YES;
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定动画选项
    animation.duration = 20; // 持续时间
    animation.repeatCount = MAXFLOAT; // 重复次数
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    // 设定选装角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:50 * M_PI]; // 终止角度
    // 添加动画
    [self.logo.layer addAnimation:animation forKey:@"rotate-layer"];
}

- (void)stopAnimating:(CALayer *)layer
{
    self.logo.hidden = YES;
    [layer removeAllAnimations];
    self.logo.hidden = NO;
    [self.pieProgressView setProgress:0.0];
    self.pieProgressView.hidden = NO;
}

@end
