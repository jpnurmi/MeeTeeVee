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
import QtQuick 1.1

CommonPage {
    id: root

    property string title
    property string subtitle
    property alias model: listView.model

    empty: listView.count <= 0
    busy: model.busy && empty
    placeholder: busy ? qsTr("Loading...") : empty ? qsTr("No episodes") : ""

    header: Header {
        title: root.title
    }

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Separator {
            title: qsTr("Season %1").arg(root.model.season)
        }

        delegate: EpisodeDelegate {
            id: delegate
            property string seasonNumber: root.model.season < 10 ? "0" + root.model.season : root.model.season
            property string episodeNumber: episode < 10 ? "0" + episode : episode
            title: qsTr("%1: %2").arg(seasonNumber + "x" + episodeNumber).arg(name)
            subtitle: model.airdate
            rating: model.rating
            hasSummary: model.summary != ""
            hasScreencap: model.screencap != ""
            enabled: hasSummary || hasScreencap
            onClicked: {
                var page = episodePage.createObject(root, {title: delegate.title, summary: model.summary, screencap: model.screencap});
                pageStack.push(page);
                // TODO: root.showed(showid);
            }
        }
    }

    Component {
        id: episodePage
        EpisodePage { }
    }
}
