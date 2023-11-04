


#import <MetalKit/MetalKit.h>
#include <string>
using namespace std;

@protocol GuiRendererDelegate<NSObject>

- (void)setup;
- (void)draw;

@end
  

@interface GuiRenderer : NSObject <MTKViewDelegate>

@property (nonatomic, weak, nullable) id<GuiRendererDelegate> delegate;

-(nonnull instancetype)initWithView:(nonnull MTKView *)view;

-(void)initializePlatform;
-(void)shutdownPlatform;

#if TARGET_OS_OSX
-(bool)handleEvent:(NSEvent *_Nonnull)event view:(NSView *_Nullable)view;
#else
-(void)handleEvent:(UIEvent *_Nullable)event view:(UIView *_Nullable)view;
#endif

-(id<MTLTexture>_Nullable)loadTextureWithURL:(NSURL *_Nonnull)url;
-(id<MTLTexture>_Nullable)loadTextureWithName:(NSString *_Nonnull)name;
-(id<MTLTexture>_Nullable)loadTextureWithBase64:(string)Base64String;


@end

