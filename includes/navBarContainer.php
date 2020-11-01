<div id="navBarContainer">
	<nav class="navBar">

		<span role="link" tabindex="0" onclick="openPage('index.php')" class="logo">
			<img src="assets/images/icons/logo.png">
		</span>


		<div class="group">

			<div class="navItem">
				<span role='link' tabindex='0' onclick='openPage("search.php")' class="navItemLink">
					Procurar
					<img src="assets/images/icons/search.png" class="icon" alt="Search">
				</span>
			</div>

		</div>

		<div class="group">
			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('browse.php')" class="navItemLink">Navegar</span>
			</div>

			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('genre.php')" class="navItemLink">Gêneros</span>
			</div>

			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('artists.php')" class="navItemLink">Artistas</span>
			</div>

			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('songs.php')" class="navItemLink">Músicas</span>
			</div>

			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('yourMusic.php')" class="navItemLink">Suas músicas</span>
			</div>

			<div class="navItem">
				<span role="link" tabindex="0" onclick="openPage('settings.php')" class="navItemLink"> <?php echo $userLoggedIn->getFirstAndLastName(); ?></span>
			</div>
		</div>

	</nav>
</div>