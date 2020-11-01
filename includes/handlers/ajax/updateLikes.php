<?php
include("../../config.php");

if(isset($_POST['songId'])) {
	$songId = $_POST['songId'];

	mysqli_query($con, "UPDATE songs SET Likes=(Likes+1) WHERE id='$songId'");
}
?>