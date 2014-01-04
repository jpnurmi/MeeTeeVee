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
import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    id: page

    property string title
    property alias model: listView.model

    SilicaListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: PageHeader { title: page.title }

        ViewPlaceholder {
            enabled: !listView.count
            text: model.busy ? qsTr("Loading...") : qsTr("No episodes")
        }

        delegate: EpisodeDelegate {
            id: delegate
            property string seasonNumber: page.model.season < 10 ? "0" + page.model.season : page.model.season
            property string episodeNumber: model.episode < 10 ? "0" + model.episode : model.episode
            badge: qsTr("%1x%2").arg(seasonNumber).arg(episodeNumber)
            title: model.name
            subtitle: model.airdate && model.airdate != "0000-00-00" ? model.airdate : qsTr("No date")
            rating: model.rating
            hasSummary: model.summary !== ""
            hasScreencap: model.screencap !== ""
            onClicked: pageStack.push(episodePage, {title: page.title, subtitle: qsTr("%1: %2").arg(badge).arg(delegate.title), summary: model.summary, screencap: model.screencap, link: model.link})
        }
    }

    Component {
        id: episodePage
        EpisodePage { }
    }
}
