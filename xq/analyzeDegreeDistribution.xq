(: in a sentence, calculate degrees for each word :)
(: degree distribution -- what percentage of words in sentence has each degree :)
(: calculate for all sentences in the collection :)
declare function local:degreedist($degrees){
  let $total := count($degrees/d)
let $calc := element s {
for $d in $degrees/d
let $dd := $d/string()
group by $dd
return element row { element degree { $dd } , element degd { count($d) div $total } }
}
return $calc
};
let $db := "grc-tb-g-tree"
for $s in db:open($db)//sentence
let $wdegree := element s {
for $w in $s//word
let $degree := count($w/word)
return element d { $degree }
}
return local:degreedist($wdegree)