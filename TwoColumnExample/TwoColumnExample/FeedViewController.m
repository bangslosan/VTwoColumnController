#import "FeedViewController.h"
#import "VPost.h"
#import "VPostView.h"

@interface FeedViewController ()

- (void)createPosts;
- (void)loadMorePosts;

@end

@implementation FeedViewController

@synthesize posts = posts_;

- (void)loadView {
    [super loadView];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.delegate = self;
}

- (void)viewDidLoad {
    [self createPosts];
    [super viewDidLoad];
}

#pragma mark - Properties

- (NSArray *)posts {
    if (!posts_) {
        posts_ = [NSArray array];
    }
    return posts_;
}

#pragma mark - Private Interface

- (void)createPosts {
    // Set up some test data...
    VPost *firstPost  = [[VPost alloc] initWithImageNamed:@"img1.jpg"];
    VPost *secondPost = [[VPost alloc] initWithImageNamed:@"img2.jpg"];
    VPost *thirdPost  = [[VPost alloc] initWithImageNamed:@"img3.jpg"];
    VPost *fourthPost = [[VPost alloc] initWithImageNamed:@"img4.jpg"];
    VPost *fifthPost  = [[VPost alloc] initWithImageNamed:@"img5.jpg"];
    self.posts = @[firstPost, secondPost, thirdPost, fourthPost, fifthPost];
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

#pragma mark - TwoColumnViewController methods

- (float)heightForViewAtIndex:(NSInteger)index {
    VPost *post = [self.posts objectAtIndex:index];
    return [VPostView heightForPost:post];
}

- (NSInteger)numberOfViews {
    return [self.posts count];
}

- (UIView *)viewForIndex:(NSInteger)index {
    CGRect frame = CGRectMake(0,0,0,0);
    VPost *post = [self.posts objectAtIndex:index];
    VPostView *view = [[VPostView alloc] initWithFrame:frame andPost:post];
    return view;
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