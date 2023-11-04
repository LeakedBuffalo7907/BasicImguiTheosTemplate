

#import "FuckOffMenuOverlay.h"
#import "../../Setup.h"


@implementation FuckOffMenuOverlay

- (instancetype)initWithFrame:(CGRect)frame {
       
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 0;
        self.alpha = 1;
                
    }
    return self;
}

#pragma mark - Event
- (void)didTapIconView {
    [IFuckYou getInstance].overlayView.isShowMenu = ![IFuckYou getInstance].overlayView.isShowMenu;
}

@end
