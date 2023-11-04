

#import <UIKit/UIKit.h>
#import "Menu.h"


@interface IFuckYou : NSObject

@property (nonatomic, strong) IFuckYouTemp *overlayView;
@property (nonatomic, strong) FuckOffMenuOverlay *floatingMenuView;
@property (nonatomic, strong) FuckOffMenuOverlay *floatingMenuViewTwo;

+ (IFuckYou *)getInstance;
+ (UITextField *)getNoRecView;

- (void)entry;
- (void)cancelTimer;

@end
