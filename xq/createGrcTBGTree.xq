(: create empty database to which we will add trees transformed from grc-tb-g db :)
(: afterwards, run ListToTree.xq :)
 db:create("grc-tb-g-tree", (), (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })