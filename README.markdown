iOS KeyBurns effect
====================

The goal of this project is to create a UIView that can generate a KyBurns transition with a set of images passed as an array.

Use interface:

**- (void)starAnimationWithImages:(NSArray*)images TransitionTime:(float)time onLoop:(BOOL)isLoop inLandscape:(BOOL)isLandscape;**

1. *images:* NSArray of UIImages.
2. *time:*  Time in seconds for the transition between each image.
3. *isLoop:*  The animation will start again when ended.
4. *isLandscape:*  If true optimized to show in Landscape mode.

### TODO

* Need to allow device rotation.
* Better image transitions effects.


--
###[SweetBits](http://example.com/ "SweetBits"), welcome to the candy factory.###