
#import "GuiRenderer.h"
#import <Metal/Metal.h>
#include <string>
using std::string;

#include "imgui/imgui.h"
#include "imgui/render/imgui_impl_metal.h"

#if TARGET_OS_OSX
#include "imgui/render/imgui_impl_osx.h"
#endif

@interface GuiRenderer ()
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@property (nonatomic, strong) MTKTextureLoader *loader;
@end
  


@implementation GuiRenderer

-(nonnull instancetype)initWithView:(nonnull MTKView *)view;
{
    self = [super init];
    if(self)
    {
        _device = view.device;
        _commandQueue = [_device newCommandQueue];
        _loader = [[MTKTextureLoader alloc] initWithDevice: _device];
        
        IMGUI_CHECKVERSION();
        ImGui::CreateContext();
        ImGui::StyleColorsLight();   

    }

    return self;
}

- (void)drawInMTKView:(MTKView *)view
{
    ImGuiIO &io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

#if TARGET_OS_OSX
    CGFloat framebufferScale = view.window.screen.backingScaleFactor ?: NSScreen.mainScreen.backingScaleFactor;
#else
    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
#endif
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);

    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];

    static float clear_color[4] = { 0.0f, 0.0f, 0.0f, 0.0f };
    
    view.clearColor = MTLClearColorMake(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil)
    {
//        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);

        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"SwiftGUI"];

        // Start the Dear ImGui frame
        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
#if TARGET_OS_OSX
        ImGui_ImplOSX_NewFrame(view);
#endif
        ImGui::NewFrame();

        if (self.delegate && [self.delegate respondsToSelector:@selector(draw)]) {

            [self.delegate draw];
        }

        // Rendering
        ImGui::Render();
        ImDrawData *drawData = ImGui::GetDrawData();
        ImGui_ImplMetal_RenderDrawData(drawData, commandBuffer, renderEncoder);

        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];

        [commandBuffer presentDrawable:view.currentDrawable];
    }

    [commandBuffer commit];
}

- (void)MTKView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
}

-(void)initializePlatform {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setup)]) {
        [self.delegate setup];
    }

    ImGui_ImplMetal_Init(_device);

#if TARGET_OS_OSX
    ImGui_ImplOSX_Init();
#endif
}

-(void)shutdownPlatform {
    
#if TARGET_OS_OSX
    ImGui_ImplOSX_Shutdown();
#endif
}

-(void)handleEvent:(UIEvent *_Nullable)event view:(UIView *_Nullable)view {
 
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches) {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled) {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

-(id<MTLTexture>)loadTextureWithURL:(NSURL *)url {

    id<MTLTexture> texture = [self.loader newTextureWithContentsOfURL:url options:nil error:nil];
    
    if(!texture)
    {
        NSLog(@"Failed to create the texture from %@", url.absoluteString);
        return nil;
    }
    return texture;
}
-(id<MTLTexture>)loadTextureWithBase64:(std::string)Base64String {
    NSData *Base64Data = [[NSData alloc] initWithBase64EncodedString:[NSString stringWithCString:Base64String.c_str() encoding:[NSString defaultCStringEncoding]] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (Base64Data) {
        id<MTLTexture> texture = [self.loader newTextureWithData:Base64Data options:nil error:nil];
        
        if(!texture) {
            NSLog(@"Failed to create the texture from image data");
            return nil;
        }
        return texture;
    } else {
    NSLog(@"Unable to create the image from base64 string");
    return nil;
    }
}

-(id<MTLTexture>)loadTextureWithName:(NSString *)name {

    id<MTLTexture> texture = [self.loader newTextureWithName:name scaleFactor:1.0 bundle:nil options:nil error:nil];

    if(!texture)
    {
        NSLog(@"Failed to create the texture from %@", name);
        return nil;
    }
    return texture;
}

@end
