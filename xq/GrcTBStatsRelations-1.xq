(: get statistical data on the treebank collection: how many sentences, words, words per relations? :)

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
  return ("Words with missing or undefined annotations (relation or head): " || count($c))
};

declare function local:count-relations($db){
  let $c := collection($db)//*:word[not(@relation=("UNDEFINED", "nil", ""))]
  return ("Words with defined relations: " || count($c))
};

declare function local:count-missing-relations($db){
  let $c := collection($db)//*:word[@relation=("UNDEFINED", "nil", "")]
  return "Words with missing or undefined relations: " || count($c)
};

declare function local:relations-words($db){
   ( "# Relations (R) grouped by word count (W), in descending order" ,
"R | W" ,  
" ---- | ---- " ,
  for $s in distinct-values(collection($db)//*:word/@relation)
  let $countr := count(collection($db)//*:word[@relation=$s])
  group by $countr
  order by $countr descending
  return ( 
  string-join($s, ", ") || " | " || $countr )
)
};

let $db := "grc-tb-g"
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection, " || fn:current-date() , 
local:count-texts($db) , 
local:count-sentences($db) , 
local:count-words($db) , 
local:count-words-no-punc($db) , 
local:count-relations($db) , 
local:count-words-missing-annotation($db) ,  
local:count-missing-relations($db) , 
local:relations-words($db) )
