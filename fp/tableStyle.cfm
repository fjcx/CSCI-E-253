<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">
	
	// nav: i am here ###
	$(document).ready(function(){
		var mybodyid = $('body').attr('id');
		var mynavid = '#nav' + mybodyid;
		/* e.g. for showsources.cfm:
		  mybodyid is 'part1'
		  mynavid  is '#navpart1'
		*/
		var cssid = 'iamhere' + mybodyid;
		$(mynavid).attr('id',cssid);
	});
	
	$(document).ready(function(){ 
		$("table.tablesorter")
		.tablesorter({widthFixed: true, widgets: ['zebra']}) 
		.tablesorterPager({container: $("#pager")}); 
	}); 
</script>