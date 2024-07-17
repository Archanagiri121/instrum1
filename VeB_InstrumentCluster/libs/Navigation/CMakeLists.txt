qt_add_library(Navigation STATIC)

set(navModelHeader
    include/navigationcontroller.h
)
set(navModelSource
    src/navigationcontroller.cpp
)

qt_add_qml_module(
    Navigation
    URI "Navigation"
    VERSION 1.0
    QML_FILES NavigationMap.qml

    RESOURCES
    assets/Image/Car.png
    assets/Image/NavIcon.png
    assets/Image/Pin.png
    assets/Image/slightLeft.png
    assets/Image/slightRight.png
    assets/Image/Straight.png
    assets/Image/turnLeft.png
    assets/Image/turnRight.png
    assets/Image/uturnLeft.png
    assets/Image/uturnRight.png

    SOURCES
    ${navModelHeader}
    ${navModelSource}
)

target_link_libraries(
    Navigation
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui
)
