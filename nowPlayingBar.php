<?php
$songQuery = mysqli_query($con, "SELECT id FROM songs ORDER BY RAND() LIMIT 10");

$resultArray = array();

while($row = mysqli_fetch_array($songQuery)) {
	array_push($resultArray, $row['id']);
}

$jsonArray = json_encode($resultArray);
?>

<script>

$(document).ready(function() {
	var newPlaylist = <?php echo $jsonArray; ?>;
	audioElement = new Audio();
	setTrack(newPlaylist[0], newPlaylist, false);
	updateVolumeProgressBar(audioElement.audio);


	$("#nowPlayingBarContainer").on("mousedown touchstart mousemove touchmove", function(e) {
		e.preventDefault();
	});


	$(".playbackBar .progressBar").mousedown(function() {
		mouseDown = true;
	});

	$(".playbackBar .progressBar").mousemove(function(e) {
		if(mouseDown == true) {
			//Set time of song, depending on position of mouse
			timeFromOffset(e, this);
		}
	});

	$(".playbackBar .progressBar").mouseup(function(e) {
		timeFromOffset(e, this);
	});


	$(".volumeBar .progressBar").mousedown(function() {
		mouseDown = true;
	});

	$(".volumeBar .progressBar").mousemove(function(e) {
		if(mouseDown == true) {

			var percentage = e.offsetX / $(this).width();

			if(percentage >= 0 && percentage <= 1) {
				audioElement.audio.volume = percentage;
			}
		}
	});

	$(".volumeBar .progressBar").mouseup(function(e) {
		var percentage = e.offsetX / $(this).width();

		if(percentage >= 0 && percentage <= 1) {
			audioElement.audio.volume = percentage;
		}
	});

	$(document).mouseup(function() {
		mouseDown = false;
	});




});

function timeFromOffset(mouse, progressBar) {
	var percentage = mouse.offsetX / $(progressBar).width() * 100;
	var seconds = audioElement.audio.duration * (percentage / 100);
	audioElement.setTime(seconds);
}

function prevSong() {
	if(audioElement.audio.currentTime >= 3 || currentIndex == 0) {
		audioElement.setTime(0);
	}
	else {
		currentIndex = currentIndex - 1;
		setTrack(currentPlaylist[currentIndex], currentPlaylist, true);
	}
}


var modal = document.getElementById("myModal");
var cont = 1;
var indexGlobal = 0;
var vetor = [];
var menor = 0;
var menosPlays = 0;

function nextSong() {
	var cont2 = 0;

	if(repeat == true) {
		audioElement.setTime(0);
		playSong();
		return;
	}

	var trackToPlay = shuffle ? shufflePlaylist[indexGlobal] : currentPlaylist[indexGlobal];
	$.post("includes/handlers/ajax/getSongJson.php", { songId: trackToPlay }, function(data) 
	{
		var track2 = JSON.parse(data);
		$generoMusica = track2.genre;
	});
	for (var i = 1; i <= 27; i++)
	{
		$.post("includes/handlers/ajax/getSongJson.php", { songId: i }, function(data) 
		{
			var musicaRecomendada = JSON.parse(data);
			$generoMusicaFor = musicaRecomendada.genre;
			$idMusicaFor = musicaRecomendada.id;
			if($generoMusicaFor == $generoMusica)
			{
				cont2++;
				$playsMusicas = musicaRecomendada.plays;
				if (cont2 == 1)
				{
					menor = $playsMusicas;
					menosPlays = $idMusicaFor;
				}
				else
				{
					if ($playsMusicas < menor)
					{
						menor = $playsMusicas;
						menosPlays = $idMusicaFor;
					}
				}
			}
		});
	}
	
	if(indexGlobal == currentPlaylist.length - 1) {
		indexGlobal = 0;
	}
	else {
		indexGlobal++;
	}

	if(cont % 2 != 0){
		var trackToPlay = shuffle ? shufflePlaylist[indexGlobal] : currentPlaylist[indexGlobal];
		setTrack(trackToPlay, currentPlaylist, true);
		cont++;
	}
	else{
		indexGlobal = currentIndex;
		location.href = "#popup1";
		setTrack(menosPlays, currentPlaylist, true);
		vetor = [];
		menor = 0;
		menosPlays = 0;
		cont++;
	}
}
function likeSong(){
    $.post("includes/handlers/ajax/updateLikes.php", { songId: audioElement.currentlyPlaying.id });
    $(".controlButton.like").hide();
	$(".controlButton.dislike").show();
}

