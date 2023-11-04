#pragma mark - 调用文件
#import "Menu.h"
#import "Setup.h"

#import "System/imgui/imgui/imgui.h"
#import "System/imgui/imgui/imgui_internal.h"
#import "System/imgui/ImGuiWrapper.h"
#import "System/imgui/ImGuiStyleWrapper.h"
#import "System/imgui/GuiRenderer.h"
#import "System/Utils/UIImage+animatedGIF.h"

#include <mach-o/dyld.h>
#include <mach/mach_traps.h>
#include <libkern/OSCacheControl.h>
#include "cmath"
#include "iostream"
#import <pthread/pthread.h>
#include <arm_neon.h>
#import <mach/mach.h>
#import <vector>
#include <iostream>
#include <iomanip>
#include <string>
#import <Foundation/Foundation.h>
#import <stdio.h>
#include <algorithm>
#import <sys/utsname.h>
#include <map>
#include <unordered_map>
#include <sstream>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <TargetConditionals.h>
#import <AdSupport/ASIdentifierManager.h>
#import <AVKit/AVKit.h>
#include <array>
#import <UIKit/UIKit.h>

using namespace std;
IFuckYouTemp *instance;
UIView* view;
UITextField *field = [[UITextField alloc] init];
bool StreamerMode = false;

@interface IFuckYouTemp () <GuiRendererDelegate> {
    ImFont *_espFont;
}

@property (nonatomic, strong) MTKView *MTKView;
@property (nonatomic, strong) GuiRenderer *renderer;
@end

@implementation IFuckYouTemp
- (instancetype)initWithFrame:(CGRect)frame
{
    //LoadDefaults();
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
 
        
        self.isStartTimer = false;
        self.isShowMenu = false;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    instance = self;
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [view setBackgroundColor:[UIColor clearColor]];
    [view setUserInteractionEnabled:YES];
    field.secureTextEntry = true;
    [view addSubview:field];
    view = field.layer.sublayers.firstObject.delegate;
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:view];

    self.MTKView = [[MTKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.MTKView.backgroundColor = [UIColor clearColor];
    [view addSubview:self.MTKView];
    self.MTKView.device = MTLCreateSystemDefaultDevice();
    if (!self.MTKView.device) {
        return;
    }
    
    self.renderer = [[GuiRenderer alloc] initWithView:self.MTKView];
    self.renderer.delegate = self;
    self.MTKView.delegate = self.renderer;
    [self.renderer initializePlatform];
}

- (void)draw {
    [self CheckStreamerMode];
    [self drawMenu];
}
- (void)drawMenu {
    self.userInteractionEnabled = self.isShowMenu;
    self.MTKView.userInteractionEnabled = self.isShowMenu;
    if (!_isShowMenu) return;
    ImGui::StyleColorsDark();
    ImGui::Begin("IOS 17 Menu Test", &_isShowMenu); 
    {
        ImGui::Checkbox("Streamer", &StreamerMode);

    }
    ImGui::End();
}
- (void)CheckStreamerMode{
        [IFuckYou getNoRecView].secureTextEntry = StreamerMode;
        field.secureTextEntry = StreamerMode;
    return;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

@end