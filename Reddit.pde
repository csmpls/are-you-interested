public class Reddit {
  
  int curr_time = 0;
  ArrayList all_articles = new ArrayList();
  int curr = 0; //current article index
  Article currentArticle; // current title;
  

  Reddit() {
    all_articles = downloadRedditFrontpage();
    cueRedditData();
  }

  ArrayList downloadRedditFrontpage() {
    ArrayList ar = new ArrayList();
    org.json.JSONArray reddits = getRedditJSON();
    
    if (!(reddits == null)) {
      for(int i = 0; i < reddits.length(); i++) {
        Article a = new Article();
        try {
          a = getArticleFromJSONObject(reddits.getJSONObject(i));
        } catch (Exception e) {} 
        ar.add(a);
      }
    println("okay, all articles downloaded and stored.");
    } else  println("there were no articles?..."); 
    return ar;  
  }
  
  Article getArticleFromJSONObject(org.json.JSONObject entry1) {
    String title = "ERROR?";
    String url = "leekspin.com";
    String img = "";
    String subreddit = "";
     
    try {
      
        org.json.JSONObject entry2 = entry1.getJSONObject("data");
        title = entry2.getString("title");
        url = entry2.getString("url");
        img = entry2.getString("media_embed");
        subreddit = entry2.getString("subreddit");
        
      } catch (Exception e) { println("i couldnt create the article classes."); }
      
      Article a = new Article(title, url, img, subreddit);
      return a; 
  }
  
  org.json.JSONArray getRedditJSON() {
    String response = join(loadStrings(BASE_URL),"");
    
    if (response!=null) {
      try{
        
        org.json.JSONObject root = new org.json.JSONObject(response);
        org.json.JSONObject data = root.getJSONObject("data");
        org.json.JSONArray children = data.getJSONArray("children");
        println("json retrieved from reddit..");
        return children;
        
      } catch (Exception e) { println("error parsing json"); }
    }
    org.json.JSONArray c = new org.json.JSONArray();
    return c;
  }
  
  void advance() {
    if (curr == all_articles.size()) curr = 0;
    else curr++;
    cueRedditData();
    curr_time = millis();
  }
  
  void back() {
    if (curr > 0) curr--;
    cueRedditData();
  }

  void cueRedditData() {
    Article c = (Article)all_articles.get(curr);
    currentArticle = c;
  }
}

public class Article {
  
  public String title;
  public String url;
  public String img;
  public String subreddit;
  
  Article(String s, String u, String i, String sr) {
    title = s;
    url = u;
    img = i;
    subreddit = sr;
  }
  
  Article () {
    title = "error!!";
  }
  
}
