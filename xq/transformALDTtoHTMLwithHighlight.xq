(: transform ALDT file to HTML 5 with jQuery highlight :)
(: transform ALDT :)
(: normalize unicode to composed :)
declare option output:method "html";
declare option output:html-version "5.0";

declare function local:nfc($sequence){
  for $s in $sequence
  return normalize-unicode($s)
};

declare function local:word2span($s, $subdoc){
  for $w in $s/word
let $id := $subdoc || "-" || $w/@id/string()
let $head := $subdoc || "-" || $w/@head/string()
let $form :=  normalize-unicode($w/@form/string())
let $lemma := normalize-unicode($w/@lemma/string())
let $artificial := normalize-unicode($w/@artificial/string())
return element span { 
attribute id { $id },
attribute head { $head },
attribute data-lemma { $lemma } ,
attribute data-powertip { $lemma } ,
if ($artificial) then attribute data-artificial { $artificial } else (),
$form
}
};

declare function local:sent($db , $doc){
  for $s in db:open($db, $doc)//sentence
let $docid := $s/@document_id
let $subdocid := $s/@subdoc
let $subdoc := replace($s/@subdoc/string(), "\.", "-") || "-" || $s/@id/string()
let $words := local:word2span($s, $subdoc)
return element div {
  attribute class { "sentence"} ,
  $docid ,
  $subdocid ,
  $words
}
};

declare function local:paragroup($result) {
  for $rr in $result/div
let $docid2 := $rr/@document_id
let $subdocgroup := $rr/@subdoc
group by $subdocgroup
return element div { 
attribute class { "para" },
attribute document_id {  distinct-values($docid2) },
$rr }
};

(: make HTML with jQuery :)
declare function local:htmlframe($sourcetitle , $result){
<html>
<head>
<title>Prosa Graeca syntactice annotata: { $sourcetitle }</title>
<meta charset="UTF-8"/>
<link href="https://fonts.googleapis.com/css?family=EB+Garamond:400,400i,800,800i&amp;subset=greek,greek-ext,latin-ext" rel="stylesheet"/>
<style>
 { local:cssrules() }
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js">&amp;</script>
<link rel="stylesheet" type="text/css" href="css/jquery.powertip-yellow.css" />
</head>
<body>
<div class="titulus">
      <p>Fons: { $sourcetitle }</p>
      <p>Universitas Zagrabiensis, Facultas philosophica, <a href="http://www.ffzg.unizg.hr/klafil">Institutum philologiae classicae</a>, <span id="datum"></span></p>
      <p>Editionem publici iuris fecit <a href="http://www.perseus.tufts.edu/">Persei bibliotheca digitalis</a>. Annotavit <a href="https://zenodo.org/record/3596076">Vanessa Gorman</a>, de dato 31 Decembris 2019.</p>
    </div>
<div class="legenda">
      <p class="circle">Governor</p>
      <p class="circle2">Dependent</p>
    </div>
<div class="text-grc">
{ $result }
</div>
<script type="text/javascript" src="js/jquery.powertip.js">&amp;</script>
<script>
{ local:jsscript() }
</script>
<script>
{ local:powrtip() }
</script>
<script>
{ local:currdate() }
  </script>
</body>
</html>
};

declare function local:cssrules(){
  '
.highlight {
    background: #E0E0FF;
  }
.highlight2 {
    background: #F0FFE0;
  }
span:hover {
	background-color: lemonChiffon;
}

div > span {
	display: inline-block;
}

span[data-lemma="punc1"] {
  padding-left: -0.2em;
  margin-left: -0.2em;
}

span[data-artificial]:before {
	content: "["
}

span[data-artificial]:after {
	content: "]"
}

span[data-artificial] {
	opacity: 0.5;
}

body {
	line-height: 1.2em;
	font-size: 2em;
	width: 33em;
}
html {
	padding: 3em;
	font-family: "EB Garamond",  "LinuxLibertineORegular", "AseaRegular", "Times", serif;
}

div.text-grc {
  padding-right: 5%;
  padding-left: 15%;
  text-align: justify;
}

div.sentence:first-child:before {
	content:attr(subdoc);
	color: green;
	}

div.sentence {
	display: contents;
}

div.para:before {
	content:attr(document_id);
	color: navy;
	font-size: 0.5em;
	}

div.para {
	display: block;
}

div.legenda {
	float: left;
	position:fixed;
}

div.titulus {
	font-size: 0.7em;
	line-height: 1em;
}

.circle{
	text-align: center;
     background-color: #E0E0FF;
     font-size: 0.75em;
  }
.circle2{
	text-align: center;
     background-color: #F0FFE0;
     font-size: 0.75em;
  }

'
};

declare function local:jsscript(){
  '
// toggle class "highlight" on "head" of selected element (by value of "id")
	function selectHead($strNewString){
	$("#" + $strNewString ).toggleClass( "highlight" );
}

function selectChild($strNewString){
	$("span[head=\"" + $strNewString + "\"]" ).toggleClass( "highlight2" );
	}
	
// on hover, call function to select head (by value of "head" element) and highlight it		
  $("span").hover(function(){
    var $strNewString = $(this).attr("head");
	selectHead($strNewString);
  });
  
  $("span").hover(function(){
    var $strNewString = $(this).attr("id");
	selectChild($strNewString);
  });
  '
};

declare function local:currdate(){
  '
  // format current date and add it to the element with the id "datum"
var d=new Date();
var dat=d.getDate();
var menses=["Januarii","Februarii","Martis","Aprilis","Maii","Junii","Julii", "Augusti","Septembris","Octobris","Novembris","Decembris"];
var year=d.getFullYear();
var todayDate = "de dato "+dat+" "+menses[d.getMonth()]+" "+year + ".";
$("#datum").text(todayDate);
  '
};

declare function local:powrtip(){
  '
$("span").powerTip({
mouseOnToPopup: true,
smartPlacement: true
}
);

  '
};

let $db := "grc-tb-g"
(: let $doc := "xen hell 1_1-4 bu2.xml" :)
(: let $doc := "Aeschines 1 51-100 bu1.xml" :)
(: let $doc := "josephus BJ 1.11-15 bu1.xml" :)
let $doc := "Aristotle Politics book 2 bu2.xml"
let $result := element res {
local:sent($db, $doc)
}
return local:htmlframe($doc , local:paragroup($result))