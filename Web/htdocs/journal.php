<?php

$CgiHost="127.0.0.1";
$CgiPath="/cgi-bin/EJ.exe";
$port="80";

$Login = isset($_POST["Login"]) ? $_POST["Login"]:'';
$LoginUrl = urlencode($Login);
$Task = $_POST["Task"];
if ($Login !="")
	$Pass = $_POST["Password"];
else
	$Pass= "";

$PassUrl = urlencode($Pass);
$TempUserId = isset($_POST["TempUserId"]) ? $_POST["TempUserId"]:'';
$TempUserIdUrl = urlencode($TempUserId);
$Week = $_POST["Week"];
$WeekUrl = urlencode($Week);
$PrevWeek = intval($Week)-1;
$NextWeek = intval($Week)+1;

echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">';
echo '<html lang="ru">';
echo '<head>';
echo '<meta http-equiv=Content-Type content="text/html;charset=utf-8">';
echo '<title>';
echo 'Дневник учащегося';
echo '</title>';
echo '</head>';
echo '<body>';

$param="";

if ($Login != "")
	$param="Login=$LoginUrl&Password=$PassUrl";
else if ($TempUserId != "")
	$param="TempUserId=$TempUserId";

if ($Task=="Book")
	$param = $param."&Task=Book&Week=$WeekUrl";
if ($Task=="FinalMarks")
	$param = $param."&Task=FinalMarks";
if ($Task=="YearMarks")
	$param = $param."&Task=YearMarks";
if ($Task=="Rating")
	$param = $param."&Task=Rating&Week=$WeekUrl";
if ($Task=="Notes")
	$param = $param."&Task=Notes&Week=$WeekUrl";

$data = $param; //тут твои параметры
$packet="POST ".$CgiPath." HTTP/1.0\r\n";
$packet.="Host: localhost\r\n";
$packet.="Content-Length: ".strlen($data)."\r\n";
$packet.="Referer: http://localhost\r\n"; 
$packet.="Content-Type: application/x-www-form-urlencoded\r\n";
$packet.="Connection: keep-alive\r\n";
$packet.="Cache-Control: no-cache\r\n\r\n";
$packet.=$data."\r\n\r\n";

if ($param!="")
{
	$ock=fsockopen(gethostbyname($CgiHost),$port);
	fputs($ock,$packet);
	$contents="";
	      while (!feof($ock))
	       {
	       $contents.=fgets($ock);
	       }
	fclose($ock);
}

$contents = strstr($contents,"<?xml");


$xml = new DOMDocument();
$xml->loadXML($contents);

$SourceNode = $xml->getElementsByTagName('source')->Item(0);
$StatusNode = $SourceNode->getElementsByTagName('status')->Item(0);
$Success = $StatusNode->getAttribute('success');
$Error = $StatusNode->getAttribute('error');

$LoginNode = $SourceNode->getElementsByTagName('login');
$LoginNode= $LoginNode->Item(0);

$TempUserIdW='';

if (isset($LoginNode))
{

	$TempUserIdW = $LoginNode->getAttribute('user_temp_id');

	if ($TempUserIdW != "")
		$TempUserId = $TempUserIdW;
}
                                      	
if ($Success=="true")
{
	$LoginNode = $SourceNode->getElementsByTagName('login')->Item(0);
	$TempUserIdW = $LoginNode->getAttribute('user_temp_id');

	if ($TempUserIdW != "")
		$TempUserId = $TempUserIdW;
	

	$xsl = new DOMDocument();

	if ($Task=="Book")
		$xsl->load("book.xsl");
	if ($Task=="FinalMarks")
		$xsl->load("final_marks.xsl");
	if ($Task=="YearMarks")
		$xsl->load("year_marks.xsl");
	if ($Task=="Rating")
		$xsl->load("rating.xsl");
	if ($Task=="Notes")
		$xsl->load("notes.xsl");

	$processor = new XSLTProcessor();
	$processor->importStylesheet($xsl);
	$html = $processor->transformToXml($xml);
}
else
{
	$html=$Error;
}

