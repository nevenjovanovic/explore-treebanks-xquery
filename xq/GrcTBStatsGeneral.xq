(: get some general statistical data on the treebank collection: how many sentences, words, words per sentence, relations, POS, max heads? :)

declare function local:count-texts($db){
  let $s := collection($db)//*:treebank
  return ("Texts (documents): " || count($s))
};

declare function local:count-sentences($db){
  let $s := collection($db)//*:sentence
  return ("Sentences: " || count($s))
};

declare function local:count-words($db){
  let $c := collection($db)//*:word
  return ("Words: " || count($c))
};

declare function local:count-words-no-punc($db){
  let $c := collection($db)//*:word[not(starts-with(@lemma, "punc"))]
  return ("Words excluding punctuation marks: " || count($c))
};

declare function local:count-words-missing-annotation($db){
  let $c := collection($db)//*:word[@relation=("UNDEFINED", "nil", "") or @head=""]
  return ("Words with missing or undefined annotations: " || count($c))
};

declare function local:count-ellipses($db){
  let $c := collection($db)//*:word[@artificial]
  return ("Ellipses (words originally omitted, added for analysis): " || count($c))
};

declare function local:sentence-words($db){
  let $s := collection($db)//*:sentence
  for $ss in $s
  let $ww := count($ss/*:word)
  group by $ww
  order by $ww descending
  return ( count($ss) || " | " || $ww )
};

let $db := "grc-tb-g"
return ( "# Statistics on Vanessa Gorman's Greek treebank collection, " || fn:current-date() , local:count-texts($db) , local:count-sentences($db) , local:count-words($db) , local:count-words-no-punc($db) , local:count-ellipses($db) , local:count-words-missing-annotation($db) , "# Sentences (S) grouped by word count (W), in descending order" ,"S | W" ,  " ---- | ---- " ,  local:sentence-words($db) )
