TARGET = MeeTeeVee
CONFIG += sailfishapp
QT += network

DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x000000

HEADERS += src/networkaccessmanager.h
SOURCES += src/main.cpp src/networkaccessmanager.cpp

OTHER_FILES += \
    qml/MeeTeeVee/*.qml \
    qml/MeeTeeVee/*.js \
    qml/MeeTeeVee/icons/*.png \
    qml/MeeTeeVee/images/*.png \
    qml/MeeTeeVee/util/*.js
