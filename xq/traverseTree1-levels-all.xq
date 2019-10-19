(: for a given relation, here SBJ, retrieve first node governing it (parent) 
and first node or nodes dependent on it (children) :)
(: use recursion on ALDT XML format "list" :)
(: output an ALDT fragment suitable for importing into Perseids :)
declare option output:method "xml";
declare option output:omit-xml-declaration "no";
declare function local:traverse($sentence, $id){
  for $i in $id
  let $childid := $sentence/*:word[@head=$id]/@id/string()
  return if ($childid[1]) then 
    for $c in $childid 
    return ($c , local:traverse($sentence, $c) )
  else $id
};

declare function local:fragment ($sentence, $id, $head, $sid, $docid, $subdoc, $relation) {
  element sentence { 
  $sid ,
  $docid ,
  $subdoc ,
  attribute span { "fragment-" || $relation },
    for $idset in distinct-values( 
      ($head/string() , $id/string() , distinct-values(
        local:traverse($sentence, $id)
      )
    )
)
order by xs:int($idset)
return $sentence/*:word[@id=$idset] }
};

let $db := "grc-tb-g"
let $relation := "SBJ"
let $sentences := collection($db)//*:sentence[not(*:word/@relation=("UNDEFINED", "nil") or *:word/@head="")][10]
let $result :=
for $s in $sentences return
let $sid := $s/@id
let $docid := $s/@document_id
let $subdoc := $s/@subdoc
for $word in $s/*:word[@relation=$relation]
let $id := $word/@id
let $head := $word/@head
return local:fragment($s, $id, $head, $sid, $docid, $subdoc, $relation)
return <treebank xmlns:saxon="http://saxon.sf.net/"
          xml:lang="grc"
          version="1.5"
          direction="ltr"
          format="morphgrc">
          { $result }
          </treebank>