#import "VTwoColumnViewController.h"

#define SCREEN_WIDTH 320.f
#define SECOND_COLUMN_X_OFFSET (SCREEN_WIDTH / 2)

@interface VTwoColumnViewController ()

- (void)setupViews;
- (CGRect)nextFrameForIndex:(NSInteger)index;
- (UIView *)viewForIndex:(NSInteger)index;

@end

@implementation VTwoColumnViewController

@synthesize scrollView = scrollView_;
@synthesize firstColumnYOffset  = firstColumnYOffset_;
@synthesize secondColumnYOffset = secondColumnYOffset_;

#pragma mark - View Controller methods

- (void)loadView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Override these in subclass

- (float)heightForViewAtIndex:(NSInteger)index {
    return 0.f;
}

- (NSInteger)numberOfViews {
    return 0;
}

- (UIView *)viewForIndex:(NSInteger) index {
    return nil;
}

#pragma mark - Private interface

- (void)setupViews {
    self.firstColumnYOffset  = 0.f;
    self.secondColumnYOffset = 0.f;
    float maxY = 0.f;
    for (NSInteger index = 0; index < [self numberOfViews]; index++) {
        CGRect frame = [self nextFrameForIndex:index];
        UIView *view = [self viewForIndex:index];
        view.frame = frame;
        [self.view addSubview:view];
        maxY = frame.origin.y + frame.size.height;
    }
    
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, maxY)];
}

- (CGRect)nextFrameForIndex:(NSInteger)index {
    BOOL placeInFirstColumn = self.firstColumnYOffset <= self.secondColumnYOffset;
    
    float xOrigin = placeInFirstColumn ? 4.f : SECOND_COLUMN_X_OFFSET - 4.f;
    float yOrigin = placeInFirstColumn ? self.firstColumnYOffset : self.secondColumnYOffset;
    
    float height = [self heightForViewAtIndex:index];
    
    CGRect nextFrame = CGRectMake(xOrigin, yOrigin, SCREEN_WIDTH / 2, height);
    
    if (placeInFirstColumn) {
        self.firstColumnYOffset  = nextFrame.origin.y + nextFrame.size.height;
    } else {
        self.secondColumnYOffset = nextFrame.origin.y + nextFrame.size.height;
    }

    return nextFrame;
}

- (void)reloadViews {
    for (UIView *view in self.scrollView.subviews) {
        if (![view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [self setupViews];
}


@end