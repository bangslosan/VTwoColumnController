#import <Foundation/Foundation.h>

@interface VPost : NSObject

@property(strong, nonatomic) UIImage *image;
@property(strong, nonatomic) NSString *imageName;

- (id)initWithImageNamed:(NSString *)imageName;

@end
