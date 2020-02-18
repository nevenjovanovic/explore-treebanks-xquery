(: find longest path :)
(: for each word, count ancestors :)
(: format result as a markdown table :)
declare function local:longest($s){
  let $ancestors :=
for $w in $s//word
let $anc := count($w/ancestor::word)
return $anc
return max($ancestors)
};
let $title := "# Sentences in Gorman's collection by longest path, " || fn:current-date()
let $header := ( "Longest path | Sentence count" ,  " ---- | ---- " )
let $db := "grc-tb-g-tree"
let $long := element r {
for $s in db:open($db)//sentence
(: if we want to limit the analysis to certain word count in sentence :)
(: where count($s//word) < 10 :)
return element l { local:longest($s) }
}
let $result :=
for $l in $long/l
let $val := data($l)
group by $val
order by number($val) descending
return ( $val || " | " || count($l) )
return ( $title , $header , $result )