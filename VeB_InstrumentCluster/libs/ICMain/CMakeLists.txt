qt_add_library(ICMain STATIC)


set(icMainHeader
    include/maincontroller.h
    include/WeatherApi.h
    include/WeatherInfo.h
    include/vehiclemetrics.h
    include/keyhandler.h
    include/menuselection.h
)


set(icMainSource
    src/maincontroller.cpp
    src/WeatherApi.cpp
    src/WeatherInfo.cpp
    src/vehiclemetrics.cpp
    src/keyhandler.cpp
    src/menuselection.cpp

)

set_source_files_properties(Styles.qml
    PROPERTIES
    QT_QML_SINGLETON_TYPE true
)


qt_add_qml_module(
    ICMain
    URI "ICMain"
    VERSION 1.0
    QML_FILES
    BoundaryBox.qml
    ICHomescreen.qml
    SpeedoMeter.qml
    RangeMeter.qml
    Odometer.qml
    DateTime.qml
    Styles.qml
    WeatherPage.qml
    BatteryMeter.qml
    RegenMeter.qml
    MenuSection.qml

    RESOURCES
    assets/images/lowerCurve.svg
    assets/images/batteryCar.png
    assets/images/regenrativeBraking.png
    assets/images/homeIcon.png
    assets/images/navigationIcon.png
    assets/images/tripIcon.png



    SOURCES
    ${icMainHeader}
    ${icMainSource}





)

target_link_libraries(
    ICMain
    PRIVATE Qt6::Quick
    Qt6::Core
    Qt::Gui

    PUBLIC
    CarModelplugin
    Navigationplugin
    TripInfoplugin
    WarningIndicatorsplugin
    ICSimulationplugin
)
