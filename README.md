# Two column iOS UI

[![](http://i.imgur.com/OFZPC.png)](http://i.imgur.com/OFZPC.png)

Personally I first saw this in the Pinterest app.

This is some example code I threw together to check out how this would work before adding
it into another app. Perhaps it can be made to be re-usable...

# How to use this code

1. Create a subclass of VTwoColumnViewController
2. Override the following methods

    - (float)heightForViewAtIndex:(NSInteger)index
    - (NSInteger)numberOfViews
    - (UIView *)viewForIndex:(NSInteger)index

3. Call `reloadViews` as seen in the TwoColumnExample's subclass called `FeedViewController`

# Stuff this demo does

* Loads more when you reach the bottom
* Adds a custom view for each model's image with a shadow

# TODO

* Orientation/other device support
* Make this reusable via CocoaPods
* Performance optimizations
* Other awesome stuff

# Caveats

* If your UIView returned from `viewForIndex` is a `UIImageView`, this code won't work properly. Wrap the UIImageView in another view..

# License

MIT 
