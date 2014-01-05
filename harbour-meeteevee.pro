TARGET = harbour-meeteevee
CONFIG += sailfishapp
QT += network

HEADERS += src/networkaccessmanager.h
SOURCES += src/main.cpp src/networkaccessmanager.cpp

OTHER_FILES += \
    qml/*.qml \
    qml/*.js \
    qml/icons/*.png \
    qml/images/*.png \
    qml/util/*.js
