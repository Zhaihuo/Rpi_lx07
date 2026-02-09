cmake_minimum_required(VERSION 3.16)

project(E29_EOLTest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick QuickControls2 Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appTouchAreaTest
    main.cpp
    # uart.cpp
)

qt_add_qml_module(appTouchAreaTest
    URI E29_EOLTest
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES DefaultPage.qml
    SOURCES cppdata.h cppdata.cpp uart.cpp

    RESOURCES images/test000.png images/test004.bmp
    RESOURCES images/test001.png images/test002.png images/test003.png images/test004.png images/test005.png images/test006.png images/test007.png images/test008.png images/test009.png images/test010.png
    RESOURCES images/test011.png images/test012.png images/test013.png images/test014.png images/test015.png images/test016.png images/test017.png images/test018.png images/test019.png images/test020.png
    RESOURCES images/test021.png images/test022.png images/test023.png images/test024.png images/test025.png images/test026.png images/test027.png images/test028.png images/test029.png images/test030.png
    RESOURCES images/test031.png images/test032.png images/test033.png images/test034.png images/test035.png images/test036.png images/test037.png images/test038.png images/test039.png images/test040.png
    RESOURCES images/test041.png images/test042.png images/test043.png images/test044.png images/test045.png images/test046.png images/test047.png images/test048.png images/test049.png images/test050.png
    RESOURCES images/test051.png images/test052.png images/test053.png images/test054.png images/test055.png images/test056.png images/test057.png images/test058.png images/test059.png images/test060.png
    RESOURCES images/test061.png images/test062.png images/test063.png images/test064.png images/test065.png images/test066.png images/test067.png images/test068.png images/test069.png images/test070.png
    RESOURCES images/test071.png images/test072.png images/test073.png images/test074.png images/test075.png images/test076.png images/test077.png images/test078.png images/test079.png images/test080.png
    RESOURCES images/test081.png images/test082.png images/test083.png images/test084.png images/test085.png images/test086.png images/test087.png images/test088.png images/test089.png images/test090.png
    RESOURCES images/test091.png images/test092.png images/test093.png images/test094.png images/test095.png images/test096.png images/test097.png images/test098.png images/test099.png images/test100.png
    RESOURCES images/test101.png images/test102.png images/test103.png images/test104.png images/test105.png images/test106.png images/test107.png images/test108.png images/test109.png images/test110.png
    RESOURCES images/test111.png images/test112.png images/test113.png images/test114.png images/test115.png images/test116.png images/test117.png images/test118.png images/test119.png images/test120.png
    RESOURCES images/test121.png images/test122.png images/test123.png images/test124.png images/test125.png images/test126.png images/test127.png images/test128.png images/test129.png images/test130.png
    RESOURCES images/test131.png images/test132.png images/test133.png images/test134.png images/test135.png images/test136.png images/test137.png images/test138.png images/test139.png images/test140.png
    RESOURCES images/test141.png images/test142.png images/test143.png images/test144.png images/test145.png images/test146.png images/test147.png images/test148.png images/test149.png images/test150.png
    RESOURCES images/test151.png images/test152.png images/test153.png images/test154.png images/test155.png images/test156.png images/test157.png images/test158.png images/test159.png images/test160.png
    RESOURCES images/test161.png images/test162.png images/test163.png images/test164.png images/test165.png images/test166.png images/test167.png images/test168.png images/test169.png images/test170.png
    RESOURCES images/test171.png images/test172.png images/test173.png images/test174.png images/test175.png images/test176.png images/test177.png images/test178.png images/test179.png images/test180.png
    RESOURCES images/test181.png images/test182.png images/test183.png images/test184.png images/test185.png images/test186.png images/test187.png images/test188.png images/test189.png images/test190.png
    RESOURCES images/test191.png images/test192.png images/test193.png images/test194.png images/test195.png images/test196.png images/test197.png images/test198.png images/test199.png images/test200.png
    RESOURCES images/test201.png images/test202.png images/test203.png images/test204.png images/test205.png images/test206.png images/test207.png images/test208.png images/test209.png images/test210.png
    RESOURCES images/test211.png images/test212.png images/test213.png images/test214.png images/test215.png images/test216.png images/test217.png images/test218.png images/test219.png images/test220.png
    RESOURCES images/test221.png images/test222.png images/test223.png images/test224.png images/test225.png images/test226.png images/test227.png images/test228.png images/test229.png images/test230.png
    RESOURCES images/test231.png images/test232.png images/test233.png images/test234.png images/test235.png images/test236.png images/test237.png images/test238.png images/test239.png images/test240.png
    RESOURCES images/test241.png images/test242.png images/test243.png images/test244.png images/test245.png images/test246.png images/test247.png images/test248.png images/test249.png images/test250.png
    RESOURCES images/test251.png images/test252.png images/test253.png images/test254.png images/test255.png images/test256.png images/test257.png images/test258.png images/test259.png images/test260.png
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
