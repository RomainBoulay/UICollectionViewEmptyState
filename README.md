#UICollectionView+EmptyState

Want to display an arbitrary `UIView` on your `UICollectionView` when in an *empty* state, and in a loosely-coupled fashion? Look no further.

##What's new

* 1.0.1
	* Tidying of methods.
	* Existing empty views are always removed when a new view is set. Allows for more dynamic changing of empty state views. 

* 1.0.0
	* Added `UICollectionViewEmptyStateDelegate` protocol.
	* Added `setEmptyStateImageViewWithImage:`.
* 0.0.1 - Initial release


##Usage

`#import "UICollectionView+EmptyState.h"` and simply set the property `emptyState_view` on your `UICollectionView` instance. We do the rest. Note that your view will be resized to overlay the `UICollectionView` so be sure to properly configure beforehand.

##Category properties

* **@property (nonatomic, strong) UIView *emptyState_view;** set your overlay view.
* **@property (nonatomic, assign) BOOL emptyState_shouldRespectSectionHeader;** when used with `UICollectionViewFlowLayout`, setting this property to `YES` causes the overlay to be laid-out beneath the first section's header view. This would be useful if your first section's header contains controls that affect the collection's content in some way. We don't want to block those.
* **@property (nonatomic, assign) NSTimeInterval emptyState_showAnimationDuration;**, **@property (nonatomic, assign) NSTimeInterval emptyState_hideAnimationDuration;** the overlay can be faded in and out using these properties. Set either to 0 for no animation.
* `UICollectionViewEmptyStateDelegate` protocol can be used for further customisation of the view as it's added and removed.
* A convenience method `setEmptyStateImageViewWithImage:` creates a `UIImageView` with the provided image, sets it as `emptyState_view`, and returns it for any further customisation required.

##Notes

`UICollectionView` is a complex beast, and there are quite likely to be edge cases I haven't considered here. If you find a gremlin, please let me know!

**Have fun!**

<joncrooke@gmail.com>




