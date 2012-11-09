#import "VPost.h"

@implementation VPost

@synthesize image = image_;
@synthesize imageName = imageName_;

- (id)initWithImageNamed:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:imageName];
        self.imageName = imageName;
    }
    return self;
    
}

@end
