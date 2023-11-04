
#import "Setup.h"
#import <mach-o/dyld.h>
#import <mach/mach.h>
#import <dlfcn.h>
#import <stdio.h>
#import <string>
#import "System/Utils/UIImage+animatedGIF.h"
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[IFuckYou getInstance] entry];
    });
}
__attribute__((constructor)) static void initialize()
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDrop);
}

#pragma mark
@interface IFuckYou ()
@property (nonatomic, strong) NSTimer *dataTimer;
@property (nonatomic, strong) NSTimer *actionTimer;
@end

@implementation IFuckYou
UIView* NoRecView;
UITextField *ffield = [[UITextField alloc] init];
static IFuckYou *instance = nil;

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

+ (IFuckYou *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (id)allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
+ (UITextField *)getNoRecView
{
    return ffield;
}
#pragma mark
- (void)entry
{
    if (!self.floatingMenuView.superview) {
        NoRecView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [NoRecView setBackgroundColor:[UIColor clearColor]];
        [NoRecView setUserInteractionEnabled:YES];
        ffield.secureTextEntry = true;
        [NoRecView addSubview:ffield];
        NoRecView = ffield.layer.sublayers.firstObject.delegate;
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:NoRecView];
        self.floatingMenuViewTwo.iconImageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"https://www.freepnglogos.com/uploads/youtube-shorts-logo-png/red-shorts-png-logo-with-play-icon-0.png"]];
        self.floatingMenuView.iconImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:@"" options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self.overlayView];
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self.floatingMenuView];
        [NoRecView addSubview:self.floatingMenuViewTwo];
    }
    [self startFuckYou];
}
- (void)startFuckYou
{
    [self cancelTimer];
    self.dataTimer = [NSTimer timerWithTimeInterval:1.0f/40 target:self selector:@selector(UpdateIcon) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.dataTimer forMode:NSRunLoopCommonModes];}

- (void)cancelTimer
{
    if (self.dataTimer) {
        [self.dataTimer invalidate];
        self.dataTimer = nil;
    }
}
- (void)UpdateIcon
{
     self.floatingMenuViewTwo.frame = self.floatingMenuView.frame;
     [NoRecView setNeedsDisplay];
     return;
}

#pragma mark
float iconScale = isIPad ? 1.5f : 1.0f;   
- (FuckOffMenuOverlay *)floatingMenuView
{
    if (!_floatingMenuView) {
        _floatingMenuView = [[FuckOffMenuOverlay alloc] initWithFrame:CGRectMake(90, 90, int(45 * iconScale), int(45 * iconScale))];
    }
    return _floatingMenuView;
}
- (FuckOffMenuOverlay *)floatingMenuViewTwo
{
    if (!_floatingMenuViewTwo) {
        _floatingMenuViewTwo = [[FuckOffMenuOverlay alloc] initWithFrame:CGRectMake(90, 90, int(45 * iconScale), int(45 * iconScale))];
    }
    return _floatingMenuViewTwo;
} //getinstance

- (IFuckYouTemp *)overlayView
{
    if (!_overlayView) {
        CGRect ScreenBounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _overlayView = [[IFuckYouTemp alloc] initWithFrame:ScreenBounds];
    }
    return _overlayView;
}

@end
