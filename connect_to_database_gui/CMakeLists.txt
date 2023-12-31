cmake_minimum_required(VERSION 3.16)

project(connect_to_database_gui VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appconnect_to_database_gui
    main.cpp
)

qt_add_qml_module(appconnect_to_database_gui
    URI connect_to_database_gui
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES MainView.qml
    SOURCES
    sql.h
    sql.cpp
    RESOURCES
    res.qrc
    QML_FILES
    QueryView.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appconnect_to_database_gui PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appconnect_to_database_gui
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appconnect_to_database_gui
    PRIVATE
    Qt6::Quick
    Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appconnect_to_database_gui
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
