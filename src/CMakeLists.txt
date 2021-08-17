add_executable(norns-qml-shield)

target_sources(norns-qml-shield
    PRIVATE
    main.cpp
    process.h
    xsendkey.cpp
    resources.qrc
)

target_link_libraries(norns-qml-shield Qt5::Core Qt5::Qml Qt5::Quick ${X11_LIBRARIES} ${LIBXDO_LIBRARIES})
target_include_directories(norns-qml-shield PRIVATE ${X11_INCLUDE_DIR} ${LIBXDO_INCLUDE_DIRS})

install(TARGETS norns-qml-shield ${INSTALL_TARGETS_DEFAULT_ARGS})
install(FILES org.kde.norns-qml-shield.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})

add_subdirectory(icons)
