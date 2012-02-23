.pragma library

var serverTime;

function initialize() {
    var timeReq = new XMLHttpRequest();
    timeReq.onreadystatechange = function() {
                if (timeReq.readyState === XMLHttpRequest.DONE) {
                    var root = timeReq.responseXML.documentElement;
                    for (var i = 0; i < root.childNodes.length; ++i) {
                        var child = root.childNodes[i];
                        if (child.nodeName === "Time") {
                            serverTime = child.firstChild.nodeValue;
                            break;
                        }
                    }
                }
            }
    timeReq.open("GET", "http://www.thetvdb.com/api/Updates.php?type=none");
    timeReq.send();
}
