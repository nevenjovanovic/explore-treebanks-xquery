(: normalize unicode to composed :)
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
return element span { 
attribute id { $id },
attribute head { $head },
attribute data-lemma { $lemma } ,
attribute data-powertip { $lemma } ,
$form
}
};

declare function local:sent($db , $doc){
  for $s in db:open($db, $doc)//sentence
let $docid := $s/@document_id
let $subdocid := $s/@subdoc
let $subdoc := $s/@subdoc/string() || "-" || $s/@id/string()
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

let $db := "grc-tb-g"
let $doc := "Aeschines 1 51-100 bu1.xml"
let $result := element res {
local:sent($db, $doc)
}
return local:paragroup($result)