#include "numbersmodel_plugin.h"

#include "numbersmodel.h"

#include <qqml.h>

void NumbersModelPlugin::registerTypes(const char *uri)
{
    // @NumbersModelPlugin
    qmlRegisterType<NumbersModel>(uri, 1, 0, "NumbersModel");
}
