let $db := "grc-tb-g"
let $sentences := collection($db)/*:treebank/sentence
let $scount := count($sentences)
let $predicatewords := $sentences/word[@relation=("PRED", "PNOM", "PRED_CO", "PRED_AP")]
let $countpredwords := count($predicatewords)
let $predicates := 
for $w in $predicatewords
let $postag := substring($w/@postag, 1, 2)
group by $postag
order by $postag
return ( $postag || " | " || count($w) || " | " || round(count($w) div $countpredwords * 100) || "%" )
return $predicates