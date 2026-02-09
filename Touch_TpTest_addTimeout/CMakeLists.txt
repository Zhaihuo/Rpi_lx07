cmake_minimum_required(VERSION 3.16)

project(TouchAreaTest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick QuickControls2 Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appTouchAreaTest
    TpTimeOut.cpp
    main.cpp
)

qt_add_qml_module(appTouchAreaTest
    URI TouchAreaTest
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES images/appIconVideo.png
    QML_FILES CalibrationPage.qml
    QML_FILES
    QML_FILES ColorChangePage.qml
    RESOURCES images/calibration.png
    QML_FILES PaintPage.qml
    QML_FILES DefaultPage.qml
    RESOURCES images/default.png
    RESOURCES images/pic00.png images/pic01.png images/pic02.png images/pic03.png images/pic04.png
    #RESOURCES images/huijie/pic_huijie_0*.png
    RESOURCES images/huijie/pic_huijie_000.png images/huijie/pic_huijie_001.png images/huijie/pic_huijie_002.png images/huijie/pic_huijie_003.png
    RESOURCES images/huijie/pic_huijie_004.png images/huijie/pic_huijie_005.png images/huijie/pic_huijie_006.png images/huijie/pic_huijie_007.png
    RESOURCES images/huijie/pic_huijie_008.png images/huijie/pic_huijie_009.png images/huijie/pic_huijie_010.png images/huijie/pic_huijie_011.png
    RESOURCES images/huijie/pic_huijie_012.png images/huijie/pic_huijie_013.png images/huijie/pic_huijie_014.png images/huijie/pic_huijie_015.png
    RESOURCES images/huijie/pic_huijie_016.png images/huijie/pic_huijie_017.png images/huijie/pic_huijie_018.png images/huijie/pic_huijie_019.png
    RESOURCES images/huijie/pic_huijie_020.png images/huijie/pic_huijie_021.png images/huijie/pic_huijie_022.png images/huijie/pic_huijie_023.png
    RESOURCES images/huijie/pic_huijie_024.png images/huijie/pic_huijie_025.png images/huijie/pic_huijie_026.png images/huijie/pic_huijie_027.png
    RESOURCES images/huijie/pic_huijie_028.png images/huijie/pic_huijie_029.png images/huijie/pic_huijie_030.png images/huijie/pic_huijie_031.png
    RESOURCES images/huijie/pic_huijie_032.png images/huijie/pic_huijie_033.png images/huijie/pic_huijie_034.png images/huijie/pic_huijie_035.png
    RESOURCES images/huijie/pic_huijie_036.png images/huijie/pic_huijie_037.png images/huijie/pic_huijie_038.png images/huijie/pic_huijie_039.png
    #RESOURCES images/huijie/pic_huijie_040.png images/huijie/pic_huijie_041.png images/huijie/pic_huijie_042.png images/huijie/pic_huijie_043.png
    RESOURCES images/pic05.png
    SOURCES cppdata.h cppdata.cpp
    RESOURCES images/airdark.png images/airlight.png images/closedark.png images/closelight.png images/music.png
    RESOURCES
    RESOURCES images/TouchBG.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTouchAreaTest PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTouchAreaTest
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTouchAreaTest
    PRIVATE Qt6::Quick
    Qt6::QuickControls2
    Qt6::Widgets
)

include(GNUInstallDirs)
install(TARGETS appTouchAreaTest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
