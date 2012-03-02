#import "BackgroundView.h"
#import "RadialIntersectionView.h"

@implementation BackgroundView {
    CGPoint _touchPoint;
}

@synthesize myView = _myView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTouchPoint:(CGPoint)point {
    _touchPoint = point;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGPoint center = self.myView.center;
    CGFloat radians = atan2f(_touchPoint.y - center.y, _touchPoint.x - center.x);
    CGPoint edgePoint = [self.myView radialIntersectionWithRadians:radians];
    [UIColor.blueColor setFill];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.myView.center];
    [path addLineToPoint:edgePoint];
    [path stroke];
    
    static CGFloat const Radius = 10;
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(edgePoint.x - Radius, edgePoint.y - Radius, Radius * 2, Radius * 2)] stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.touchPoint = [((UITouch *)touches.anyObject) locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    self.touchPoint = [((UITouch *)touches.anyObject) locationInView:self];
}

@end
