require 'spec_helper'

describe Yobot::Behaviors::Xkcd do
  
  it "has a description" do
    Yobot::Behaviors::Xkcd.new.describe.length > 0
  end
  
  
  it "writes latest image url if prompted with xkcd" do
    room = stub(:room)
    
    room.should_receive(:text).with('http://imgs.xkcd.com/comics/tween_bromance.png')
    room.should_receive(:text).with('Verbiage. Va-jay-jay. Irregardless.')
    
    Yobot::Behaviors::Xkcd.new.react(room, 'xkcd')
  end
  
  it "writes latest image url if prompted with xkcd find ballmer" do
    room = stub(:room)

    xkcd = Yobot::Behaviors::Xkcd.new
    xkcd.should_receive(:fetch_comic).with(room, '323')
    
    xkcd.react(room, 'xkcd find ballmer')
  end
  
  it "does nothing if message doesn't start with xkcd" do
    room = stub(:room)
    
    room.should_not_receive(:text)
    
    Yobot::Behaviors::Xkcd.new.react(room, 'peng')
  end
  

  class Yobot::Behaviors::Xkcd
    def fetch_comic(room, id=nil)
      parse_comic(room, html_comic)
    end
    
    def get_search_html(search_word)
      <<SEARCHHTML
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
              "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>

      	<title>Unofficial XKCD Search - Quick Comic Searcher</title>

      	<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />

      	<script src="js/prototype.js" type="text/javascript"></script>
      	<script src="js/scriptaculous.js?load=effects,builder" type="text/javascript"></script>
      	<script src="js/lightbox.js" type="text/javascript"></script>

      	<style type="text/css">
      		body{ color: #333; font: 13px 'Lucida Grande', Verdana, sans-serif;	}
      	</style>

      </head>
      <body>

      <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-86859-16']);
        _gaq.push(['_trackPageview']);

        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
        })();

      </script>

      <div style="float:right">
      <script type="text/javascript"><!--
      google_ad_client = "pub-2595687861356859";
      /* derp.co.uk/xkcd */
      google_ad_slot = "1560625525";
      google_ad_width = 468;
      google_ad_height = 60;
      //-->
      </script>
      <script type="text/javascript"
      src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
      </script>
      </div>

      <h2 style="margin-bottom:5px;">XKCD Search</h2>
      <div style="padding-bottom:5px; border-bottom: 1px solid #CCC;">
      <b style="color: #555;">View Mode:</b>
      <a href="gallery" style="color:blue;"><b>Gallery Mode</b></a> | <b>Standard Mode</b><br />
      </div>

      <small>Unofficial <a href="http://www.xkcd.com/">XKCD WebComic</a> Search. All the WebComics from the <a href="http://www.xkcd.com/">incredibly awesome XKCD.com</a></small>.


      <br style="clear:right;">

      	<table cellpadding=20 border=0>
      	<tr><td nowrap align="center">
                      <form method="GET" action="/xkcd/page">
      		<input type="text" name="q" value="ballmer">
      		<input type="submit" name="search" value="Search">
      		</form>
      	</td><td align="center">
      	</td></tr>

      	</table>
      0 results found, showing 10 results from page 0:<br><br>

      	<table>


      	<tr>
      		<td><a href="comics/ballmer_peak.png" rel="lightbox[xkcd]" title="Ballmer Peak - Apple uses automated schnapps IVs."><img src="thumb.php?fn=ballmer_peak.png"></a></td>
      		<td><b>Ballmer Peak</b><br>Apple uses automated schnapps IVs.<br>
      			<a target="_blank" href="http://www.xkcd.com/323/">http://www.xkcd.com/323/</a></td>

      	</tr>		
              <table cellpadding=20 border=0>
              <tr><td nowrap align="center">
                      <form method="GET" action="/xkcd/page">
                      <input type="text" name="q" value="ballmer">
                      <input type="submit" name="search" value="Search">
                      </form>
              </td><td align="center">
              </td></tr>

              </table>
      </table>
      <br />
      <div align="center">
      <small>All the comics shown 
      are by the incredibly awesome <a href="http://www.xkcd.com/"><b>XKCD.com</b></a>
      who licences <a href="http://creativecommons.org/licenses/by-nc/2.5/">
      under a Creative Commons Attribution-NonCommercial 2.5 License</a> which nicely allows us to do this :)
      <br />
      Search system thrown together by <a href="http://www.frag.co.uk/">frag.co.uk</a> using <a href="http://www.mysql.com/">MySQL</a>, <a href="http://www.gentoo.org/">Gentoo</a> and a struggling <a href="http://www.kimsufi.co.uk/">Kimsufi Box</a>.<br />

      <a href="/">Have you seen our pastebin/imagebin?</a></small>
      </div>
      </body>
      </html>
