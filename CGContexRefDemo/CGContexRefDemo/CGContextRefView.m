//
//  CGContextRefView.m
//  CGContexRefDemo
//
//  Created by Jone on 15/11/24.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "CGContextRefView.h"
#define D2R(degrees)  ((M_PI * degrees) / 180)  // 角度转弧度

@implementation CGContextRefView
{
    CGFloat xOffset;
    CGFloat yOffset;
    
    CGFloat textWidth;
    CGFloat textHeight;
    
    CGFloat yInterval;
    
    CGFloat lineWidth;
    UIColor *lineColor;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        xOffset = 5;
        yOffset = 80;
        
        textWidth  = 50;
        textHeight = 15;
        
        yInterval = 60;
        
        lineWidth = 3.0;
        lineColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 直线
    [self drawLineContext:context];
    
    // 曲线
    [self drawArc:context];
    
    // 椭圆
    [self drawEllipse:context];
    
    // 弧线
    [self drawQuadCurve: context];
    
    // 圆
    [self drawCircle:context];
    
    // 矩形
    [self drawRectContext:context];
    
    // 扇形
    [self drawArcChart:context];
    
    // 圆角矩阵
    [self drawRectRadius:context];
    
    // 渐变
    [self drawGradient:context];
}

/**
 *  绘制直线
 *
 *  @param context
 */
- (void)drawLineContext:(CGContextRef)context
{
    // 直线
    CGRect textRect = (CGRect){xOffset, yOffset-textHeight/2, textWidth, textHeight};
    [self drawText:@"直线:" inRect:textRect];
    
    CGFloat lineLength = 120;
    CGContextMoveToPoint(context, xOffset + textWidth, yOffset);
    CGContextAddLineToPoint(context, xOffset + textWidth + lineLength, yOffset);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokePath(context);
    
    /**
     *   CGContextSaveGState函数的作用是将当前图形状态推入堆栈暂时保存。之后对图形状态所做的修改不会影响先前设置的样式；
     *   在修改完成后，通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态；
     *   这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改（比如不需要再将虚线切换回实线）。
     */
    
    CGContextSaveGState(context);
    CGPoint aPoints[2]; // 坐标点
    aPoints[0] =CGPointMake(xOffset + 2*textWidth + lineLength , yOffset);//坐标1
    aPoints[1] =CGPointMake(xOffset + textWidth + lineLength*2, yOffset); //坐标2
    CGFloat lengths[] = {5, 3};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextAddLines(context, aPoints, 2);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}

/**
 *  绘制曲线
 *
 */
- (void)drawQuadCurve:(CGContextRef)context
{
    CGFloat ew          = 120;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"曲线:" inRect:textRect];
    
    
    CGContextMoveToPoint(context, startX, startY); // 设置Path的起点
    // (cpx, cpy)控制点，(x, y)终点
    CGContextAddQuadCurveToPoint(context, startX + ew/2, startY - yInterval, startX + ew, startY);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
}

/**
 *  绘制160圆弧
 *
 * CGContextAddArcToPoint(CGContextRef __nullable c,
 * CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius)
 * 该函数与CGContextMoveToPoint(CGContextRef __nullable c,
 * CGFloat x, CGFloat y)混合使用
 * (x,y)代表圆弧的起点，(x2,y2)代表圆弧的终点，(x1,y1)代表起点和终点切线的交点，需要事先定好圆的半径
 * 方可求出(x1,y1)
 */

- (void)drawArc:(CGContextRef)context
{
    CGFloat degree      = 160;
    CGFloat radius      = yOffset/2;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval * 2;
    CGFloat middleX     = startX + radius * sin(D2R(degree/2));
    CGFloat middleY     = startY - radius * (1/cos(D2R(degree/2))-cos(D2R(degree/2)));
    CGPoint startPoint  = CGPointMake(startX, startY);    // 起点
    CGPoint middlePoint = CGPointMake(middleX, middleY);  // 切线交汇点
    CGPoint endPoint    = CGPointMake(startX + 2 * radius*sin(D2R(degree/2)), startY); // 终点
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"圆弧:" inRect:textRect];
    
    CGContextMoveToPoint(context,startPoint.x ,startPoint.y);
    CGContextAddArcToPoint(context, middlePoint.x, middlePoint.y, endPoint.x, endPoint.y, radius);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokePath(context);
    
    // 方法二:
    CGContextAddArc(context, startX+180, startY, radius, 0, -M_PI_2, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
}

/**
 *  绘制椭圆
 */
- (void)drawEllipse:(CGContextRef)context
{
    CGFloat eh          = 40;
    CGFloat ew          = 120;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval*3;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"椭圆:" inRect:textRect];
    
    // 空心椭圆
    CGContextSetLineWidth(context, lineWidth);
    CGContextAddEllipseInRect(context, CGRectMake(startX, startY - eh/2, ew, eh));
    CGContextDrawPath(context, kCGPathStroke);
    
    // 实心椭圆
    CGContextAddEllipseInRect(context, CGRectMake(startX + 1.5*ew, startY - eh/2, ew, eh));
    CGContextDrawPath(context, kCGPathFillStroke);
}



