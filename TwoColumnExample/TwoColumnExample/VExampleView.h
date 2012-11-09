#import <UIKit/UIKit.h>

@class VPost;

@interface VExampleView : UIView

@property(strong, nonatomic) VPost *post;

+ (float)heightForPost:(VPost *)post;
- (id)initWithFrame:(CGRect)frame andPost:(VPost *)post;


@end
