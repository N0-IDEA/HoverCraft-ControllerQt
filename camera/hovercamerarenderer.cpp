#include "hovercamerarenderer.h"

#include <QOpenGLTexture>

#define ATTRIB_VERTEX 0
#define ATTRIB_TEXTURE 1

HoverCameraRenderer::HoverCameraRenderer()
{

}

void HoverCameraRenderer::initDrawBuffer(unsigned bsize)
{
    m_FrameSize = bsize;
    /*if(m_BufYuv)
        delete []  (unsigned char *)m_BufYuv;*/
    m_BufYuv = new unsigned char[bsize];
}

void HoverCameraRenderer::displayVideoFrame(unsigned char *data, int frameWidth, int frameHeight)
{
    m_VideoW = frameWidth;
    m_VideoH = frameHeight;
    memcpy(m_BufYuv, data, m_FrameSize);
    //m_hoverCamera->window()->update();
}



void HoverCameraRenderer::initialize()
{
    initializeOpenGLFunctions();

    m_program.addCacheableShaderFromSourceCode(QOpenGLShader::Vertex,
                                                "attribute vec4 vertexIn; \
                                                attribute vec2 textureIn; \
                                                varying vec2 textureOut;  \
                                                void main(void)           \
                                                {                         \
                                                    gl_Position = vertexIn; \
                                                    textureOut = textureIn; \
                                                }");
    m_program.addCacheableShaderFromSourceCode(QOpenGLShader::Fragment,
                                                "varying vec2 textureOut; \
                                                uniform sampler2D tex; \
                                                void main(void) \
                                                { \
                                                    vec3 yuv; \
                                                    vec3 rgb; \
                                                    vec4 yuvTex = texture2D(tex, textureOut); \
                                                    yuv.x = yuvTex.r; \
                                                    yuv.y = yuvTex.g - 0.5; \
                                                    yuv.z = yuvTex.b - 0.5; \
                                                    rgb = mat3( 1,       1,         1, \
                                                                0,       -0.39465,  2.03211, \
                                                                1.13983, -0.58060,  0) * yuv; \
                                                    gl_FragColor = vec4(rgb, 1); \
                                                }");

    m_program.bindAttributeLocation("vertexIn", ATTRIB_VERTEX);
    m_program.bindAttributeLocation("textureIn", ATTRIB_TEXTURE);
    m_program.link();

    m_uniformLocation = m_program.uniformLocation("tex");
}

void HoverCameraRenderer::render()
{
    m_program.bind();

    //Vertex matrix
    static const GLfloat vertexVertices[] = {
        -1.0f, -1.0f,
         1.0f, -1.0f,
         -1.0f, 1.0f,
         1.0f, 1.0f,
    };

    //Texture matrix
    static const GLfloat textureVertices[] = {
        0.0f,  1.0f,
        1.0f,  1.0f,
        0.0f,  0.0f,
        1.0f,  0.0f,
    };
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertexVertices);
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, 0, 0, textureVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);

    QOpenGLTexture* texture = new QOpenGLTexture(QOpenGLTexture::Target2D);
    texture->create();
    GLuint idTexture = texture->textureId();

    glClearColor (0.3, 0.3, 0.3, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glActiveTexture(GL_TEXTURE0);
    //Indicamos que textura estamos cargando
    glBindTexture(GL_TEXTURE_2D, idTexture);
    //Usa la memoria del buffer en la textura
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, m_VideoW, m_VideoH, 0, GL_RGB, GL_UNSIGNED_BYTE, m_BufYuv);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    glUniform1i(m_uniformLocation, 0);

    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    glDisableVertexAttribArray(ATTRIB_VERTEX);
    glDisableVertexAttribArray(ATTRIB_TEXTURE);
    m_program.release();

    delete texture;

}
