add_library(norns-qml-shield-plugin SHARED)
target_sources(norns-qml-shield-plugin
    PRIVATE
    qmlplugin.cpp
    process.h
    xdowrapper.cpp
    plugin_resources.qrc
)
target_link_libraries(norns-qml-shield-plugin Qt5::Core Qt5::Qml Qt5::Quick ${X11_LIBRARIES} ${LIBXDO_LIBRARIES})
target_include_directories(norns-qml-shield-plugin PRIVATE ${X11_INCLUDE_DIR} ${LIBXDO_INCLUDE_DIRS})

install(TARGETS norns-qml-shield-plugin DESTINATION ${QML_INSTALL_DIR}/org/zynthbox/norns/qmlshield)
install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/zynthbox/norns/qmlshield)

add_subdirectory(icons)
