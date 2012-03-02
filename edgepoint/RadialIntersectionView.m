    #import "RadialIntersectionView.h"

    @implementation RadialIntersectionView

    - (id)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            // Initialization code
        }
        return self;
    }

    - (CGPoint)radialIntersectionWithDegrees:(CGFloat)degrees {
        return [self radialIntersectionWithRadians:degrees * M_PI / 180];
    }

    - (CGPoint)radialIntersectionWithRadians:(CGFloat)radians {
        radians = fmodf(radians, 2 * M_PI);
        if (radians < 0)
            radians += (CGFloat)(2 * M_PI);
        return [self radialIntersectionWithConstrainedRadians:radians];
    }

    - (CGPoint)radialIntersectionWithConstrainedRadians:(CGFloat)radians {
        // This method requires 0 <= radians < 2 * π.

        CGRect frame = self.frame;
        CGFloat xRadius = frame.size.width / 2;
        CGFloat yRadius = frame.size.height / 2;

        CGPoint pointRelativeToCenter;
        CGFloat tangent = tanf(radians);
        CGFloat y = xRadius * tangent;
        // An infinite line passing through the center at angle `radians`
        // intersects the right edge at Y coordinate `y` and the left edge
        // at Y coordinate `-y`.
        if (fabsf(y) <= yRadius) {
            // The line intersects the left and right edges before it intersects
            // the top and bottom edges.
            if (radians < (CGFloat)M_PI_2 || radians > (CGFloat)(M_PI + M_PI_2)) {
                // The ray at angle `radians` intersects the right edge.
                pointRelativeToCenter = CGPointMake(xRadius, y);
            } else {
                // The ray intersects the left edge.
                pointRelativeToCenter = CGPointMake(-xRadius, -y);
            }
        } else {
            // The line intersects the top and bottom edges before it intersects
            // the left and right edges.
            CGFloat x = yRadius / tangent;
            if (radians < (CGFloat)M_PI) {
                // The ray at angle `radians` intersects the bottom edge.
                pointRelativeToCenter = CGPointMake(x, yRadius);
            } else {
                // The ray intersects the top edge.
                pointRelativeToCenter = CGPointMake(-x, -yRadius);
            }
        }

        return CGPointMake(pointRelativeToCenter.x + CGRectGetMidX(frame),
            pointRelativeToCenter.y + CGRectGetMidY(frame));
    }

    @end