function dislikeSong(){
    $.post("includes/handlers/ajax/updateLikes.php", { songId: audioElement.currentlyPlaying.id });
    $(".controlButton.like").show();
	$(".controlButton.dislike").hide();
}

function setRepeat() {
	repeat = !repeat;
	var imageName = repeat ? "repeat-active.png" : "repeat.png";
	$(".controlButton.repeat img").attr("src", "assets/images/icons/" + imageName);
}

function setMute() {
	audioElement.audio.muted = !audioElement.audio.muted;
	var imageName = audioElement.audio.muted ? "volume-mute.png" : "volume.png";
	$(".controlButton.volume img").attr("src", "assets/images/icons/" + imageName);
}

function setShuffle() {
	shuffle = !shuffle;
	var imageName = shuffle ? "shuffle-active.png" : "shuffle.png";
	$(".controlButton.shuffle img").attr("src", "assets/images/icons/" + imageName);

	if(shuffle == true) {
		//Randomize playlist
		shuffleArray(shufflePlaylist);
		currentIndex = shufflePlaylist.indexOf(audioElement.currentlyPlaying.id);
	}
	else {
		//shuffle has been deactivated
		//go back to regular playlist
		currentIndex = currentPlaylist.indexOf(audioElement.currentlyPlaying.id);
	}

}

function shuffleArray(a) {
    var j, x, i;
    for (i = a.length; i; i--) {
        j = Math.floor(Math.random() * i);
        x = a[i - 1];
        a[i - 1] = a[j];
        a[j] = x;
    }
}


function setTrack(trackId, newPlaylist, play) {

	if(newPlaylist != currentPlaylist) {
		currentPlaylist = newPlaylist;
		shufflePlaylist = currentPlaylist.slice();
		shuffleArray(shufflePlaylist);
	}

	if(shuffle == true) {
		currentIndex = shufflePlaylist.indexOf(trackId);
	}
	else {
		currentIndex = currentPlaylist.indexOf(trackId);
	}
	pauseSong();

	$.post("includes/handlers/ajax/getSongJson.php", { songId: trackId }, function(data) {

		var track = JSON.parse(data);
		$(".trackName span").text(track.title);

		$.post("includes/handlers/ajax/getArtistJson.php", { artistId: track.artist }, function(data) {
			var artist = JSON.parse(data);
			$(".trackInfo .artistName span").text(artist.name);
			$(".trackInfo .artistName span").attr("onclick", "openPage('artist.php?id=" + artist.id + "')");
		});

		$.post("includes/handlers/ajax/getAlbumJson.php", { albumId: track.album }, function(data) {
			var album = JSON.parse(data);
			$(".content .albumLink img").attr("src", album.artworkPath);
			$(".content .albumLink img").attr("onclick", "openPage('album.php?id=" + album.id + "')");
			$(".trackInfo .trackName span").attr("onclick", "openPage('album.php?id=" + album.id + "')");
		});


		audioElement.setTrack(track);

		if(play == true) {
			playSong();
		}
	});

}

function playSong() {

	if(audioElement.audio.currentTime == 0) {
		$.post("includes/handlers/ajax/updatePlays.php", { songId: audioElement.currentlyPlaying.id });
	}

	$(".controlButton.play").hide();
	$(".controlButton.pause").show();
	audioElement.play();
}

function pauseSong() {
	$(".controlButton.play").show();
	$(".controlButton.pause").hide();
	audioElement.pause();
}
</script>
<style>


h1 {
  text-align: center;
  font-family: Tahoma, Arial, sans-serif;
  color: #06D85F;
  margin: 80px 0;
}

.box {
  width: 40%;
  margin: 0 auto;
  background: rgba(255,255,255,0.2);
  padding: 35px;
  border: 2px solid #fff;
  border-radius: 20px/50px;
  background-clip: padding-box;
  text-align: center;
}

