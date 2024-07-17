qt_add_library(WarningIndicators STATIC)

set(warningIndicatorHeader
    include/warningindicatorcontroller.h
)
set(warningIndicatorSource
    src/warningindicatorcontroller.cpp
)

qt_add_qml_module(
    WarningIndicators
    URI "WarningIndicators"
    VERSION 1.0

    QML_FILES
    WarningIndicators.qml
    IndicatorComponent.qml
    GearStateIndicator.qml

    RESOURCES
    assets/Image/deafultDoorAjar.png
    assets/Image/defaultHandbrake.png
    assets/Image/defaultHeadlamp.png
    assets/Image/defaultSeatbelt.png
    assets/Image/dipperHeadlamp.png
    assets/Image/doorAjar.png
    assets/Image/handbrake.png
    assets/Image/leftOffIndicator.png
    assets/Image/leftOnIndicator.png
    assets/Image/rightOffIndicator.png
    assets/Image/rightOnIndicator.png
    assets/Image/seatbelt.png
    assets/Image/upperHeadlamp.png
    assets/Image/imgUpperCurve.png

    assets/Music/Seatbelt_Warning_Sound1.wav
    assets/Music/turnIndicator_Sound1.wav

    SOURCES
    ${warningIndicatorHeader}
    ${warningIndicatorSource}
)

target_link_libraries(
    WarningIndicators
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui
)
