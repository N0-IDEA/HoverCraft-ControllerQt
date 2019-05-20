#include "hovercamera.h"

#include <QtQuick/qquickwindow.h>
#include <QtGui/QOpenGLShaderProgram>
#include <QtGui/QOpenGLContext>
#include <QOpenGLFramebufferObject>
#include <QOpenGLTexture>

#define PROGRAM_VERTEX_ATTRIBUTE 0
#define PROGRAM_TEXCOORD_ATTRIBUTE 1

#define ATTRIB_VERTEX 0
#define ATTRIB_TEXTURE 1

const unsigned FRAME_WIDTH = 720;
const unsigned FRAME_HEIGHT = 480;
const unsigned FRAME_SIZE = FRAME_WIDTH * FRAME_HEIGHT * 3;
const unsigned BUFFER_SIZE = FRAME_WIDTH * FRAME_HEIGHT * 2;

class HoverCameraFBRenderer : public QQuickFramebufferObject::Renderer
{
public:
    HoverCameraFBRenderer() {
        hoverCameraRenderer.initialize();
        runCommand("./capture -o");
    }

    void runCommand(const QString &cmd) {
        m_proccess = new QProcess();
        m_proccess->setProcessChannelMode(QProcess::MergedChannels);
        QObject::connect(m_proccess, &QProcess::readyRead, [this] () -> void {this->readFrame();});
        const QString c = QString(cmd);
        m_proccess->start(c);

        hoverCameraRenderer.initDrawBuffer(FRAME_SIZE);
    }

    void addToFrameBuffer(unsigned char y, unsigned char u, unsigned char v, unsigned char *buffer) {
        buffer[currentPixel * 3 ] = y;
        buffer[currentPixel * 3 + 1] = u;
        buffer[currentPixel * 3 + 2 ] = v;
        currentPixel++;
    }

    void render() override {
        hoverCameraRenderer.render();
        update();
    }


    QOpenGLFramebufferObject *createFramebufferObject(const QSize &size) override {
        QOpenGLFramebufferObjectFormat format;
        format.setAttachment(QOpenGLFramebufferObject::CombinedDepthStencil);
        //format.setSamples(4);
        return new QOpenGLFramebufferObject(size, format);
    }

    HoverCameraRenderer hoverCameraRenderer;
    void readFrame() {
        if(m_proccess->bytesAvailable() < BUFFER_SIZE) {
            return;
        }
        unsigned char *stream = new unsigned char[BUFFER_SIZE];
        int num = m_proccess->read((char*) stream, BUFFER_SIZE);
        convertYUYVtoYUV(BUFFER_SIZE, stream);
        hoverCameraRenderer.displayVideoFrame(m_buffer, FRAME_WIDTH, FRAME_HEIGHT);
        delete [] stream;
        delete [] m_buffer;
    }

private:

    QProcess* m_proccess;
    int currentPixel;
    unsigned char* m_buffer;
    void convertYUYVtoYUV(int readSize, unsigned char *readBuffer) {
        unsigned size = readSize / 2 * 3;
        m_buffer = new unsigned char[size];

        currentPixel = 0;
        for (int i=0; i * 4 < readSize; i++) {
            unsigned char u  = readBuffer[i * 4 + 1];
            unsigned char y1 = readBuffer[i * 4];
            unsigned char v  = readBuffer[i * 4 + 3];
            unsigned char y2 = readBuffer[i * 4 + 2];

            addToFrameBuffer(y1, u, v, m_buffer);
            addToFrameBuffer(y2, u, v, m_buffer);
        }
    }
};

QQuickFramebufferObject::Renderer *HoverCameraFB::createRenderer() const
{
    return new HoverCameraFBRenderer();
}
