/**
 * 
 */

#ifndef XSENDKEY_H
#define XSENDKEY_H

#include <QObject>

class XSendKey : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString windowName READ windowName WRITE setWindowName NOTIFY windowNameChanged)
public:
    explicit XSendKey(QObject *parent = 0);
    ~XSendKey() override;

    QString windowName() const;
    void setWindowName(const QString& windowName);
    Q_SIGNAL void windowNameChanged();

    void sendKeyPress(const QString& key);
private:
    class Private;
    Private* d;
};

#endif//XSENDKEY_H
