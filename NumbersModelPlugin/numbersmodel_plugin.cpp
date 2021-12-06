#include "numbersmodel_plugin.h"

#include "numbersmodel.h"

#include <qqml.h>

void NumbersModelPlugin::registerTypes(const char *uri)
{
    // @uri org.myplugins.qmlcomponents
    qmlRegisterType<NumbersModel>(uri, 1, 0, "NumbersModel");
}

