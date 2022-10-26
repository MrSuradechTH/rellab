<?php
	require_once 'connect_mysqli.php';
	header('Content-Type: application/json');
	if(isset($_POST['mode'])) {
		$mode = $_POST['mode'];
		if ($mode == "update") {
			if (isset($_POST['mode']) && isset($_POST['name']) && isset($_POST['temp']) && isset($_POST['humid'])) {
				$name = $_POST['name'];
				$temp = $_POST['temp'];
				$humid = $_POST['humid'];
				$query = mysqli_query($con, "UPDATE machine_data SET temp = '$temp',humid = '$humid' WHERE name = '$name'");
				$result = mysqli_affected_rows($con);
				if ($result) {
					echo '<span class = "text_rainbow">Update Success!!!</span>';
				}else {
					echo '<span class = "text_rainbow">Update Fail!!!</span>';
				}
				exit();
			}
		}else if ($mode == "monitor") {
			if (isset($_POST['name'])) {
				$name = $_POST['name'];
				$query = mysqli_query($con, "SELECT name,temp,humid FROM machine_data WHERE name = '$name'");
				$result = mysqli_fetch_array($query);
				// $time = date("d/m/Y H:i:s",strtotime('+7 hours, +543 year, -1 second'));
				$time = date("H:i:s",strtotime('+7 hours, +543 year, -1 second'));
				// $as = array("time" => $result[0], "value" => $time);
				$array = array("name" => $result[0], "temp" => number_format($result[1], 2), "humid" => number_format($result[2], 2), "time" => $time);
				echo json_encode($array, JSON_PRETTY_PRINT);
				// echo json_encode($array);
				// echo '{"name" : "'.$result[0].'","temp" : '.$result[1].',"humid" : '.$result[2].'}';
					
					
					
				/*$decode = json_decode($decode, true);
				echo $decode["name"];
				echo $decode["temp"];
				echo $decode["humid"];*/
				exit();
			}
		}
	}else {
		$query = mysqli_query($con, "SELECT name,temp,humid FROM machine_data WHERE name = 'TEMPHUMID#01'");
		$result = mysqli_fetch_array($query);
		$time = date("H:i:s",strtotime('+7 hours, +543 year, -1 second'));
		$array = array("name" => $result[0], "temp" => number_format($result[1], 2), "humid" => number_format($result[2], 2), "time" => $time);
		echo json_encode($array, JSON_PRETTY_PRINT);
		exit();
	}
?>
<html>
	<form method = "post">
		
	<form method = "post" enctype = "multipart/form-data">
</html>