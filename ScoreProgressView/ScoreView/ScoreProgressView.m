//
//  HZScoreView.m
//  Common
//
//  Created by jiang junhui on 2019/1/29.
//  Copyright © 2019 hongzheng. All rights reserved.
//

#import "ScoreProgressView.h"
#import "TriangleView.h"

#define score_label_font 13
#define score_bg_height 10
// 屏幕宽度，会根据横竖屏的变化而变化
#define score_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
// 屏幕高度，会根据横竖屏的变化而变化
#define score_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface ScoreProgressView ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *progressView;
@property (nonatomic,strong) UILabel *minLabel;
@property (nonatomic,strong) UILabel *maxLabel;
@property (nonatomic,strong) UILabel *infoLabel;

@end

@implementation ScoreProgressView

-(instancetype)initWithFrame:(CGRect)frame model:(ScoreProgressModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        [self checkData];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.infoLabel];
    [self addSubview:self.minLabel];
    [self.bgView addSubview:self.progressView];
    [self addSubview:self.bgView];
    [self addSubview:self.maxLabel];
    
    [self initData];
}

- (void)checkData{
    if (_model == nil) {
        return;
    }
    if (_model.scoreFont == 0) {
        _model.scoreFont = score_label_font;
    }
    if (_model.bgColor == nil) {
        _model.bgColor = [UIColor groupTableViewBackgroundColor];
    }
    if (_model.bgHeight == 0) {
        _model.bgHeight = score_bg_height;
    }
    if (_model.progressColor == nil) {
        _model.progressColor = [UIColor redColor];
    }
    CGFloat minWidth = [self getWidthWithText:[NSString stringWithFormat:@"%ld",_model.minScore] height:_model.scoreFont font:_model.scoreFont];
    CGFloat maxWidth = [self getWidthWithText:[NSString stringWithFormat:@"%ld",_model.maxScore] height:_model.scoreFont font:_model.scoreFont];
    _model.scoreWidth = MAX(minWidth, maxWidth);
}

- (void)initData{
    self.infoLabel.text = _model.info;
    self.minLabel.text = [NSString stringWithFormat:@"%ld",_model.minScore];
    self.minLabel.font = [UIFont systemFontOfSize:_model.scoreFont];
    self.maxLabel.text = [NSString stringWithFormat:@"%ld",_model.maxScore];
    self.maxLabel.font = [UIFont systemFontOfSize:_model.scoreFont];
    if (_model.finalScore < _model.minScore || _model.finalScore > _model.maxScore) {
        self.infoLabel.text = @"获取分数不在区间范围内";
        return;
    }
    if (_model.maxScore < _model.minScore) {
        self.infoLabel.text = @"分数区间范围有误";
        return;
    }
    if (_model.maxScore == _model.minScore) {
        self.infoLabel.text = @"分数区间相同";
        return;
    }
    CGFloat totalWidth = self.bgView.frame.size.width;
    if (totalWidth <= 0) {
        self.infoLabel.text = @"界面设置有误";
        return;
    }
    
    CGFloat infoWidth = [self getWidthWithText:_model.info height:15 font:13];
    
    //计算比例
    CGFloat totalScoreOffset = _model.maxScore - _model.minScore;
    CGFloat ratio = totalWidth / totalScoreOffset;
    CGFloat progressWidth = _model.finalScore * ratio;
    
    
    
    //绘制三角形
    CGFloat pointX = progressWidth + self.bgView.frame.origin.x;
    CGFloat pointY = self.bgView.frame.origin.y;
    
    [self initTriangleView:pointX y:pointY];
    
    CGFloat infoLeft = pointX - infoWidth / 2;
    if (infoLeft < 0) {
        infoLeft = 5;
    }
    CGFloat infoRight = pointX + infoWidth / 2;
    if (infoRight > score_SCREEN_WIDTH) {
        infoLeft = score_SCREEN_WIDTH - 5 - infoWidth;
    }
    CGPoint minLabelPoint = CGPointMake(self.minLabel.center.x, self.bgView.center.y);
    CGPoint maxLabelPoint = CGPointMake(self.maxLabel.center.x, self.bgView.center.y);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.progressView.frame = CGRectMake(0, 0, progressWidth, self.bgView.frame.size.height);
        weakSelf.infoLabel.frame = CGRectMake(infoLeft, 0, infoWidth, 15);
        weakSelf.minLabel.center = minLabelPoint;
        weakSelf.maxLabel.center = maxLabelPoint;
    }];
}

- (void)initTriangleView:(CGFloat)pointX y:(CGFloat)pointY {
    
    CGPoint piont1;
    piont1.x = 0;
    piont1.y = 0;
    CGPoint piont2;
    piont2.x = 10;
    piont2.y = 0;
    CGPoint piont3;
    piont3.x = 5;
    piont3.y = 10;
    TriangleView *triangeView = [[TriangleView alloc] initStartPoint:piont1 middlePoint:piont2 endPoint:piont3 color:[UIColor blackColor]];
    triangeView.frame = CGRectMake(pointX - 5, pointY - 10, 10, 10);
    [self addSubview:triangeView];
    
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
        _infoLabel.font = [UIFont systemFontOfSize:13];
        _infoLabel.textColor = [UIColor blackColor];
    }
    return _infoLabel;
}



- (UILabel *)minLabel{
    if (!_minLabel) {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 10 + 5 - _model.scoreWidth / 2, _model.scoreWidth, _model.scoreWidth)];
        _minLabel.font = [UIFont systemFontOfSize:13];
        _minLabel.textColor = [UIColor blackColor];
        _minLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _minLabel;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(_model.scoreWidth + 15 + 5, 15 + 10 + 5, self.frame.size.width - _model.scoreWidth * 2 - 30 - 10 , _model.bgHeight)];
        _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _bgView.layer.cornerRadius = 15 / 2;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectZero];
        _progressView.backgroundColor = _model.progressColor;
    }
    return _progressView;
}

- (UILabel *)maxLabel{
    if (!_maxLabel) {
        _maxLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - _model.scoreWidth * 2 - 30 - 10) + _model.scoreWidth + 15 + 5 + 5 , 15 + 10 + 5 - _model.scoreFont / 2, _model.scoreWidth, _model.scoreFont)];
        _maxLabel.font = [UIFont systemFontOfSize:13];
        _maxLabel.textColor = [UIColor blackColor];
        _maxLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _maxLabel;
}

- (CGFloat)sqrtNumber:(CGFloat)number {
    CGFloat sqrtNumber = 0;
    if (number < 0) {
        // 这里根据实际情况做处理,简单的返回-1,可以根据-1情况进行处理
        sqrtNumber = -1;
    } else {
        // 下面是最主要的
        // 定义变量
        CGFloat oldRangeMid; // 记录上次运算的中间值
        CGFloat newRangeMid; // 生成新的中间值
        CGFloat rangeLeft; // 二分法区间的起始数
        CGFloat rangeRight; // 二分法区间的截止数
        
        // 初始化
        rangeLeft = 0;
        rangeRight = number;
        newRangeMid = oldRangeMid = (rangeLeft + rangeRight) / 2;
        
        do {
            // 满足条件,二分法缩小判断范围
            if (newRangeMid * newRangeMid > number) {
                rangeRight = newRangeMid;
            } else {
                rangeLeft = newRangeMid;
            }
            // 重新赋值,判断并且是否进入下一步的运算
            oldRangeMid = newRangeMid;
            newRangeMid = (rangeRight + rangeLeft) / 2;
            // 下面的判断是比较重要的
            // 我们需要判断新的Mid的值和旧的Mid的值的差值是不是在Float的精确度的允许误差范围之内,
            // 如果在误差范围之内,那么新的Mid就是我们需要得到的数值
            // 如果不在误差范围之内,那么继续进入下一步的运算,一直到满足
        } while (fabs(newRangeMid - oldRangeMid) > FLT_EPSILON);
        // 满足结果,赋值
        sqrtNumber = newRangeMid;
    }
    // 返回求得的开方数
    return sqrtNumber;
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
