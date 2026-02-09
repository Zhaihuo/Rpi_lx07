# set(CMAKE_SYSTEM_NAME Linux)
# set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_SYSROOT /)
# set(CMAKE_SYSROOT /tool/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/linux-x86/aarch64/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/libc)
# set(project /home/wenlun/qt/qt-everywhere-src-6.5.2-target1)
set(CMAKE_STAGING_PREFIX /home/wenlun/qt/build-host-qt6.5.2)

#include_directories(
#	/opt/cluster-qt/2.5/sysroots/cortexa57-cortexa53-sdrv-linux/usr/include
#)

link_directories(
	${CMAKE_STAGING_PREFIX}/lib
)

# set(tools /opt/cluster-qt/2.5/sysroots/x86_64-sdrvsdk-linux/usr/bin/aarch64-sdrv-linux)
# set(CMAKE_C_COMPILER ${tools}/aarch64-sdrv-linux-gcc)
# set(CMAKE_CXX_COMPILER ${tools}/aarch64-sdrv-linux-g++)

# set(tools /tool/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/linux-x86/aarch64/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin)
# set(CMAKE_C_COMPILER ${tools}/aarch64-none-linux-gnu-gcc)
# set(CMAKE_CXX_COMPILER ${tools}/aarch64-none-linux-gnu-g++)

# set(CMAKE_CXX_FLAGS   "-no-pie")  
# set(CMAKE_C_FLAGS   "-no-pie") 

# set(QT_COMPILER_FLAGS "-march=armv8-a -mthumb -mfpu=neon -mfloat-abi=hard")
# set(QT_COMPILER_FLAGS_RELEASE "-O2 -pipe")
# set(QT_LINKER_FLAGS "-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed")

# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
