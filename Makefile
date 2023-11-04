ARCHS = arm64 ##arm64e
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

TWEAK_NAME = Test

$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wall -w -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -O2 
$(TWEAK_NAME)_CCFLAGS = -std=c++0x -std=gnu++0x -fno-rtti -DNDEBUG -Wall -w -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function # -D_FORTIFY_SOURCE=1 #-fno-exceptions
## Common frameworks ##
PROJ_COMMON_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics CoreText

## source files ##
FLOATNG_SRC = $(wildcard System/Floating/*.mm)
IMGUI_SRC = $(wildcard System/imgui/*.mm) $(wildcard System/imgui/imgui/*.cpp) $(wildcard System/imgui/imgui/render/*.mm)
UTILS_SRC = $(wildcard System/Utils/*.m) $(wildcard System/Utils/*.cpp)
LOADERS_SRC = Menu.mm Setup.mm

include $(THEOS)/makefiles/common.mk

$(TWEAK_NAME)_FILES = $(LOADERS_SRC) $(FLOATNG_SRC) $(UTILS_SRC) $(IMGUI_SRC)

$(TWEAK_NAME)_LIBRARIES += substrate

$(TWEAK_NAME)_FRAMEWORKS = $(PROJ_COMMON_FRAMEWORKS)

include $(THEOS_MAKE_PATH)/tweak.mk
