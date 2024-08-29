#include "Translator.h"

namespace minesweeper {

Translator::Translator(QObject *parent)
    : QObject(parent)
    , translator_(new QTranslator())
    , translationLoaded_(false)
{}

void Translator::initTranslation()
{
    setLanguage(QLocale::system().name());

    if (!translationLoaded_)
        setLanguage("en_US");

    if (translationLoaded_)
        QGuiApplication::instance()->installTranslator(translator_.data());
}

QString Translator::language() const
{
    return translator_->language();
}

void Translator::setLanguage(const QString &newLanguage)
{
    translationLoaded_ = translator_->load(":/translations/minesweeper_" + newLanguage + ".qm");

    if (translationLoaded_) {
        emit languageChanged();
    }
}

} // namespace minesweeper
