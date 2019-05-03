public with sharing class SpotifyPlaylists {
    public String href;
    public List<Items> items;
    public String next; 
    public Integer total;
    public Integer offset;

    public SpotifyPlaylists(String href, List<Items> items, String next, Integer total, Integer offset){
        this.href = href;
        this.items = items;
        this.next = next;
        this.total = total;
        this.offset = offset;
    }

    public class Items{
        public Boolean collaborative;
        public String href;
        public String id;
        public String name;
        public Tracks tracks;
    }

    public class Tracks{
        public String href;
        public Integer total;
    }
}