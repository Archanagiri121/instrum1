qt_add_library(TripInfo STATIC)

set(tripInfoModelHeader
    include/tripinfocontroller.h
    include/tripdata.h
)
set(tripInfoModelSource
    src/tripinfocontroller.cpp
    src/tripdata.cpp
)

qt_add_qml_module(
    TripInfo
    URI "TripInfo"
    VERSION 1.0

    SOURCES
    ${tripInfoModelHeader}
    ${tripInfoModelSource}
    QML_FILES TripInfo.qml
    QML_FILES RowItem.qml
    QML_FILES TripDetails.qml

    RESOURCES
    asset/images/distanceIcon.png
    asset/images/fromIcon.png
    asset/images/fuelIcon.png
    asset/images/speedIcon.png
    asset/images/timerIcon.png
    asset/images/toIcon.png

)

target_link_libraries(
    TripInfo
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui
)
