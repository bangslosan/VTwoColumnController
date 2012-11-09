#import <UIKit/UIKit.h>

@interface VTwoColumnViewController : UIViewController<UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;
@property(assign) float firstColumnYOffset;
@property(assign) float secondColumnYOffset;

- (void)reloadViews;

@end
