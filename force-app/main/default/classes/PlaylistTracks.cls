public with sharing class PlaylistTracks {
    public String href;
    public List<Item> items;
    public Integer total;
    public String next;

    public PlaylistTracks(String href, List<Item> items, Integer total, String next) {
        this.href = href;
        this.items = items;
        this.total = total;
        this.next = next;
    }

    public class Item {
        public Boolean is_local;
        public Track track;
    }
}