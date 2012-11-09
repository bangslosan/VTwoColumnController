#import <QuartzCore/QuartzCore.h>
#import "VPostView.h"
#import "VPost.h"

#define PADDING 12.f

@implementation VPostView

@synthesize post = post_;

+ (float)heightForPost:(VPost *)post {
    float imageHeight = 0.f;

    if ([post.imageName isEqualToString:@"img1.jpg"]) {
        imageHeight = 206.f;
    } else if ([post.imageName isEqualToString:@"img2.jpg"]) {
        imageHeight = 91.f;
    } else if ([post.imageName isEqualToString:@"img3.jpg"]) {
        imageHeight = 181.f;
    } else if ([post.imageName isEqualToString:@"img4.jpg"]) {
        imageHeight = 191.f;
    } else if ([post.imageName isEqualToString:@"img5.jpg"]) {
        imageHeight = 195.f;
    }

    return imageHeight + PADDING;
}

- (id)initWithFrame:(CGRect)frame andPost:(VPost *)post {
    self = [self initWithFrame:frame];
    if (self) {
        self.post = post;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:post.image];
        imageView.frame = CGRectOffset(imageView.frame, PADDING, PADDING / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageView.frame];
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.5;
        self.opaque = YES;
        [self addSubview:imageView];
    }
    return self;
}

@end
