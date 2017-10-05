<html>
<head>
 <title>
  XML form
 </title>
</head>
<body>
<?php
if(isset($_REQUEST['ok'])){
	$xml = new DOMDocument("1.0","UTF-8");
	$xml->load("test.xml");
	
	$rootTag = $xml->getElementByTagName("document")->item(0);
	
	$dataTag = $xml->createElement("date");
	
	$aTag = $xml->createElement("a",$_REQUEST['a']);
	$bTag = $xml->createElement("b",$_REQUEST['b']);
	
	$dateTag -> appendChild($aTag);
	$dateTag -> appendChild($bTag);
	
	$rootTag -> appendChild($dataTag);
	
	$xml->save("test.xml");
}
?>

 <form action="a.php" method="post">
<input type = "text" name="a"/>
<input type = "text" name="b"/>
<input type = "submit" name="ok" />
 </form>
 
</body>
</html>