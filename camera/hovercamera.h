#ifndef HOVERCAMERA_H
#define HOVERCAMERA_H

#include "hovercamerarenderer.h"

#include <QProcess>
#include <QQuickFramebufferObject>

class HoverCameraFB : public QQuickFramebufferObject
{
    Q_OBJECT
public:
    Renderer *createRenderer() const;
};

#endif // HOVERCAMERA_H

