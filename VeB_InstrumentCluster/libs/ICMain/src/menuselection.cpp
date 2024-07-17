#include "include/menuSelection.h"

MenuSelection::MenuSelection(QObject *parent)
    : QObject(parent)
{}

int MenuSelection::menuIndex() const
{
    return m_menuIndex;
}

void MenuSelection::setMenuIndex(int index)
{
    m_menuIndex = index;
    emit menuIndexChanged(m_menuIndex);
}

int MenuSelection::repeaterCount() const
{
    return m_repeaterCount;
}

void MenuSelection::setRepeaterCount(int count)
{
    m_repeaterCount = count;
    emit repeaterCountChanged();
}
