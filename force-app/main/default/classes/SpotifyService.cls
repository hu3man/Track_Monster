public with sharing class SpotifyService {
    public SpotifyService() {
    }

    //Send GET request to spotify api rest resource
    public static HttpResponse getResponseFromSpotifyEndpoint(String pathToResource){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Spotify' + '/' + pathToResource);
        System.debug('Http end point set: ' + req.getEndpoint());
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res;
        try{
            res = http.send(req);
            //System.debug('Http response body: ' + res.getBody());
        }
        catch(Exception e){
            System.debug('Rest callout failed in spotify service getResponseFromEndpoint method');
            System.debug(e.getMessage());
            res = null;
        }
        return res;
    }

    //Gets a list of tracks from a particular playlist
    public static List<Track> getPlaylistTracks(String playlistId){
        //Get first paging object of playlists
        HttpResponse res;
        String path = 'playlists/' + playlistId  +'/tracks';
        res = getResponseFromSpotifyEndpoint(path);       
        if(res == null){
            System.debug('Response was null in getPlaylistTracks fuction');
            return null;
        } 

        //Get the paging object of tracks for this playlist from each pager in the series
        List<Track> returnTracks = new List<Track>();
        PlaylistTracks listOfTracks;
        while(true){
            //Parse JSON to paging object
            listOfTracks = (PlaylistTracks)JSON.deserialize(res.getBody(), PlaylistTracks.class);
            
            //Extract Track objects for result
            if(listOfTracks != null){
                for(Integer i = 0; i < listOfTracks.items.size(); i++){
                    String id = listOfTracks.items.get(i).track.id;
                    String name = listOfTracks.items.get(i).track.name;
                    String href = listOfTracks.items.get(i).track.href;
                    Integer duration_ms = listOfTracks.items.get(i).track.duration_ms;
                    List<Artist> artists = listOfTracks.items.get(i).track.artists;
                    
                    Track currentTrack = new Track();
                    currentTrack.href = href;
                    currentTrack.name = name;
                    currentTrack.id = id;
                    currentTrack.duration_ms = duration_ms;
                    currentTrack.artists = artists;
                    returnTracks.add(currentTrack);
                }
            }

            //End of series reached when next property is null - terminate loop
            if(listOfTracks.next == null){
                break;
            }

            //Get next paging object in the series
            path = getUrlSuffix(listOfTracks.next);
            res = getResponseFromSpotifyEndpoint(path);
            if(res != null){
                listOfTracks = (PlaylistTracks)JSON.deserialize(res.getBody(), PlaylistTracks.class);
            }
        }
        return returnTracks;
    }

    //Gets the current Spotify users playlists in object format
    public static List<SpotifyPlaylist> getSpotifyPlaylists(){

        //Get first paging object of playlists
        HttpResponse res;
        String path = 'me/playlists';
        res = getResponseFromSpotifyEndpoint(path);
        
        if(res == null){
            System.debug('Response was null in getSpotifyPlaylists fuction');
            return null;
        }
        
        //Spotify paginates data via paging objects, loop through and call service for subsequent data and extract playlist id's
        List<SpotifyPlaylist> returnPlaylist = new List<SpotifyPlaylist>();
        SpotifyPlaylists playlists;

        while(true){
            //Parse JSON response to playlists pagination object
            playlists = (SpotifyPlaylists)JSON.deserialize(res.getBody(), SpotifyPlaylists.class);

            //Extract playlist objects
            if(playlists != null){
                for(Integer i = 0; i < playlists.items.size(); i++){
                    SpotifyPlaylist currentPlaylist = new SpotifyPlaylist();
                    currentPlaylist.id = playlists.items.get(i).id;
                    currentPlaylist.isCollaborative = playlists.items.get(i).collaborative;
                    currentPlaylist.numTracks = playlists.items.get(i).tracks.total;
                    currentPlaylist.name = playlists.items.get(i).name;
                    returnPlaylist.add(currentPlaylist);
                }
            }

            //If the current playlist pagination object does not have a next url, it is the last page of data
            if(playlists.next == null){
                break;
            }

            //Call next pagination url
            path = getUrlSuffix(playlists.next);
            res = getResponseFromSpotifyEndpoint(path);
            if(res != null){
                playlists = (SpotifyPlaylists)JSON.deserialize(res.getBody(), SpotifyPlaylists.class);
            }
        }
        return returnPlaylist;
    }

    public static List<String> getPlaylistNames(){
        List<String> pNames = new List<String>();
        List<SpotifyPlaylist> pl = getSpotifyPlaylists();
        for(SpotifyPlaylist sp : pl){
            pNames.add(sp.name);
        }
        return pNames;
    }

    //Remove the base url from a rest resource address returning only the suffix
    public static String getUrlSuffix(String url){ 
        return url.substring(27);
    }
}