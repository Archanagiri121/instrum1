cmake_minimum_required(VERSION 3.24)

project(VeB_InstrumentCluster VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.2 COMPONENTS Quick Gui Qml REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)



qt_add_executable(appVeB_InstrumentCluster
    main.cpp
)

qt6_add_qml_module(appVeB_InstrumentCluster
    URI appVeB_InstrumentCluster
    VERSION 1.0
    QML_FILES
    main.qml
)

add_subdirectory(libs)

target_link_libraries(appVeB_InstrumentCluster
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt::Gui

    PUBLIC
    ICMainplugin
    # CarModelplugin
)

# target_include_directories(appVeB_InstrumentCluster
#     PUBLIC
#     CarModel
#     ICSimulation)

install(TARGETS appVeB_InstrumentCluster
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})