echo '<style type="text/css"><!--
.inp.lbl { font-family: Arial, Helvetica, sans-serif; font-size: smaller; }
.inp.val { font-family: Arial, Helvetica, sans-serif; font-size: smaller; }
table.bt1 {
  border-width: 2px 2px 2px 2px;
  border-spacing: 1px;
  border-style: solid solid solid solid;
  border-color: gray gray gray gray;
  border-collapse: collapse;
}
table.bt1 td {
  border-color: gray gray gray gray;
  border-width: 1px 1px 1px 1px;
  padding: 1px 3px 1px 3px;
  border-style: solid solid solid solid;
}
.title{
	position:relative;
	z-index:1;
	zoom:1;
	color:#06F;
}
.title em{display:none;}
.title:hover em{
	display:block;
	position:absolute;
	z-index:1;
 	background-color:#FFF;
 	-webkit-border-radius:5px; /* красивости в виде скругленных углов */
 	-moz-border-radius:5px;
 	border-radius:5px;
	line-height:normal;
	color:#000;
	text-decoration:none;
	padding:3px 5px;
	bottom:22px;
	right:0;
	-webkit-box-shadow:0 0 5px #000; /* красивости в виде тени */
	-moz-box-shadow:0 0 5px #000;
	box-shadow:0 0 5px #000;
}
.title:hover em i{
	position:absolute;
	z-index:1;
	bottom:-7px;
	right:5px;
	border-top:7px solid #FFF;
	border-left:7px solid transparent;
	_border-left:7px solid #FDEFC6; /* цвет фона. это для ие6.*/
	display:block;
	height:0;
	overflow:hidden;
}
--></style>
';

echo '<TABLE cellspacing=0 align=center><tr>';


if ($Task!="Book")
{
	echo '<td>';
	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=hidden Name="Week" value="'.$Week.'">';
	echo '<input type=hidden Name="Task" value="Book">';
	echo '<input type=submit VALUE="Дневник">';
	echo '</FORM>';

	echo '</td>';

}

if ($Task!="FinalMarks")
{
	echo '<td>';
	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=Hidden Name="Week" value="'.$Week.'">';
	echo '<input type=hidden Name="Task" value="FinalMarks">';
	echo '<input type=submit VALUE="Итоговые оценки">';
	echo '</FORM>';

	echo '</td>';
}
if ($Task!="YearMarks")
{
	echo '<td>';
	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=Hidden Name="Week" value="'.$Week.'">';
	echo '<input type=hidden Name="Task" value="YearMarks">';
	echo '<input type=submit VALUE="Оценки за год">';
	echo '</FORM>';

	echo '</td>';
}

if ($Task!="Rating")
{
	echo '<td>';

	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=Hidden Name="Week" value="'.$Week.'">';
	echo '<input type=hidden Name="Task" value="Rating">';
	echo '<input type=submit VALUE="Мониторинг успеваемости">';
	echo '</FORM>';

	echo '</td>';
}

if ($Task!="Notes")
{
	echo '<td>';

	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=Hidden Name="Week" value="'.$Week.'">';
	echo '<input type=hidden Name="Task" value="Notes">';
	echo '<input type=submit VALUE="Записи в дневник">';
	echo '</FORM>';

	echo '</td>';
}

echo '<td>';
echo '<form action="index.html" method=POST>';
echo '<input type=hidden Name="Login" value="'.$Login.'">';
echo '<input type=submit VALUE="Выйти">';
echo '</FORM>';
echo '</td></tr></table>';

if ($Task=="Book")
{
	echo '<TABLE cellspacing=0 align=center><tr>';

	echo '<td>';
	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=hidden Name="Week" value="'.$PrevWeek.'">';
	echo '<input type=hidden Name="Task" value="Book">';
	echo '<input type=submit VALUE="Предыдущая неделя">';
	echo '</FORM>';

	echo '</td><td>';

	echo '<form action="journal.php" method=POST>';
	echo '<input type=hidden Name="TempUserId" value="'.$TempUserId.'">';
	echo '<input type=Hidden Name="Week" value="'.$NextWeek.'">';
	echo '<input type=hidden Name="Task" value="Book">';
	echo '<input type=submit VALUE="Следующая неделя">';
	echo '</FORM>';

	echo '</td>';

	echo '</tr></table>';
}

echo $html;
echo '</body>';
echo '</html>';

?>