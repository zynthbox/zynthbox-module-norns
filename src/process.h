#include <QProcess>
#include <QVariant>

class Process : public QProcess {
    Q_OBJECT
    Q_PROPERTY(QString executableFile MEMBER m_executableFile NOTIFY executableFileChanged)
    Q_PROPERTY(QVariantList arguments MEMBER m_arguments NOTIFY argumentsChanged)
    Q_PROPERTY(bool isRunning MEMBER m_isRunning NOTIFY isRunningChanged)
public:
    Process(QObject *parent = 0) : QProcess(parent) {
        connect(
            this, &QProcess::stateChanged,\
            [this](QProcess::ProcessState newState){
                m_isRunning = (newState == QProcess::Running);
                Q_EMIT isRunningChanged();
            }
        );
    }

    Q_INVOKABLE void start() {
        QStringList args;

        // convert QVariantList from QML to QStringList for QProcess 
        for (int i = 0; i < m_arguments.length(); i++)
            args << m_arguments[i].toString();

        QProcess::start(m_executableFile, args);
    }

    Q_INVOKABLE QByteArray readAll() {
        return QProcess::readAll();
    }

    Q_SIGNAL void executableFileChanged();
    QString m_executableFile;
    Q_SIGNAL void argumentsChanged();
    QVariantList m_arguments;
    Q_SIGNAL void isRunningChanged();
    bool m_isRunning;
}; 
