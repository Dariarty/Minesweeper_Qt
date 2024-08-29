#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QGuiApplication>
#include <QTranslator>

namespace minesweeper {

class Translator : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Translator)

    Q_PROPERTY(QString language READ language NOTIFY languageChanged)

public:
    Translator(QObject *parent = NULL);
    ~Translator() = default;

    void initTranslation();

    QString language() const;

    Q_INVOKABLE void setLanguage(const QString &newLanguage);

signals:
    void languageChanged();

private:
    QScopedPointer<QTranslator> translator_;

    bool translationLoaded_;
};

} // namespace minesweeper

#endif // TRANSLATOR_H
