QT += quick

HEADERS += \
    Translator.h \
    UiManager.h

SOURCES += \
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

