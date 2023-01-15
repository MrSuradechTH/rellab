<?php
	require_once 'connect_mysqli.php';
	date_default_timezone_set("Asia/Bangkok");
	// $date_dafault 
	// $date = date("d-m-Y",strtotime('+6 hours, +543 year, -1 second'));
	// echo $date;
	
	// date eng
	// $time = date("m-d-Y H:i:s");
	$time = date_create();
	$time = date_format($time,"m/d/Y H:i:s");
	// echo $time.PHP_EOL;
	
	// echo $time;
	// $time = date_create($time);
	// echo date_timestamp_get($time);
	
	// $time1 = strtotime(date_format(date_create(),"m/d/Y H:i:s"));
	// echo $time1;
	// $time2 = strtotime("01/15/2023 17:44:00");
	// $x = $time1 - $time2;
	// echo $x;
	// exit();
	
	// $time = date("H:i:s");
	// echo $time;
	// exit();
	
	
	
	
	// // date thai
	// $time = date("H:i:s",strtotime('+6 hours, +543 year, -1 second'));
	// $query = mysqli_query($con, "SELECT ADDTIME(NOW(), '198327 0:0:0'),NOW()");
	// $result = mysqli_fetch_array($query);
	// echo($result[0].PHP_EOL.$result[1].PHP_EOL);
	// exit();
	
	if(isset($_POST['mode'])) {
		header('Content-Type: application/json');
		$mode = $_POST['mode'];
		if ($mode == "update") {
			if (isset($_POST['mode']) && isset($_POST['name']) && isset($_POST['temp']) && isset($_POST['humid'])) {
				$name = $_POST['name'];
				$temp = $_POST['temp'];
				$humid = $_POST['humid'];
				
				$query = mysqli_query($con, "SELECT LOG_600 FROM machine_data WHERE name = '$name'");
				$result = mysqli_fetch_array($query);
				
				$old_array = explode("}",$result[0]);
				echo count($old_array);
				$size_max = 600 + 1;
				if (count($old_array) > $size_max) {
					// unset($old_array[count($old_array) - 1]);
					// unset($old_array[count($old_array) - 2]);
					array_splice($old_array, $size_max - 1);
				}else {
					unset($old_array[count($old_array) - 1]);
				}
				// echo count($old_array);
				$timearray = $old_array[0]."}";
				$timearray = json_decode($timearray);
				
				if ($timearray->{"time"} == $time) {
					// echo $old_array[2];
					echo '<span class = "text_rainbow">Update Fail!!!</span>';
				}else {
					$array = array("temp" => $temp, "humid" => $humid, "time" => $time);
					$json = json_encode($array, JSON_PRETTY_PRINT);
					$str = $json.",";
					// echo count($old_array);
					for ($x = 0;$x < count($old_array);$x++) {
						$str = $str.$old_array[$x]."}";
					}
					// echo count($old_array)+1;
					echo "[\n".$str."\n]";
					
					$query = mysqli_query($con, "UPDATE machine_data SET temp = '$temp',humid = '$humid',time = '$time',LOG_600 = '$str' WHERE name = '$name'");
					$result = mysqli_affected_rows($con);
					if ($result) {
						echo '<span class = "text_rainbow">Update Success!!!</span>';
					}else {
						echo '<span class = "text_rainbow">Update Fail!!!</span>';
					}
				}
			}
		}else if ($mode == "monitor") {
			if (isset($_POST['name'])) {
				$name = $_POST['name'];
				$query = mysqli_query($con, "SELECT name,temp,humid,time FROM machine_data WHERE name = '$name'");
				$result = mysqli_fetch_array($query);
				$time_stamp_seconds = strtotime($time) - strtotime($result[3]);
				// echo $time_stamp_seconds;
				$array = array("name" => $result[0], "temp" => number_format($result[1], 2), "humid" => number_format($result[2], 2), "time" => $result[3], "time_stamp_seconds" => $time_stamp_seconds);
				echo json_encode($array, JSON_PRETTY_PRINT);
			}
		}else if ($mode == "log") {
			if (isset($_POST['name'])) {
				$name = $_POST['name'];
				$query = mysqli_query($con, "SELECT LOG_600 FROM machine_data WHERE name = '$name'");
				$result = mysqli_fetch_array($query);
				// echo json_encode($array, JSON_PRETTY_PRINT);
				echo "[\n".$result[0]."\n]";
				// echo json_encode($array);
				// echo '{"name" : "'.$result[0].'","temp" : '.$result[1].',"humid" : '.$result[2].'}';
					
					
					
				/*$decode = json_decode($decode, true);
				echo $decode["name"];
				echo $decode["temp"];
				echo $decode["humid"];*/
				
			}
		}
	}else if(isset($_GET['mode']) && isset($_GET['name'])) {
		$mode = $_GET['mode'];
		$name = $_GET['name'];
		if ($mode == "getlog") {
			
			$query = mysqli_query($con, "SELECT LOG_600 FROM machine_data WHERE name = '$name'");
			$result = mysqli_affected_rows($con);
			$result = mysqli_fetch_array($query);
			$old_array = explode("},",$result[0]);
			// echo $old_array[1]."}";
			
			$jsonarray = $old_array[count($old_array) - 1];
			$jsondecode = json_decode($jsonarray);
			$filename = date_format(date_create($jsondecode->time),"[m-d-Y_H-i-s]");
			$jsonarray = $old_array[0]."}";
			$jsondecode = json_decode($jsonarray);
			// echo $jsondecode->time;
			$filename = $filename."to".date_format(date_create($jsondecode->time),"[m-d-Y_H-i-s]");
			// echo $filename;
			header('Content-Type:application/xls');
			header('Content-Disposition: attachment; filename='.$filename.'.xls');
			
			echo "<table><thead><tr><th>time</th><th>temp</th><th>humid</th></tr></thead><tbody>";
			for ($x = 0;$x < count($old_array);$x++) {
				// echo $x." ";
				if ($x <= 0) {
					$jsonarray = $old_array[count($old_array) - 1];
					$jsondecode = json_decode($jsonarray);
					// echo $jsondecode->time."   ".$jsondecode->temp."   ".$jsondecode->humid."   ".PHP_EOL;
					echo "<tr><td>".$jsondecode->time."</td>"."<td>".$jsondecode->temp."</td>"."<td>".$jsondecode->humid."</td></tr>";
				}else {
					$jsonarray = $old_array[count($old_array) - 1 - $x]."}";
					$jsondecode = json_decode($jsonarray);
					// echo $jsondecode->time."   ".$jsondecode->temp."   ".$jsondecode->humid."   ".PHP_EOL;
					echo "<tr><td>".$jsondecode->time."</td>"."<td>".$jsondecode->temp."</td>"."<td>".$jsondecode->humid."</td></tr>";
				}
			}
			echo "</tbody></table>";
			
			// header('Content-Type:application/xls');  
			// header('Content-Disposition: attachment; filename=test.xls');
		}else {
			$temp = strval(rand(25,180));
			$humid = strval(rand(0,90));
			
			$query = mysqli_query($con, "SELECT LOG_600 FROM machine_data WHERE name = '$name'");
			$result = mysqli_fetch_array($query);
			
			$old_array = explode("}",$result[0]);
			echo count($old_array);
			$size_max = 600 + 1;
			if (count($old_array) > $size_max) {
				// unset($old_array[count($old_array) - 1]);
				// unset($old_array[count($old_array) - 2]);
				array_splice($old_array, $size_max - 1);
			}else {
				unset($old_array[count($old_array) - 1]);
			}
			// echo count($old_array);
			$timearray = $old_array[0]."}";
			$timearray = json_decode($timearray);
			
			if ($timearray->{"time"} == $time) {
				// echo $old_array[2];
				echo '<span class = "text_rainbow">Update Fail!!!</span>';
			}else {
				$array = array("temp" => $temp, "humid" => $humid, "time" => $time);
				$json = json_encode($array, JSON_PRETTY_PRINT);
				$str = $json.",";
				// echo count($old_array);
				for ($x = 0;$x < count($old_array);$x++) {
					$str = $str.$old_array[$x]."}";
				}
				// echo count($old_array)+1;
				echo "[\n".$str."\n]";
				
				$query = mysqli_query($con, "UPDATE machine_data SET temp = '$temp',humid = '$humid',time = '$time',LOG_600 = '$str' WHERE name = '$name'");
				$result = mysqli_affected_rows($con);
				if ($result) {
					echo '<span class = "text_rainbow">Update Success!!!</span>';
				}else {
					echo '<span class = "text_rainbow">Update Fail!!!</span>';
				}
			}
		}
	}
	
	// else {
		// $query = mysqli_query($con, "SELECT name,temp,humid,time FROM machine_data WHERE name = 'BURNIN#01'");
		// $result = mysqli_fetch_array($query);
		// $array = array("name" => $result[0], "temp" => number_format($result[1], 2), "humid" => number_format($result[2], 2), "time" => $result[3]);
		// echo json_encode($array, JSON_PRETTY_PRINT);
		
	// }
	exit();
?>
<html>
	<form method = "post">
		
	<form method = "post" enctype = "multipart/form-data">
</html>
