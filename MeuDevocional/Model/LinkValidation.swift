//
//  LinkValidation.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 11/02/22.
//

import UIKit

///classe para validar os inputs do YouTube, Deezer, Spotify e Apple Music
class Validation {
    public func validateYoutube(name: String) ->Bool {
      // Length be 18 characters max and 3 characters minimum, you can always modify.
        let youtubeRegex = "(http(s)?:\\/\\/)?(www\\.|m\\.)?youtu(be\\.com|\\.be)(\\/watch\\?([&=a-z]{0,})(v=[\\d\\w]{1,}).+|\\/[\\d\\w]{1,})"
        let youtubeCheckResult = NSPredicate(format: "SELF MATCHES %@", youtubeRegex)
        return youtubeCheckResult.evaluate(with: name)
    }
    ///https://open.spotify.com/album/6BU9l5h76Oei7yb2lmZIDf?si=Qx0JvzDMTHKDMPSwugXHvA&dl_branch=1
    ///https://open.spotify.com/track/0fhDEhYbDjmcbuFPcwvPCH?si=6607dbc471774973
    ///https://open.spotify.com/playlist/4M2ZG2z8OlsgVd5OvWuqX7?si=739077540ddd41c9
    public func validateSpotify(name: String) ->Bool {
        if name.contains("youtube"){return true}
        else if name.contains("youtu.be"){return true}
        else if name.contains("spotify.com"){return true}
        else if name.contains("https://deezer"){return true}
        else if name.contains ("https://music.apple"){return true}
        return false
    }
}
