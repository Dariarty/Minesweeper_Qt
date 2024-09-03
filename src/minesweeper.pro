QT += quick widgets

HEADERS += \
    GameHandler.h \
    Translator.h \
    UiManager.h

SOURCES += \
        GameHandler.cpp \
        Translator.cpp \
        UiManager.cpp \
        main.cpp

RESOURCES += \ 
        qml.qrc \
        resources.qrc \
        translations.qrc

TRANSLATIONS += \
    translations/minesweeper_ru_RU.ts \
    translations/minesweeper_en_US.ts

