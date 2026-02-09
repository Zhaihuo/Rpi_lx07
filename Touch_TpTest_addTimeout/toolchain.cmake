set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_SYSROOT /tool/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/linux-x86/aarch64/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/libc)
set(CMAKE_STAGING_PREFIX /home/wenlun/qt/qt6-5-2-rpi5-install)

include_directories(
	# /opt/cluster-qt/2.5/sysroots/cortexa57-cortexa53-sdrv-linux/usr/include
	#/opt/cluster-qt/2.5/sysroots/cortexa57-cortexa53-sdrv-linux/usr/local/FFmpeg-n6.0/include
)

set(tools /tool/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/linux-x86/aarch64/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/)
set(CMAKE_C_COMPILER ${tools}/aarch64-none-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${tools}/aarch64-none-linux-gnu-g++)

set(CMAKE_CXX_FLAGS   "-no-pie")  
set(CMAKE_C_FLAGS   "-no-pie") 

set(QT_COMPILER_FLAGS "-march=armv8-a -mthumb -mfpu=neon -mfloat-abi=hard")
set(QT_COMPILER_FLAGS_RELEASE "-O2 -pipe")
set(QT_LINKER_FLAGS "-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
