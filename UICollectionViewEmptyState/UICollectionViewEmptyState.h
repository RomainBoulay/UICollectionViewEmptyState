//
//  UICollectionViewEmptyState.h
//  UICollectionViewEmptyState
//


@import UIKit;


@protocol UICollectionViewEmptyStateDelegate;


@interface UICollectionViewEmptyState : UICollectionView

/** The view to be displayed when content is empty */
@property (nonatomic, strong) UIView *noResultPlaceholderView;

/** Convenience method to create a UIImageView with a centred UIImage placeholder */
- (UIImageView*)setEmptyStateImageViewWithImage:(UIImage*)image;


/** Fade in animation duration. 0.0 = no animation */
@property (nonatomic, assign) NSTimeInterval showNoResultPlaceholderAnimationDuration;

/** Fade out animation duration. 0.0 = no animation */
@property (nonatomic, assign) NSTimeInterval hideNoResultPlaceholderAnimationDuration;

/** Delay before displaying the overlay */
@property (nonatomic, assign) NSTimeInterval showNoResultPlaceholderAnimationDelay;

/** Delay before removing the overlay */
@property (nonatomic, assign) NSTimeInterval hideNoResultPlaceholderAnimationDelay;

/** Further customisation */
@property (nonatomic, unsafe_unretained) id <UICollectionViewEmptyStateDelegate> noResultPlaceholderDelegate;

@end



@protocol UICollectionViewEmptyStateDelegate <NSObject>
@optional
- (void)collectionView:(UICollectionView*)collectionView willAddEmptyStateOverlayView:(UIView*)view animated:(BOOL)animated;
- (void)collectionView:(UICollectionView*)collectionView didAddEmptyStateOverlayView:(UIView*)view;
- (void)collectionView:(UICollectionView*)collectionView willRemoveEmptyStateOverlayView:(UIView*)view animated:(BOOL) animated;
- (void)collectionView:(UICollectionView*)collectionView didRemoveEmptyStateOverlayView:(UIView*)view;
@end
