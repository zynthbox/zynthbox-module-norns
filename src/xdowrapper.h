/**
 * 
 */

#ifndef XDOWRAPER_H
#define XDOWRAPER_H

#include <QObject>
#include <QPoint>
#include <QSize>

class XDoWrapper : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString windowName READ windowName WRITE setWindowName NOTIFY windowNameChanged)
    Q_PROPERTY(QPoint windowPosition READ windowPosition WRITE setWindowPosition NOTIFY windowPositionChanged)
    Q_PROPERTY(QSize windowSize READ windowSize WRITE setWindowSize NOTIFY windowSizeChanged)
public:
    explicit XDoWrapper (QObject *parent = 0);
    ~XDoWrapper() override;

    QString windowName() const;
    void setWindowName(const QString &windowName);
    Q_SIGNAL void windowNameChanged();
    Q_SIGNAL void windowLocated();

    QPoint windowPosition() const;
    void setWindowPosition(const QPoint &position);
    Q_SIGNAL void windowPositionChanged();

    QSize windowSize() const;
    void setWindowSize(const QSize &size);
    Q_SIGNAL void windowSizeChanged();

    Q_INVOKABLE void activateWindow();
    Q_INVOKABLE void sendKey(const QString &key);
    Q_INVOKABLE void sendKeyDown(const QString &key);
    Q_INVOKABLE void sendKeyUp(const QString &key);
private:
    class Private;
    Private* d;
};

#endif//XDOWRAPER_H