SEARCHHTML
    end

    def html_comic
    <<DUDE
    <?xml version="1.0" encoding="utf-8" ?>
    <?xml-stylesheet href="http://imgs.xkcd.com/s/c40a9f8.css" type="text/css" media="screen" ?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
     <head>
      <title>xkcd: Tween Bromance</title>
      <link rel="stylesheet" type="text/css" href="http://imgs.xkcd.com/s/c40a9f8.css" media="screen" title="Default" />
      <!--[if IE]><link rel="stylesheet" type="text/css" href="http://imgs.xkcd.com/s/ecbbecc.css" media="screen" title="Default" /><![endif]-->
      <link rel="alternate" type="application/atom+xml" title="Atom 1.0" href="/atom.xml" />
      <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="/rss.xml" />

      <link rel="icon" href="http://imgs.xkcd.com/s/919f273.ico" type="image/x-icon" />
      <link rel="shortcut icon" href="http://imgs.xkcd.com/s/919f273.ico" type="image/x-icon" />
     </head>
     <body>
      <div id="container">
       <div id="topContainer">
        <div id="topLeft" class="dialog">
         <div class="hd"><div class="c"></div></div>
         <div class="bd">

          <div class="c">
           <div class="s">
    	<ul>
             <li><a href="/archive/">Archive</a><br /></li>
    	 <li><a href="http://blag.xkcd.com/">News/Blag</a><br /></li>
             <li><a href="http://store.xkcd.com/">Store</a><br /></li>
             <li><a href="/about/">About</a><br /></li>

            </ul>
           </div>
          </div>
         </div>
         <div class="ft"><div class="c"></div></div>
        </div>
        <div id="topRight" class="dialog">
         <div class="hd"><div class="c"></div></div>
         <div class="bd">

          <div class="c">
           <div class="s">
            <div id="topRightContainer">
             <div id="logo">
              <a href="/"><img src="http://imgs.xkcd.com/s/9be30a7.png" alt="xkcd.com logo" height="83" width="185"/></a>
              <h2><br />A webcomic of romance,<br/> sarcasm, math, and language.</h2>
              <div class="clearleft"></div>

              <br />
    New blog post: <a href="http://blog.xkcd.com/2011/06/30/family-illness/">Family Illness</a>

             </div>
            </div>
           </div>
          </div>
         </div>
         <div class="ft"><div class="c"></div></div>

        </div>
       </div>
       <div id="contentContainer">
        <div id="middleContent" class="dialog">
         <div class="hd"><div class="c"></div></div>
         <div class="bd">
          <div class="c">
           <div class="s">

    <h1>Tween Bromance</h1><br/>
    <br />
    <div class="menuCont">
     <ul>
      <li><a href="/1/">|&lt;</a></li>
      <li><a href="/918/" accesskey="p">&lt; Prev</a></li>
      <li><a href="http://dynamic.xkcd.com/random/comic/" id="rnd_btn_t">Random</a></li>
      <li><a href="#" accesskey="n">Next &gt;</a></li>

      <li><a href="/">&gt;|</a></li>
     </ul>
    </div>
    <br/>
    <br/>
    <img src="http://imgs.xkcd.com/comics/tween_bromance.png" title="Verbiage. Va-jay-jay. Irregardless." alt="Tween Bromance" /><br/>
    <br/>
    <div class="menuCont">
     <ul>
      <li><a href="/1/">|&lt;</a></li>
      <li><a href="/918/" accesskey="p">&lt; Prev</a></li>

      <li><a href="http://dynamic.xkcd.com/random/comic/" id="rnd_btn_b">Random</a></li>
      <li><a href="#" accesskey="n">Next &gt;</a></li>
      <li><a href="/">&gt;|</a></li>
     </ul>
    </div>
    <h3>Permanent link to this comic: http://xkcd.com/919/</h3>
    <h3>Image URL (for hotlinking/embedding): http://imgs.xkcd.com/comics/tween_bromance.png</h3>

    <div id="transcript" style="display: none"></div>

          </div>
         </div>
        </div>
        <div class="ft"><div class="c"></div></div>
       </div>
       <div id="middleFooter" class="dialog">
        <div class="hd"><div class="c"></div></div>
        <div class="bd">

         <div class="c">
          <div class="s">
           <img src="http://imgs.xkcd.com/s/a899e84.jpg" width="520" height="100" alt="Selected Comics" usemap="#comicmap" />
           <map name="comicmap">
            <area shape="rect" coords="0,0,100,100" href="/150/" alt="Grownups" />
            <area shape="rect" coords="104,0,204,100" href="/730/" alt="Circuit Diagram" />
            <area shape="rect" coords="208,0,308,100" href="/162/" alt="Angular Momentum" />
            <area shape="rect" coords="312,0,412,100" href="/688/" alt="Self-Description" />
            <area shape="rect" coords="416,0,520,100" href="/556/" alt="Alternative Energy Revolution" />

           </map><br/><br />

    Search comic titles and transcripts:<br />
    <script type="text/javascript" src="//www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('search', '1');
      google.setOnLoadCallback(function() {
        google.search.CustomSearchControl.attachAutoCompletion(
          '012652707207066138651:zudjtuwe28q',
          document.getElementById('q'),
          'cse-search-box');
      });
    </script>
    <form action="//www.google.com/cse" id="cse-search-box">
      <div>
        <input type="hidden" name="cx" value="012652707207066138651:zudjtuwe28q" />
        <input type="hidden" name="ie" value="UTF-8" />
        <input type="text" name="q" id="q" autocomplete="off" size="31" />

        <input type="submit" name="sa" value="Search" />
      </div>
    </form>
    <script type="text/javascript" src="//www.google.com/cse/brand?form=cse-search-box&lang=en"></script>

    <a href="/rss.xml">RSS Feed</a> - <a href="/atom.xml">Atom Feed</a>
    <br />
           <br/>

           <div id="comicLinks">
            Comics I enjoy:<br/>
            <a href="http://www.qwantz.com">Dinosaur Comics</a>,
            <a href="http://www.asofterworld.com">A Softer World</a>,
            <a href="http://pbfcomics.com/">Perry Bible Fellowship</a>,
            <a href="http://www.boltcity.com/copper/">Copper</a>,
            <a href="http://questionablecontent.net/">Questionable Content</a>,
            <a href="http://achewood.com/">Achewood</a>,
            <a href="http://wondermark.com/">Wondermark</a>,
            <a href="http://thisisindexed.com/">Indexed</a>,
            <a href="http://www.buttercupfestival.com/buttercupfestival.htm">Buttercup Festival</a>

           </div>


           <br/>
           Warning: this comic occasionally contains strong language (which may be unsuitable for children), unusual humor (which may be unsuitable for adults), and advanced mathematics (which may be unsuitable for liberal-arts majors).<br/>
           <br/>
           <h4>We did not invent the algorithm.  The algorithm consistently finds Jesus.  The algorithm killed Jeeves. <br />The algorithm is banned in China.  The algorithm is from Jersey. The algorithm constantly finds Jesus.<br />This is not the algorithm.  This is close.</h4><br/>
           <div class="line"></div>

            <br/>
            <div id="licenseText">
             <!-- <a rel="license" href="http://creativecommons.org/licenses/by-nc/2.5/"><img alt="Creative Commons License" style="border:none" src="http://imgs.xkcd.com/static/somerights20.png" /></a><br/> -->
             This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/2.5/">Creative Commons Attribution-NonCommercial 2.5 License</a>.
    <!-- <rdf:RDF xmlns="http://web.resource.org/cc/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><Work rdf:about=""><dc:creator>Randall Munroe</dc:creator><dcterms:rightsHolder>Randall Munroe</dcterms:rightsHolder><dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:source rdf:resource="http://www.xkcd.com/"/><license rdf:resource="http://creativecommons.org/licenses/by-nc/2.5/" /></Work><License rdf:about="http://creativecommons.org/licenses/by-nc/2.5/"><permits rdf:resource="http://web.resource.org/cc/Reproduction" /><permits rdf:resource="http://web.resource.org/cc/Distribution" /><requires rdf:resource="http://web.resource.org/cc/Notice" /><requires rdf:resource="http://web.resource.org/cc/Attribution" /><prohibits rdf:resource="http://web.resource.org/cc/CommercialUse" /><permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" /></License></rdf:RDF> -->
             <br/>
             This means you're free to copy and share these comics (but not to sell them). <a href="/license.html">More details</a>.<br/>

            </div>
           </div>
          </div>
         </div>
         <div class="ft"><div class="c"></div></div>
        </div>
       </div>
      </div>
     </body>

    </html>
DUDE
    end
  end
end
