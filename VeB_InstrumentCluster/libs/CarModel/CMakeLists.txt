qt_add_library(CarModel STATIC)

set(carModelHeader
    include/ConfigReader.h
    include/carmodelcontroller.h)
set(carModelSource
   src/ConfigReader.cpp
   src/carmodelcontroller.cpp)


qt_add_qml_module(
    CarModel
    URI "CarModel"
    VERSION 1.0

    QML_FILES
    CentralCarModel.qml
    SplashScreen.qml

    RESOURCES
    Image/MainCarImg.png
    Image/SecCarImg.png
    Image/FogOverlay.png
    Image/whiteRoad.png
    Image/TransparentRoad.png
    Image/splashScreenLogo.png
    Image/Emitter.png
    Image/verolt.png


    SOURCES
    ${carModelHeader}
    ${carModelSource}

)

target_link_libraries(
    CarModel
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui
)
