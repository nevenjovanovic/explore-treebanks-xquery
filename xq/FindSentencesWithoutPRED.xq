declare function local:tr($sentence){
  element s {
  for $w in $sentence//word
  order by $w/@id
  return normalize-unicode($w/@form/string())
}
};

let $db := "grc-tb-g"
let $sentences := collection($db)/*:treebank/sentence
let $scount := count($sentences)
let $nopredicate :=
for $s in $sentences
where not($s/word[@relation=("PRED", "PNOM", "PRED_CO", "PRED_AP")])
return $s
let $nopredcount := count($nopredicate)
return ( $nopredcount || " of " || $scount || "; " || ( round($nopredcount div $scount * 1000) div 10 ) || "%" )