#import "VTwoColumnViewController.h"
#import "VPost.h"
#import "VExampleView.h"

#define SCREEN_WIDTH 320.f
#define POST_VIEW_WIDTH 160.f
#define SECOND_COLUMN_X_OFFSET POST_VIEW_WIDTH

@interface VTwoColumnViewController ()

- (void)createPosts;
- (void)setupPostViews;
- (CGRect)nextFrameForPost:(VPost *)post;
- (void)loadMorePosts;
- (void)reloadViews;

@end

@implementation VTwoColumnViewController

@synthesize scrollView = scrollView_;
@synthesize posts = posts_;
@synthesize firstColumnYOffset  = firstColumnYOffset_;
@synthesize secondColumnYOffset = secondColumnYOffset_;

- (void)loadView {
    NSLog(@"ok");
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPosts];
    [self setupPostViews];
}

#pragma mark - Properties

- (NSArray *)posts {
    if (!posts_) {
        posts_ = [NSArray array];
    }
    return posts_;
}

#pragma mark - Private interface

- (void)createPosts {
    // Set up some test data...
    VPost *firstPost  = [[VPost alloc] initWithImageNamed:@"img1.jpg"];
    VPost *secondPost = [[VPost alloc] initWithImageNamed:@"img2.jpg"];
    VPost *thirdPost  = [[VPost alloc] initWithImageNamed:@"img3.jpg"];
    VPost *fourthPost = [[VPost alloc] initWithImageNamed:@"img4.jpg"];
    VPost *fifthPost  = [[VPost alloc] initWithImageNamed:@"img5.jpg"];
    self.posts = @[firstPost, secondPost, thirdPost, fourthPost, fifthPost];
}

- (void)setupPostViews {
    self.firstColumnYOffset  = 0.f;
    self.secondColumnYOffset = 0.f;
    float maxY = 0.f;
    for (VPost *post in self.posts) {
        CGRect frame = [self nextFrameForPost:post];
        VExampleView *view = [[VExampleView alloc] initWithFrame:frame andPost:post];
        [self.view addSubview:view];
        maxY = frame.origin.y + frame.size.height;
    }
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, maxY)];
}

- (CGRect)nextFrameForPost:(VPost *)post {
    BOOL placeInFirstColumn = self.firstColumnYOffset <= self.secondColumnYOffset;
    
    float xOrigin = placeInFirstColumn ? 4.f : SECOND_COLUMN_X_OFFSET - 4.f;
    float yOrigin = placeInFirstColumn ? self.firstColumnYOffset : self.secondColumnYOffset;
    
    float height = [VExampleView heightForPost:post];
    
    CGRect nextFrame = CGRectMake(xOrigin, yOrigin, POST_VIEW_WIDTH, height);
    
    if (placeInFirstColumn) {
        self.firstColumnYOffset  = nextFrame.origin.y + nextFrame.size.height;
    } else {
        self.secondColumnYOffset = nextFrame.origin.y + nextFrame.size.height;
    }

    return nextFrame;
}

- (void)loadMorePosts {
    VPost *firstPost  = [[VPost alloc] initWithImageNamed:@"img1.jpg"];
    VPost *secondPost = [[VPost alloc] initWithImageNamed:@"img2.jpg"];
    VPost *thirdPost  = [[VPost alloc] initWithImageNamed:@"img3.jpg"];
    VPost *fourthPost = [[VPost alloc] initWithImageNamed:@"img4.jpg"];
    VPost *fifthPost  = [[VPost alloc] initWithImageNamed:@"img5.jpg"];
    self.posts = [self.posts arrayByAddingObjectsFromArray:@[firstPost, secondPost, thirdPost, fourthPost, fifthPost]];
    
    [self reloadViews];
}

- (void)reloadViews {
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[VExampleView class]]) {
            [view removeFromSuperview];
        }
    }
    [self setupPostViews];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // from stackoverflow somewhere or another...
    // appears to be working without causing the singularity.
    // no promises.
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float yOffset = offset.y + bounds.size.height - inset.bottom;
    float height = size.height;
    float tolerance = 5.f;
    if (yOffset > height + tolerance) {
        [self loadMorePosts];
    }
}

@end