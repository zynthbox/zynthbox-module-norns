add_executable(norns-qml-shield)
target_sources(norns-qml-shield
    PRIVATE
    main.cpp
    app_resources.qrc
)
target_link_libraries(norns-qml-shield Qt5::Core Qt5::Qml Qt5::Quick)

install(TARGETS norns-qml-shield ${INSTALL_TARGETS_DEFAULT_ARGS})
install(FILES org.kde.norns-qml-shield.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})