.button {
  font-size: 1em;
  padding: 10px;
  color: #fff;
  border: 2px solid #06D85F;
  border-radius: 20px/50px;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease-out;
}
.button:hover {
  background: #06D85F;
}

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0;
}
.overlay:target {
  visibility: visible;
  opacity: 1;
}

.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 50%;
  height: 25%;
  position: absolute;
  overflow-y: scroll;
  top: 20%;
  left: 25%;
  transition: all 5s ease-in-out;
}

.popup h2 {
  margin-top: 0;
  color: #000;
  font-size: 40px;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .close {
  position: absolute;
  top: 20px;
  right: 30px;
  transition: all 200ms;
  font-size: 30px;
  font-weight: bold;
  text-decoration: none;
  color: #000;
}
.popup .close:hover {
  color: #06D85F;
}
.popup .content {
  max-height: 30%;
  color: #000;
  font-size: 30px;
  font-family: Tahoma, Arial, sans-serif;
}

@media screen and (max-width: 700px){
  .box{
    width: 70%;
  }
  .popup{
    width: 70%;
  }
}
</style>
<div id="nowPlayingBarContainer">

	<div id="nowPlayingBar">

		<div id="nowPlayingLeft">
			<div class="content">
				<span class="albumLink">
					<img role="link" tabindex="0" src="" class="albumArtwork">
				</span>

				<div class="trackInfo">

					<span class="trackName">
						<span role="link" tabindex="0"></span>
					</span>

					<span class="artistName">
						<span role="link" tabindex="0"></span>
					</span>

				</div>
			</div>
		</div>

		<div id="nowPlayingCenter">

			<div class="content playerControls">

				<div class="buttons">

					<button class="controlButton shuffle" title="Shuffle button" onclick="setShuffle()">
						<img src="assets/images/icons/shuffle.png" alt="Shuffle">
					</button>

					<button class="controlButton previous" title="Previous button" onclick="prevSong()">
						<img src="assets/images/icons/previous.png" alt="Previous">
					</button>

					<button class="controlButton play" title="Play button" onclick="playSong()">
						<img src="assets/images/icons/play.png" alt="Play">
					</button>


					<div id="popup1" class="overlay">
						<div class="popup">
							<h2>Que tal conhecer alguém novo?</h2>
							<a class="close" href="#">&times;</a>
							<div class="content">
								Procuramos em nossa biblioteca e achamos uma música nova que bate com seu gosto musical! Caso você goste, basta adiciona-lá a playlist, às suas “Músicas Salvas” ou simplesmente ouvi-la até o final. Caso você não goste, é só pular!”
							</div>
						</div>
					</div>

					<button class="controlButton pause" title="Pause button" style="display: none;" onclick="pauseSong()">
						<img src="assets/images/icons/pause.png" alt="Pause">
					</button>

					<button class="controlButton next" title="Next button" onclick="nextSong()">
						<img src="assets/images/icons/next.png" alt="Next">
					</button>

					<button class="controlButton repeat" title="Repeat button" onclick="setRepeat()">
						<img src="assets/images/icons/repeat.png" alt="Repeat">
					</button>

					
					<button class="controlButton like" title="Like button" onclick="likeSong()" style="opacity:0.5;">
						<img src="assets/images/icons/likea.png" alt="Like">
					</button>
										
					<button class="controlButton dislike" title="Dislike button" onclick="dislikeSong()" style="opacity:0.5;display: none;">
						<img src="assets/images/icons/likeb.png" alt="Like">
					</button>

				</div>

				<div class="playbackBar">

					<span class="progressTime current">0.00</span>

					<div class="progressBar">
						<div class="progressBarBg">
							<div class="progress"></div>
						</div>
					</div>

					<span class="progressTime remaining">0.00</span>


				</div>


			</div>


		</div>

		<div id="nowPlayingRight">
			<div class="volumeBar">

				<button class="controlButton volume" title="Volume button" onclick="setMute()">
					<img src="assets/images/icons/volume.png" alt="Volume">
				</button>

				<div class="progressBar">
					<div class="progressBarBg">
						<div class="progress"></div>
					</div>
				</div>

			</div>
		</div>




	</div>

</div>