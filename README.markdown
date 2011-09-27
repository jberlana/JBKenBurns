iOS KeyBurns effect
====================

The goal of this project is to create a UIView that can generate a KyBurns transition with a set of images passed as an array.

Use interface:

- (void)starAnimationWithImages:(NSArray*)images TransitionTime:(float)time onLoop:(BOOL)isLoop inLandscape:(BOOL)isLandscape;

1. **images:** (Shows in green.) NSArray of UIImages.
2. **time:** (Shows in green.) Time in seconds for the transition between each image.
3. **isLoop:** (Shows in green.) The animation will stare again when ended.
4. **isLandscape:** (Shows in green.) If true optimized to show in Landscape mode.

### TODO

* Need to allow device rotation.
* Better image transitions effects.
