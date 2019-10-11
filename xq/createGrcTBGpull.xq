(: run this file if you don't clone VG's repository :)
(: create empty database to which we will add documents from Git :)
(: afterwards, run populateGrcTBGfromGit.xq :)
 db:create("grc-tb-g-pull", (), (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })