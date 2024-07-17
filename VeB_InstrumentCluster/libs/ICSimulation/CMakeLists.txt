qt_add_library(ICSimulation STATIC)

set(simulationHeader
    include/simulationcontroller.h
    include/speedsimulator.h)
set(simulationSource
    src/simulationcontroller.cpp
    src/speedsimulator.cpp)


qt_add_qml_module(
    ICSimulation
    URI "ICSimulation"
    VERSION 1.0


    SOURCES
    ${simulationHeader}
    ${simulationSource}


)

target_link_libraries(
    ICSimulation
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui
)
