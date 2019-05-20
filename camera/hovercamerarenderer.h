#ifndef HOVERCAMERARENDERER_H
#define HOVERCAMERARENDERER_H

#include <QOpenGLFunctions>
#include <QOpenGLShaderProgram>



class HoverCameraRenderer : protected QOpenGLFunctions
{
public:
    HoverCameraRenderer();

    void render();
    void initialize();
    void initDrawBuffer(unsigned bsize);
    void displayVideoFrame(unsigned char *data, int frameWidth, int frameHeight);
private:
    QOpenGLShaderProgram m_program;
    int m_uniformLocation;

    GLsizei m_VideoW, m_VideoH;
    GLvoid* m_BufYuv;
    int m_FrameSize;
};

#endif // HOVERCAMERARENDERER_H
