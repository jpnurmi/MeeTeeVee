/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
#include "timezoner.h"
#include <unicode/timezone.h>

TimeZoner::TimeZoner(QObject *parent) : QObject(parent)
{
}

static UnicodeString toUString(const QString& str)
{
    return UnicodeString(static_cast<const UChar *>(str.utf16()));
}

static QString toQString(const UnicodeString& str)
{
    return QString(reinterpret_cast<const QChar *>(str.getBuffer()), str.length());
}

int TimeZoner::diff(QString time, QString tz)
{
    bool dst = false;
    if (tz.endsWith("+DST")) {
        tz.chop(4);
        dst = true;
    }
    else if (tz.endsWith("-DST")) {
        tz.chop(4);
        dst = false;
    }
    tz = tz.trimmed();

    TimeZone *source = TimeZone::createTimeZone(toUString(tz));
    TimeZone *target = TimeZone::createDefault();
    int offset = target->getRawOffset() - source->getRawOffset();
    qDebug("### %s (%d): %d", qPrintable(tz), dst, offset / 1000 / 3600);
    delete source;
    delete target;
    return offset;
}
