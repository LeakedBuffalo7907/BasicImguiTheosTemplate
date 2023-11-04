
#ifndef JFCommon_h
#define JFCommon_h

#define iPhone8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPad (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad ? YES : NO)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#endif
