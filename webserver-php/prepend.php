<?php
_x_echoHttpCacheHeader(-1);
function _x_echoHttpCacheHeader($seconds) {
	$seconds = (int) $seconds;
	if($seconds <=0){
		header('Cache-Control: no-cache, no-store');
		header('Pragma: no-cache'); 
		header("Expires: Mon, 26 Jul 1979 05:00:00 GMT");
	}else{
		header("Cache-Control: public, max-age={$seconds}, s-max-age={$seconds}");
		header('Pragma: '); 
		header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT' );
		header("Expires: " .gmdate ('D, d M Y H:i:s', time() + $seconds ). ' GMT');
		
	}

}