/**
 *  绘制圆
 *
 *  CGContextAddArc(CGContextRef __nullable c, CGFloat x, CGFloat y,
 *  CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
 *  (x,y)圆心坐标，radius半径，startAngle起始角度，endAngle结束角度，clockwise是否为顺时针
 *  由于iOS坐标系与数学中的坐标系是颠倒的，clockwise为1是其实是逆时针，为0时是顺势针
 */
- (void)drawCircle:(CGContextRef)context
{
    CGFloat ew          = 120;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval * 4;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"圆:" inRect:textRect];
    
    // 空心圆
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextAddArc(context, startX+ew/4, startY, ew/4, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 实心圆
    CGContextAddArc(context, startX + 2*ew - ew/4 , startY, ew/4, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  绘制矩形
*/
- (void)drawRectContext:(CGContextRef)context
{
    CGFloat ew          = 80;
    CGFloat eh          = 40;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval * 5;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"矩阵:" inRect:textRect];

    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextStrokeRect(context,CGRectMake(startX, startY, ew, eh));  // 空心
    
    CGContextFillRect(context, CGRectMake(startX + ew*2.25, startY, ew, eh));  // 实心
}

/**
 *  绘制扇形
 *
 *  扇形其实也是利用绘制圆的函数，只不过是连接了圆心
 */
- (void)drawArcChart:(CGContextRef)context
{
    CGFloat ew          = 120;
    CGFloat startX      = xOffset + textWidth + ew/8;
    CGFloat startY      = yOffset + yInterval * 6;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"扇形:" inRect:textRect];
    
    CGContextSetFillColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startX, startY);
    
    CGContextAddArc(context, startX, startY, ew/4, D2R(60), D2R(120), 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextMoveToPoint(context, startX + 1.5*ew, startY);
    CGContextAddArc(context, startX + ew*1.5, startY, ew/4, D2R(60), D2R(120), 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  圆角矩阵
 *
 *  也就是绘制不规则图形
 *
 */
- (void)drawRectRadius:(CGContextRef)context
{
    CGFloat ew          = 80;
    CGFloat eh          = 50;
    CGFloat offset      = 8;
    CGFloat startX      = xOffset + textWidth*1.3;
    CGFloat startY      = yOffset + yInterval * 7.5 + 30;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth*1.2, textHeight};
    [self drawText:@"圆角矩阵:" inRect:textRect];
    
    // 左上角
    CGContextMoveToPoint(context, startX, startY+offset);
    CGContextAddArcToPoint(context, startX, startY, startX+offset, startY, offset);
    
    // 右上角
    CGContextAddLineToPoint(context, startX + ew - offset, startY);
    CGContextAddArcToPoint(context, startX+ew, startY, startX+ew, startY+offset, offset);
    
    // 右下角
    CGContextAddLineToPoint(context, startX+ew, startY+eh-offset);
    CGContextAddArcToPoint(context, startX+ew, startY+eh, startX+ew-offset, startY+eh, offset);
    
    // 左下角
    CGContextAddLineToPoint(context, startX+offset, startY+eh);
    CGContextAddArcToPoint(context, startX, startY+eh, startX, startY+eh-offset, offset);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}

/**
 *  渐变
 */

- (void)drawGradient:(CGContextRef)context
{
    
    CGFloat ew          = 80;
    CGFloat eh          = 50;
    CGFloat startX      = xOffset + textWidth;
    CGFloat startY      = yOffset + yInterval * 6.5 + 30;
    
    CGRect textRect = (CGRect){xOffset, startY -textHeight/2, textWidth, textHeight};
    [self drawText:@"渐变:" inRect:textRect];
    
    
    CGColorSpaceRef spaceRGB = CGColorSpaceCreateDeviceRGB();
    CGFloat spaceColors[] = {
                                1, 1, 1, 1.00,
                                1, 1, 0, 1.00,
                                1, 0, 0, 1.00,
                                1, 0, 1, 1.00,
                                0, 1, 1, 1.00,
                                0, 1, 0, 1.00,
                                0, 0, 1, 1.00,
                                0, 0, 0, 1.00,
                            };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(spaceRGB, spaceColors, NULL, sizeof(spaceColors)/(sizeof(spaceColors[0])*4));
    CGColorSpaceRelease(spaceRGB);
    
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, startX+ew, startY);
    CGContextAddLineToPoint(context, startX+ew, startY+eh);
    CGContextAddLineToPoint(context, startX, startY+eh);
    CGContextClip(context); // 裁剪路径
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (startX, startY) ,CGPointMake(startX, startY+eh),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
}

/**
 *  绘字
 */
- (void)drawText:(NSString *)text inRect:(CGRect)textRect
{
    UIFont *font = [UIFont systemFontOfSize:12.0];
    
    // 水平居中样式(垂直居中可使用(textRect.size.height-fontSize)/2)
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributeDictionary = @{ NSFontAttributeName : font,
                                           NSForegroundColorAttributeName : lineColor,
                                           NSParagraphStyleAttributeName : style
                                           
                                           };
    
    [text drawInRect:textRect withAttributes:attributeDictionary];
}


@end
